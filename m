Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4683CA9EC9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 23:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69442080F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 23:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69442080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRlhf-0002jf-Me
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 18:24:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iRlgZ-0002DR-9D
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 18:23:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iRlgW-0006UN-TC
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 18:22:58 -0500
Resent-Date: Mon, 04 Nov 2019 18:22:58 -0500
Resent-Message-Id: <E1iRlgW-0006UN-TC@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21464)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iRlgV-0006Sp-9K; Mon, 04 Nov 2019 18:22:56 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1572909754; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hTTN/ZvPkMJwTtyvRgebHTCNfp5TCvhfiifiMiuE5Re1yeLrePi6j6xybO8rlFxI6hU0yrSTyMQltb+Ze8nXpBO24b7ooxd32NOnFcc3CLyu3xiINoFFzamJ/M3PHEc0tQ2Ve0cq8QZ8ipKM4tYdR89TXXrCdI+u/vIRNd6V6IY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572909754;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=b0/3qqh5tmRtg2xzpuVA3bIT0K4yPhdj7WeO7sQTCgY=; 
 b=QWzRzyG46GfFl1vANN0vSTFqnf2c1O6Es/hw4Fsre04R4qNkMYEg89JQFXmSzng0KwCdIg+kfZZo7Je3ungqPIinGCbt6iupPOqDVVzjIrVn+zy9SaICM8EgwxCG/grQhLZNPzSDYMjWimTcVQdfcQ2S/TSW5vm++qsiCgMOO2I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1572909751680440.05171983654077;
 Mon, 4 Nov 2019 15:22:31 -0800 (PST)
In-Reply-To: <20191104185202.102504-1-dgilbert@redhat.com>
Subject: Re: [PATCH] global: Squash 'the the'
Message-ID: <157290975035.27285.3954856965557307495@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dgilbert@redhat.com
Date: Mon, 4 Nov 2019 15:22:31 -0800 (PST)
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
Cc: peter.maydell@linaro.org, sstabellini@kernel.org, qemu-trivial@nongnu.org,
 mjt@tls.msk.ru, qemu-devel@nongnu.org, laurent@vivier.eu,
 marcandre.lureau@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEwNDE4NTIwMi4xMDI1
MDQtMS1kZ2lsYmVydEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0hdIGdsb2JhbDogU3F1YXNoICd0aGUgdGhlJwpU
eXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTExMDQxODUyMDIuMTAyNTA0LTEtZGdpbGJlcnRA
cmVkaGF0LmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2
LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0
Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5n
IDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBu
ZXcgYnJhbmNoICd0ZXN0Jwo0MmE2ODUwIGdsb2JhbDogU3F1YXNoICd0aGUgdGhlJwoKPT09IE9V
VFBVVCBCRUdJTiA9PT0KRVJST1I6IGRvIG5vdCB1c2UgQzk5IC8vIGNvbW1lbnRzCiMyNDogRklM
RTogZGlzYXMvbGlidml4bC92aXhsL2ludmFsc2V0Lmg6MTA1OgorICAvLyBOb3RlIHRoYXQgdGhp
cyBkb2VzIG5vdCBtZWFuIHRoZSBiYWNraW5nIHN0b3JhZ2UgaXMgZW1wdHk6IGl0IGNhbiBzdGls
bAoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA1NiBsaW5lcyBjaGVja2VkCgpDb21taXQg
NDJhNjg1MDNjMTFiIChnbG9iYWw6IFNxdWFzaCAndGhlIHRoZScpIGhhcyBzdHlsZSBwcm9ibGVt
cywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0
aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJ
TlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNv
ZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9s
b2dzLzIwMTkxMTA0MTg1MjAyLjEwMjUwNC0xLWRnaWxiZXJ0QHJlZGhhdC5jb20vdGVzdGluZy5j
aGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


