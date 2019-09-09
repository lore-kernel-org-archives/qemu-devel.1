Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0884C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 12:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35EA20693
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 12:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35EA20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7JB1-0002AR-SO
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 08:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i7J9y-0001Nb-1Q
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 08:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i7J9w-0006QB-V3
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 08:52:45 -0400
Resent-Date: Mon, 09 Sep 2019 08:52:45 -0400
Resent-Message-Id: <E1i7J9w-0006QB-V3@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21444)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i7J9w-0006Pw-Nm
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 08:52:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568033552; cv=none; d=zoho.com; s=zohoarc; 
 b=Qz7hh44BuQbmNGTzDRjh8wBs1ntDiByNZi+Ql2nDF6KvXE0V9kC6zMhQ/55owP+riWHSOoSZMIB6NDGTRT8vyJ8gcUoj7T9zMZW/Q0W7TR/sQza7csLEd9A87oMM9IMN0+lTP2HuevVY1mSyqnnbfV+aPrEGSh1Jv63wJiQeyp4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568033552;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=JYBiLTUUfSGJatI/8tNru+qRkVfYr1TW+4kppj/74N0=; 
 b=VZAgfLmPevFvxYFfdf8cOB+unIU03eLnfNBfUUnp07t+I+VAP4mquo4tEOJC/A85tJZVYC1cSaWUXqmlykLEy5Wppvnsajpbtspbuh9UkY8B+Vkf2GNXLXHSW3Ke6UVeVkva24viFGQnu8kiUZ3JupbZ9ncmhK5c2vSSCeId4gs=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568033550579389.39173106749377;
 Mon, 9 Sep 2019 05:52:30 -0700 (PDT)
In-Reply-To: <20190909104948.30253-1-yury-kotov@yandex-team.ru>
Message-ID: <156803354892.8620.13423294099487473319@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: yury-kotov@yandex-team.ru
Date: Mon, 9 Sep 2019 05:52:30 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.54
Subject: Re: [Qemu-devel] [PATCH v6 0/3] High downtime with 95+ throttle pct
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
Cc: lvivier@redhat.com, thuth@redhat.com, quintela@redhat.com, sw@weilnetz.de,
 dgilbert@redhat.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkwOTEwNDk0OC4zMDI1
My0xLXl1cnkta290b3ZAeWFuZGV4LXRlYW0ucnUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVk
IHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0
aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBp
bnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1mZWRvcmEg
Vj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3JhIEo9MTQgTkVU
V09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgoKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxh
YmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwOTA5MTA0OTQ4LjMwMjUzLTEteXVy
eS1rb3RvdkB5YW5kZXgtdGVhbS5ydS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=


