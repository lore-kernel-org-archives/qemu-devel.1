Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2055EC1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 13:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD8220663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 13:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD8220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCNgY-0003lL-2q
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 09:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jCNfv-0003H8-4b
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jCNft-00067T-3h
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:14:58 -0400
Resent-Date: Thu, 12 Mar 2020 09:14:58 -0400
Resent-Message-Id: <E1jCNft-00067T-3h@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21199)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jCNfs-0005ws-QH
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:14:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584018874; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HfbO/aiLprqPoDN70rvVWpHQzjAw51pJV5AhWa78qjP1+aAErzMfGNflE8rVP+kn57q5r8m5QooXVdrpsX0/RYix3O/MaZOu7bqvWtqcvRkzxriXtm8udndcB1i5yM/p3fdMalDytvrkMF8C12dIy5ZlbuvBqQIyRh0PNdQEcCk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584018874;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=uLmiIbbMvMMPhQfXpRvc9YIt6Fbew15z5+W3uQq3gnw=; 
 b=C+hR92av7ssqaPKhSPSkhsYqVRh/Ky9RSpqs5TaAUMBQieTRgJcwVq2UMo80riDI4EAgviKwIzZwx0tcQyzshPhJprOFG3861Lay2IDLfNJD3Dyl1/JqNFxC1YCYbMs4Q7OJQvNVB0xyQXmlLGmAk1fQ/YxXhmK6FokFdjRQL+w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1584018872527310.454762274769;
 Thu, 12 Mar 2020 06:14:32 -0700 (PDT)
In-Reply-To: <20200312125524.7812-1-jandryuk@gmail.com>
Subject: Re: [PATCH 0/4] usb-serial: xHCI and timeout fixes
Message-ID: <158401887145.15607.4367755462902255111@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jandryuk@gmail.com
Date: Thu, 12 Mar 2020 06:14:32 -0700 (PDT)
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
Cc: samuel.thibault@ens-lyon.org, jandryuk@gmail.com, kraxel@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxMjEyNTUyNC43ODEy
LTEtamFuZHJ5dWtAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggMC80XSB1c2Itc2VyaWFsOiB4SENJIGFuZCB0aW1l
b3V0IGZpeGVzCk1lc3NhZ2UtaWQ6IDIwMjAwMzEyMTI1NTI0Ljc4MTItMS1qYW5kcnl1a0BnbWFp
bC5jb20KVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNo
CmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRy
dWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMv
Y2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
VXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hl
ZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjY1N2VlZTMgdXNiLXNlcmlhbDogRml4IHRpbWVvdXQg
Y2xvc2luZyB0aGUgZGV2aWNlCjI5OWNlMzcgdXNiLXNlcmlhbDogSW5jcmVhc2UgcmVjZWl2ZSBi
dWZmZXIgdG8gNDk2CjgwNDExZTMgdXNiLXNlcmlhbDogY2h1bmsgZGF0YSB0byB3TWF4UGFja2V0
U2l6ZQoxZDkzMzI2IHVzYi1zZXJpYWw6IE1vdmUgVVNCX1RPS0VOX0lOIGludG8gYSBoZWxwZXIg
ZnVuY3Rpb24KCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvNCBDaGVja2luZyBjb21taXQgMWQ5MzMy
NjcxYTBkICh1c2Itc2VyaWFsOiBNb3ZlIFVTQl9UT0tFTl9JTiBpbnRvIGEgaGVscGVyIGZ1bmN0
aW9uKQpFUlJPUjogYnJhY2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRoaXMg
c3RhdGVtZW50CiM0NDogRklMRTogaHcvdXNiL2Rldi1zZXJpYWwuYzozODQ6CisgICAgaWYgKGxl
biA+IHMtPnJlY3ZfdXNlZCkKWy4uLl0KCkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBm
b3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzUwOiBGSUxFOiBody91c2IvZGV2LXNlcmlh
bC5jOjM5MDoKKyAgICBpZiAoZmlyc3RfbGVuID4gbGVuKQpbLi4uXQoKRVJST1I6IGJyYWNlcyB7
fSBhcmUgbmVjZXNzYXJ5IGZvciBhbGwgYXJtcyBvZiB0aGlzIHN0YXRlbWVudAojNTQ6IEZJTEU6
IGh3L3VzYi9kZXYtc2VyaWFsLmM6Mzk0OgorICAgIGlmIChsZW4gPiBmaXJzdF9sZW4pClsuLi5d
Cgp0b3RhbDogMyBlcnJvcnMsIDAgd2FybmluZ3MsIDk0IGxpbmVzIGNoZWNrZWQKClBhdGNoIDEv
NCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJy
b3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNl
ZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMi80IENoZWNraW5nIGNvbW1pdCA4MDQxMWUz
YzdlODUgKHVzYi1zZXJpYWw6IGNodW5rIGRhdGEgdG8gd01heFBhY2tldFNpemUpCkVSUk9SOiBi
cmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzgw
OiBGSUxFOiBody91c2IvZGV2LXNlcmlhbC5jOjM5NToKKyAgICAgICAgaWYgKGxlbiA+IHMtPnJl
Y3ZfdXNlZCkKWy4uLl0KCkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFy
bXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzg0OiBGSUxFOiBody91c2IvZGV2LXNlcmlhbC5jOjM5OToK
KyAgICAgICAgaWYgKGZpcnN0X2xlbiA+IGxlbikKWy4uLl0KCkVSUk9SOiBicmFjZXMge30gYXJl
IG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzg4OiBGSUxFOiBody91
c2IvZGV2LXNlcmlhbC5jOjQwMzoKKyAgICAgICAgaWYgKGxlbiA+IGZpcnN0X2xlbikKWy4uLl0K
CnRvdGFsOiAzIGVycm9ycywgMCB3YXJuaW5ncywgNjMgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi80
IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJv
cnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2Vl
CkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgozLzQgQ2hlY2tpbmcgY29tbWl0IDI5OWNlMzdh
MWY2MyAodXNiLXNlcmlhbDogSW5jcmVhc2UgcmVjZWl2ZSBidWZmZXIgdG8gNDk2KQo0LzQgQ2hl
Y2tpbmcgY29tbWl0IDY1N2VlZTNjZTgzZiAodXNiLXNlcmlhbDogRml4IHRpbWVvdXQgY2xvc2lu
ZyB0aGUgZGV2aWNlKQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0
aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5v
cmcvbG9ncy8yMDIwMDMxMjEyNTUyNC43ODEyLTEtamFuZHJ5dWtAZ21haWwuY29tL3Rlc3Rpbmcu
Y2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2Fs
bHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZl
ZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

