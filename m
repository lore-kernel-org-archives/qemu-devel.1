Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75718C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 18:48:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4769320652
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 18:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4769320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38408 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLuH2-0008Em-Ds
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 14:48:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLuG7-0007x7-T4
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLuG6-0003WD-NS
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:47:11 -0400
Resent-Date: Wed, 01 May 2019 14:47:11 -0400
Resent-Message-Id: <E1hLuG6-0003WD-NS@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hLuG5-0003U8-JY
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:47:10 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556736416; cv=none; d=zoho.com; s=zohoarc; 
	b=Jbs1IJIfUlt5AhmsBoqtRPaXQ1vMvHIClogvR81ZBvLAZIuLHezmXUP0gMghxuGBlvHYoDdrMos230MlBrIf8kMUPWUzgZwXni/X3+1ytbtkRi0SwiKZNtqgE+MipNPbFUbDtvbzhD6T/u2cbUCvceAfu1n82bsQphJxoC7ffsQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556736416;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=7+2eeYx3mRhgh8LJaJyQQ1LPBKgYRnVUpvouJrxtSU0=; 
	b=IVCZi6bNRAA8LyqBh0rWSF7w68BuRMhMogOVkYzle3Ztrj/F4viqMCOa9vAKvHK/+SFLVTvS0cT++FPpatZtyKYtWcoO0UKeCXHiyUQxWp0RrWzrx3lMtEpDHM1C/7DDRxuGPDGPMLJleV/ZwuT6C197IYPf8VEFoFHEfm7Rtug=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556736414595463.24715568508304;
	Wed, 1 May 2019 11:46:54 -0700 (PDT)
In-Reply-To: <20190501184306.15208-1-richard.henderson@linaro.org>
Message-ID: <155673641354.10667.5985564310999267637@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Wed, 1 May 2019 11:46:54 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
Subject: Re: [Qemu-devel] [PATCH] tests/tcg/alpha: add system boot.S
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: fam@euphon.net, alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501184654.FAnqz5ShZGAzBKvy7EKzrJVC4u_CaYFWTI4hSYTJ6Aw@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDUwMTE4NDMwNi4xNTIw
OC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MDUwMTE4
NDMwNi4xNTIwOC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSF0gdGVzdHMvdGNnL2FscGhhOiBhZGQgc3lzdGVtIGJvb3QuUwoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2
L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBi
YXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4Nzgy
MTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1w
cm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE5MDUwMTE4
NDMwNi4xNTIwOC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcgLT4gcGF0Y2hldy8yMDE5
MDUwMTE4NDMwNi4xNTIwOC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcKU3dpdGNoZWQg
dG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo5NjE4ZDgzYjc2IHRlc3RzL3RjZy9hbHBoYTogYWRkIHN5
c3RlbSBib290LlMKCj09PSBPVVRQVVQgQkVHSU4gPT09CldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBv
ciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzE1OiAK
bmV3IGZpbGUgbW9kZSAxMDA2NDQKCkVSUk9SOiB0cmFpbGluZyB3aGl0ZXNwYWNlCiMyMDg6IEZJ
TEU6IHRlc3RzL3RjZy9hbHBoYS9zeXN0ZW0vYm9vdC5TOjE1MToKK15JLyogJAoKRVJST1I6IHRy
YWlsaW5nIHdoaXRlc3BhY2UKIzIzMzogRklMRTogdGVzdHMvdGNnL2FscGhhL3N5c3RlbS9ib290
LlM6MTc2OgorXkkvKiAkCgp0b3RhbDogMiBlcnJvcnMsIDEgd2FybmluZ3MsIDU3MyBsaW5lcyBj
aGVja2VkCgpDb21taXQgOTYxOGQ4M2I3NjRmICh0ZXN0cy90Y2cvYWxwaGE6IGFkZCBzeXN0ZW0g
Ym9vdC5TKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhl
c2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWlu
ZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRl
c3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJs
ZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDUwMTE4NDMwNi4xNTIwOC0xLXJpY2hh
cmQuaGVuZGVyc29uQGxpbmFyby5vcmcvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2Uu
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBy
ZWRoYXQuY29t


