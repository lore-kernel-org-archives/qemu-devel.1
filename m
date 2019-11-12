Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546BAC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 07:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2603F206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 07:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2603F206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUQvj-0001fW-9H
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 02:49:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iUQuZ-0000ny-Ds
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 02:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iUQuX-0001YO-PA
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 02:48:27 -0500
Resent-Date: Tue, 12 Nov 2019 02:48:27 -0500
Resent-Message-Id: <E1iUQuX-0001YO-PA@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iUQuX-0001VC-H9
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 02:48:25 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573544892; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mLxmsalGfS6EAvQGCEFQHpA6GPDgW71GhWmeaS0klwuqXFWYwwXaQuPog8MbDNFDbVpVobfV+wYN/HSShNpslpQT3xbUYbGS2XtLX/hdGLkAAJtiRE795R3GmFYz/dU7xDcMkoabO3KY0EWYb6uQdiOOJMgJqehz7zVare7NcAA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1573544892;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Nsicyw1EkkOofEVO1Y2+dvlQZ2Eqe5QFnUcT/K32Czg=; 
 b=SX5/2sOcF6ACrqe+a06gvOw3CQcOmbU4unBoWsmkmd2lOtqFZOfUfcVlPRRnbP0CFZ4GUVMgFX/JKx+n1BK2DHJ8aJWtKbkVIH0MXCQw/gH58LwoC1Ig5XLxABPVz8Of04+OAX+1A0Rsfto0sburIyXCpWOAjwd9+ZqeCJQMvZg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1573544890949651.2963378754483;
 Mon, 11 Nov 2019 23:48:10 -0800 (PST)
In-Reply-To: <20191111152808.13371-1-frankja@linux.ibm.com>
Subject: Re: [PATCH v2] s390x: Properly fetch the short psw on diag308 subc 0/1
Message-ID: <157354488986.9707.6899205076509397269@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: frankja@linux.ibm.com
Date: Mon, 11 Nov 2019 23:48:10 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTExMTE1MjgwOC4xMzM3
MS0xLWZyYW5ramFAbGludXguaWJtLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHYyXSBzMzkweDogUHJvcGVybHkgZmV0Y2gg
dGhlIHNob3J0IHBzdyBvbiBkaWFnMzA4IHN1YmMgMC8xClR5cGU6IHNlcmllcwpNZXNzYWdlLWlk
OiAyMDE5MTExMTE1MjgwOC4xMzM3MS0xLWZyYW5ramFAbGludXguaWJtLmNvbQoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251
bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFs
Z29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNl
Li4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0
ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo3NGQ2
MGRjIHMzOTB4OiBQcm9wZXJseSBmZXRjaCB0aGUgc2hvcnQgcHN3IG9uIGRpYWczMDggc3ViYyAw
LzEKCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIg
dXNlIHRhYnMKIzQ2OiBGSUxFOiB0YXJnZXQvczM5MHgvY3B1Lmg6MjY4OgorI2RlZmluZSBQU1df
TUFTS19TSE9SVFBTV15JMHgwMDA4MDAwMDAwMDAwMDAwVUxMJAoKdG90YWw6IDEgZXJyb3JzLCAw
IHdhcm5pbmdzLCAyNSBsaW5lcyBjaGVja2VkCgpDb21taXQgNzRkNjBkYzQ4NmEwIChzMzkweDog
UHJvcGVybHkgZmV0Y2ggdGhlIHNob3J0IHBzdyBvbiBkaWFnMzA4IHN1YmMgMC8xKSBoYXMgc3R5
bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBm
YWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BB
VENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0
ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0
Y2hldy5vcmcvbG9ncy8yMDE5MTExMTE1MjgwOC4xMzM3MS0xLWZyYW5ramFAbGludXguaWJtLmNv
bS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNl
bmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

