Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D79C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:04:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F05207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F05207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5F2D-0001sf-MP
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 16:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i5F0D-0000aI-30
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:02:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i5F0B-0001tV-En
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:02:08 -0400
Resent-Date: Tue, 03 Sep 2019 16:02:08 -0400
Resent-Message-Id: <E1i5F0B-0001tV-En@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21406)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i5F0B-0001sI-5W
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:02:07 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1567540913; cv=none; d=zoho.com; s=zohoarc; 
 b=C04pRlEXrcCb+s2mt6tgdOMw9wAysEle4O+BtfxF+xzfMVtHuxSOzTrQ63O7qGQt8KNmi3e+zl/rZeNiX0WE5sJM/AVsXDt2KeEUM5/G79crY9bnRyehQvShMVG+3Ky9PPSO9VtVrmdos8wgFUYo+7CojSmsLxawgF2k1XWERbk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1567540913;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=GACBE60ZPOyOYYnW4Op7R9dkD8eW5AjfjiCk/80VWek=; 
 b=YqOP89joavFNARdFBa+etsvPjWEHWIe7qCOdNJUz0VihKZZHZUCLKGomJc614q2bLfoEv56g/gw0aiq47OfHuwmJVic0DGLqJjsaUmjekAw38Rb2ZlbdW+YEtHWTcq7Suc2EtS8vqtQoZMTAguhc+WUry5eCt3epgkCNABfq1DQ=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1567540905374280.23947387488204;
 Tue, 3 Sep 2019 13:01:45 -0700 (PDT)
In-Reply-To: <20190903195442.11199-1-johannes@sipsolutions.net>
Message-ID: <156754090412.19886.2937803515149098449@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: johannes@sipsolutions.net
Date: Tue, 3 Sep 2019 13:01:45 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH] libvhost-user: fix SLAVE_SEND_FD handling
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
Cc: tiwei.bie@intel.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 johannes.berg@intel.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkwMzE5NTQ0Mi4xMTE5
OS0xLWpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMg
dG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IK
bW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MDkwMzE5NTQ0
Mi4xMTE5OS0xLWpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQKU3ViamVjdDogW1FlbXUtZGV2ZWxd
IFtQQVRDSF0gbGlidmhvc3QtdXNlcjogZml4IFNMQVZFX1NFTkRfRkQgaGFuZGxpbmcKCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rl
di9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sg
YmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4
MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcK
OWRhNTg0ZiBsaWJ2aG9zdC11c2VyOiBmaXggU0xBVkVfU0VORF9GRCBoYW5kbGluZwoKPT09IE9V
VFBVVCBCRUdJTiA9PT0KRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwoj
MzA6IEZJTEU6IGNvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11c2VyLmM6MTEwMToKK15J
XkkgICAgIFZIT1NUX1VTRVJfUFJPVE9DT0xfRl9TTEFWRV9TRU5EX0ZEKSkgeyQKCnRvdGFsOiAx
IGVycm9ycywgMCB3YXJuaW5ncywgOSBsaW5lcyBjaGVja2VkCgpDb21taXQgOWRhNTg0ZjUyMzYw
IChsaWJ2aG9zdC11c2VyOiBmaXggU0xBVkVfU0VORF9GRCBoYW5kbGluZykgaGFzIHN0eWxlIHBy
b2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2Ug
cG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBp
biBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdp
dGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMjAxOTA5MDMxOTU0NDIuMTExOTktMS1qb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0
L3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


