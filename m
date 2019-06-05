Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FCBC282CE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 01:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D9E1206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 01:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9E1206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33801 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYKeT-0006lE-DB
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 21:23:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hYKdh-0006PG-5b
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 21:22:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hYKdY-0000yT-H8
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 21:22:51 -0400
Resent-Date: Tue, 04 Jun 2019 21:22:45 -0400
Resent-Message-Id: <E1hYKdY-0000yT-H8@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hYKdX-0000oB-53
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 21:22:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1559696792; cv=none; d=zoho.com; s=zohoarc; 
	b=lzz4zdavC2RESpuKuQ9V93eY5G/CmKVvtq/FUW7yny1YcvzU8wWXICNjqfQAdxdLNPiIznXElkPiBNplWPoqjf8L1OSVfJrs1JFcjeQp9PATgnK7w60xPNHRs0Iofigk+2OVtIUIiVg38EdD7/tKTBV0d7fY2mzlhZDD4QcwVlg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1559696792;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=R1+XstUzQLfSQji+TRxhISzHQjVzUGIBPxje5Kd+OZA=; 
	b=O48RCFaAYRhTc+4aQ6gDfIufFG4NaRMjgN86H8sI237mvNw47MYfgueB9+CuD5D0OtRyUf7MvkovEqqtodMpGqTe0IXIMDfihHIveMuz5y12RIFE84OlgHBhYdEWlP+/daY4cnmwYDHw3oCTGPJD0uyql+ioiz3fTOLRvh3UE6s=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1559696791443184.5473280689888;
	Tue, 4 Jun 2019 18:06:31 -0700 (PDT)
In-Reply-To: <cover.1559638310.git.tgfbeta@me.com>
Message-ID: <155969679045.32260.1519674070503985895@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: qemu-devel@nongnu.org
Date: Tue, 4 Jun 2019 18:06:31 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH 0/2] ui/cocoa: Fix input device issues on
 Mojave
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
Cc: peter.maydell@linaro.org, kraxel@redhat.com, tgfbeta@me.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTU5NjM4MzEwLmdp
dC50Z2ZiZXRhQG1lLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUg
Y29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0
aW9uOgoKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCAwLzJdIHVpL2NvY29hOiBGaXggaW5w
dXQgZGV2aWNlIGlzc3VlcyBvbiBNb2phdmUKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IGNvdmVy
LjE1NTk2MzgzMTAuZ2l0LnRnZmJldGFAbWUuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3Jh
bQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUK
ICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy9jb3Zlci4xNTU5NjM4MzEwLmdpdC50
Z2ZiZXRhQG1lLmNvbSAtPiBwYXRjaGV3L2NvdmVyLjE1NTk2MzgzMTAuZ2l0LnRnZmJldGFAbWUu
Y29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMTI3YTY3MDdhNSB1aS9jb2NvYTog
Rml4IG1vdXNlIGdyYWJiaW5nIGluIGZ1bGxzY3JlZW4gbW9kZSBmb3IgcmVsYXRpdmUgaW5wdXQg
ZGV2aWNlCmU1Nzk5MzU5ZDAgdWkvY29jb2E6IEZpeCBhYnNvbHV0ZSBpbnB1dCBkZXZpY2UgZ3Jh
YmJpbmcgaXNzdWUgb24gTW9qYXZlCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzIgQ2hlY2tpbmcg
Y29tbWl0IGU1Nzk5MzU5ZDA1ZCAodWkvY29jb2E6IEZpeCBhYnNvbHV0ZSBpbnB1dCBkZXZpY2Ug
Z3JhYmJpbmcgaXNzdWUgb24gTW9qYXZlKQpFUlJPUjogQXV0aG9yIGVtYWlsIGFkZHJlc3MgaXMg
bWFuZ2xlZCBieSB0aGUgbWFpbGluZyBsaXN0CiMyOiAKQXV0aG9yOiBDaGVuIFpoYW5nIHZpYSBR
ZW11LWRldmVsIDxxZW11LWRldmVsQG5vbmdudS5vcmc+Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2Fy
bmluZ3MsIDYxIGxpbmVzIGNoZWNrZWQKClBhdGNoIDEvMiBoYXMgc3R5bGUgcHJvYmxlbXMsIHBs
ZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMg
cmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlO
RVJTLgoKMi8yIENoZWNraW5nIGNvbW1pdCAxMjdhNjcwN2E1ZTggKHVpL2NvY29hOiBGaXggbW91
c2UgZ3JhYmJpbmcgaW4gZnVsbHNjcmVlbiBtb2RlIGZvciByZWxhdGl2ZSBpbnB1dCBkZXZpY2Up
CkVSUk9SOiBBdXRob3IgZW1haWwgYWRkcmVzcyBpcyBtYW5nbGVkIGJ5IHRoZSBtYWlsaW5nIGxp
c3QKIzI6IApBdXRob3I6IENoZW4gWmhhbmcgdmlhIFFlbXUtZGV2ZWwgPHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZz4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTMgbGluZXMgY2hlY2tlZAoK
UGF0Y2ggMi8yIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0
aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0K
ClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWls
YWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy9jb3Zlci4xNTU5NjM4MzEwLmdpdC50Z2Zi
ZXRhQG1lLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdl
bmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4K
UGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


