Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8573CC3F68F
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 01:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E13924125
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 01:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E13924125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifwTU-0008D3-Gs
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 20:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ifwSv-0007la-R6
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 20:43:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ifwSu-0002wV-4i
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 20:43:29 -0500
Resent-Date: Fri, 13 Dec 2019 20:43:29 -0500
Resent-Message-Id: <E1ifwSu-0002wV-4i@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21161)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ifwSt-0002pG-Uw; Fri, 13 Dec 2019 20:43:28 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1576287788; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fvxYN5vz0wpBVOvenKdqXsDPqUyfnxGDwMgiN/sBbOw8Jq0bO5x3skgapik6vCLq0EPwDt+iZsEl38SdHKsX312RAIXRNpm6ramIfnYQfRKrYlL30KznBiehThWl9SHPyqDneO54DsU3Hd7p0mH83fvKql7BYGzFxTqVIK+yPHg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1576287788;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=we4FEUpxdZm9orLNXZLkxPhL5gAZtZo5tNPnlmu4/pc=; 
 b=T0LHyfs5tj9365M67cq8pDvCBt6Z0agS9S8cSEC9dUYAaz+s5vqsWc0Q5SR1OycMagzsm8RFPQbjAd5k3CkCTxSRIGz1G43J/al5cCH4uEuakJGS5WRNnquMBbJTdOYhwFBQz6ZPsNQ4E1eEKsUAGshCUTqpwuz/b3lHGEvWHaU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1576287787171157.4479558340521;
 Fri, 13 Dec 2019 17:43:07 -0800 (PST)
