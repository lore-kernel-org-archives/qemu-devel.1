Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B97AC07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 14:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D34217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 14:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D34217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46546 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVGTz-0002GS-Gm
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 10:20:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hVGSa-0001aW-J7
	for qemu-devel@nongnu.org; Mon, 27 May 2019 10:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hVGSY-0007Sv-JT
	for qemu-devel@nongnu.org; Mon, 27 May 2019 10:18:44 -0400
Resent-Date: Mon, 27 May 2019 10:18:43 -0400
Resent-Message-Id: <E1hVGSY-0007Sv-JT@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hVGSX-0007RJ-BO
	for qemu-devel@nongnu.org; Mon, 27 May 2019 10:18:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1558960292; cv=none; d=zoho.com; s=zohoarc; 
	b=Up3mkOkZzo5yLOrPSffioIGDEAwBBGBq1SumubItra6n53rNpFGjrg6fdmdIaheHUAmYPN3peIS1eL9wfYoGcGHHQPEMIF+5L5JpaACU/Ixg99SWrdkRPvvgKh3N1D0w9YMmUyymB6f7oD7fhVkSUanDx1jEpKWzS0ygk2nCqO0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1558960292;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=+vWsj462XklaqwLz+g3S9gUdbsUbVxmkeAhbKqPrkQM=; 
	b=nmFjI3JjU3OPHrdrH1Gir5FHwFGveoGx90iQ34vcZQEafa1X4GMeRN/c5fPzNdq6P0KpHjpbvwUsT7pLpPgZViNdfAZC/BH89FO6DrMd4msr4vRvQi55m0BkDhgKKxyisDwDfQUR543BY7GeMQ838iCBIZGq/lHQKHJ3aAGP91M=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1558960291339723.0272863463014;
	Mon, 27 May 2019 05:31:31 -0700 (PDT)
In-Reply-To: <20190527114203.2762-1-eric.auger@redhat.com>
Message-ID: <155896028968.24.17330667446250277041@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eric.auger@redhat.com
Date: Mon, 27 May 2019 05:31:31 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
Subject: Re: [Qemu-devel] [RFC v4 00/27] vSMMUv3/pSMMUv3 2 stage VFIO
 integration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, drjones@redhat.com, yi.l.liu@intel.com,
	mst@redhat.com, jean-philippe.brucker@arm.com,
	zhangfei.gao@foxmail.com, qemu-devel@nongnu.org,
	peterx@redhat.com, eric.auger@redhat.com,
	alex.williamson@redhat.com, qemu-arm@nongnu.org,
	vincent.stehle@arm.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDUyNzExNDIwMy4yNzYy
LTEtZXJpYy5hdWdlckByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCBidWls
ZCB0ZXN0IG9uIHMzOTB4IGhvc3QuIFBsZWFzZSBmaW5kIHRoZSBkZXRhaWxzIGJlbG93LgoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAojIFRlc3Rpbmcgc2NyaXB0IHdpbGwg
YmUgaW52b2tlZCB1bmRlciB0aGUgZ2l0IGNoZWNrb3V0IHdpdGgKIyBIRUFEIHBvaW50aW5nIHRv
IGEgY29tbWl0IHRoYXQgaGFzIHRoZSBwYXRjaGVzIGFwcGxpZWQgb24gdG9wIG9mICJiYXNlIgoj
IGJyYW5jaApzZXQgLWUKQ0M9JEhPTUUvYmluL2NjCklOU1RBTEw9JFBXRC9pbnN0YWxsCkJVSUxE
PSRQV0QvYnVpbGQKbWtkaXIgLXAgJEJVSUxEICRJTlNUQUxMClNSQz0kUFdECmNkICRCVUlMRAok
U1JDL2NvbmZpZ3VyZSAtLWNjPSRDQyAtLXByZWZpeD0kSU5TVEFMTAptYWtlIC1qNAojIFhYWDog
d2UgbmVlZCByZWxpYWJsZSBjbGVhbiB1cAojIG1ha2UgY2hlY2sgLWo0IFY9MQptYWtlIGluc3Rh
bGwKCmVjaG8KZWNobyAiPT09IEVOViA9PT0iCmVudgoKZWNobwplY2hvICI9PT0gUEFDS0FHRVMg
PT09IgpycG0gLXFhCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgcHBjLXNvZnRt
bXUvaHcvZGlzcGxheS92Z2EubwogIENDICAgICAgbWlwcy1zb2Z0bW11L2h3L21pcHMvbWlwc19y
NGsubwovdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtb2FxZm14dTUvc3JjL2h3L3BwYy9zcGFw
cl9pb21tdS5jOiBJbiBmdW5jdGlvbiDigJhzcGFwcl90Y2VfcmVwbGF54oCZOgovdmFyL3RtcC9w
YXRjaGV3LXRlc3Rlci10bXAtb2FxZm14dTUvc3JjL2h3L3BwYy9zcGFwcl9pb21tdS5jOjE2MTox
NDogZXJyb3I6IOKAmElPTU1VTm90aWZpZXLigJkge2FrYSDigJhzdHJ1Y3QgSU9NTVVOb3RpZmll
cuKAmX0gaGFzIG5vIG1lbWJlciBuYW1lZCDigJhub3RpZnnigJkKICAxNjEgfCAgICAgICAgICAg
ICBuLT5ub3RpZnkobiwgJmlvdGxiKTsKICAgICAgfCAgICAgICAgICAgICAgXn4KbWFrZVsxXTog
KioqIFsvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtb2FxZm14dTUvc3JjL3J1bGVzLm1hazo2
OTogaHcvcHBjL3NwYXByX2lvbW11Lm9dIEVycm9yIDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxh
YmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwNTI3MTE0MjAzLjI3NjItMS1lcmlj
LmF1Z2VyQHJlZGhhdC5jb20vdGVzdGluZy5zMzkweC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9d
LgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


