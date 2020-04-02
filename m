Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32D8C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 20:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C654A20678
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 20:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C654A20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK6GZ-0006GN-Un
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 16:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jK6FW-00058U-Sn
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 16:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jK6FV-0002Jl-II
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 16:15:38 -0400
Resent-Date: Thu, 02 Apr 2020 16:15:38 -0400
Resent-Message-Id: <E1jK6FV-0002Jl-II@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21137)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jK6FT-0002Ht-Ok
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 16:15:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585858511; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ViMaKxVtkwjzjU191G1Raq+QXpAMQrEIMr5u29QWw/xn0q3qeJnY1lvCo+jDVZhxaXo3cVCe9YLpDWg7tYN91abD3BEzgygyicRCbMjeZQvecEtNRaOp8DhhGYbrCz85s2WPqApNfiSzzhNxCb/kwW0FkyAL7pacDAIqjjMxK7M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585858511;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=WSKSTOtWCX9hGBOh6bnx0lQ99szpCBLG9MYZu4Vp7sg=; 
 b=lU48rCPjbIZJD4MY7MXtKPdjK4F/H6Dud3NL0xLrt3E2CuiDgSnlcYnwRRtqnBwrWXF4rnnq8tmjIWtatPYMzXyXlmaz0BRSFZMkPb5tAmedYbd+J16fhweQOHxAd0VF4+UOvQQn3dg28PEvDrxTBXWZVl5rt40dk+tKNXM8A1E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585858508173777.7769702140223;
 Thu, 2 Apr 2020 13:15:08 -0700 (PDT)
In-Reply-To: <20200402182848.GA3023@simran-Inspiron-5558>
Subject: Re: [PATCH v3] qobject: json-streamer: Change bracket_count to
 brace_count
Message-ID: <158585850759.23425.4563496624463162546@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: singhalsimran0@gmail.com
Date: Thu, 2 Apr 2020 13:15:08 -0700 (PDT)
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
Cc: stefanha@gmail.com, jusual@mail.ru, qemu-devel@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwMjE4Mjg0OC5HQTMw
MjNAc2ltcmFuLUluc3Bpcm9uLTU1NTgvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBh
c2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVp
ciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJv
YmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMh
L2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1pbWFnZS1mZWRvcmEgVj0x
IE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtZGVidWdAZmVkb3JhIFRBUkdFVF9MSVNU
PXg4Nl82NC1zb2Z0bW11IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgoK
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIw
MjAwNDAyMTgyODQ4LkdBMzAyM0BzaW1yYW4tSW5zcGlyb24tNTU1OC90ZXN0aW5nLmFzYW4vP3R5
cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcg
W2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRj
aGV3LWRldmVsQHJlZGhhdC5jb20=

