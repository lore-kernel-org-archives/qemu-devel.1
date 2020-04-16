Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AC4C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C325B206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C325B206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPBXx-0001MP-UX
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 16:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jPBXK-0000fQ-5O
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jPBXI-0006Wz-HY
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:55:01 -0400
Resent-Date: Thu, 16 Apr 2020 16:55:01 -0400
Resent-Message-Id: <E1jPBXI-0006Wz-HY@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21371)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jPBXI-0006WH-9o
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:55:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587070488; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WLq7YCzhD/+zp6LHcdgfWWwkWIv1wIBTxUWoAJGCERUFkkfz0x8chsJeRRPlE/gUn3Y3m8ndPAvHlLm8T9PWRXDXVI7SyquNwXIAOKD9E9+q+ftOA67R6GtvbNS60Rf6McIBlW4m8fOmS04NSPby2kyEKs0vub9DwGjK8o71qxc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587070488;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=2jAjJWTqYyPqRh6DAri9+pCCo+YlXidja5KNgpuuHS4=; 
 b=LJfDCs6dKx+V+9euwLgZPAZyShdgHF/+UfYQNY/5vSU2C2lwpsj28RXcCcmvJacpbF7pL8zYtpjd95NM0+8wrLc/gvElNvhB7kN7nzcpMSsNPWv3Kdw2Szi6mtODqCv89KA8mXho3+CT11FqX79wCx6mcXsW25KPypLUYNI/wrM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587070485572483.2663549725967;
 Thu, 16 Apr 2020 13:54:45 -0700 (PDT)
In-Reply-To: <20200416195641.13144.16955.stgit@localhost.localdomain>
Subject: Re: [PATCH v20 QEMU 0/5] virtio-balloon: add support for free page
 reporting
Message-ID: <158707048437.15335.13907227918434557974@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alexander.duyck@gmail.com
Date: Thu, 16 Apr 2020 13:54:45 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.53
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQxNjE5NTY0MS4xMzE0
NC4xNjk1NS5zdGdpdEBsb2NhbGhvc3QubG9jYWxkb21haW4vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
c2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxv
dyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2MjAgUUVNVSAwLzVdIHZp
cnRpby1iYWxsb29uOiBhZGQgc3VwcG9ydCBmb3IgZnJlZSBwYWdlIHJlcG9ydGluZwpNZXNzYWdl
LWlkOiAyMDIwMDQxNjE5NTY0MS4xMzE0NC4xNjk1NS5zdGdpdEBsb2NhbGhvc3QubG9jYWxkb21h
aW4KVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdp
dCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hl
Y2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKU3dp
dGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwozM2RlNWM4IHZpcnRpby1iYWxsb29uOiBQcm92
aWRlIGFuIGludGVyZmFjZSBmb3IgZnJlZSBwYWdlIHJlcG9ydGluZwoyMGNkOWQyIGxpbnV4LWhl
YWRlcnM6IHVwZGF0ZSB0byBjb250YWluIHZpcml0by1iYWxsb29uIGZyZWUgcGFnZSByZXBvcnRp
bmcKZmU5YTI5YiB2aXJ0aW8tYmFsbG9vbjogSW1wbGVtZW50IHN1cHBvcnQgZm9yIHBhZ2UgcG9p
c29uIHRyYWNraW5nIGZlYXR1cmUKNTgyNDAyMiB2aXJ0aW8tYmFsbG9vbjogUmVwbGFjZSBmcmVl
IHBhZ2UgaGludGluZyByZWZlcmVuY2VzIHRvICdyZXBvcnQnIHdpdGggJ2hpbnQnCjlmY2Y5NTUg
bGludXgtaGVhZGVyczogVXBkYXRlIHRvIGFsbG93IHJlbmFtaW5nIG9mIGZyZWVfcGFnZV9yZXBv
cnRfY21kX2lkCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzUgQ2hlY2tpbmcgY29tbWl0IDlmY2Y5
NTVjZTVkNyAobGludXgtaGVhZGVyczogVXBkYXRlIHRvIGFsbG93IHJlbmFtaW5nIG9mIGZyZWVf
cGFnZV9yZXBvcnRfY21kX2lkKQoyLzUgQ2hlY2tpbmcgY29tbWl0IDU4MjQwMjI2YzExNiAodmly
dGlvLWJhbGxvb246IFJlcGxhY2UgZnJlZSBwYWdlIGhpbnRpbmcgcmVmZXJlbmNlcyB0byAncmVw
b3J0JyB3aXRoICdoaW50JykKMy81IENoZWNraW5nIGNvbW1pdCBmZTlhMjliYTE1MjEgKHZpcnRp
by1iYWxsb29uOiBJbXBsZW1lbnQgc3VwcG9ydCBmb3IgcGFnZSBwb2lzb24gdHJhY2tpbmcgZmVh
dHVyZSkKNC81IENoZWNraW5nIGNvbW1pdCAyMGNkOWQyZDA4NDUgKGxpbnV4LWhlYWRlcnM6IHVw
ZGF0ZSB0byBjb250YWluIHZpcml0by1iYWxsb29uIGZyZWUgcGFnZSByZXBvcnRpbmcpCjUvNSBD
aGVja2luZyBjb21taXQgMzNkZTVjOGJiMmY2ICh2aXJ0aW8tYmFsbG9vbjogUHJvdmlkZSBhbiBp
bnRlcmZhY2UgZm9yIGZyZWUgcGFnZSByZXBvcnRpbmcpCkVSUk9SOiBjb2RlIGluZGVudCBzaG91
bGQgbmV2ZXIgdXNlIHRhYnMKIzY4OiBGSUxFOiBody92aXJ0aW8vdmlydGlvLWJhbGxvb24uYzoz
NjQ6CiteSV5JKHJhbV9vZmZzZXQgKyBzaXplKSA+IHFlbXVfcmFtX2dldF91c2VkX2xlbmd0aChy
YikpIHskCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDk0IGxpbmVzIGNoZWNrZWQKClBh
dGNoIDUvNSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhl
c2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWlu
ZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpU
ZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFi
bGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA0MTYxOTU2NDEuMTMxNDQuMTY5NTUu
c3RnaXRAbG9jYWxob3N0LmxvY2FsZG9tYWluL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==

