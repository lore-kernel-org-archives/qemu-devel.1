Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDB3C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 10:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3FA1206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 10:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FA1206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51600 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIswG-0005St-BV
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 06:46:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hIsvT-0004ve-CE
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hIsvS-00069U-5H
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:45:23 -0400
Resent-Date: Tue, 23 Apr 2019 06:45:23 -0400
Resent-Message-Id: <E1hIsvS-00069U-5H@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hIsvR-00061A-Ti
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:45:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556016278; cv=none; d=zoho.com; s=zohoarc; 
	b=bsSswANVTnmzIII6jUKExU99EHpbGsn0ZWlQBkmttaZx9G2pp7kDvUygYzOWRMU1GIRko+V908LRhRGfjx5VR1b2CY/O6dnF9q+ew/MHRYvf4QkqtTCnXE0Od0rZpP97eQbFzsusphLlipIbixG6z+BrMUliGfPxSZXrq/gaU5w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556016278;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=ehbHiW0a7qIsLACD0XKWBrRinkNYpYapmXen0vymslU=; 
	b=dHjeSsD7G3RWwBRroqLgyvYjGMXxs8jaXvu2hskgqsqfNc4Zqn9klGB5AOP/EMdM8aISTPlQejNWCaITq8F8IfTXhuiSuDvj2mRzsPise8ul4/BzFN/cFUbfMh+vlg/tbEGCFehP9Z4pAquSfWQuolLTKzC023U+lWVuiVPSP/A=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556016273221193.2518567502192;
	Tue, 23 Apr 2019 03:44:33 -0700 (PDT)
In-Reply-To: <20190423103855.1257968-1-jakub.jermar@kernkonzept.com>
Message-ID: <155601627096.26689.2851011824444304661@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jakub.jermar@kernkonzept.com
Date: Tue, 23 Apr 2019 03:44:33 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
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
Message-ID: <20190423104433.rz6nGWaIsfnOI1SYluPkRuPLNjTEwXph_b-mmNIGFNY@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyMzEwMzg1NS4xMjU3
OTY4LTEtamFrdWIuamVybWFyQGtlcm5rb256ZXB0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBz
ZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93
IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkwNDIz
MTAzODU1LjEyNTc5NjgtMS1qYWt1Yi5qZXJtYXJAa2VybmtvbnplcHQuY29tClN1YmplY3Q6IFtR
ZW11LWRldmVsXSBbUEFUQ0hdIG1pcHM6IERlY2lkZSB0byBtYXAgUEFHRV9FWEVDIGluIG1hcF9h
ZGRyZXNzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFy
c2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVu
YW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5w
bCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4
Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHVi
LmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRj
aGV3LzIwMTkwNDIzMTAzODU1LjEyNTc5NjgtMS1qYWt1Yi5qZXJtYXJAa2VybmtvbnplcHQuY29t
IC0+IHBhdGNoZXcvMjAxOTA0MjMxMDM4NTUuMTI1Nzk2OC0xLWpha3ViLmplcm1hckBrZXJua29u
emVwdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo0MGUwZDcyMTU3IG1pcHM6
IERlY2lkZSB0byBtYXAgUEFHRV9FWEVDIGluIG1hcF9hZGRyZXNzCgo9PT0gT1VUUFVUIEJFR0lO
ID09PQpFUlJPUjogYnJhY2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRoaXMg
c3RhdGVtZW50CiM0NzogRklMRTogdGFyZ2V0L21pcHMvaGVscGVyLmM6MTA0OgorICAgICAgICAg
ICAgICAgIGlmICghKG4gPyB0bGItPlhJMSA6IHRsYi0+WEkwKSkKWy4uLl0KCnRvdGFsOiAxIGVy
cm9ycywgMCB3YXJuaW5ncywgNTIgbGluZXMgY2hlY2tlZAoKQ29tbWl0IDQwZTBkNzIxNTcyNCAo
bWlwczogRGVjaWRlIHRvIG1hcCBQQUdFX0VYRUMgaW4gbWFwX2FkZHJlc3MpIGhhcyBzdHlsZSBw
cm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNl
IHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0gg
aW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3
aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3
Lm9yZy9sb2dzLzIwMTkwNDIzMTAzODU1LjEyNTc5NjgtMS1qYWt1Yi5qZXJtYXJAa2Vybmtvbnpl
cHQuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


