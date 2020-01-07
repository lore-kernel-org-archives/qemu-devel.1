Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156CDC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:10:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB81E206F0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB81E206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iongS-00044h-0I
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:10:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iondz-0007Hj-7q
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:07:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iondx-0006qv-E4
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:07:30 -0500
Resent-Date: Tue, 07 Jan 2020 07:07:30 -0500
Resent-Message-Id: <E1iondx-0006qv-E4@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iondx-0006qA-5l
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:07:29 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1578398838; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nvV5Se62xk4yMz18kPsWstz23DlWHLPsrzmOX6FvHTB4BqttUPOpb9qbE6H2rDenh5cK7ExRIH5xyx1ymZU9wsz1w89m+y4w4kVj/OQHBR2uaPomMmSFroHLId/Kt+Mfb/wd41KZWgNduTO07GYP61XyeU+wNY/1D00MQ5z+F7w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1578398838;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=geTzJvlc+ia8ImFaC1ep1s4AGCj9vbz8kY6URNBmlcA=; 
 b=O3Yt11d8k/+rXJouu129AO0uJMLIGrgDJJcK5wdce3tm9/mwfbUPlykBtlVKHK4ckI6Z1uz9xFX3J1xf25P6uUw+lmaEnEuofySUNg5jWblqvMDbgGOD9+tFD+uz6rXuTHXbKY2ElUg8t2J3wttY/V5xXNUbmb9zlMIlLHQiT+o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1578398835570334.8310690503363;
 Tue, 7 Jan 2020 04:07:15 -0800 (PST)
In-Reply-To: <20200107104914.1814-1-quintela@redhat.com>
Subject: Re: [PATCH v2 0/3] Fix multifd + cancel + multifd
Message-ID: <157839883493.727.2839689792701242416@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: quintela@redhat.com
Date: Tue, 7 Jan 2020 04:07:15 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: lvivier@redhat.com, thuth@redhat.com, quintela@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDEwNzEwNDkxNC4xODE0
LTEtcXVpbnRlbGFAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCgoKCgoKVGhlIGZ1bGwg
bG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDEwNzEwNDkx
NC4xODE0LTEtcXVpbnRlbGFAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEv
P3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


