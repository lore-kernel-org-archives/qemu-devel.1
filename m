Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718FBC606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:43:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED8F21537
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED8F21537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkkmk-0003Wx-GT
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 03:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49192)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hkkm0-00035N-U9
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hkklz-0001Ph-Hg
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:42:48 -0400
Resent-Date: Tue, 09 Jul 2019 03:42:48 -0400
Resent-Message-Id: <E1hkklz-0001Ph-Hg@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21530)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hkklz-0001OE-8X
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:42:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562658072; cv=none; d=zoho.com; s=zohoarc; 
 b=c41WoCXdJaNmWWdp/lLU2Vsced15lCRyosLFiKiVV2OJrwMFT3DLLWFBxR1LNyXc/1qpNaHFbtCma4S5qDUW0udOpmozkD0S+/s53TvFSYQvC1SQCULTnx4hgiKCBbw99ldDmYwTNsszmEfvfrKBg7R19s8WXA8tn6RhI+7Zh6w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562658072;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=wP+AxN8cqJKjvus2zcaHemnFuQurrh3NuXh+vfPTzJ0=; 
 b=MvoeHkLWFAae6Bl+WWOpglrtcUYZzGIPXbpQ28SWdcK5EqwNbMtESeEKECqa/9+WvxhXpnxGTaxnf2i0jBkuoM2/qmQOt7aWebFSZ95PS4E9s7EjJDC6Wu9QR7DbbGwNPzhJP9AIqvZhV0EVBWYdBUucU99e4H4x8NnQPMsJ9Ak=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562658070020897.7206511902992;
 Tue, 9 Jul 2019 00:41:10 -0700 (PDT)
Message-ID: <156265806842.29610.4304130026402148292@c4a48874b076>
In-Reply-To: <20190709071520.8745-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: tao3.xu@intel.com
Date: Tue, 9 Jul 2019 00:41:10 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH RESEND v6 00/14] Build ACPI Heterogeneous
 Memory Attribute Table (HMAT)
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
Reply-To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, jingqi.liu@intel.com, tao3.xu@intel.com,
 fan.du@intel.com, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 imammedo@redhat.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcwOTA3MTUyMC44NzQ1
LTEtdGFvMy54dUBpbnRlbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIGJ1aWxkIHRl
c3Qgb24gczM5MHggaG9zdC4gUGxlYXNlIGZpbmQgdGhlIGRldGFpbHMgYmVsb3cuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCiMgVGVzdGluZyBzY3JpcHQgd2lsbCBiZSBp
bnZva2VkIHVuZGVyIHRoZSBnaXQgY2hlY2tvdXQgd2l0aAojIEhFQUQgcG9pbnRpbmcgdG8gYSBj
b21taXQgdGhhdCBoYXMgdGhlIHBhdGNoZXMgYXBwbGllZCBvbiB0b3Agb2YgImJhc2UiCiMgYnJh
bmNoCnNldCAtZQoKZWNobwplY2hvICI9PT0gRU5WID09PSIKZW52CgplY2hvCmVjaG8gIj09PSBQ
QUNLQUdFUyA9PT0iCnJwbSAtcWEKCmVjaG8KZWNobyAiPT09IFVOQU1FID09PSIKdW5hbWUgLWEK
CkNDPSRIT01FL2Jpbi9jYwpJTlNUQUxMPSRQV0QvaW5zdGFsbApCVUlMRD0kUFdEL2J1aWxkCm1r
ZGlyIC1wICRCVUlMRCAkSU5TVEFMTApTUkM9JFBXRApjZCAkQlVJTEQKJFNSQy9jb25maWd1cmUg
LS1jYz0kQ0MgLS1wcmVmaXg9JElOU1RBTEwKbWFrZSAtajQKIyBYWFg6IHdlIG5lZWQgcmVsaWFi
bGUgY2xlYW4gdXAKIyBtYWtlIGNoZWNrIC1qNCBWPTEKbWFrZSBpbnN0YWxsCj09PSBURVNUIFND
UklQVCBFTkQgPT09CgogIEdFTiAgICAgdXRpbC90cmFjZS5jCiAgR0VOICAgICBjb25maWctYWxs
LWRldmljZXMubWFrCkNsb25pbmcgaW50byAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWVo
a3F6am03L3NyYy9kdGMnLi4uCmVycm9yOiBSUEMgZmFpbGVkOyBjdXJsIDE4IHRyYW5zZmVyIGNs
b3NlZCB3aXRoIG91dHN0YW5kaW5nIHJlYWQgZGF0YSByZW1haW5pbmcKZmF0YWw6IHRoZSByZW1v
dGUgZW5kIGh1bmcgdXAgdW5leHBlY3RlZGx5CmZhdGFsOiBwcm90b2NvbCBlcnJvcjogYmFkIHBh
Y2sgaGVhZGVyCmZhdGFsOiBjbG9uZSBvZiAnaHR0cHM6Ly9naXQucWVtdS5vcmcvZ2l0L2R0Yy5n
aXQnIGludG8gc3VibW9kdWxlIHBhdGggJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1laGtx
emptNy9zcmMvZHRjJyBmYWlsZWQKRmFpbGVkIHRvIGNsb25lICdkdGMnLiBSZXRyeSBzY2hlZHVs
ZWQKQ2xvbmluZyBpbnRvICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtZWhrcXpqbTcvc3Jj
L3NsaXJwJy4uLgotLS0KQ2xvbmluZyBpbnRvICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAt
ZWhrcXpqbTcvc3JjL3Rlc3RzL2ZwL2JlcmtlbGV5LXRlc3RmbG9hdC0zJy4uLgpDbG9uaW5nIGlu
dG8gJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1laGtxemptNy9zcmMvdWkva2V5Y29kZW1h
cGRiJy4uLgpDbG9uaW5nIGludG8gJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1laGtxempt
Ny9zcmMvZHRjJy4uLgplcnJvcjogUlBDIGZhaWxlZDsgY3VybCAxOCB0cmFuc2ZlciBjbG9zZWQg
d2l0aCBvdXRzdGFuZGluZyByZWFkIGRhdGEgcmVtYWluaW5nCmZhdGFsOiB0aGUgcmVtb3RlIGVu
ZCBodW5nIHVwIHVuZXhwZWN0ZWRseQpmYXRhbDogcHJvdG9jb2wgZXJyb3I6IGJhZCBwYWNrIGhl
YWRlcgpmYXRhbDogY2xvbmUgb2YgJ2h0dHBzOi8vZ2l0LnFlbXUub3JnL2dpdC9kdGMuZ2l0JyBp
bnRvIHN1Ym1vZHVsZSBwYXRoICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtZWhrcXpqbTcv
c3JjL2R0YycgZmFpbGVkCkZhaWxlZCB0byBjbG9uZSAnZHRjJyBhIHNlY29uZCB0aW1lLCBhYm9y
dGluZwouL3NjcmlwdHMvZ2l0LXN1Ym1vZHVsZS5zaDogZmFpbGVkIHRvIHVwZGF0ZSBtb2R1bGVz
CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8y
MDE5MDcwOTA3MTUyMC44NzQ1LTEtdGFvMy54dUBpbnRlbC5jb20vdGVzdGluZy5zMzkweC8/dHlw
ZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBb
aHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNo
ZXctZGV2ZWxAcmVkaGF0LmNvbQ==


