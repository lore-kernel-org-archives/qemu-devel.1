Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97EDFA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 17:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE08520663
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 17:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE08520663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKmgM-0002k7-PN
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 13:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iKmeN-0001SX-R4
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iKmeL-0007ed-O0
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:59:51 -0400
Resent-Date: Wed, 16 Oct 2019 12:59:51 -0400
Resent-Message-Id: <E1iKmeL-0007ed-O0@eggs.gnu.org>
Received: from sender4-of-o56.zoho.com ([136.143.188.56]:21648)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iKmeL-0007dS-GT
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:59:49 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571245168; cv=none; d=zoho.com; s=zohoarc; 
 b=il5NbTN/F4otVH3yt8VwEP83plSgsSSosWJfiaqft/Qh/UGpnx1Xib6d60taSZaxA3cgQCU+zAUr80avFi9RdmWUqRX3oZ1gPw/iiytotpO3BJjCis0HAEb1vY0StkSzahf8wwfAWb0PgGx2ExYBLwvibGbP9yZf6KFJXJJWC6g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1571245168;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=tkJinSKyeIuzQVy9IflZLdWehrdt0KSub8ODZeIz1aM=; 
 b=GVX5WJXvFoWewbCYzguxyelEHkRDlHeJKUa1Sb1dfFVONq57nx3QxPewszVQItO8AUR7iPnbn2AF0JmvTcrVdN6JElH+LQhFQxTQeEhFbomcdhPuAAaX3Dv3OTWQFIWMjdIo25l1m4NQdb5I1bmHz4op32h4BQalbrK3xqHE7Nc=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571245167962308.84090933448977;
 Wed, 16 Oct 2019 09:59:27 -0700 (PDT)
In-Reply-To: <20191016073240.12473-1-mkysel@tachyum.com>
Subject: Re: [PATCH] Added hardfloat conversion from float32 to float64
Message-ID: <157124516664.16217.6578718152335165244@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mkysel@tachyum.com
Date: Wed, 16 Oct 2019 09:59:27 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.56
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org,
 aurelien@aurel32.net, mkysel@tachyum.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAxNjA3MzI0MC4xMjQ3
My0xLW1reXNlbEB0YWNoeXVtLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIXSBBZGRlZCBoYXJkZmxvYXQgY29udmVyc2lvbiBm
cm9tIGZsb2F0MzIgdG8gZmxvYXQ2NApUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTEwMTYw
NzMyNDAuMTI0NzMtMS1ta3lzZWxAdGFjaHl1bS5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9
PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9n
cmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFND
UklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjRhZjBmZjcgQWRk
ZWQgaGFyZGZsb2F0IGNvbnZlcnNpb24gZnJvbSBmbG9hdDMyIHRvIGZsb2F0NjQKCj09PSBPVVRQ
VVQgQkVHSU4gPT09CkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJyonIChjdHg6
V3hWKQojMjc6IEZJTEU6IGZwdS9zb2Z0ZmxvYXQuYzoxOTI0Ogorc29mdF9mbG9hdDMyX3RvX2Zs
b2F0NjQoZmxvYXQzMiBhLCBmbG9hdF9zdGF0dXMgKnMpCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3Vu
ZCB0aGF0ICcqJyAoY3R4Old4VikKIzM0OiBGSUxFOiBmcHUvc29mdGZsb2F0LmM6MTkzMToKK2Zs
b2F0NjQgZmxvYXQzMl90b19mbG9hdDY0KGZsb2F0MzIgYSwgZmxvYXRfc3RhdHVzICpzdGF0dXMp
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgp0
b3RhbDogMiBlcnJvcnMsIDAgd2FybmluZ3MsIDI3IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCA0YWYw
ZmY3MzIyZmIgKEFkZGVkIGhhcmRmbG9hdCBjb252ZXJzaW9uIGZyb20gZmxvYXQzMiB0byBmbG9h
dDY0KSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2Ug
ZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIs
IHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3Qg
Y29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBh
dApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTAxNjA3MzI0MC4xMjQ3My0xLW1reXNlbEB0
YWNoeXVtLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdl
bmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4K
UGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


