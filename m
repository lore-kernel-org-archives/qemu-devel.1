Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDC7C282E3
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 08:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D66F2075B
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 08:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D66F2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52426 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUoZy-0007gB-Fv
	for qemu-devel@archiver.kernel.org; Sun, 26 May 2019 04:32:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hUoWp-0005Dh-UY
	for qemu-devel@nongnu.org; Sun, 26 May 2019 04:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hUoVt-0002Ed-4c
	for qemu-devel@nongnu.org; Sun, 26 May 2019 04:28:18 -0400
Resent-Date: Sun, 26 May 2019 04:28:18 -0400
Resent-Message-Id: <E1hUoVt-0002Ed-4c@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hUoVs-0002Bd-Mz
	for qemu-devel@nongnu.org; Sun, 26 May 2019 04:28:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1558859256; cv=none; d=zoho.com; s=zohoarc; 
	b=niD1I0n+5OwxHz8tdRpPF3gAmT+fuAI/aF3z3LDqPItXLeyhENmPUFq2yMd3pIMBWbSS2eY88pX39cXwoYAcjFlzTU72DSs0q3sV82bNPxAVPmhYSz18moTCj2o+GqJgcbONf4Z+DvxCZaAkOCiUYMVcSJYpgyqzrwrFnX+lkVY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1558859256;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=q8fjy6tcNeIF8zF1MO5B0xaH/MHuz6m0M6dL0HjYrRc=; 
	b=ZTyPuGyN4baVKN2a9W+vu6s4wT9cCGhYTawG4OePj/afs9Z9gJMHCBM21GEjoQbyVVh3Dazq6+GuRefiFWqPQIa/5dzcqlsp17YUZ2xbRHBLH33RrLQE2klXntEDHRRybD4l75dMJ51LIrTSIxyOGh9NJ1PGQpXtZtz0yQh1uDw=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 155885925487379.15440415423643;
	Sun, 26 May 2019 01:27:34 -0700 (PDT)
In-Reply-To: <20190526075056.33865-1-lucienmp_antispam@yahoo.com>
Message-ID: <155885925348.24.11226943700623912061@549697c9ad12>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: qemu-devel@nongnu.org
Date: Sun, 26 May 2019 01:27:34 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH] Regression for m68k causing Single-Step
 via GDB/RSP to not single step
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
Cc: huth@tuxfamily.org, richard.henderson@linaro.org, qemu-devel@nongnu.org,
	laurent@vivier.eu, cota@braap.org, lucienmp_antispam@yahoo.com,
	alex.bennee@linaro.org, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDUyNjA3NTA1Ni4zMzg2
NS0xLWx1Y2llbm1wX2FudGlzcGFtQHlhaG9vLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVt
cyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZv
cgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTA1MjYwNzUwNTYuMzM4NjUtMS1s
dWNpZW5tcF9hbnRpc3BhbUB5YWhvby5jb20KVHlwZTogc2VyaWVzClN1YmplY3Q6IFtRZW11LWRl
dmVsXSBbUEFUQ0hdIFJlZ3Jlc3Npb24gZm9yIG02OGsgY2F1c2luZyBTaW5nbGUtU3RlcCB2aWEg
R0RCL1JTUCB0byBub3Qgc2luZ2xlIHN0ZXAKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEv
YmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29u
ZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJl
bmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4v
c2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBF
TkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBb
bmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzIwMTkwNTI2MDc1MDU2LjMzODY1LTEtbHVj
aWVubXBfYW50aXNwYW1AeWFob28uY29tIC0+IHBhdGNoZXcvMjAxOTA1MjYwNzUwNTYuMzM4NjUt
MS1sdWNpZW5tcF9hbnRpc3BhbUB5YWhvby5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0
ZXN0JwplYWI4MTgwNWNjIFJlZ3Jlc3Npb24gZm9yIG02OGsgY2F1c2luZyBTaW5nbGUtU3RlcCB2
aWEgR0RCL1JTUCB0byBub3Qgc2luZ2xlIHN0ZXAKCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9S
OiBBdXRob3IgZW1haWwgYWRkcmVzcyBpcyBtYW5nbGVkIGJ5IHRoZSBtYWlsaW5nIGxpc3QKIzI6
IApBdXRob3I6IEx1Y2llbiBNdXJyYXktUGl0dHMgdmlhIFFlbXUtZGV2ZWwgPHFlbXUtZGV2ZWxA
bm9uZ251Lm9yZz4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgOCBsaW5lcyBjaGVja2Vk
CgpDb21taXQgZWFiODE4MDVjY2MxIChSZWdyZXNzaW9uIGZvciBtNjhrIGNhdXNpbmcgU2luZ2xl
LVN0ZXAgdmlhIEdEQi9SU1AgdG8gbm90IHNpbmdsZSBzdGVwKSBoYXMgc3R5bGUgcHJvYmxlbXMs
IHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2
ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5U
QUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2Rl
OiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9n
cy8yMDE5MDUyNjA3NTA1Ni4zMzg2NS0xLWx1Y2llbm1wX2FudGlzcGFtQHlhaG9vLmNvbS90ZXN0
aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91
ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


