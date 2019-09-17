Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7E2C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E3920665
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E3920665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAGPz-00023L-HS
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 12:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iAGG9-0002X2-Cz
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iAGG8-0004rf-8x
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:23:21 -0400
Resent-Date: Tue, 17 Sep 2019 12:23:21 -0400
Resent-Message-Id: <E1iAGG8-0004rf-8x@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21587)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iAGG8-0004pL-02
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:23:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568737390; cv=none; d=zoho.com; s=zohoarc; 
 b=bRsIlNiPv/9y/RJ8ARaFEBGYZdLEgu93j97lndazwdpQV+TDrULkUjKVnAuAG0pRZz2tbVhKADQFch4KlAoEeS5Zg7AbaopeHE+zbCdRoWtVPv9qLUPxHmpayBFR3u9+KdfFHtCYNm6CLDTjLmdsNGPZJAXwhrgBKu1EfgIOd4U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568737390;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=YMIhBew8O4CtQyjctfNJJ1nlM+t0wYQoDvQpelwV5Ro=; 
 b=SD2192QZvSJUvNcS18wDxvwNiyAfteKmnDpYNsZntkpEHumyGygIEDFIU2zOwsesyotIid2aAcuFOmJEROrkGk7+MToNWWZWC5es/XeXSy7zBDNi3DgOQfc22F2oeHTx8uqtXo9e+qchcHL/cccJcBMb92AJtgEn/SDf6Hxelbk=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568737389694658.4046738810689;
 Tue, 17 Sep 2019 09:23:09 -0700 (PDT)
In-Reply-To: <20190917111441.27405-1-kraxel@redhat.com>
Message-ID: <156873738857.17151.7067327846844653377@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Tue, 17 Sep 2019 09:23:09 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v3 0/2] ati: fix ati_cursor_define bug.
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
Cc: kraxel@redhat.com, qemu-devel@nongnu.org, flier_m@outlook.com,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxNzExMTQ0MS4yNzQw
NS0xLWtyYXhlbEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojISAvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRX
T1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9
PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IC0tZW5naW5l
IGF1dG8gYnVpbGQgcWVtdTpmZWRvcmEgdGVzdHMvZG9ja2VyL2RvY2tlcmZpbGVzL2ZlZG9yYS5k
b2NrZXIgICAtLWFkZC1jdXJyZW50LXVzZXIgIApJbWFnZSBpcyB1cCB0byBkYXRlLgogIExEICAg
ICAgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3JhLm1vCmNjOiBmYXRhbCBlcnJvcjogbm8gaW5wdXQg
ZmlsZXMKY29tcGlsYXRpb24gdGVybWluYXRlZC4KbWFrZTogKioqIFtkb2NrZXItdGVzdC1taW5n
d0BmZWRvcmEubW9dIEVycm9yIDQKCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDkxNzExMTQ0MS4yNzQwNS0xLWtyYXhlbEByZWRoYXQu
Y29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9d
LgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


