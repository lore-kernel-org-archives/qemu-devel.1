Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F14C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 07:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C4D821882
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 07:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Ps0yjik1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4D821882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iETpv-0005Tn-Ff
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 03:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhlb29@foxmail.com>) id 1iEToF-0003lA-D3
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 03:40:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhlb29@foxmail.com>) id 1iETo8-0005GR-C6
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 03:39:54 -0400
Received: from smtpbgeu1.qq.com ([52.59.177.22]:53583)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhlb29@foxmail.com>) id 1iETo7-0005Aq-9Z
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 03:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1569742780;
 bh=oJel8hT4tm6/zKMHLqSN8N3kGqSlfzOZUJ6sIiCb6XQ=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=Ps0yjik1qrytpw6FZW50Yf9WeWYk5LX3PMCnifvwtUywdeWiUDs4nmz9e28+maeWL
 Y3BlfGN/jbhLhJrqOInoKCGQrZCBaYzX3K5L0Cf01FiKkjyJDmXVxQ+BEB01shSGI3
 Ep7aFx26jNU8M0cfkeUDypmoJ5TEvDDh7WXl7cwc=
X-QQ-SSF: 00000000000000F000000000000000G
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 159.226.200.178
In-Reply-To: <tencent_76DBE21F6D585D0B6F510084@qq.com>
References: <tencent_76DBE21F6D585D0B6F510084@qq.com>
X-QQ-STYLE: 
X-QQ-mid: webenglish1t1569742779t893280
From: "=?ISO-8859-1?B?TGlibyBaaG91?=" <zhlb29@foxmail.com>
To: "=?ISO-8859-1?B?cWVtdS1kZXZlbA==?=" <qemu-devel@nongnu.org>
Subject: Re:Why on earth is this code giving me Segfaults?
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date: Sun, 29 Sep 2019 15:39:39 +0800
X-Priority: 3
Message-ID: <tencent_5AE78C5A4BC959A87510F0C7@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 3959436529
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Sun, 29 Sep 2019 15:39:39 +0800 (CST)
Feedback-ID: webenglish:foxmail.com:bgforeign:bgforeign4
X-QQ-Bgrelay: 1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 52.59.177.22
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SSdtIGNvcHlpbmcgYW5kIHBhc3RpbmcgYWxsIG15IGRpZmYgYmVsb3csIGp1c3QgaW4gY2Fz
ZSBzb21ldGhpbmcgZWxzZSBjYXVzZWQgdGhlIHNlZ2ZhdWx0LiBBbnkgaGVscCB3b3VsZCBi
ZSByZWFsbHkgYXBwcmVjaWF0ZWQgZ3V5cy4KCmRpZmYgLS1naXQgYS90YXJnZXQvbWlwcy9t
aXBzLWRlZnMuaCBiL3RhcmdldC9taXBzL21pcHMtZGVmcy5oCmluZGV4IGJiZjA1NmE1Li44
YTRhY2ZmMyAxMDA2NDQKLS0tIGEvdGFyZ2V0L21pcHMvbWlwcy1kZWZzLmgKKysrIGIvdGFy
Z2V0L21pcHMvbWlwcy1kZWZzLmgKQEAgLTUwLDYgKzUwLDcgQEAKICNkZWZpbmUgSU5TTl9M
T09OR1NPTjJGICAgMHgwMDAyMDAwMDAwMDAwMDAwVUxMCiAjZGVmaW5lIElOU05fVlI1NFhY
ICAgICAgIDB4MDAwNDAwMDAwMDAwMDAwMFVMTAogI2RlZmluZSBJTlNOX1I1OTAwICAgICAg
ICAweDAwMDgwMDAwMDAwMDAwMDBVTEwKKyNkZWZpbmUgSU5TTl9NQU9UVSAgICAgICAgMHgw
MDEwMDAwMDAwMDAwMDAwVUxMCiAvKgogICogICBiaXRzIDU2LTYzOiB2ZW5kb3Itc3BlY2lm
aWMgQVNFcwogICovCkBAIC05MSw2ICs5Miw5IEBACiAvKiBXYXZlIENvbXB1dGluZzogIm5h
bm9NSVBTIiAqLwogI2RlZmluZSBDUFVfTkFOT01JUFMzMiAoQ1BVX01JUFMzMlI2IHwgSVNB
X05BTk9NSVBTMzIpCiAKKy8qIFN5bGluY29tOiAibWFvdHUiICovCisjZGVmaW5lIENQVV9N
QU9UVSAoQ1BVX01JUFMxIHwgSU5TTl9NQU9UVSkKKwogLyogU3RyaWN0bHkgZm9sbG93IHRo
ZSBhcmNoaXRlY3R1cmUgc3RhbmRhcmQ6CiAgICAtIERpc2FsbG93ICJzcGVjaWFsIiBpbnN0
cnVjdGlvbiBoYW5kbGluZyBmb3IgUE1PTi9TUElNLgogICAgTm90ZSB0aGF0IHdlIHN0aWxs
IG1haW50YWluIENvdW50L0NvbXBhcmUgdG8gbWF0Y2ggdGhlIGhvc3QgY2xvY2suICovCmRp
ZmYgLS1naXQgYS90YXJnZXQvbWlwcy90cmFuc2xhdGUuYyBiL3RhcmdldC9taXBzL3RyYW5z
bGF0ZS5jCmluZGV4IGNhNjI4MDAyLi40ZTRiNmU4OSAxMDA2NDQKLS0tIGEvdGFyZ2V0L21p
cHMvdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L21pcHMvdHJhbnNsYXRlLmMKQEAgLTI5MjM0
LDcgKzI5MjM0LDExIEBAIHN0YXRpYyB2b2lkIGRlY29kZV9vcGMoQ1BVTUlQU1N0YXRlICpl
bnYsIERpc2FzQ29udGV4dCAqY3R4KQogICAgICAgICAgICAgZGVjb2RlX29wY19zcGVjaWFs
MyhlbnYsIGN0eCk7CiAgICAgICAgIH0KICNlbHNlCi0gICAgICAgIGRlY29kZV9vcGNfc3Bl
Y2lhbDMoZW52LCBjdHgpOworICAgICAgICBpZiAoY3R4LT5pbnNuX2ZsYWdzICYgSU5TTl9N
QU9UVSkgeworICAgICAgICAgICAgZ2VuX3N0KGN0eCwgT1BDX1NXLCBydCwgcnMsIGltbSk7
IC8qIE9QQ19NQU9UVV9TVyAqLworICAgICAgICB9IGVsc2UgeworICAgICAgICAgICAgZGVj
b2RlX29wY19zcGVjaWFsMyhlbnYsIGN0eCk7CisgICAgICAgIH0KICNlbmRpZgogICAgICAg
ICBicmVhazsKICAgICBjYXNlIE9QQ19SRUdJTU06CkBAIC0yOTQ4NCw3ICsyOTQ4OCw3IEBA
IHN0YXRpYyB2b2lkIGRlY29kZV9vcGMoQ1BVTUlQU1N0YXRlICplbnYsIERpc2FzQ29udGV4
dCAqY3R4KQogICAgICAgICAgICAgZ2VuX2NvbXB1dGVfYnJhbmNoKGN0eCwgb3AsIDQsIHJz
LCBydCwgaW1tIDw8IDIsIDQpOwogICAgICAgICB9CiAgICAgICAgIGJyZWFrOwotICAgIGNh
c2UgT1BDX0JHVFpDOiAvKiBPUENfQkxUWkMsIE9QQ19CTFRDLCBPUENfQkdUWkwgKi8KKyAg
ICBjYXNlIE9QQ19CR1RaQzogLyogT1BDX0JMVFpDLCBPUENfQkxUQywgT1BDX0JHVFpMLCBP
UENfTUFPVFVfTFcgKi8KICAgICAgICAgaWYgKGN0eC0+aW5zbl9mbGFncyAmIElTQV9NSVBT
MzJSNikgewogICAgICAgICAgICAgaWYgKHJ0ID09IDApIHsKICAgICAgICAgICAgICAgICBn
ZW5lcmF0ZV9leGNlcHRpb25fZW5kKGN0eCwgRVhDUF9SSSk7CkBAIC0yOTQ5Miw2ICsyOTQ5
Niw5IEBAIHN0YXRpYyB2b2lkIGRlY29kZV9vcGMoQ1BVTUlQU1N0YXRlICplbnYsIERpc2Fz
Q29udGV4dCAqY3R4KQogICAgICAgICAgICAgfQogICAgICAgICAgICAgLyogT1BDX0JHVFpD
LCBPUENfQkxUWkMsIE9QQ19CTFRDICovCiAgICAgICAgICAgICBnZW5fY29tcHV0ZV9jb21w
YWN0X2JyYW5jaChjdHgsIG9wLCBycywgcnQsIGltbSA8PCAyKTsKKyAgICAgICAgfSBlbHNl
IGlmIChjdHgtPmluc25fZmxhZ3MgJiBJTlNOX01BT1RVKSB7CisgICAgICAgICAgICAvKiBP
UENfTUFPVFVfTFcgKi8KKyAgICAgICAgICAgIGdlbl9sZChjdHgsIE9QQ19MVywgcnQsIHJz
LCBpbW0pOwogICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgLyogT1BDX0JHVFpMICov
CiAgICAgICAgICAgICBnZW5fY29tcHV0ZV9icmFuY2goY3R4LCBvcCwgNCwgcnMsIHJ0LCBp
bW0gPDwgMiwgNCk7CmRpZmYgLS1naXQgYS90YXJnZXQvbWlwcy90cmFuc2xhdGVfaW5pdC5p
bmMuYyBiL3RhcmdldC9taXBzL3RyYW5zbGF0ZV9pbml0LmluYy5jCmluZGV4IDZkMTQ1YTkw
Li41YjFhN2NlZiAxMDA2NDQKLS0tIGEvdGFyZ2V0L21pcHMvdHJhbnNsYXRlX2luaXQuaW5j
LmMKKysrIGIvdGFyZ2V0L21pcHMvdHJhbnNsYXRlX2luaXQuaW5jLmMKQEAgLTQ4OSw2ICs0
ODksMTAgQEAgY29uc3QgbWlwc19kZWZfdCBtaXBzX2RlZnNbXSA9CiAgICAgICAgICAgICAg
ICAgICAgICAgQVNFX01ULAogICAgICAgICAubW11X3R5cGUgPSBNTVVfVFlQRV9SNDAwMCwK
ICAgICB9LAorICAgIHsKKyAgICAgICAgLm5hbWUgPSAibWFvdHUiLAorICAgICAgICAuaW5z
bl9mbGFncyA9IENQVV9NQU9UVSwKKyAgICB9LAogI2lmIGRlZmluZWQoVEFSR0VUX01JUFM2
NCkKICAgICB7CiAgICAgICAgIC5uYW1lID0gIlI0MDAwIiw=




