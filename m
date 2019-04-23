Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BE4C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 16:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A92B20651
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 16:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A92B20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56273 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIy0L-0001sM-HB
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 12:10:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hIxzQ-0001P4-4n
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hIxzP-0001XH-26
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:09:48 -0400
Resent-Date: Tue, 23 Apr 2019 12:09:48 -0400
Resent-Message-Id: <E1hIxzP-0001XH-26@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hIxzM-0001Sy-VU
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:09:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556035768; cv=none; d=zoho.com; s=zohoarc; 
	b=AcpKbel0XEM3FVCLOjcKCST40/as06q+njNCKd1R1fKbf6GDVISIkvbqouvOLepU8Z2FHFL+Ijdg0fPRElQrQrtPBKCIdGwaGrzjEQ06VtWcRAgO3ZrUyxJe0KieIn/rc6bkafmZ6KyKi7UyjFrOYVVr3uVmqUaeQeF3NHVDDNI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556035768;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=NW8mdt0kE1ORoFhzTKMo2m52LYLu1wNhxGhP9WVN9eo=; 
	b=jGkFxUSBe/UBXgbdsaqdELVSfKKl+0K+mb+QEjh3JvGPv0LEdK32XXsQjimvYnp6Eizf27V2u1Y5jb/bCoR0yMsZH1vFP9ypLE/2+rdeY7oS1tUZEJ4yCiu7tjVs2MUu7QU7wfPlXCRfEAIPyY86p/2c6WO8UVZhx+R8fsXyVbg=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556035763275462.60735435228617;
	Tue, 23 Apr 2019 09:09:23 -0700 (PDT)
In-Reply-To: <20190423132004.13725-1-marcandre.lureau@redhat.com>
Message-ID: <155603576197.26689.10924565351730912400@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: marcandre.lureau@redhat.com
Date: Tue, 23 Apr 2019 09:09:23 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v6 00/11] vhost-user for input & GPU
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
Cc: fam@euphon.net, marcandre.lureau@redhat.com, mst@redhat.com,
	qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423160923.eig9KX4zrjmHoLQRzNYw14Pvx2zP1iO3myPUpjLnYaU@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyMzEzMjAwNC4xMzcy
NS0xLW1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWls
ZWQgdGhlIGFzYW4gYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMg
YW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91
IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJ
TiA9PT0KIyEvYmluL2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJH
RVRfTElTVD14ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5E
ID09PQoKICBDQyAgICAgIHFtcC5vCiAgQ0MgICAgICBobXAubwogIENDICAgICAgY3B1cy1jb21t
b24ubwovdG1wL3FlbXUtdGVzdC9zcmMvY29udHJpYi9saWJ2aG9zdC11c2VyL2xpYnZob3N0LXVz
ZXIuYzo1NDY6MzI6IGVycm9yOiB0YWtpbmcgYWRkcmVzcyBvZiBwYWNrZWQgbWVtYmVyICdwYXls
b2FkJyBvZiBjbGFzcyBvciBzdHJ1Y3R1cmUgJ1Zob3N0VXNlck1zZycgbWF5IHJlc3VsdCBpbiBh
biB1bmFsaWduZWQgcG9pbnRlciB2YWx1ZSBbLVdlcnJvciwtV2FkZHJlc3Mtb2YtcGFja2VkLW1l
bWJlcl0KICAgIFZob3N0VXNlck1lbW9yeSAqbWVtb3J5ID0gJnZtc2ctPnBheWxvYWQubWVtb3J5
OwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn4KL3Rt
cC9xZW11LXRlc3Qvc3JjL2NvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11c2VyLmM6Njg4
OjMyOiBlcnJvcjogdGFraW5nIGFkZHJlc3Mgb2YgcGFja2VkIG1lbWJlciAncGF5bG9hZCcgb2Yg
Y2xhc3Mgb3Igc3RydWN0dXJlICdWaG9zdFVzZXJNc2cnIG1heSByZXN1bHQgaW4gYW4gdW5hbGln
bmVkIHBvaW50ZXIgdmFsdWUgWy1XZXJyb3IsLVdhZGRyZXNzLW9mLXBhY2tlZC1tZW1iZXJdCiAg
ICBWaG9zdFVzZXJNZW1vcnkgKm1lbW9yeSA9ICZ2bXNnLT5wYXlsb2FkLm1lbW9yeTsKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+Ci90bXAvcWVtdS10
ZXN0L3NyYy9jb250cmliL2xpYnZob3N0LXVzZXIvbGlidmhvc3QtdXNlci5jOjgxNzozNzogZXJy
b3I6IHRha2luZyBhZGRyZXNzIG9mIHBhY2tlZCBtZW1iZXIgJ3BheWxvYWQnIG9mIGNsYXNzIG9y
IHN0cnVjdHVyZSAnVmhvc3RVc2VyTXNnJyBtYXkgcmVzdWx0IGluIGFuIHVuYWxpZ25lZCBwb2lu
dGVyIHZhbHVlIFstV2Vycm9yLC1XYWRkcmVzcy1vZi1wYWNrZWQtbWVtYmVyXQogICAgc3RydWN0
IHZob3N0X3ZyaW5nX2FkZHIgKnZyYSA9ICZ2bXNnLT5wYXlsb2FkLmFkZHI7CiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fgozIGVycm9ycyBnZW5l
cmF0ZWQuCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcv
bG9ncy8yMDE5MDQyMzEzMjAwNC4xMzcyNS0xLW1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbS90
ZXN0aW5nLmFzYW4vP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNh
bGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBm
ZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


