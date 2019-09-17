Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA6EC4CECE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 17:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE1B2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 17:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE1B2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAH8d-0003Ia-Nx
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 13:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iAH3D-0007VH-B9
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iAH3B-0003WH-Rm
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:14:03 -0400
Resent-Date: Tue, 17 Sep 2019 13:14:02 -0400
Resent-Message-Id: <E1iAH3B-0003WH-Rm@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iAH3B-0003RK-Jz
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:14:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568740422; cv=none; d=zoho.com; s=zohoarc; 
 b=VyIUOe/FAWnKCaTvOfOmO67MRurUVGkSLaVYSO0FHh2jzxuypiRQMFT7ysmWWxnw/N+WF0C5ww8+VIzpf9qb46EmwiS0uM6xc4UphZZjuJxmFdqzLApQDpHw1mrECPcKX2T/R4u+W2hfjuSFk1Jq5uSzIxklkDaZozKPKNFLlzE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568740422;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=XeHE4m+ToCnrX4GsQ+nk4uCfY5Hsxv/S5y+wxJP1I9g=; 
 b=i+t1+HeYE3rvDOLXUZAeLxRPzhRPfHWYitkT7pzGa8fqRM9kHVl57LDAjGe4VZdpojLueXjUtaER++Fce/JK5mtukQP05RmuwShMb/55QNwkcuWA8CAKs1m0uo1mwz/BoXFQ1DxoNOgwi5gG3D3pyIVozhaJiZSPiCjK5yDdUgo=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568740419857356.26365306637206;
 Tue, 17 Sep 2019 10:13:39 -0700 (PDT)
In-Reply-To: <20190917122559.15555-1-johannes@sipsolutions.net>
Message-ID: <156874041879.17151.16130048479476261479@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: johannes@sipsolutions.net
Date: Tue, 17 Sep 2019 10:13:39 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.54
Subject: Re: [Qemu-devel] [PATCH] libvhost-user: handle NOFD flag in
 call/kick/err better
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
Cc: qemu-devel@nongnu.org, johannes.berg@intel.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxNzEyMjU1OS4xNTU1
NS0xLWpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVk
IHRoZSBhc2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFu
ZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBj
YW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRp
bWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9eDg2XzY0LXNvZnRt
bXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCi4vdGVzdHMvZG9ja2Vy
L2RvY2tlci5weSAtLWVuZ2luZSBhdXRvIGJ1aWxkIHFlbXU6ZmVkb3JhIHRlc3RzL2RvY2tlci9k
b2NrZXJmaWxlcy9mZWRvcmEuZG9ja2VyICAgLS1hZGQtY3VycmVudC11c2VyICAKSW1hZ2UgaXMg
dXAgdG8gZGF0ZS4KICBMRCAgICAgIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYS5tbwpjYzogZmF0
YWwgZXJyb3I6IG5vIGlucHV0IGZpbGVzCmNvbXBpbGF0aW9uIHRlcm1pbmF0ZWQuCm1ha2U6ICoq
KiBbZG9ja2VyLXRlc3QtZGVidWdAZmVkb3JhLm1vXSBFcnJvciA0CgoKClRoZSBmdWxsIGxvZyBp
cyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA5MTcxMjI1NTkuMTU1
NTUtMS1qb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0L3Rlc3RpbmcuYXNhbi8/dHlwZT1tZXNzYWdl
LgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==


