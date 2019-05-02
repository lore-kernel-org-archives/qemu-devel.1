Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD0CC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 04:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F8AF2081C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 04:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8AF2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44897 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM3Io-0000Zo-Fh
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 00:26:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hM3I5-0008CU-Ix
	for qemu-devel@nongnu.org; Thu, 02 May 2019 00:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hM3Hi-00072T-5B
	for qemu-devel@nongnu.org; Thu, 02 May 2019 00:25:34 -0400
Resent-Date: Thu, 02 May 2019 00:25:27 -0400
Resent-Message-Id: <E1hM3Hi-00072T-5B@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hM3Hd-0006Mg-0P
	for qemu-devel@nongnu.org; Thu, 02 May 2019 00:25:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556771048; cv=none; d=zoho.com; s=zohoarc; 
	b=ZBTATsA+ujasMlspN74niKzQPWuJ36/jsLe0pKwEVf81QkghqlIIDnYFI12Jl1MAAI29j+67VZtCHpIJ9EYoOis37tX+aNhgivqLny3CmXmxMkeKlS0cCQdNV2RGzNaUyPQf7Bing8t+kMckZY0SyYoomGBCfGbEp3QTm36lAl8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556771048;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=bqZTX5Wjhq8r9j7kMSK7ogMzcKXGFrwrxI8F/DHdyEg=; 
	b=fmDJ7F1vPV3T42KXl8Ya0zP5hg4wG+aogTYPJxENBScK7ib9yUXVN0tQsCRVaW5bMiF1xwuoGTpW+98dkkJ1SFGtAYl3uUl8FBN5v3MJ/BjqebZ2y2RPVTFE56Q2N5e+l4uNtClwinCSNbLvs7wPgtL4KyomuyFcKTnWwUbomUM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556771046109134.09433020530037;
	Wed, 1 May 2019 21:24:06 -0700 (PDT)
In-Reply-To: <20190430034412.12935-1-richardw.yang@linux.intel.com>
Message-ID: <155677104475.10667.17544832182226944733@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richardw.yang@linux.intel.com
Date: Wed, 1 May 2019 21:24:06 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
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
Message-ID: <20190502042406.vDE3cFtOjw6a0ponAuBdjUqi6h1llAIVqpDWPLAGQgE@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQzMDAzNDQxMi4xMjkz
NS0xLXJpY2hhcmR3LnlhbmdAbGludXguaW50ZWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZh
aWxlZCB0aGUgYXNhbiBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5k
cyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5
b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojIS9iaW4vYmFzaAp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtZGVidWdAZmVkb3JhIFRB
UkdFVF9MSVNUPXg4Nl82NC1zb2Z0bW11IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBF
TkQgPT09CgogIENPUFkgICAgUlVOTkVSCiAgICBSVU4gdGVzdC1kZWJ1ZyBpbiBxZW11OmZlZG9y
YSAKY29udGFpbmVyX2xpbnV4LmdvOjI0Nzogc3RhcnRpbmcgY29udGFpbmVyIHByb2Nlc3MgY2F1
c2VkICJwcm9jZXNzX2xpbnV4LmdvOjI1ODogYXBwbHlpbmcgY2dyb3VwIGNvbmZpZ3VyYXRpb24g
Zm9yIHByb2Nlc3MgY2F1c2VkIFwiVGhlIG1heGltdW0gbnVtYmVyIG9mIGFjdGl2ZSBjb25uZWN0
aW9ucyBmb3IgVUlEIDAgaGFzIGJlZW4gcmVhY2hlZFwiIgovdXNyL2Jpbi9kb2NrZXItY3VycmVu
dDogRXJyb3IgcmVzcG9uc2UgZnJvbSBkYWVtb246IG9jaSBydW50aW1lIGVycm9yOiBUaGUgbWF4
aW11bSBudW1iZXIgb2YgYWN0aXZlIGNvbm5lY3Rpb25zIGZvciBVSUQgMCBoYXMgYmVlbiByZWFj
aGVkLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9k
b2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2MTUsIGluIDxtb2R1bGU+CiAgICBzeXMuZXhpdChtYWlu
KCkpCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9n
cy8yMDE5MDQzMDAzNDQxMi4xMjkzNS0xLXJpY2hhcmR3LnlhbmdAbGludXguaW50ZWwuY29tL3Rl
c3RpbmcuYXNhbi8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2Fs
bHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZl
ZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


