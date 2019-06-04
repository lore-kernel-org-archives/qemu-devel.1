Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DF6C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 17:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B243520866
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 17:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B243520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47680 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYZll-0005ym-Sg
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 13:32:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hYZkK-000591-FP
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hYZkJ-0005oG-1j
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:30:44 -0400
Resent-Date: Wed, 05 Jun 2019 13:30:44 -0400
Resent-Message-Id: <E1hYZkJ-0005oG-1j@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hYZkI-0005FR-Q0
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:30:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1559641343; cv=none; d=zoho.com; s=zohoarc; 
	b=PSRjFBvRwtmXPyFuJ9korTIrHJwCPTk2S8FfryonOBDS2+Cb0ff0pWrq70GlPUzmcw6N5nudkXloRAnVh54cfcjueXiRqT2pjtyV+dGbC6xqbU48aquwQ7E1eSX70Un17e4wUnb0gg1klPYmQXk0G+9yBCqDDspXSWyePssVce8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1559641343;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=3tkCeCEINrTPmSqsmt2C85lrbVelWyblQjJDCzDz/P0=; 
	b=R9eSaM7O6HNwVnimEa7VoLl8Wbmmpa+rAqrTU9NMsR6ehxgZwIaqiHegUFCh2S4rbNnGHR+3YvFLamMjjPWlizP3WIjSzVU5b8z1oytLt528t1AAY44rHIxf5jooH50EB3mZR1Z8P2/6glTvEceqUnyhSqb2XtY3VpBFerWsWoc=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1559641341593458.38216544965485;
	Tue, 4 Jun 2019 02:42:21 -0700 (PDT)
In-Reply-To: <B3540B0C-9A71-4733-8109-11B0DC7A17D2@me.com>
Message-ID: <155964134054.32260.7557344412033377568@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: qemu-devel@nongnu.org
Date: Tue, 4 Jun 2019 02:42:21 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9CMzU0MEIwQy05QTcxLTQ3MzMt
ODEwOS0xMUIwREM3QTE3RDJAbWUuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIDAvMl0gdWkvY29jb2E6
IEZpeCBpbnB1dCBkZXZpY2UgaXNzdWVzIG9uIE1vamF2ZQpUeXBlOiBzZXJpZXMKTWVzc2FnZS1p
ZDogQjM1NDBCMEMtOUE3MS00NzMzLTgxMDktMTFCMERDN0ExN0QyQG1lLmNvbQoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251
bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFs
Z29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNl
Li4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNo
ZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcvQjM1NDBC
MEMtOUE3MS00NzMzLTgxMDktMTFCMERDN0ExN0QyQG1lLmNvbSAtPiBwYXRjaGV3L0IzNTQwQjBD
LTlBNzEtNDczMy04MTA5LTExQjBEQzdBMTdEMkBtZS5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJh
bmNoICd0ZXN0JwowZjQ1NDIyNGZjIHVpL2NvY29hOiBGaXggbW91c2UgZ3JhYmJpbmcgaW4gZnVs
bHNjcmVlbiBtb2RlIGZvciByZWxhdGl2ZSBpbnB1dCBkZXZpY2UKODA4ZTk0MjU2ZiB1aS9jb2Nv
YTogRml4IGFic29sdXRlIGlucHV0IGRldmljZSBncmFiYmluZyBpc3N1ZSBvbiBNb2phdmUKCj09
PSBPVVRQVVQgQkVHSU4gPT09CjEvMiBDaGVja2luZyBjb21taXQgODA4ZTk0MjU2ZmM1ICh1aS9j
b2NvYTogRml4IGFic29sdXRlIGlucHV0IGRldmljZSBncmFiYmluZyBpc3N1ZSBvbiBNb2phdmUp
CkVSUk9SOiBBdXRob3IgZW1haWwgYWRkcmVzcyBpcyBtYW5nbGVkIGJ5IHRoZSBtYWlsaW5nIGxp
c3QKIzI6IApBdXRob3I6IENoZW4gWmhhbmcgdmlhIFFlbXUtZGV2ZWwgPHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZz4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgNjEgbGluZXMgY2hlY2tlZAoK
UGF0Y2ggMS8yIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0
aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoyLzIgQ2hlY2tpbmcgY29tbWl0
IDBmNDU0MjI0ZmNkOSAodWkvY29jb2E6IEZpeCBtb3VzZSBncmFiYmluZyBpbiBmdWxsc2NyZWVu
IG1vZGUgZm9yIHJlbGF0aXZlIGlucHV0IGRldmljZSkKRVJST1I6IEF1dGhvciBlbWFpbCBhZGRy
ZXNzIGlzIG1hbmdsZWQgYnkgdGhlIG1haWxpbmcgbGlzdAojMjogCkF1dGhvcjogQ2hlbiBaaGFu
ZyB2aWEgUWVtdS1kZXZlbCA8cWVtdS1kZXZlbEBub25nbnUub3JnPgoKdG90YWw6IDEgZXJyb3Jz
LCAwIHdhcm5pbmdzLCAxMyBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzIgaGFzIHN0eWxlIHByb2Js
ZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9z
aXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBN
QUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRo
IGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9y
Zy9sb2dzL0IzNTQwQjBDLTlBNzEtNDczMy04MTA5LTExQjBEQzdBMTdEMkBtZS5jb20vdGVzdGlu
Zy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIg
ZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


