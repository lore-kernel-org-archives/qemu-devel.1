Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B39CC48BDA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 15:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47D092080C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 15:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D092080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg9gd-0001xC-IQ
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 11:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40415)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hg9eN-0001EC-IX
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 11:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hg9eK-0004gY-41
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 11:15:55 -0400
Resent-Date: Wed, 26 Jun 2019 11:15:55 -0400
Resent-Message-Id: <E1hg9eK-0004gY-41@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21857)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hg9eJ-0004T6-SB
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 11:15:52 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561562113; cv=none; d=zoho.com; s=zohoarc; 
 b=kT4F7NuMM/SS0Sn1n5BtC/jlyIwucOCPqdu/cVJcopZP5U2uxQhJ0wwAEqdXgvEIpEIBcWyaX5sAaus74LLXHOD1pDD4961SHLlLGP2yI3EYhTqLEDK0NiiHE1/OpGL/5EWRBXnK/v6RrpnA35BwKNPM34BWST/Kk4gjW6NlDvg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561562113;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=EqG8LubwFKuAzbKCwz9z7Kd0IyME9mquLZ4k77WE63I=; 
 b=Jsw+tjZz2y1CZtNgHvETeFA+sJG+DoFciq1/s6RIINDySy7rkW7twtZlddnQiaekgvzmdRP1116sRDFSJ6IpMuQBj4wGqnH/aH73AQYB27N2hmIYpWymiVXhLagY7SybhSHnHJ1f0xQpCF2MLG9H4VYcyUWpy907TKOHJabJBhY=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561562111588248.91895174243075;
 Wed, 26 Jun 2019 08:15:11 -0700 (PDT)
Message-ID: <156156211053.6332.18156620782204988441@c4a48874b076>
In-Reply-To: <20190626150855.27446-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Wed, 26 Jun 2019 08:15:11 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
Subject: Re: [Qemu-devel] [PATCH] linux-user: move
 QEMU_IFLA_BR_MULTI_BOOLOPT to the good function
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
Cc: riku.voipio@iki.fi, qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYyNjE1MDg1NS4yNzQ0
Ni0xLWxhdXJlbnRAdml2aWVyLmV1LwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCBidWlsZCB0
ZXN0IG9uIHMzOTB4IGhvc3QuIFBsZWFzZSBmaW5kIHRoZSBkZXRhaWxzIGJlbG93LgoKCgoKCgpU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkw
NjI2MTUwODU1LjI3NDQ2LTEtbGF1cmVudEB2aXZpZXIuZXUvdGVzdGluZy5zMzkweC8/dHlwZT1t
ZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0
cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXct
ZGV2ZWxAcmVkaGF0LmNvbQ==