In-Reply-To: <cover.1576286757.git.fthain@telegraphics.com.au>
Subject: Re: [PATCH 00/10] Fixes for DP8393X SONIC device emulation
Message-ID: <157628778601.20418.17236421597625110152@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: fthain@telegraphics.com.au
Date: Fri, 13 Dec 2019 17:43:07 -0800 (PST)
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
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 hpoussin@reactos.org, aleksandar.rikalo@rt-rk.com, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTc2Mjg2NzU3Lmdp
dC5mdGhhaW5AdGVsZWdyYXBoaWNzLmNvbS5hdS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIDAwLzEwXSBGaXhlcyBmb3IgRFA4Mzkz
WCBTT05JQyBkZXZpY2UgZW11bGF0aW9uClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiBjb3Zlci4x
NTc2Mjg2NzU3LmdpdC5mdGhhaW5AdGVsZWdyYXBoaWNzLmNvbS5hdQoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwg
ZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAt
LWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRo
bSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09
IFRFU1QgU0NSSVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNzAy
YjcwOCBkcDgzOTN4OiBEb24ndCBjbG9iYmVyIHBhY2tldCBjaGVja3N1bQphNmVmY2U1IGRwODM5
M3g6IERvbid0IHN0b3AgcmVjZXB0aW9uIHVwb24gUkJFIGludGVycnVwdCBhc3NlcnRpb24KOGYw
NDM2MSBkcDgzOTN4OiBJbXBsZW1lbnQgcGFja2V0IHNpemUgbGltaXQgYW5kIFJCQUUgaW50ZXJy
dXB0CjE5YmRhZWMgZHA4MzkzeDogSW1wbGVtZW50IFRCV0MwIGFuZCBUQldDMSByZWdpc3RlcnMg
dG8gcmVzdG9yZSBidWZmZXIgc3RhdGUKZDQ2MzRmZCBkcDgzOTN4OiBDbGVhciBSUlJBIGNvbW1h
bmQgcmVnaXN0ZXIgYml0IG9ubHkgd2hlbiBhcHByb3ByaWF0ZQozOWUzNWRiIGRwODM5M3g6IFVw
ZGF0ZSBMTEZBIHJlZ2lzdGVyCjI0MGNlZjQgZHA4MzkzeDogRG9uJ3QgYWR2YW5jZSBSWCBkZXNj
cmlwdG9yIHR3aWNlCmJhMjkyMmQgZHA4MzkzeDogSGF2ZSBkcDgzOTN4X3JlY2VpdmUoKSByZXR1
cm4gdGhlIHBhY2tldCBzaXplCjhlMWM1YTYgZHA4MzkzeDogQ2xlYW4gdXAgZW5kaWFubmVzcyBo
YWNrcwo5YzlmZmMzIGRwODM5M3g6IE1hc2sgRU9MIGJpdCBmcm9tIGRlc2NyaXB0b3IgYWRkcmVz
c2VzCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzEwIENoZWNraW5nIGNvbW1pdCA5YzlmZmMzOGU5
YjkgKGRwODM5M3g6IE1hc2sgRU9MIGJpdCBmcm9tIGRlc2NyaXB0b3IgYWRkcmVzc2VzKQpFUlJP
UjogcmV0dXJuIGlzIG5vdCBhIGZ1bmN0aW9uLCBwYXJlbnRoZXNlcyBhcmUgbm90IHJlcXVpcmVk
CiMyNDogRklMRTogaHcvbmV0L2RwODM5M3guYzoyMDA6CisgICAgcmV0dXJuIChzLT5yZWdzW1NP
TklDX1VSREFdIDw8IDE2KSB8IChzLT5yZWdzW1NPTklDX0NSREFdICYgMHhmZmZlKTsKCkVSUk9S
OiByZXR1cm4gaXMgbm90IGEgZnVuY3Rpb24sIHBhcmVudGhlc2VzIGFyZSBub3QgcmVxdWlyZWQK
IzMzOiBGSUxFOiBody9uZXQvZHA4MzkzeC5jOjIyMDoKKyAgICByZXR1cm4gKHMtPnJlZ3NbU09O
SUNfVVREQV0gPDwgMTYpIHwgKHMtPnJlZ3NbU09OSUNfVFREQV0gJiAweGZmZmUpOwoKdG90YWw6
IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCAyNiBsaW5lcyBjaGVja2VkCgpQYXRjaCAxLzEwIGhhcyBz
dHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJl
IGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNL
UEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoyLzEwIENoZWNraW5nIGNvbW1pdCA4ZTFjNWE2ODg4Mzgg
KGRwODM5M3g6IENsZWFuIHVwIGVuZGlhbm5lc3MgaGFja3MpCjMvMTAgQ2hlY2tpbmcgY29tbWl0
IGJhMjkyMmRjM2U5MyAoZHA4MzkzeDogSGF2ZSBkcDgzOTN4X3JlY2VpdmUoKSByZXR1cm4gdGhl
IHBhY2tldCBzaXplKQo0LzEwIENoZWNraW5nIGNvbW1pdCAyNDBjZWY0Y2FhZWUgKGRwODM5M3g6
IERvbid0IGFkdmFuY2UgUlggZGVzY3JpcHRvciB0d2ljZSkKNS8xMCBDaGVja2luZyBjb21taXQg
MzllMzVkYjEwN2JkIChkcDgzOTN4OiBVcGRhdGUgTExGQSByZWdpc3RlcikKNi8xMCBDaGVja2lu
ZyBjb21taXQgZDQ2MzRmZGQyNDRjIChkcDgzOTN4OiBDbGVhciBSUlJBIGNvbW1hbmQgcmVnaXN0
ZXIgYml0IG9ubHkgd2hlbiBhcHByb3ByaWF0ZSkKNy8xMCBDaGVja2luZyBjb21taXQgMTliZGFl
YzI5OWYxIChkcDgzOTN4OiBJbXBsZW1lbnQgVEJXQzAgYW5kIFRCV0MxIHJlZ2lzdGVycyB0byBy
ZXN0b3JlIGJ1ZmZlciBzdGF0ZSkKOC8xMCBDaGVja2luZyBjb21taXQgOGYwNDM2MWI2YmM4IChk
cDgzOTN4OiBJbXBsZW1lbnQgcGFja2V0IHNpemUgbGltaXQgYW5kIFJCQUUgaW50ZXJydXB0KQo5
LzEwIENoZWNraW5nIGNvbW1pdCBhNmVmY2U1YjE3ZDAgKGRwODM5M3g6IERvbid0IHN0b3AgcmVj
ZXB0aW9uIHVwb24gUkJFIGludGVycnVwdCBhc3NlcnRpb24pCjEwLzEwIENoZWNraW5nIGNvbW1p
dCA3MDJiNzA4Y2YwOTkgKGRwODM5M3g6IERvbid0IGNsb2JiZXIgcGFja2V0IGNoZWNrc3VtKQo9
PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhl
IGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy9jb3Zlci4x
NTc2Mjg2NzU3LmdpdC5mdGhhaW5AdGVsZWdyYXBoaWNzLmNvbS5hdS90ZXN0aW5nLmNoZWNrcGF0
Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


