Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9190C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 20:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A770D2082C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 20:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A770D2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i89Ig-0003xy-OX
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 16:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i89GM-0002ct-CM
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 16:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i89GK-0002ut-QO
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 16:30:50 -0400
Resent-Date: Wed, 11 Sep 2019 16:30:50 -0400
Resent-Message-Id: <E1i89GK-0002ut-QO@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i89GK-0002tR-HB
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 16:30:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568233838; cv=none; d=zoho.com; s=zohoarc; 
 b=DHSA9zDsoEBd3SlIu1wYWXUk0/3Sox9Djx6oqosccyS5RpV50C5Iilhe+2Nu7mT4N9D+b7nZodumtAdtQmUVLP9XfmFBG3+H4VDyzmUfiDyL41NbeZAJ0uffqUqUNY7nzs8HMN1Awv0W5gwug/Mrv2+blVSZXce+5Mh38dHbmj8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568233838;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=Nxz2R59YhsSslgFSRxJesZCg+OPlTwix7VuAUKvAu4g=; 
 b=E7Rp7sfy/sqdYupxXO2Jtc+TWy9qlhY4fOGc8ALg6zvcBr63hmgsSIgXPKKFF4xBw+HXDLQxeL85vrOV5biggN9QCAlbatQZk5DmTgmIGTt7p0spBPa33Ilv2N4/mGcFwe4bJrceg5dQKtxYQBhkKxEdfhHjvMdN3bcA5ucW00s=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568233836150511.626194386296;
 Wed, 11 Sep 2019 13:30:36 -0700 (PDT)
In-Reply-To: <20190911164202.31136-1-dgilbert@redhat.com>
Message-ID: <156823383488.20553.1335158513492542230@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dgilbert@redhat.com
Date: Wed, 11 Sep 2019 13:30:36 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.58
Subject: Re: [Qemu-devel] [PATCH 0/3] Automatic RCU read unlock
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
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxMTE2NDIwMi4zMTEz
Ni0xLWRnaWxiZXJ0QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggMC8zXSBBdXRvbWF0aWMg
UkNVIHJlYWQgdW5sb2NrCk1lc3NhZ2UtaWQ6IDIwMTkwOTExMTY0MjAyLjMxMTM2LTEtZGdpbGJl
cnRAcmVkaGF0LmNvbQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEv
YmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29u
ZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJl
bmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4v
c2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBF
TkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0
ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYmYzM2JlOSBtaWdyYXRpb246IFVzZSBh
dXRvbWF0aWMgcmN1X3JlYWQgdW5sb2NrIGluIHJkbWEuYwpjNjRmMmY0IG1pZ3JhdGlvbjogVXNl
IGF1dG9tYXRpYyByY3VfcmVhZCB1bmxvY2sgaW4gcmFtLmMKYWY2YTYwOCByY3U6IEFkZCBhdXRv
bWF0aWNhbGx5IHJlbGVhc2VkIHJjdV9yZWFkX2xvY2sgdmFyaWFudAoKPT09IE9VVFBVVCBCRUdJ
TiA9PT0KMS8zIENoZWNraW5nIGNvbW1pdCBhZjZhNjA4YjkwOGQgKHJjdTogQWRkIGF1dG9tYXRp
Y2FsbHkgcmVsZWFzZWQgcmN1X3JlYWRfbG9jayB2YXJpYW50KQpFUlJPUjogTWFjcm9zIHdpdGgg
bXVsdGlwbGUgc3RhdGVtZW50cyBzaG91bGQgYmUgZW5jbG9zZWQgaW4gYSBkbyAtIHdoaWxlIGxv
b3AKIzMzOiBGSUxFOiBpbmNsdWRlL3FlbXUvcmN1Lmg6MTY1OgorI2RlZmluZSBSQ1VfUkVBRF9M
T0NLX0FVVE8gZ19hdXRvKHJjdV9yZWFkX2F1dG9fdCkgXAorICAgIF9yY3VfcmVhZF9hdXRvID0g
J3gnOyBcCisgICAgcmN1X3JlYWRfbG9jaygpOwoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdz
LCAxOCBsaW5lcyBjaGVja2VkCgpQYXRjaCAxLzMgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
CjIvMyBDaGVja2luZyBjb21taXQgYzY0ZjJmNGM5MjNmIChtaWdyYXRpb246IFVzZSBhdXRvbWF0
aWMgcmN1X3JlYWQgdW5sb2NrIGluIHJhbS5jKQozLzMgQ2hlY2tpbmcgY29tbWl0IGJmMzNiZTk1
OWMyYiAobWlncmF0aW9uOiBVc2UgYXV0b21hdGljIHJjdV9yZWFkIHVubG9jayBpbiByZG1hLmMp
Cj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkw
OTExMTY0MjAyLjMxMTM2LTEtZGdpbGJlcnRAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gv
P3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


