Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C48ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687B82168B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687B82168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7yd8-0008UD-16
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 05:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i7yBO-0000pj-U9
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i7yBN-0008FP-35
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:40:58 -0400
Resent-Date: Wed, 11 Sep 2019 04:40:58 -0400
Resent-Message-Id: <E1i7yBN-0008FP-35@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21862)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i7yBM-0008Ef-TH
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:40:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568191234; cv=none; d=zoho.com; s=zohoarc; 
 b=WGoNoMZe/nxNTWmVS5yEDI9MNSaGv10A0dHXw4zZHnM3MX1AQ/gqdeHeXJr57nBFB7FAMHgMKQEFeTZlRASicwZ7JyxAoIRHuWGSs3XzjZ3ph+SHlZ5eNz9pFd0r9s10qnun0oNbalIboGbhxYrOyK3tTNvydc9Rvxqzd39R6j8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568191234;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=aTYaFs4wgiziJTG0ji8GTrz9u/fG7XFglHIlsglRMEw=; 
 b=YG3Ll+CDSDFIsRwq2oCO1oVWGKdjbiskvfVuQmkw2qYz0PgwfeJoOWbk+ccwpMMHI7JzEOKfNwRph0boreNJC6cKLbp7ad7hV4HAiCG3s0X+sn5coWas37vkGB1DHi8ZVtV3ZLTWaGfLfY9jKSYGjgkrpwnV28L4+Avh7FJX5DQ=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568191233000908.0023094851477;
 Wed, 11 Sep 2019 01:40:33 -0700 (PDT)
