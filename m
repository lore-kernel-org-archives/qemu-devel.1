Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C2EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 17:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2674E2075A
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 17:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2674E2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3NSv-00050g-G0
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 13:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k3NSI-0004T7-Ru; Wed, 05 Aug 2020 13:43:58 -0400
Resent-Date: Wed, 05 Aug 2020 13:43:58 -0400
Resent-Message-Id: <E1k3NSI-0004T7-Ru@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k3NSG-0002UK-8K; Wed, 05 Aug 2020 13:43:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1596649418; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hga758tI4tU8E6QVDwHNnl2Kdj052lotG25nNeF8g0GPD6KPN5EyiJAcXtkWhg+C8Bf7Y3s0KCWI0QsOZkdJqaUTkyVitBPkdNKTRKFDC1oMHUNyFsDKb98r3m3biG0b1AVd4DX9qeFXApdTo0USsvne2gPfLCw7QgbkJJI4h6s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1596649418;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=eDQcR4VfeVorZFUeMmbteCXXbXCcKTDExMfmYrUbs1o=; 
 b=bJFR3ByMQmucyEtGDxQHlSq97vHuZYMc5/m++yOmGeHsqmbydWVdNgDgKNWgjC9R6uGWtbSiUHQxOKeCeMci9ZTwoXj2A66a54DQ0xoBJ8Hmt69x60F494VblIpb0ze8nYcKh2UfqueNodlu3nXBh2Lcq2Kqi7tZHqSYxTskTyc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1596649415437113.76968660679393;
 Wed, 5 Aug 2020 10:43:35 -0700 (PDT)
Subject: Re: [PATCH for-5.2 0/5] spapr: Cleanups for XIVE and PHB
Message-ID: <159664941485.23552.17842967884430546114@66eaa9a8a123>
In-Reply-To: <159664891296.638781.18417631893299150932.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: groug@kaod.org
Date: Wed, 5 Aug 2020 10:43:35 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 13:43:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_BL_SPAMCOP_NET=1.347,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, danielhb@linux.ibm.com, qemu-ppc@nongnu.org,
 clg@kaod.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTk2NjQ4OTEyOTYuNjM4Nzgx
LjE4NDE3NjMxODkzMjk5MTUwOTMyLnN0Z2l0QGJhaGlhLmxhbi8KCgoKSGksCgpUaGlzIHNlcmll
cyBmYWlsZWQgdGhlIGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQg
dGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUg
RG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4K
Cj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82
NAptYWtlIGRvY2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2Vy
LXRlc3QtbWluZ3dAZmVkb3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09
CgoKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dz
LzE1OTY2NDg5MTI5Ni42Mzg3ODEuMTg0MTc2MzE4OTMyOTkxNTA5MzIuc3RnaXRAYmFoaWEubGFu
L3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQ
bGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

