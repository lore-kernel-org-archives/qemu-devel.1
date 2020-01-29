Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE8EC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C1920702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C1920702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwmV7-0003jF-1O
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 07:31:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iwmUV-0003AJ-D9
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:30:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iwmUT-0007N9-MM
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:30:43 -0500
Resent-Date: Wed, 29 Jan 2020 07:30:42 -0500
Resent-Message-Id: <E1iwmUT-0007N9-MM@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21171)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iwmUT-0007Gm-EB
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:30:41 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15803010264101019.3619179078395;
 Wed, 29 Jan 2020 04:30:26 -0800 (PST)
In-Reply-To: <20200129111906.9815-1-quintela@redhat.com>
Subject: Re: [PATCH] git: Make submodule check only needed modules
Message-ID: <158030102528.2099.18042295402438597597@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: quintela@redhat.com
Date: Wed, 29 Jan 2020 04:30:26 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDEyOTExMTkwNi45ODE1
LTEtcXVpbnRlbGFAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIXSBnaXQ6IE1ha2Ugc3VibW9kdWxlIGNoZWNrIG9u
bHkgbmVlZGVkIG1vZHVsZXMKTWVzc2FnZS1pZDogMjAyMDAxMjkxMTE5MDYuOTgxNS0xLXF1aW50
ZWxhQHJlZGhhdC5jb20KVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMh
L2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5y
ZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQou
L3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQg
RU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICog
W25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMDEyOTExMTkwNi45ODE1LTEtcXVpbnRlbGFA
cmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMjAwMTI5MTExOTA2Ljk4MTUtMS1xdWludGVsYUByZWRo
YXQuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMmY1ODQ3YyBnaXQ6IE1ha2Ug
c3VibW9kdWxlIGNoZWNrIG9ubHkgbmVlZGVkIG1vZHVsZXMKCj09PSBPVVRQVVQgQkVHSU4gPT09
CkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzI4OiBGSUxFOiBzY3Jp
cHRzL2dpdC1zdWJtb2R1bGUuc2g6NjM6CiteSUNVUlNUQVRVUz0kKCRHSVQgc3VibW9kdWxlIHN0
YXR1cyAkbW9kdWxlKSQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMK
IzI5OiBGSUxFOiBzY3JpcHRzL2dpdC1zdWJtb2R1bGUuc2g6NjQ6CiteSU9MRFNUQVRVUz0kKGNh
dCAkc3Vic3RhdCB8IGdyZXAgJG1vZHVsZSkkCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5l
dmVyIHVzZSB0YWJzCiMzMDogRklMRTogc2NyaXB0cy9naXQtc3VibW9kdWxlLnNoOjY1OgorXklp
ZiB0ZXN0ICIkQ1VSU1RBVFVTIiAhPSAiJE9MRFNUQVRVUyI7IHRoZW4kCgpFUlJPUjogY29kZSBp
bmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMzMTogRklMRTogc2NyaXB0cy9naXQtc3VibW9k
dWxlLnNoOjY2OgorXkkgICAgZXhpdCAxJAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZl
ciB1c2UgdGFicwojMzI6IEZJTEU6IHNjcmlwdHMvZ2l0LXN1Ym1vZHVsZS5zaDo2NzoKK15JZmkk
Cgp0b3RhbDogNSBlcnJvcnMsIDAgd2FybmluZ3MsIDE4IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCAy
ZjU4NDdjNzA1OTAgKGdpdDogTWFrZSBzdWJtb2R1bGUgY2hlY2sgb25seSBuZWVkZWQgbW9kdWxl
cykgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVy
cm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBz
ZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNv
bW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQK
aHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAxMjkxMTE5MDYuOTgxNS0xLXF1aW50ZWxhQHJl
ZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