In-Reply-To: <20190910163600.19971-1-laurent@vivier.eu>
Message-ID: <156819123182.18674.16345102059641214447@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Wed, 11 Sep 2019 01:40:33 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.58
Subject: Re: [Qemu-devel] [PULL 00/15] Linux user for 4.2 patches
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
Cc: jcmvbkbc@gmail.com, riku.voipio@iki.fi, qemu-devel@nongnu.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxMDE2MzYwMC4xOTk3
MS0xLWxhdXJlbnRAdml2aWVyLmV1LwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BVTEwgMDAvMTVdIExpbnV4IHVzZXIg
Zm9yIDQuMiBwYXRjaGVzCk1lc3NhZ2UtaWQ6IDIwMTkwOTEwMTYzNjAwLjE5OTcxLTEtbGF1cmVu
dEB2aXZpZXIuZXUKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jp
bi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5h
bWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3Nj
cmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5E
ID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApG
cm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogLSBbdGFnIHVwZGF0
ZV0gICAgICBwYXRjaGV3L2NvdmVyLjE1NjY2MDM0MTIuZ2l0LmFsaXN0YWlyLmZyYW5jaXNAd2Rj
LmNvbSAtPiBwYXRjaGV3L2NvdmVyLjE1NjY2MDM0MTIuZ2l0LmFsaXN0YWlyLmZyYW5jaXNAd2Rj
LmNvbQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3L2NvdmVyLjE1NjgxNzA5OTQuZ2l0Lm1h
b3pob25neWlAY21zcy5jaGluYW1vYmlsZS5jb20gLT4gcGF0Y2hldy9jb3Zlci4xNTY4MTcwOTk0
LmdpdC5tYW96aG9uZ3lpQGNtc3MuY2hpbmFtb2JpbGUuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJy
YW5jaCAndGVzdCcKYmUyMmI5NSBsaW51eC11c2VyOiBBZGQgc3VwcG9ydCBmb3IgRkRSRVNFVCwg
RkRSQVdDTUQsIEZEVFdBRERMRSwgYW5kIEZERUpFQ1QgaW9jdGxzCjE4MTIxNjYgbGludXgtdXNl
cjogQWRkIHN1cHBvcnQgZm9yIEZETVNHT04gYW5kIEZETVNHT0ZGIGlvY3Rscwo0MDg4NGVkIGxp
bnV4LXVzZXI6IEFkZCBzdXBwb3J0IGZvciBGREZMVVNIIGlvY3RsCmQ1NzRiM2EgbGludXgtdXNl
cjogQWRkIHN1cHBvcnQgZm9yIEZJT0dFVE9XTiBhbmQgRklPU0VUT1dOIGlvY3RscwplMTZiOGRk
IGxpbnV4LXVzZXI6IEFkZCBzdXBwb3J0IGZvciBSTkRSRVNFRURDUk5HIGlvY3RsCjkyMjY2OWQg
bGludXgtdXNlcjogZHJvcCByZWR1bmRhbnQgaGFuZGxpbmcgb2YgZW52aXJvbm1lbnQgdmFyaWFi
bGVzCmRlYjE4ZGIgdGFyZ2V0L3h0ZW5zYTogbGludXgtdXNlcjogYWRkIGNhbGwwIEFCSSBzdXBw
b3J0CmE3MGRmOGEgbGludXgtdXNlcjogU3VwcG9ydCBnZGIgJ3FPZmZzZXRzJyBxdWVyeSBmb3Ig
RUxGCjJhZDNjNjggbGludXgtdXNlci9hcm06IEFkanVzdCBNQVhfUkVTRVJWRURfVkEgZm9yIE0t
cHJvZmlsZQpiNGFiNGFjIGxpbnV4LXVzZXI6IFBhc3MgQ1BVU3RhdGUgdG8gTUFYX1JFU0VSVkVE
X1ZBCmE1OWQ3ODggbGludXgtdXNlcjogYWRkIG1lbWZkX2NyZWF0ZQphNjg5MjEwIGxpbnV4LXVz
ZXI6IGZhaWwgYW5kIHJlcG9ydCBvbiBiYWQgZGZpbHRlciBzcGVjcwphNTAxOGRlIGxpbnV4LXVz
ZXI6IGVycm9uZW91cyBmZF90cmFuc191bnJlZ2lzdGVyIGNhbGwKZDNkY2Y5OSBsaW51eC11c2Vy
OiBBZGQgQVRfSFdDQVAyIGZvciBhYXJjaDY0LWxpbnV4LXVzZXIKMzM3OGE0MyBsaW51eC11c2Vy
OiByZW1vdmUgdXNlbGVzcyB2YXJpYWJsZQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8xNSBDaGVj
a2luZyBjb21taXQgMzM3OGE0MzJhNGZjIChsaW51eC11c2VyOiByZW1vdmUgdXNlbGVzcyB2YXJp
YWJsZSkKMi8xNSBDaGVja2luZyBjb21taXQgZDNkY2Y5OTkzZjkwIChsaW51eC11c2VyOiBBZGQg
QVRfSFdDQVAyIGZvciBhYXJjaDY0LWxpbnV4LXVzZXIpCjMvMTUgQ2hlY2tpbmcgY29tbWl0IGE1
MDE4ZGU4YzYxMiAobGludXgtdXNlcjogZXJyb25lb3VzIGZkX3RyYW5zX3VucmVnaXN0ZXIgY2Fs
bCkKRVJST1I6IEF1dGhvciBlbWFpbCBhZGRyZXNzIGlzIG1hbmdsZWQgYnkgdGhlIG1haWxpbmcg
bGlzdAojMjogCkF1dGhvcjogU2h1LUNodW4gV2VuZyB2aWEgUWVtdS1kZXZlbCA8cWVtdS1kZXZl
bEBub25nbnUub3JnPgoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA3IGxpbmVzIGNoZWNr
ZWQKClBhdGNoIDMvMTUgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55
IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBt
YWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjQvMTUgQ2hlY2tpbmcg
Y29tbWl0IGE2ODkyMTA3NjdkMiAobGludXgtdXNlcjogZmFpbCBhbmQgcmVwb3J0IG9uIGJhZCBk
ZmlsdGVyIHNwZWNzKQo1LzE1IENoZWNraW5nIGNvbW1pdCBhNTlkNzg4NjMyMjcgKGxpbnV4LXVz
ZXI6IGFkZCBtZW1mZF9jcmVhdGUpCkVSUk9SOiBBdXRob3IgZW1haWwgYWRkcmVzcyBpcyBtYW5n
bGVkIGJ5IHRoZSBtYWlsaW5nIGxpc3QKIzI6IApBdXRob3I6IFNodS1DaHVuIFdlbmcgdmlhIFFl
bXUtZGV2ZWwgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJu
aW5ncywgNDIgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNS8xNSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBs
ZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMg
cmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlO
RVJTLgoKNi8xNSBDaGVja2luZyBjb21taXQgYjRhYjRhY2VjNjViIChsaW51eC11c2VyOiBQYXNz
IENQVVN0YXRlIHRvIE1BWF9SRVNFUlZFRF9WQSkKNy8xNSBDaGVja2luZyBjb21taXQgMmFkM2M2
ODAwM2QzIChsaW51eC11c2VyL2FybTogQWRqdXN0IE1BWF9SRVNFUlZFRF9WQSBmb3IgTS1wcm9m
aWxlKQo4LzE1IENoZWNraW5nIGNvbW1pdCBhNzBkZjhhZjhkM2MgKGxpbnV4LXVzZXI6IFN1cHBv
cnQgZ2RiICdxT2Zmc2V0cycgcXVlcnkgZm9yIEVMRikKRVJST1I6IEF1dGhvciBlbWFpbCBhZGRy
ZXNzIGlzIG1hbmdsZWQgYnkgdGhlIG1haWxpbmcgbGlzdAojMjogCkF1dGhvcjogSm9zaCBLdW56
IHZpYSBRZW11LWRldmVsIDxxZW11LWRldmVsQG5vbmdudS5vcmc+Cgp0b3RhbDogMSBlcnJvcnMs
IDAgd2FybmluZ3MsIDggbGluZXMgY2hlY2tlZAoKUGF0Y2ggOC8xNSBoYXMgc3R5bGUgcHJvYmxl
bXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3Np
dGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1B
SU5UQUlORVJTLgoKOS8xNSBDaGVja2luZyBjb21taXQgZGViMThkYjQzYzJhICh0YXJnZXQveHRl
bnNhOiBsaW51eC11c2VyOiBhZGQgY2FsbDAgQUJJIHN1cHBvcnQpCjEwLzE1IENoZWNraW5nIGNv
bW1pdCA5MjI2NjlkMWFkNDcgKGxpbnV4LXVzZXI6IGRyb3AgcmVkdW5kYW50IGhhbmRsaW5nIG9m
IGVudmlyb25tZW50IHZhcmlhYmxlcykKMTEvMTUgQ2hlY2tpbmcgY29tbWl0IGUxNmI4ZGRmODJl
YiAobGludXgtdXNlcjogQWRkIHN1cHBvcnQgZm9yIFJORFJFU0VFRENSTkcgaW9jdGwpCjEyLzE1
IENoZWNraW5nIGNvbW1pdCBkNTc0YjNhM2VkNzUgKGxpbnV4LXVzZXI6IEFkZCBzdXBwb3J0IGZv
ciBGSU9HRVRPV04gYW5kIEZJT1NFVE9XTiBpb2N0bHMpCjEzLzE1IENoZWNraW5nIGNvbW1pdCA0
MDg4NGVkYmM0NWQgKGxpbnV4LXVzZXI6IEFkZCBzdXBwb3J0IGZvciBGREZMVVNIIGlvY3RsKQox
NC8xNSBDaGVja2luZyBjb21taXQgMTgxMjE2NjljOTY1IChsaW51eC11c2VyOiBBZGQgc3VwcG9y
dCBmb3IgRkRNU0dPTiBhbmQgRkRNU0dPRkYgaW9jdGxzKQoxNS8xNSBDaGVja2luZyBjb21taXQg
YmUyMmI5NTlkNjZmIChsaW51eC11c2VyOiBBZGQgc3VwcG9ydCBmb3IgRkRSRVNFVCwgRkRSQVdD
TUQsIEZEVFdBRERMRSwgYW5kIEZERUpFQ1QgaW9jdGxzKQo9PT0gT1VUUFVUIEVORCA9PT0KClRl
c3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJs
ZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDkxMDE2MzYwMC4xOTk3MS0xLWxhdXJl
bnRAdml2aWVyLmV1L3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9d
LgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


