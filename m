Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867B0C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 18:11:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60ABC21670
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 18:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60ABC21670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAHx1-0002TR-Hd
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 14:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iAHwD-0001cv-Rr
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iAHwC-0004wk-P1
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:10:53 -0400
Resent-Date: Tue, 17 Sep 2019 14:10:53 -0400
Resent-Message-Id: <E1iAHwC-0004wk-P1@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21421)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iAHwC-0004w5-HZ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:10:52 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568743836; cv=none; d=zoho.com; s=zohoarc; 
 b=TYyIEtqBoZ+GTH4pT0I3dgyVtggB5l0wUGRy4GJ3QlaXudN21Qe1MoMhletXn/4hi57+xMZLsu97hmlYc6auQOCTnhUhbeWFoyXsT+vQevrVye8aLE+RbnQbfj0ycSLaAjY43Dju+51L88gIoZXcgdSR5UKI9NEzLPBR5Xp9st0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568743836;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=C+1ohvCZYYB8OxXA6ak8hUcrtJMdFF0j6XWv9wg4+h4=; 
 b=BCzl91n6ghboRPPJwivsmPJnYGgdY/Oe9+xGa3JyRlorLal5oPUd8L4W2XSTkgPpEN6fJi46jrgKWVx7eGVKLnKdLSxQ70921DfCFZvPvhrIiyypZsOeWewepR9/mtnBOYNo/boKBpZ1LaLiv0v4/lpZKkcdYrVUYF4+8orFw3c=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568743834491459.0097083817162;
 Tue, 17 Sep 2019 11:10:34 -0700 (PDT)
In-Reply-To: <156872146565.1757.3033215873677512474.stgit@pasha-Precision-3630-Tower>
Message-ID: <156874383189.17151.10736945008014961739@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pavel.dovgaluk@gmail.com
Date: Tue, 17 Sep 2019 11:10:34 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.54
Subject: Re: [Qemu-devel] [for-4.2 PATCH 0/6] Block-related record/replay
 fixes
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com,
 artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com,
 jasowang@redhat.com, crosthwaite.peter@gmail.com, qemu-devel@nongnu.org,
 armbru@redhat.com, dovgaluk@ispras.ru, maria.klimushenkova@ispras.ru,
 mst@redhat.com, kraxel@redhat.com, pavel.dovgaluk@ispras.ru,
 thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com,
 alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTY4NzIxNDY1NjUuMTc1Ny4z
MDMzMjE1ODczNjc3NTEyNDc0LnN0Z2l0QHBhc2hhLVByZWNpc2lvbi0zNjMwLVRvd2VyLwoKCgpI
aSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0
LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93
LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVj
ZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKbWFr
ZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0
LW1pbmd3QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKLi90
ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IC0tZW5naW5lIGF1dG8gYnVpbGQgcWVtdTpmZWRvcmEgdGVz
dHMvZG9ja2VyL2RvY2tlcmZpbGVzL2ZlZG9yYS5kb2NrZXIgICAtLWFkZC1jdXJyZW50LXVzZXIg
IApJbWFnZSBpcyB1cCB0byBkYXRlLgogIExEICAgICAgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3Jh
Lm1vCmNjOiBmYXRhbCBlcnJvcjogbm8gaW5wdXQgZmlsZXMKY29tcGlsYXRpb24gdGVybWluYXRl
ZC4KbWFrZTogKioqIFtkb2NrZXItdGVzdC1taW5nd0BmZWRvcmEubW9dIEVycm9yIDQKCgoKVGhl
IGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTY4NzIx
NDY1NjUuMTc1Ny4zMDMzMjE1ODczNjc3NTEyNDc0LnN0Z2l0QHBhc2hhLVByZWNpc2lvbi0zNjMw
LVRvd2VyL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9y
Zy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNv
bQ==


