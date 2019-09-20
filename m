Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10676C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6C8C2080F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C8C2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBK9Y-0000cl-B1
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 10:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iBK6t-0007A7-Oc
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iBK6r-0000T2-G2
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:42:11 -0400
Resent-Date: Fri, 20 Sep 2019 10:42:11 -0400
Resent-Message-Id: <E1iBK6r-0000T2-G2@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21832)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iBK6r-0000S1-7n
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:42:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568990517; cv=none; d=zoho.com; s=zohoarc; 
 b=eb9M2xDdE6EzdDS2vXuIgJAuJVm1+6S3y71wa4XV5LU/PCpYMsN19WUTdBeShTCOWb0AeZQ5hS3Yug4YEgOKmVfOLq4Qn7rPtPt3E/yCUChvP7aakwBR30XrLuvMlnkYeSKmwFY28kM7DXILCnjRiGY0nvTz30fq5WZ72Kh+4mc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568990517;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=YQ7gSNQAg0b4/JbcL23UoRS3NLm/D90+xHoxx+yftIo=; 
 b=QWmcBxL8W/7AADqCKv0yvzhmivZ7XwtAVacH8uQqel//JR5hWezpuj/g4Z2ssIX1T3bS19nh1tFGzdj7whL1MTDV8CbQOesEWr7Be5+66UHpGDEZDkw64AEx4eu0/mw5/JA1miyBiMzM9VMduqUjYxPfPHnbmmem41FQ4KipYTc=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568990516549984.3001467735547;
 Fri, 20 Sep 2019 07:41:56 -0700 (PDT)
In-Reply-To: <20190919194847.18518-1-tasleson@redhat.com>
Subject: Re: [RFC 0/4] POC: Generating realistic block errors
Message-ID: <156899051548.5071.17196629745357857637@1c8ae44fe5c0>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: tasleson@redhat.com
Date: Fri, 20 Sep 2019 07:41:56 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.58
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxOTE5NDg0Ny4xODUx
OC0xLXRhc2xlc29uQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXIt
aW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZl
ZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIGh3
L21pc2MvYXJtX3N5c2N0bC5vCiAgQ0MgICAgICBody9taXNjL2NidXMubwovdG1wL3FlbXUtdGVz
dC9zcmMvaHcvaWRlL2FoY2kuYzogSW4gZnVuY3Rpb24gJ2V4ZWN1dGVfbmNxX2NvbW1hbmQnOgov
dG1wL3FlbXUtdGVzdC9zcmMvaHcvaWRlL2FoY2kuYzoxMDk0OjMxOiBlcnJvcjogZm9ybWF0ICcl
bHUnIGV4cGVjdHMgYXJndW1lbnQgb2YgdHlwZSAnbG9uZyB1bnNpZ25lZCBpbnQnLCBidXQgYXJn
dW1lbnQgMyBoYXMgdHlwZSAndWludDY0X3QnIHtha2EgJ2xvbmcgbG9uZyB1bnNpZ25lZCBpbnQn
fSBbLVdlcnJvcj1mb3JtYXQ9XQogICAgICAgICBzcHJpbnRmKGRldmljZV9pZCwgIiVsdSIsIGlk
ZV9zdGF0ZS0+d3duKTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICB+fl4gICB+fn5+fn5+
fn5+fn5+fgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICVsbHUKCgpUaGUgZnVsbCBsb2cg
aXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwOTE5MTk0ODQ3LjE4
NTE4LTEtdGFzbGVzb25AcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5
cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcg
W2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRj
aGV3LWRldmVsQHJlZGhhdC5jb20=


