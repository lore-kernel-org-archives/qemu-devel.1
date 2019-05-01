Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA62C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 13:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C1021670
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 13:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C1021670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58353 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLpNw-0005AY-U0
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 09:34:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLpN6-0004sA-U8
	for qemu-devel@nongnu.org; Wed, 01 May 2019 09:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLpN3-0002NW-Sl
	for qemu-devel@nongnu.org; Wed, 01 May 2019 09:34:04 -0400
Resent-Date: Wed, 01 May 2019 09:34:04 -0400
Resent-Message-Id: <E1hLpN3-0002NW-Sl@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hLpN3-0002Lw-LB
	for qemu-devel@nongnu.org; Wed, 01 May 2019 09:34:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556717599; cv=none; d=zoho.com; s=zohoarc; 
	b=R9Ih5sICaahbJAhpBeIhVs0Jjw7Rnpr2ie5kYUnHR02waYb2gADVu7CTiZxdzENRrXBr3J6hKf2iJxWTGflSfbPYd7ApvShwEVMdkYQ37rAczcFbZb6oa8GyMFMBwJFmT8jllF7AO71rLy7Q5G133g/l4M0pO+w2uD1I2Glu5xk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556717599;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=ewCS3BcTBg9Ngs02XWJIgEXEXXk3ceYu600cHsloles=; 
	b=Lm3mpYcq6cUJQztOCUE8jNVF8/KC8SvYWdowdUUdqZppIwUBEJ6cVXM2rfKSHJ+y3eLq3ADf+9fk+adJETXHVCzU1Yvlz6c32yrgyNGT02D3dAmA1QyNiCHudl6qclw13RnMoXyJ+lXMJdumZnksE4svq+vug6ULrDjCWhFPPNs=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556717597718618.2529910307424;
	Wed, 1 May 2019 06:33:17 -0700 (PDT)
In-Reply-To: <20190429090250.7648-1-borntraeger@de.ibm.com>
Message-ID: <155671759623.10667.1703201848536994146@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: borntraeger@de.ibm.com
Date: Wed, 1 May 2019 06:33:17 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v3 0/9] s390x: new guest features
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
Cc: fam@euphon.net, jjherne@linux.ibm.com, walling@linux.ibm.com,
	david@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org,
	pasic@linux.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501133317.FvZHh2dHWVDkJ8WcbQrRNlNugUwY7dY_ATQ8U9tJsUA@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyOTA5MDI1MC43NjQ4
LTEtYm9ybnRyYWVnZXJAZGUuaWJtLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rpbmcg
Y29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3Rh
bGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZl
ZG9yYSBTSE9XX0VOVj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09Cgog
IENPUFkgICAgUlVOTkVSCiAgICBSVU4gdGVzdC1taW5ndyBpbiBxZW11OmZlZG9yYSAKY29udGFp
bmVyX2xpbnV4LmdvOjI0Nzogc3RhcnRpbmcgY29udGFpbmVyIHByb2Nlc3MgY2F1c2VkICJwcm9j
ZXNzX2xpbnV4LmdvOjI1ODogYXBwbHlpbmcgY2dyb3VwIGNvbmZpZ3VyYXRpb24gZm9yIHByb2Nl
c3MgY2F1c2VkIFwiVGhlIG1heGltdW0gbnVtYmVyIG9mIGFjdGl2ZSBjb25uZWN0aW9ucyBmb3Ig
VUlEIDAgaGFzIGJlZW4gcmVhY2hlZFwiIgovdXNyL2Jpbi9kb2NrZXItY3VycmVudDogRXJyb3Ig
cmVzcG9uc2UgZnJvbSBkYWVtb246IG9jaSBydW50aW1lIGVycm9yOiBUaGUgbWF4aW11bSBudW1i
ZXIgb2YgYWN0aXZlIGNvbm5lY3Rpb25zIGZvciBVSUQgMCBoYXMgYmVlbiByZWFjaGVkLgpUcmFj
ZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9j
a2VyLnB5IiwgbGluZSA2MTUsIGluIDxtb2R1bGU+CiAgICBzeXMuZXhpdChtYWluKCkpCgoKVGhl
IGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDQy
OTA5MDI1MC43NjQ4LTEtYm9ybnRyYWVnZXJAZGUuaWJtLmNvbS90ZXN0aW5nLmRvY2tlci1taW5n
d0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


