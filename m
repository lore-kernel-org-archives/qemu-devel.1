Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099BAC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:33:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF272086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="vJ4hc0mt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF272086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBLqg-0007M1-84
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 12:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhlb29@foxmail.com>) id 1iBLnJ-0004mF-Rc
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhlb29@foxmail.com>) id 1iBLnB-0003pJ-P0
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:29:58 -0400
Received: from smtpbguseast2.qq.com ([54.204.34.130]:40971)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhlb29@foxmail.com>) id 1iBLn9-0003nQ-Kq
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1568996987;
 bh=v3GVc+3ugmo9VU+fZbiHnRklbNk2UZztE4hFNZ1s8RM=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=vJ4hc0mtHI6Zlt3GktX1MNu4/xDPW6GziKspWSGq58emGDULWeut1SvvFvDiv5Ydo
 CEG1U5B9jYskgYi7oEHSvr5fuZRvxJL/OisFynTVkvacuQEju4vBgnvLeu+4ciqi7X
 P7pR2TqTHSlm2K03wDXBzJiMOjwaOMUXmU0lzBAs=
X-QQ-SSF: 00000000000000F000000000000000G
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 123.114.36.138
In-Reply-To: <CAFEAcA-GEtZUVU838Cb0j7ekUzrQ9VTLFfFVL37BALzk_VQFBA@mail.gmail.com>
References: <tencent_7BDD949D4C752E2A291A6A02@qq.com>
 <CAFEAcA9QDrwUAdZWX7n_gO9afnT4n9+i8ZdqOcxrNbvi6n9=sw@mail.gmail.com>
 <tencent_5378456F7A2F471F74C049FC@qq.com>
 <CAFEAcA87Pb4Mk8McdaZHe41s=Cc1EeCknKfikRm6F+QoxKsdgg@mail.gmail.com>
 <tencent_7D89E27172EB5C93465EFBB4@qq.com>
 <CAFEAcA-GEtZUVU838Cb0j7ekUzrQ9VTLFfFVL37BALzk_VQFBA@mail.gmail.com>
X-QQ-STYLE: 
X-QQ-mid: webenglish1t1568996986t660451
From: "=?ISO-8859-1?B?TGlibyBaaG91?=" <zhlb29@foxmail.com>
To: "=?ISO-8859-1?B?UGV0ZXIgTWF5ZGVsbA==?=" <peter.maydell@linaro.org>
Subject: Re:  Initialize data memory in user space emulation
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date: Sat, 21 Sep 2019 00:29:46 +0800
X-Priority: 3
Message-ID: <tencent_2CB77C2B1C2DB29264EB30A0@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 3138484263
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Sat, 21 Sep 2019 00:29:46 +0800 (CST)
Feedback-ID: webenglish:foxmail.com:bgforeign:bgforeign4
X-QQ-Bgrelay: 1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 54.204.34.130
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
Cc: =?ISO-8859-1?B?cWVtdS1kZXZlbA==?= <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhhbmtzIGZvciB5b3VyIGluc2lnaHRmdWwgaW5wdXQuIEkgd2lsbCBjb21lIGJhY2sgdG8g
dGhpcyB0aHJlYWQgYWZ0ZXIgSSB0cmllZCBhbGwgdGhlIG9wdGlvbnMuCgpDaGVlcnMsCkxp
Ym8gWmhvdQoKCgoKLS0tLS0tLS0tLS0tLS0tLS0tIE9yaWdpbmFsIC0tLS0tLS0tLS0tLS0t
LS0tLQpGcm9tOiAgIlBldGVyIE1heWRlbGwiOzxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+
OwpTZW5kIHRpbWU6IFNhdHVyZGF5LCBTZXAgMjEsIDIwMTkgMDowOCBBTQpUbzogIkxpYm8g
WmhvdSI8emhsYjI5QGZveG1haWwuY29tPjsgCkNjOiAicWVtdS1kZXZlbCI8cWVtdS1kZXZl
bEBub25nbnUub3JnPjsgClN1YmplY3Q6ICBSZTogSW5pdGlhbGl6ZSBkYXRhIG1lbW9yeSBp
biB1c2VyIHNwYWNlIGVtdWxhdGlvbgoKCgpPbiBGcmksIDIwIFNlcCAyMDE5IGF0IDE2OjI2
LCBMaWJvIFpob3UgPHpobGIyOUBmb3htYWlsLmNvbT4gd3JvdGU6Cj4KPiBJIGFjdHVhbGx5
IHRob3VnaHQgYWJvdXQgaGFja2luZyBpdCB0byBtbWFwIGZyb20gZmlsZSBpbnRvIGd1ZXN0
IG1lbW9yeSBiZWZvcmUgcnVubmluZyBFTEYuIEluIGluY2x1ZGUvZXhlYy9tZW1vcnkuaCwg
dGhlIGZ1bmN0aW9uIG1lbW9yeV9yZWdpb25faW5pdF9yYW1fZnJvbV9maWxlIHNvdW5kcyBs
aWtlIHdoYXQgSSBuZWVkLiBCdXQgdGhlIGVudGlyZSBtZW1vcnkuaCBzb3VyY2UgZmlsZSBp
cyB3cmFwcGVkIGJ5ICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWSwgSSBjYW5ub3QgdXNlIHRo
YXQgQVBJIGluIHVzZXIgc3BhY2UgZW11bGF0aW9uLCByaWdodD8KCkNvcnJlY3QsIHlvdSBk
b24ndCB3YW50IHRvIHVzZSB0aGF0LiBZb3Ugd2FudAp0byBwdXQgc29tZSBjb2RlIGluIGxp
bnV4LXVzZXIvbWFpbi5jLCBwcm9iYWJseQpqdXN0IGFmdGVyIHRoZSBjYWxsIHRvIHNpZ25h
bF9pbml0KCksIHdoaWNoIG9wZW5zCnRoZSBob3N0IGZpbGUgYW5kIHRoZW4gY2FsbHMgdGFy
Z2V0X21tYXAoKSB0byBtbWFwCml0IGludG8gdGhlIGhvc3QuCgpJZiB5b3UgaGFwcGVuIHRv
IGhhdmUgdGhlIHNvdXJjZSBmb3IgdGhlIGd1ZXN0IHByb2dyYW0sCnlvdSBjb3VsZCBhbHNv
IGp1c3QgbWFrZSBpdCBkbyB0aGUgb3BlbiBhbmQgbW1hcCgpIGl0c2VsZgphcyB0aGUgZmly
c3QgdGhpbmcgaXQgZG9lcyBpbiBtYWluKCkgLS0gdGhpcyBpcyBiYXNpY2FsbHkKZXF1aXZh
bGVudC4gT3IgaWYgdGhlIGd1ZXN0IHByb2dyYW0gaXMgZHluYW1pY2FsbHkgbGlua2VkCnRo
ZW4geW91IGNhbiB1c2UgUUVNVSdzIC1FIG9wdGlvbiB0byBzZXQgdGhlIExEX1BSRUxPQUQK
ZW52aXJvbm1lbnQgdmFyaWFibGUgZm9yIHRoZSBndWVzdCB0byBtYWtlIGl0IGxvYWQgYSBn
dWVzdApzaGFyZWQgbGlicmFyeSB0aGF0IGhhcyBhIGNvbnN0cnVjdG9yIGZ1bmN0aW9uIHRo
YXQgZG9lcwp0aGUgb3Blbi9tbWFwIGJlZm9yZSB0aGUgZ3Vlc3QgbWFpbigpIGdldHMgY29u
dHJvbC4KCnRoYW5rcwotLSBQTU0=




