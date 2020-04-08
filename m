Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEC8C2D0F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 20:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4089A2072F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 20:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4089A2072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMHnS-0003pM-Dz
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 16:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jMHmh-000384-Mn
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 16:58:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jMHmg-000331-6R
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 16:58:55 -0400
Resent-Date: Wed, 08 Apr 2020 16:58:55 -0400
Resent-Message-Id: <E1jMHmg-000331-6R@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21703)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jMHmf-00030y-TS
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 16:58:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586379524; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZcqAlqU24mgd8hq20wByoOK2ZXXu46p/CE6lrw+fznqsrJzx54CMA716RylIhoI0f9DEpbiKpcsAhNbP8odzpDXlk91TY5rjzt0HjdA/ZGQhN/VsA5NSWvDjamkGNJRhmRwstNPM0iXnpP9pzlKDQbGiByrLUHj2QkJHqF0rbXA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586379524;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=/k8Ev4BtjiFiJjp9YwhwdMb4AM90J0N5Pphackcanp4=; 
 b=HQuSRZJtYAjQTWTcOTS2ZAvoxeMsO12R9hffjmkIst5Lt/R5OuwFTVmZCSkJ79ODb739HWks6sa9PTenkxM3lSoLsVy6jza96h3QsCNoLrkFRL4BthWjQb07LPHNZCnk7gyXNk8faVR/qCKU7g7+u6o15iD9Sie62sVv/98XtuE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586379522461720.0324022760435;
 Wed, 8 Apr 2020 13:58:42 -0700 (PDT)
In-Reply-To: <20200408194628.24143.51644.stgit@localhost.localdomain>
Subject: Re: [PATCH v17 RESUBMIT QEMU 0/3] virtio-balloon: add support for
 providing free page reporting
Message-ID: <158637952127.18042.11609267329459924847@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alexander.duyck@gmail.com
Date: Wed, 8 Apr 2020 13:58:42 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.57
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
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwODE5NDYyOC4yNDE0
My41MTY0NC5zdGdpdEBsb2NhbGhvc3QubG9jYWxkb21haW4vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
c2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxv
dyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2MTcgUkVTVUJNSVQgUUVN
VSAwLzNdIHZpcnRpby1iYWxsb29uOiBhZGQgc3VwcG9ydCBmb3IgcHJvdmlkaW5nIGZyZWUgcGFn
ZSByZXBvcnRpbmcKTWVzc2FnZS1pZDogMjAyMDA0MDgxOTQ2MjguMjQxNDMuNTE2NDQuc3RnaXRA
bG9jYWxob3N0LmxvY2FsZG9tYWluClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lO
ID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAw
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0
b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1Qg
U0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4
ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpjMWUxZTRjIHZpcnRpby1i
YWxsb29uOiBQcm92aWRlIGEgaW50ZXJmYWNlIGZvciBmcmVlIHBhZ2UgcmVwb3J0aW5nCmMzZmM0
YzUgdmlydGlvLWJhbGxvb246IEFkZCBzdXBwb3J0IGZvciBwcm92aWRpbmcgZnJlZSBwYWdlIHJl
cG9ydHMgdG8gaG9zdAozNDEwZjY1IHZpcnRpby1iYWxsb29uOiBJbXBsZW1lbnQgc3VwcG9ydCBm
b3IgcGFnZSBwb2lzb24gdHJhY2tpbmcgZmVhdHVyZQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8z
IENoZWNraW5nIGNvbW1pdCAzNDEwZjY1OTkyMTEgKHZpcnRpby1iYWxsb29uOiBJbXBsZW1lbnQg
c3VwcG9ydCBmb3IgcGFnZSBwb2lzb24gdHJhY2tpbmcgZmVhdHVyZSkKRVJST1I6IHRyYWlsaW5n
IHdoaXRlc3BhY2UKIzY4OiBGSUxFOiBody92aXJ0aW8vdmlydGlvLWJhbGxvb24uYzo3MDg6Cisg
ICAgZGV2LT5wb2lzb25fdmFsID0gdmlydGlvX3ZkZXZfaGFzX2ZlYXR1cmUodmRldiwgVklSVElP
X0JBTExPT05fRl9QQUdFX1BPSVNPTikgPyAkCgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFj
dGVycwojNjg6IEZJTEU6IGh3L3ZpcnRpby92aXJ0aW8tYmFsbG9vbi5jOjcwODoKKyAgICBkZXYt
PnBvaXNvbl92YWwgPSB2aXJ0aW9fdmRldl9oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fQkFMTE9P
Tl9GX1BBR0VfUE9JU09OKSA/IAoKdG90YWw6IDEgZXJyb3JzLCAxIHdhcm5pbmdzLCA3NiBsaW5l
cyBjaGVja2VkCgpQYXRjaCAxLzMgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjIvMyBDaGVj
a2luZyBjb21taXQgYzNmYzRjNWE5ZmMzICh2aXJ0aW8tYmFsbG9vbjogQWRkIHN1cHBvcnQgZm9y
IHByb3ZpZGluZyBmcmVlIHBhZ2UgcmVwb3J0cyB0byBob3N0KQozLzMgQ2hlY2tpbmcgY29tbWl0
IGMxZTFlNGM3ZjNkMSAodmlydGlvLWJhbGxvb246IFByb3ZpZGUgYSBpbnRlcmZhY2UgZm9yIGZy
ZWUgcGFnZSByZXBvcnRpbmcpCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRh
YnMKIzM2OiBGSUxFOiBody92aXJ0aW8vdmlydGlvLWJhbGxvb24uYzozMzA6CisgICAgXkl1bnNp
Z25lZCBpbnQgaTskCgpFUlJPUjogYnJhY2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1z
IG9mIHRoaXMgc3RhdGVtZW50CiM0NTogRklMRTogaHcvdmlydGlvL3ZpcnRpby1iYWxsb29uLmM6
MzM5OgorICAgICAgICAgICAgaWYgKHFlbXVfYmFsbG9vbl9pc19pbmhpYml0ZWQoKSB8fCBkZXYt
PnBvaXNvbl92YWwpClsuLi5dCgpFUlJPUjogYnJhY2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFs
bCBhcm1zIG9mIHRoaXMgc3RhdGVtZW50CiM1MjogRklMRTogaHcvdmlydGlvL3ZpcnRpby1iYWxs
b29uLmM6MzQ2OgorICAgICAgICAgICAgaWYgKChyYW1fb2Zmc2V0IHwgc2l6ZSkgJiAocmJfcGFn
ZV9zaXplIC0gMSkpClsuLi5dCgp0b3RhbDogMyBlcnJvcnMsIDAgd2FybmluZ3MsIDg0IGxpbmVz
IGNoZWNrZWQKClBhdGNoIDMvMyBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJ
ZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8g
dGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBV
VCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA0MDgxOTQ2Mjgu
MjQxNDMuNTE2NDQuc3RnaXRAbG9jYWxob3N0LmxvY2FsZG9tYWluL3Rlc3RpbmcuY2hlY2twYXRj
aC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0
Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

