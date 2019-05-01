Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33822C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 01:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C6820866
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 01:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C6820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57858 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLdhd-000545-6Y
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 21:06:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLdgl-0004kX-GK
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 21:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLdgh-0001DB-Gq
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 21:05:35 -0400
Resent-Date: Tue, 30 Apr 2019 21:05:34 -0400
Resent-Message-Id: <E1hLdgh-0001DB-Gq@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hLdgf-00018E-P9
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 21:05:31 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556672715; cv=none; d=zoho.com; s=zohoarc; 
	b=IM2KFfOGf1tUoh/rp7FHfBYYV9caXzK+HS2PQbEQ/BWlUB6QMUmxP1GR5GbPgPOWAO4SHXP+MvuuOBtF0xAY+IzZN3Jy74eyYw+khAG/UJ/uu1AlZegGxECO/rguPBfjXtFMZ2SsWZAy/Brnl6F6amBHLLMjKOykWTA5VQkInSg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556672715;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=DRNJif7mLO7Yfco+NE172MK20jIGn87GtLl6oIXp3Yo=; 
	b=dtNQUxBLQqTVz3r89XVxvyP0kg6Jh0Vh35UeS2T5pYwdDhAPBAUpqx6MEw/bh4SbzFSiXjRP7RE62kHhqhXFCrhaRnrRIS4tMsGZHfHSSr3KtpyI/KI+DidfZzxFuDlTzFJ5vzEyxSbsQJXRLQEgWdnc58X8UZZnDqeQYVl2ar4=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556672712571362.6632281387283;
	Tue, 30 Apr 2019 18:05:12 -0700 (PDT)
In-Reply-To: <20190429064830.12213-1-yangchuanlong@huawei.com>
Message-ID: <155667271162.10667.10565135523714508826@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: yangchuanlong@huawei.com
Date: Tue, 30 Apr 2019 18:05:12 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v1] target/arm/arm-powerctl: mask the cpuid
 with affinity bits when get cpu
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
Cc: fam@euphon.net, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501010512.BrqRi1-eaA7LW8Vnwq9uHxs0A-A80Ap6cjf6vjdtkmc@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyOTA2NDgzMC4xMjIx
My0xLXlhbmdjaHVhbmxvbmdAaHVhd2VpLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGFzYW4gYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMgYW5k
CnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91IGNh
biBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9
PT0KIyEvYmluL2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRf
TElTVD14ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09
PQoKCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9n
cy8yMDE5MDQyOTA2NDgzMC4xMjIxMy0xLXlhbmdjaHVhbmxvbmdAaHVhd2VpLmNvbS90ZXN0aW5n
LmFzYW4vP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5
IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFj
ayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


