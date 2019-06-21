Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A64C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 17:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0650D2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 17:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0650D2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37140 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heNmP-0004qV-5Q
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 13:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34613)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1heNlJ-0003eo-JE
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 13:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1heNlH-0004fk-Mo
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 13:55:45 -0400
Resent-Date: Fri, 21 Jun 2019 13:55:44 -0400
Resent-Message-Id: <E1heNlH-0004fk-Mo@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1heNlH-0004eY-Dq
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 13:55:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561139732; cv=none; d=zoho.com; s=zohoarc; 
 b=A3+Brhnq43Nbzq6KYGZxginfSnSyrDM3ugctaK7+9WGMc8dOj+rK8i9bl6znI4YlJpFCaCPvsetMcj0sciSwIPNqx1itTOJhZT4UJM9Q4OU1HvBCQ+bbtHv9FA+/MaoubqUeEYL1XY0pagNAZx7qVbT8xkec+FTCqr2fH1riICY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561139732;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=/ishNVFhA2ItX0zIsEKBMnYTWRmXzVLy2FOIbjR+9pk=; 
 b=m8QVjEVHmaotP2AACQbtCO4fG0caLs2dWGE2kPR2wq/zvh8dQCT6VVrJuKE5emopiULpF0IHGkd9dIlqlzc6wtpkAA34Zx8b/Oq4yGFiACo8HyL+aqhj0XQ8QDMnEoTI9VAd3LH+qFO+PXKFj2w9uHELZov3GV9DTUO80iIWOws=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561139731320454.2339496278156;
 Fri, 21 Jun 2019 10:55:31 -0700 (PDT)
In-Reply-To: <20190621144541.13770-1-skrtbhtngr@gmail.com>
Message-ID: <156113973041.4070.6979056140536397914@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: skrtbhtngr@gmail.com
Date: Fri, 21 Jun 2019 10:55:31 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [RFC 0/1] Add live migration support to the PVRDMA
 device
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
Cc: qemu-devel@nongnu.org, yuval.shaia@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYyMTE0NDU0MS4xMzc3
MC0xLXNrcnRiaHRuZ3JAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtSRkMgMC8x
XSBBZGQgbGl2ZSBtaWdyYXRpb24gc3VwcG9ydCB0byB0aGUgUFZSRE1BIGRldmljZQpNZXNzYWdl
LWlkOiAyMDE5MDYyMTE0NDU0MS4xMzc3MC0xLXNrcnRiaHRuZ3JAZ21haWwuY29tCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYv
bnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
YWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJh
c2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIx
NjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjIx
YzJiMzAgaHcvcHZyZG1hOiBBZGQgbGl2ZSBtaWdyYXRpb24gc3VwcG9ydAoKPT09IE9VVFBVVCBC
RUdJTiA9PT0KRVJST1I6IGRvIG5vdCB1c2UgQzk5IC8vIGNvbW1lbnRzCiM1MDogRklMRTogaHcv
cmRtYS92bXcvcHZyZG1hX21haW4uYzo2MTA6CisgICAgLy8gUmVtYXAgRFNSCgpFUlJPUjogZG8g
bm90IHVzZSBDOTkgLy8gY29tbWVudHMKIzYwOiBGSUxFOiBody9yZG1hL3Ztdy9wdnJkbWFfbWFp
bi5jOjYyMDoKKyAgICAvLyBSZW1hcCBjbWQgc2xvdAoKV0FSTklORzogbGluZSBvdmVyIDgwIGNo
YXJhY3RlcnMKIzYyOiBGSUxFOiBody9yZG1hL3Ztdy9wdnJkbWFfbWFpbi5jOjYyMjoKKyAgICBk
ZXYtPmRzcl9pbmZvLnJlcSA9IHJkbWFfcGNpX2RtYV9tYXAocGNpX2RldiwgZGV2LT5kc3JfaW5m
by5kc3ItPmNtZF9zbG90X2RtYSwKCkVSUk9SOiBkbyBub3QgdXNlIEM5OSAvLyBjb21tZW50cwoj
NzA6IEZJTEU6IGh3L3JkbWEvdm13L3B2cmRtYV9tYWluLmM6NjMwOgorICAgIC8vIFJlbWFwIHJz
cCBzbG90CgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojNzI6IEZJTEU6IGh3L3Jk
bWEvdm13L3B2cmRtYV9tYWluLmM6NjMyOgorICAgIGRldi0+ZHNyX2luZm8ucnNwID0gcmRtYV9w
Y2lfZG1hX21hcChwY2lfZGV2LCBkZXYtPmRzcl9pbmZvLmRzci0+cmVzcF9zbG90X2RtYSwKCnRv
dGFsOiAzIGVycm9ycywgMiB3YXJuaW5ncywgNzcgbGluZXMgY2hlY2tlZAoKQ29tbWl0IDIxYzJi
MzA3N2E2YyAoaHcvcHZyZG1hOiBBZGQgbGl2ZSBtaWdyYXRpb24gc3VwcG9ydCkgaGFzIHN0eWxl
IHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFs
c2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRD
SCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVk
IHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNo
ZXcub3JnL2xvZ3MvMjAxOTA2MjExNDQ1NDEuMTM3NzAtMS1za3J0Ymh0bmdyQGdtYWlsLmNvbS90
ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


