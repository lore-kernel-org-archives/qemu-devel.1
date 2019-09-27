Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F3BC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 01:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A47D3206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 01:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47D3206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDfX2-0007fw-Lw
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 21:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iDfWB-0007Dc-1F
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 21:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iDfW9-00036l-95
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 21:57:58 -0400
Resent-Date: Thu, 26 Sep 2019 21:57:58 -0400
Resent-Message-Id: <E1iDfW9-00036l-95@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21555)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iDfW9-000343-0j
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 21:57:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569546748; cv=none; d=zoho.com; s=zohoarc; 
 b=coHOtxKyzzN47LVoz1PQ8tLb1VKENUH0wzqbAHlFgkoT6wvqhZFTC+ZJ5dhUkIMHZrBlhuAo5Hefaw3F8zxF/wUBI0IFLSkJq9DWSNaB5neRPbc4Gt4tCtGLotNHSemcfz9ZBYpiQ5pKfY0abFhC97/fYI8nToxQ0pazeMq5RTs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1569546748;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=iqjU14P25KadcqcVanWMjIRa6wilym6NNzwvYFB4ilU=; 
 b=C19AduaKDsVVVvwDbO3v2WkQmOuO8eESOAsw2Pusen4MQxWSWBm5etyKjmC4T03dYAQUiW/3qh7+s/zZmBqNw6i/ynld1E28Xn1ZRk7gGfgALzl1T3WFOTLalp8VkYj2156Sn8buVYTpWGT/SNNUJd/nGX+HW6nh/AoeMr94kSo=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1569546746543456.618197154035;
 Thu, 26 Sep 2019 18:12:26 -0700 (PDT)
Subject: Re: [PATCH v3] qga: add command guest-get-devices for reporting
 VirtIO devices
In-Reply-To: <919bbd6e0557d2fe2d9c17de394cc0b4c6fa4426.1569445204.git.tgolembi@redhat.com>
Message-ID: <156954674521.23674.9914013622784989955@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: tgolembi@redhat.com
Date: Thu, 26 Sep 2019 18:12:26 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.55
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
Cc: marcandre.lureau@redhat.com, tgolembi@redhat.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS85MTliYmQ2ZTA1NTdkMmZlMmQ5
YzE3ZGUzOTRjYzBiNGM2ZmE0NDI2LjE1Njk0NDUyMDQuZ2l0LnRnb2xlbWJpQHJlZGhhdC5jb20v
CgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9i
bGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmll
cwpNZXNzYWdlLWlkOiA5MTliYmQ2ZTA1NTdkMmZlMmQ5YzE3ZGUzOTRjYzBiNGM2ZmE0NDI2LjE1
Njk0NDUyMDQuZ2l0LnRnb2xlbWJpQHJlZGhhdC5jb20KU3ViamVjdDogW1BBVENIIHYzXSBxZ2E6
IGFkZCBjb21tYW5kIGd1ZXN0LWdldC1kZXZpY2VzIGZvciByZXBvcnRpbmcgVmlydElPIGRldmlj
ZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBi
YXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVs
aW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0t
bWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0byBhIG5l
dyBicmFuY2ggJ3Rlc3QnCjQyYzI5MTkgcWdhOiBhZGQgY29tbWFuZCBndWVzdC1nZXQtZGV2aWNl
cyBmb3IgcmVwb3J0aW5nIFZpcnRJTyBkZXZpY2VzCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJP
UjogIihmb28qKSIgc2hvdWxkIGJlICIoZm9vICopIgojMTU1OiBGSUxFOiBxZ2EvY29tbWFuZHMt
d2luMzIuYzoyMzE2OgorICAgIHZhbHVlcyA9IGdfYXJyYXlfbmV3KFRSVUUsIFRSVUUsIHNpemVv
ZihnY2hhciopKTsKCkVSUk9SOiAiZm9vKiBiYXIiIHNob3VsZCBiZSAiZm9vICpiYXIiCiMxNTc6
IEZJTEU6IHFnYS9jb21tYW5kcy13aW4zMi5jOjIzMTg6CisgICAgICAgIGdjaGFyKiBpZDggPSBn
X3V0ZjE2X3RvX3V0ZjgoaWQsIC0xLCBOVUxMLCBOVUxMLCBOVUxMKTsKCnRvdGFsOiAyIGVycm9y
cywgMCB3YXJuaW5ncywgMjgxIGxpbmVzIGNoZWNrZWQKCkNvbW1pdCA0MmMyOTE5ZmI5MzUgKHFn
YTogYWRkIGNvbW1hbmQgZ3Vlc3QtZ2V0LWRldmljZXMgZm9yIHJlcG9ydGluZyBWaXJ0SU8gZGV2
aWNlcykgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNl
IGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVy
LCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0
IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUg
YXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvOTE5YmJkNmUwNTU3ZDJmZTJkOWMxN2RlMzk0Y2Mw
YjRjNmZhNDQyNi4xNTY5NDQ1MjA0LmdpdC50Z29sZW1iaUByZWRoYXQuY29tL3Rlc3RpbmcuY2hl
Y2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkg
YnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRi
YWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


