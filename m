Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA17BC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82DCE2133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82DCE2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46463 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEXWD-0004p1-IH
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 07:05:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hEWxp-0008JH-48
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hEWxn-0000Bx-AJ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:29:48 -0400
Resent-Date: Thu, 11 Apr 2019 06:29:48 -0400
Resent-Message-Id: <E1hEWxn-0000Bx-AJ@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hEWxY-0008Q4-Nn; Thu, 11 Apr 2019 06:29:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1554978531; cv=none; d=zoho.com; s=zohoarc; 
	b=KLzm4Y6Rz9lqDLs+RS3RsGP+4e1lsSN2IR4qGAAtSdS7lfgurFdfYf8L0cCQas35zHOzFhcX6r9+JEc6TIW0M5gcm85g/Vg725CDRmwszDrVmYvAfzKQQRPYVghG4qiFXjz9cYHMHjlqdmoyAETR0ta1jHIXben0eOsQAay6/IE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1554978531;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=XYqnnWDIGInqZxEBYUKuZp3tHsFcmdpy7H8CtTLpncQ=; 
	b=RrSDqjl0naT6UFBb0n5O9THVhJEU9PiW2Unc1oxiXKjGcy9SaBaOXzyBjNr13IVJ4EkKjo491Eu5rlqpXqMy/oc/MwqIxTl5h6wRuFZe/OOYYALoC0QO3XhU3a64x2un/hOJr9I0lLImHY4LjnWeTrk1ImR1TrDqiVxfzoMwMZc=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1554978526210312.8661830096032;
	Thu, 11 Apr 2019 03:28:46 -0700 (PDT)
Message-ID: <155497852263.12882.17138118894178379111@76452e4e88f2>
In-Reply-To: <20190411102025.22559-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: cohuck@redhat.com
Date: Thu, 11 Apr 2019 03:28:46 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH for-4.1] hw: add compat machines for 4.1
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
Cc: fam@euphon.net, peter.maydell@linaro.org, cohuck@redhat.com,
	ehabkost@redhat.com, mst@redhat.com, david@redhat.com,
	qemu-devel@nongnu.org, pasic@linux.ibm.com,
	borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
	qemu-arm@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com,
	david@gibson.dropbear.id.au, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411102846.wllwqQ3dv3PtBljj7xyHQUClgQdhvzyPstm8yEacmGY@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQxMTEwMjAyNS4yMjU1
OS0xLWNvaHVja0ByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDE5MDQxMTEwMjAyNS4yMjU1OS0xLWNvaHVja0ByZWRo
YXQuY29tClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggZm9yLTQuMV0gaHc6IGFkZCBjb21w
YXQgbWFjaGluZXMgZm9yIDQuMQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9
PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9n
cmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFND
UklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4
NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiB0IFt0
YWcgdXBkYXRlXSAgICAgICAgICAgIHBhdGNoZXcvMjAxOTAzMTUwMzI2MjkuMjEyMzQtMS1yaWNo
YXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnIC0+IHBhdGNoZXcvMjAxOTAzMTUwMzI2MjkuMjEyMzQt
MS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnCiB0IFt0YWcgdXBkYXRlXSAgICAgICAgICAg
IHBhdGNoZXcvMjAxOTA0MTEwNjM0MDguMzk5OC0xLWNsZ0BrYW9kLm9yZyAtPiBwYXRjaGV3LzIw
MTkwNDExMDYzNDA4LjM5OTgtMS1jbGdAa2FvZC5vcmcKICogW25ldyB0YWddICAgICAgICAgICAg
ICAgcGF0Y2hldy8yMDE5MDQxMTA3MTczOS4yMjg4OS0xLXJpY2hhcmR3LnlhbmdAbGludXguaW50
ZWwuY29tIC0+IHBhdGNoZXcvMjAxOTA0MTEwNzE3MzkuMjI4ODktMS1yaWNoYXJkdy55YW5nQGxp
bnV4LmludGVsLmNvbQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzIwMTkwNDEx
MTAyMDI1LjIyNTU5LTEtY29odWNrQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDE5MDQxMTEwMjAy
NS4yMjU1OS0xLWNvaHVja0ByZWRoYXQuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVz
dCcKNTU3NDZkZGFlOCBodzogYWRkIGNvbXBhdCBtYWNoaW5lcyBmb3IgNC4xCgo9PT0gT1VUUFVU
IEJFR0lOID09PQpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc9JyAoY3R4Old4
VikKIzU4OiBGSUxFOiBody9pMzg2L3BjLmM6MTE4OgorR2xvYmFsUHJvcGVydHkgcGNfY29tcGF0
XzRfMFtdID17fTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgp0b3RhbDogMSBl
cnJvcnMsIDAgd2FybmluZ3MsIDE2MCBsaW5lcyBjaGVja2VkCgpDb21taXQgNTU3NDZkZGFlOGI2
IChodzogYWRkIGNvbXBhdCBtYWNoaW5lcyBmb3IgNC4xKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBs
ZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMg
cmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlO
RVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAx
CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8y
MDE5MDQxMTEwMjAyNS4yMjU1OS0xLWNvaHVja0ByZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2twYXRj
aC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0
Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


