Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F421DC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 16:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C699025D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 16:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C699025D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56321 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWNhS-0007az-UO
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 12:14:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hWNgD-0006vz-JQ
	for qemu-devel@nongnu.org; Thu, 30 May 2019 12:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hWNgC-0007QH-GV
	for qemu-devel@nongnu.org; Thu, 30 May 2019 12:13:25 -0400
Resent-Date: Thu, 30 May 2019 12:13:25 -0400
Resent-Message-Id: <E1hWNgC-0007QH-GV@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hWNgC-0006uU-8r
	for qemu-devel@nongnu.org; Thu, 30 May 2019 12:13:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1559232746; cv=none; d=zoho.com; s=zohoarc; 
	b=k2z2KPrqmp1Srq50mesPhiTJq4yKfwImeLHWgBDeSV2eneeEWje1DQ5h0NhX+zzrZgbDlcUZw2TO0UXXuCHJ70nulBYIRAt51eowwrenYK/AMl2pHm8TxDgcCW3q2594v9CAUeBS623Z0R7F7JgTG3yXgKqCwmXzlPhbZtpVPjQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1559232746;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=Is/Pk0UOYSbTZ52qMrZyfTmWrJCiCZntRlIOIMqRi0o=; 
	b=SBkK6LizNQdOw2HnEZqpfiF1cGKxWPlE4H+1iJphsmfEbiGBNEoemWJdhmPByMwAkhf819wk+LpFQE0GYmFxE0ilG1BTea6idlHWX3Hf+AjtzsKSXInDtjBToLMIb4YadWTMfXoupsce5R0sMCXfh8wAWEwPfql6YHjdojYMOlM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 15592327443171022.8248793888841;
	Thu, 30 May 2019 09:12:24 -0700 (PDT)
In-Reply-To: <20190530143916.20255-1-alex.bennee@linaro.org>
Message-ID: <155923274262.9187.6714348083557874693@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Thu, 30 May 2019 09:12:24 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [RFC PATCH] semihosting: split console_out intro
 string and char versions
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
Cc: peter.maydell@linaro.org, riku.voipio@iki.fi, qemu-devel@nongnu.org,
	laurent@vivier.eu, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDUzMDE0MzkxNi4yMDI1
NS0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUkZDIFBBVENIXSBzZW1paG9z
dGluZzogc3BsaXQgY29uc29sZV9vdXQgaW50cm8gc3RyaW5nIGFuZCBjaGFyIHZlcnNpb25zClR5
cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MDUzMDE0MzkxNi4yMDI1NS0xLWFsZXguYmVubmVl
QGxpbmFyby5vcmcKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJl
di1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3Bh
dGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpGcm9tIGh0
dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAg
ICAgICAgICBwYXRjaGV3LzIwMTkwNTMwMTQzOTE2LjIwMjU1LTEtYWxleC5iZW5uZWVAbGluYXJv
Lm9yZyAtPiBwYXRjaGV3LzIwMTkwNTMwMTQzOTE2LjIwMjU1LTEtYWxleC5iZW5uZWVAbGluYXJv
Lm9yZwpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjk4YzU1N2IzNTcgc2VtaWhvc3Rp
bmc6IHNwbGl0IGNvbnNvbGVfb3V0IGludHJvIHN0cmluZyBhbmQgY2hhciB2ZXJzaW9ucwoKPT09
IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnIT0n
IChjdHg6VnhWKQojNDc6IEZJTEU6IGh3L3NlbWlob3N0aW5nL2NvbnNvbGUuYzo1NjoKKyAgICB9
IHdoaWxlIChjIT0wKTsKICAgICAgICAgICAgICAgXgoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5p
bmdzLCAxNDcgbGluZXMgY2hlY2tlZAoKQ29tbWl0IDk4YzU1N2IzNTcwOCAoc2VtaWhvc3Rpbmc6
IHNwbGl0IGNvbnNvbGVfb3V0IGludHJvIHN0cmluZyBhbmQgY2hhciB2ZXJzaW9ucykgaGFzIHN0
eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUg
ZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQ
QVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhp
dGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3Bh
dGNoZXcub3JnL2xvZ3MvMjAxOTA1MzAxNDM5MTYuMjAyNTUtMS1hbGV4LmJlbm5lZUBsaW5hcm8u
b3JnL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


