Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2749CC282DD
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 21:29:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91A1218D3
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 21:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91A1218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59755 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ2zF-0000H8-9t
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 17:29:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hJ2yS-0008Q9-4u
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hJ2yO-0004Ts-RT
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:29:08 -0400
Resent-Date: Tue, 23 Apr 2019 17:29:06 -0400
Resent-Message-Id: <E1hJ2yO-0004Ts-RT@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hJ2yO-0004Rr-K0
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:29:04 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556054931; cv=none; d=zoho.com; s=zohoarc; 
	b=b3CM7j/u/2FVlE65G4k3owVWCjqOLwbjB8flHxkRq3QZ1u+tjpw2gWum6uQ6Y60NlXqQgjQvpbeqJX4crQT/NduWSRCeULfVUtL72l/EJU2o/qZYBAdJ41JWy/+5IPhUpJsdiXV103FV4VmpNyEJqc2Q8j1czhfDkYvTMoBvUrM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556054931;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=kvRS/VsSidmdYtWaWGsUcjdTg5aZolnoJPW7c4WSfbE=; 
	b=UmHNiInoeRYK/dgDypbBqU7ufRevgR254TIg1B7sPXNRit7d1pTSfnuMW3lqAf6+Gy53gTyq+qnVpMyR1a8zcpqfja4MbP3ffpGP5GeWXD/9rVhgAIbrXvwal6A/pUkZNGrA4goKQAlG0U6F1nVU4FFo78rTQV+yoKHFFqpBZjk=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556054929823981.1616080749664;
	Tue, 23 Apr 2019 14:28:49 -0700 (PDT)
In-Reply-To: <20190423212246.3542-1-ehabkost@redhat.com>
Message-ID: <155605492866.26689.13730040691634040020@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ehabkost@redhat.com
Date: Tue, 23 Apr 2019 14:28:49 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH 0/3] Export machine type deprecation info
 through QMP
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
Cc: fam@euphon.net, mprivozn@redhat.com, qemu-devel@nongnu.org,
	armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423212849.N2NHyJDdtjDuL-LWahxFpjWy1DAutR84KaAxa-xEg_Y@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyMzIxMjI0Ni4zNTQy
