Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F79C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 23:33:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE5F21D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 23:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE5F21D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDGnE-0007Ie-Tb
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 19:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iDGlj-0006CH-Ev
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 19:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iDGle-00041S-Ej
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 19:32:19 -0400
Resent-Date: Wed, 25 Sep 2019 19:32:19 -0400
Resent-Message-Id: <E1iDGle-00041S-Ej@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21558)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iDGld-0003wl-HG
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 19:32:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569454321; cv=none; d=zoho.com; s=zohoarc; 
 b=iSVAsN75EMNmhy8SeYqN77YLIe0GzuMsRz6G2XXJyfQswNnZdIRCVfB0K7LpvFmmnY7mXweBDoghjWLCMvdmECbY9zI9EVQmvFqsY6tFM0DnnxkKaGsSKNN+PNhCep1ByfZcj5zxEsVprv7O3BJ4rocWGNsDvAOl7MD8oUVb6Gs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1569454321;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=ZVKy0RJCpm6oZWQ9L/LpDR4JLix2TjF9sE/PeLFLL6I=; 
 b=V+4q1DZf2QQDngP14HpWd+hriuenHiOWRhZWTVODwkEJ7E+l38fzgIpvPM64whhY1Kt0UiiKCD9XVGPcTtfOjx2IR3BbeFgokOKuEo9Daeuo4M/RkDGRfsogjirI2fbeQ/NqeMd4ah/wPH4i6VpCm2XJapAYX5TWvFIJsCBcRHg=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1569454319623507.20554720743917;
 Wed, 25 Sep 2019 16:31:59 -0700 (PDT)
Subject: Re: [PATCH] docker: fix uid maping with podman
In-Reply-To: <4b9204cc8ade1c965dc5412c53c6f7c5b4f019a2.1569413332.git.tgolembi@redhat.com>
Message-ID: <156945431831.7374.10340030777705777822@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: tgolembi@redhat.com
Date: Wed, 25 Sep 2019 16:31:59 -0700 (PDT)
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
Cc: fam@euphon.net, alex.bennee@linaro.org, tgolembi@redhat.com,
 philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS80YjkyMDRjYzhhZGUxYzk2NWRj
NTQxMmM1M2M2ZjdjNWI0ZjAxOWEyLjE1Njk0MTMzMzIuZ2l0LnRnb2xlbWJpQHJlZGhhdC5jb20v
CgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBhc2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBm
aW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBo
YXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2Fs
bHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4
Nl82NAptYWtlIGRvY2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9j
a2VyLXRlc3QtZGVidWdAZmVkb3JhIFRBUkdFVF9MSVNUPXg4Nl82NC1zb2Z0bW11IEo9MTQgTkVU
V09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgoKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxh
YmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzRiOTIwNGNjOGFkZTFjOTY1ZGM1NDEyYzUz
YzZmN2M1YjRmMDE5YTIuMTU2OTQxMzMzMi5naXQudGdvbGVtYmlAcmVkaGF0LmNvbS90ZXN0aW5n
LmFzYW4vP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5
IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFj
ayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


