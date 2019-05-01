Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA8AC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 22:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD4AF206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 22:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4AF206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42433 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLy7V-0007UZ-Dq
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 18:54:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLy6e-0007Bp-RS
	for qemu-devel@nongnu.org; Wed, 01 May 2019 18:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLy6Y-0007Sz-JE
	for qemu-devel@nongnu.org; Wed, 01 May 2019 18:53:36 -0400
Resent-Date: Wed, 01 May 2019 18:53:35 -0400
Resent-Message-Id: <E1hLy6Y-0007Sz-JE@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hLy6T-0007M3-Ao
	for qemu-devel@nongnu.org; Wed, 01 May 2019 18:53:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556751183; cv=none; d=zoho.com; s=zohoarc; 
	b=MovJP87yW4Bl3img8dzR3SlZI1Rx6R7xosXxp5/A0hHPG/NpNX42hhAhkRE0GXSpsopoqQwojGHF3UO4pY2+03/f+tVhhLMzQK5mJs+CRhi7TEZBuKZrxdglNYi6sG6M+u16wRg0KKr4nFXRNMmSvFS04Ua/4zB/vPxbPZPWOVU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556751183;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=K/JxZQzniH1Ht6/00HAbzr5ieIN2GlmAPPTF6gemEFE=; 
	b=nBq2t4XxsTI4T7SzJnZ4HFQTv+iuVRfT4YPqnIHnJD8Q2fgudnHbze252gf2/26NY8jXHcdwKRTsdvu7khI40NnqDYdgbzT1WHevLEiJY1l7CB3q4udaTQrtFxDW2WsPWDEIGjX2jtCkzJtqvWyp8M2lbv/1Is6cdQS4A/LuN5w=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556751181784318.8546136227326;
	Wed, 1 May 2019 15:53:01 -0700 (PDT)
In-Reply-To: <20190430034412.12935-1-richardw.yang@linux.intel.com>
Message-ID: <155675118046.10667.9255070406416571267@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richardw.yang@linux.intel.com
Date: Wed, 1 May 2019 15:53:01 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
Subject: Re: [Qemu-devel] [PATCH 0/3] Cleanup migration/ram.c
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
Cc: fam@euphon.net, quintela@redhat.com, qemu-devel@nongnu.org,
	dgilbert@redhat.com, richardw.yang@linux.intel.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501225301.DUxGQcPQj0jeDJq_r_pY6PNxhF1p1qHeGPhrsq-ezTk@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQzMDAzNDQxMi4xMjkz
NS0xLXJpY2hhcmR3LnlhbmdAbGludXguaW50ZWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZh
aWxlZCB0aGUgZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUg
dGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2Nr
ZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAp0aW1lIG1ha2UgZG9ja2VyLXRlc3Qt
bWluZ3dAZmVkb3JhIFNIT1dfRU5WPTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVO
RCA9PT0KCgoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3Jn
L2xvZ3MvMjAxOTA0MzAwMzQ0MTIuMTI5MzUtMS1yaWNoYXJkdy55YW5nQGxpbnV4LmludGVsLmNv
bS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdl
bmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4K
UGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