LTEtZWhhYmtvc3RAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkwNDIzMjEyMjQ2LjM1NDIt
MS1laGFia29zdEByZWRoYXQuY29tClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggMC8zXSBF
eHBvcnQgbWFjaGluZSB0eXBlIGRlcHJlY2F0aW9uIGluZm8gdGhyb3VnaCBRTVAKCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9u
dWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5h
bGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFz
ZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2
NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJv
amVjdC9xZW11CiB0IFt0YWcgdXBkYXRlXSAgICAgICAgICAgIHBhdGNoZXcvMjAxOTA0MTYxMjU3
NDQuMjc3NzAtMS1wZXRlci5tYXlkZWxsQGxpbmFyby5vcmcgLT4gcGF0Y2hldy8yMDE5MDQxNjEy
NTc0NC4yNzc3MC0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZwogdCBbdGFnIHVwZGF0ZV0gICAg
ICAgICAgICBwYXRjaGV3LzIwMTkwNDE4MTEzMTEwLjE2MDY2NC0xLWJvcm50cmFlZ2VyQGRlLmli
bS5jb20gLT4gcGF0Y2hldy8yMDE5MDQxODExMzExMC4xNjA2NjQtMS1ib3JudHJhZWdlckBkZS5p
Ym0uY29tCiB0IFt0YWcgdXBkYXRlXSAgICAgICAgICAgIHBhdGNoZXcvMjAxOTA0MjAwNzM0NDIu
NzQ4OC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcgLT4gcGF0Y2hldy8yMDE5MDQyMDA3
MzQ0Mi43NDg4LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZwogdCBbdGFnIHVwZGF0ZV0g
ICAgICAgICAgICBwYXRjaGV3LzIwMTkwNDIyMTk1MDIwLjE0OTQtMS1waGlsbWRAcmVkaGF0LmNv
bSAtPiBwYXRjaGV3LzIwMTkwNDIyMTk1MDIwLjE0OTQtMS1waGlsbWRAcmVkaGF0LmNvbQogdCBb
dGFnIHVwZGF0ZV0gICAgICAgICAgICBwYXRjaGV3LzIwMTkwNDIyMjIxNzE0Ljc2MzAtMS1qc25v
d0ByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAxOTA0MjIyMjE3MTQuNzYzMC0xLWpzbm93QHJlZGhh
dC5jb20KIHQgW3RhZyB1cGRhdGVdICAgICAgICAgICAgcGF0Y2hldy8yMDE5MDQyMzE2MDYwOC43
NTE5LTEtdGh1dGhAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMTkwNDIzMTYwNjA4Ljc1MTktMS10
aHV0aEByZWRoYXQuY29tCiAqIFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcvMjAxOTA0
MjMyMTIyNDYuMzU0Mi0xLWVoYWJrb3N0QHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDE5MDQyMzIx
MjI0Ni4zNTQyLTEtZWhhYmtvc3RAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2gg
J3Rlc3QnCjI5ZTI3MTZhODAgcW1wOiBBZGQgZGVwcmVjYXRpb24gaW5mb3JtYXRpb24gdG8gcXVl
cnktbWFjaGluZXMKMzRjYjlhM2I3MCBtYWNoaW5lOiBVc2UgU3VwcG9ydFN0YXR1c0luZm8gZm9y
IGRlcHJlY2F0aW9uIGluZm8KYjQ0YjdhNDcxOCBxYXBpOiBTdXBwb3J0U3RhdHVzSW5mbyBzdHJ1
Y3QKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMyBDaGVja2luZyBjb21taXQgYjQ0YjdhNDcxODhl
IChxYXBpOiBTdXBwb3J0U3RhdHVzSW5mbyBzdHJ1Y3QpCjIvMyBDaGVja2luZyBjb21taXQgMzRj
YjlhM2I3MDgzIChtYWNoaW5lOiBVc2UgU3VwcG9ydFN0YXR1c0luZm8gZm9yIGRlcHJlY2F0aW9u
IGluZm8pCjMvMyBDaGVja2luZyBjb21taXQgMjllMjcxNmE4MGM4IChxbXA6IEFkZCBkZXByZWNh
dGlvbiBpbmZvcm1hdGlvbiB0byBxdWVyeS1tYWNoaW5lcykKV0FSTklORzogYWRkZWQsIG1vdmVk
IG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMzc6
IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM2
NTogRklMRTogdGVzdHMvYWNjZXB0YW5jZS9xdWVyeV9tYWNoaW5lcy5weToyNDoKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIkRlcHJlY2F0ZWQgbWFjaGluZSAoJXMpIG11c3QgaGF2
ZSBzdGF0dXMtbWVzc2FnZSBvciBzdWdnZXN0ZWQtYWx0ZXJuYXRpdmUiICUgKG1hY2hpbmVbJ25h
bWUnXSkpCgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzY4OiBGSUxFOiB0ZXN0cy9h
Y2NlcHRhbmNlL3F1ZXJ5X21hY2hpbmVzLnB5OjI3OgorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAic3VnZ2VzdGVkLWFsdGVybmF0aXZlIG9mICVzIG11c3QgcG9pbnQgdG8gYSB2YWxp
ZCBtYWNoaW5lIHR5cGUiICUgKG1hY2hpbmVbJ25hbWUnXSkpCgp0b3RhbDogMiBlcnJvcnMsIDEg
d2FybmluZ3MsIDU1IGxpbmVzIGNoZWNrZWQKClBhdGNoIDMvMyBoYXMgc3R5bGUgcHJvYmxlbXMs
IHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2
ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5U
QUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29k
ZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xv
Z3MvMjAxOTA0MjMyMTIyNDYuMzU0Mi0xLWVoYWJrb3N0QHJlZGhhdC5jb20vdGVzdGluZy5jaGVj
a3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBi
eSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJh
Y2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


