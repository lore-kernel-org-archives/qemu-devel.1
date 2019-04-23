Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4832EC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 15:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3B7217D9
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 15:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3B7217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55447 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIxQk-0007kj-6D
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 11:33:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hIxPg-0007Jx-BJ
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:32:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hIxPe-00044w-VE
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:32:52 -0400
Resent-Date: Tue, 23 Apr 2019 11:32:52 -0400
Resent-Message-Id: <E1hIxPe-00044w-VE@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hIxPe-00043l-M7
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:32:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556033520; cv=none; d=zoho.com; s=zohoarc; 
	b=GvyhnqnHkTmVRbQuHK/ZqAgxhshxsiw9xQfHj0iMTA4LXu4cFfXc4K5QCJNyBtjy2Ld2lU0WRl+g11u1oeS0oYQU3401ThUr7ZOjp7yDCtYETLqs1rn5KmwonRAVRXCzJ1fFceiDU25VGKb4Wh35z7UCk6E5aXZGBuUaH3sY+js=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556033520;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=DgVvRQWbH1NBIpwaw5P3pDGbKQW6j+Xm/5kks2T5TBo=; 
	b=ISoS5BVGIsIDp7dNuvBoO1lfOykWm+CKFK7AHGEP8H4atwoBOY/scKX6eITbr2wuibTC9Qzk/I9w9Dhpuf0mG47jBdGHWwQh6BybdyQEnuYX6pZgY7Uac09KtPVDTlxY5+lXAhu77NNKhed9cfPM/EdN5VSRgfmqTWA9lmzftKw=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556033516690292.1525766525864;
	Tue, 23 Apr 2019 08:31:56 -0700 (PDT)
In-Reply-To: <20190423092602.1254515-1-jakub.jermar@kernkonzept.com>
Message-ID: <155603351531.26689.4854613420813662203@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jakub.jermar@kernkonzept.com
Date: Tue, 23 Apr 2019 08:31:56 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH] mips: Decide to map PAGE_EXEC in
 map_address
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
Cc: fam@euphon.net, arikalo@wavecomp.com, qemu-devel@nongnu.org,
	jakub.jermar@kernkonzept.com, amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423153156.Tp8_TYEDucMOcO8Xd0LsSm7v9f29i40gjac6_yepoY0@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyMzA5MjYwMi4xMjU0
NTE1LTEtamFrdWIuamVybWFyQGtlcm5rb256ZXB0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBz
ZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93
IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkwNDIz
MDkyNjAyLjEyNTQ1MTUtMS1qYWt1Yi5qZXJtYXJAa2VybmtvbnplcHQuY29tClN1YmplY3Q6IFtR
ZW11LWRldmVsXSBbUEFUQ0hdIG1pcHM6IERlY2lkZSB0byBtYXAgUEFHRV9FWEVDIGluIG1hcF9h
ZGRyZXNzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFy
c2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVu
YW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5w
bCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4
Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHVi
LmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogdCBbdGFnIHVwZGF0ZV0gICAgICAgICAgICBwYXRj
aGV3LzE1NTU2NjkwOTItMTAzNTEtMS1naXQtc2VuZC1lbWFpbC1mcmVkZXJpYy5rb25yYWRAYWRh
Y29yZS5jb20gLT4gcGF0Y2hldy8xNTU1NjY5MDkyLTEwMzUxLTEtZ2l0LXNlbmQtZW1haWwtZnJl
ZGVyaWMua29ucmFkQGFkYWNvcmUuY29tCiB0IFt0YWcgdXBkYXRlXSAgICAgICAgICAgIHBhdGNo
ZXcvMTU1NjAxODk4Mi0zNzE1LTEtZ2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0By
dC1yay5jb20gLT4gcGF0Y2hldy8xNTU2MDE4OTgyLTM3MTUtMS1naXQtc2VuZC1lbWFpbC1hbGVr
c2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbQogdCBbdGFnIHVwZGF0ZV0gICAgICAgICAgICBwYXRj
aGV3LzIwMTkwNDIyMTQ1ODM4LjcwOTAzLTEtdnNlbWVudHNvdkB2aXJ0dW96em8uY29tIC0+IHBh
dGNoZXcvMjAxOTA0MjIxNDU4MzguNzA5MDMtMS12c2VtZW50c292QHZpcnR1b3p6by5jb20KICog
W25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE5MDQyMzA5MjYwMi4xMjU0NTE1LTEt
amFrdWIuamVybWFyQGtlcm5rb256ZXB0LmNvbSAtPiBwYXRjaGV3LzIwMTkwNDIzMDkyNjAyLjEy
NTQ1MTUtMS1qYWt1Yi5qZXJtYXJAa2VybmtvbnplcHQuY29tCiB0IFt0YWcgdXBkYXRlXSAgICAg
ICAgICAgIHBhdGNoZXcvMjAxOTA0MjMxMDIxNDUuMTQ4MTItMS1mNGJ1Z0BhbXNhdC5vcmcgLT4g
cGF0Y2hldy8yMDE5MDQyMzEwMjE0NS4xNDgxMi0xLWY0YnVnQGFtc2F0Lm9yZwogKiBbbmV3IHRh
Z10gICAgICAgICAgICAgICBwYXRjaGV3LzIwMTkwNDIzMTMyMDA0LjEzNzI1LTEtbWFyY2FuZHJl
Lmx1cmVhdUByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAxOTA0MjMxMzIwMDQuMTM3MjUtMS1tYXJj
YW5kcmUubHVyZWF1QHJlZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo1
YjYwZjAyNjU4IG1pcHM6IERlY2lkZSB0byBtYXAgUEFHRV9FWEVDIGluIG1hcF9hZGRyZXNzCgo9
PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogYnJhY2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFs
bCBhcm1zIG9mIHRoaXMgc3RhdGVtZW50CiM0NzogRklMRTogdGFyZ2V0L21pcHMvaGVscGVyLmM6
MTA0OgorICAgICAgICAgICAgICAgIGlmICghKG4gPyB0bGItPlhJMSA6IHRsYi0+WEkwKSkKWy4u
Ll0KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgNTIgbGluZXMgY2hlY2tlZAoKQ29tbWl0
IDViNjBmMDI2NThiYiAobWlwczogRGVjaWRlIHRvIG1hcCBQQUdFX0VYRUMgaW4gbWFwX2FkZHJl
c3MpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBl
cnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBj
b21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwNDIzMDkyNjAyLjEyNTQ1MTUtMS1qYWt1Yi5q
ZXJtYXJAa2VybmtvbnplcHQuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgot
LS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRj
aGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVk
aGF0LmNvbQ==


