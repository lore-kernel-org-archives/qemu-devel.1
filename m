Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63E2C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:50:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE25213F2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE25213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58704 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfj1d-0006mi-QJ
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 06:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43193)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hfj0B-0005e9-KB
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hfj0A-0007Jt-DD
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:48:39 -0400
Resent-Date: Tue, 25 Jun 2019 06:48:39 -0400
Resent-Message-Id: <E1hfj0A-0007Jt-DD@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21942)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hfj0A-0006zO-1d
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:48:38 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561459650; cv=none; d=zoho.com; s=zohoarc; 
 b=mHv08LsJ88kC4hfzTe+bVV4VIJYaFCR/Akmh6oWu+cT32xT9pf7pn8rhf5o3CnqRpBT1y+Gz8A6gOs8DRQ/zIJtKGyhSdumCUYbMLXcu6UGojuxYJKHNpy0cPzmqvsM1T9gXrWq0qXK1/3iOvEefuSLw48Bu2AhlVsgA90ybOwQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561459650;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=xxMp4QBD9D83/oXMaxE55ZpTSGtfvvY2loukiJzHT5Y=; 
 b=dYl59EuMxk/VrwRHHdcLeJ5ThcSy1iUigOzyd09tKWUTG9k/iCUvFyEZHbc5NfAgaw65qYmv7BjCLMLCx77Y6Y1QkZAWrUwJLnCEZutQLxoXUIM1MG9lpalzS2ih8M4hm6lCJc7ojL4MG1+tegpYIzDsOgehXaIk86U3jSlvGco=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561459648386479.568069992284;
 Tue, 25 Jun 2019 03:47:28 -0700 (PDT)
Message-ID: <156145964700.24.1996610342612780259@c4a48874b076>
In-Reply-To: <20190625101524.13447-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Tue, 25 Jun 2019 03:47:28 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [PATCH 0/5] tests/acceptance: Add bFLT loader
 linux-user test
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
Cc: fam@euphon.net, ehabkost@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, wainersm@redhat.com, maxime.coquelin@redhat.com,
 alistair.francis@wdc.com, crosa@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYyNTEwMTUyNC4xMzQ0
Ny0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCBidWlsZCB0
ZXN0IG9uIHMzOTB4IGhvc3QuIFBsZWFzZSBmaW5kIHRoZSBkZXRhaWxzIGJlbG93LgoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAojIFRlc3Rpbmcgc2NyaXB0IHdpbGwgYmUg
aW52b2tlZCB1bmRlciB0aGUgZ2l0IGNoZWNrb3V0IHdpdGgKIyBIRUFEIHBvaW50aW5nIHRvIGEg
Y29tbWl0IHRoYXQgaGFzIHRoZSBwYXRjaGVzIGFwcGxpZWQgb24gdG9wIG9mICJiYXNlIgojIGJy
YW5jaApzZXQgLWUKQ0M9JEhPTUUvYmluL2NjCklOU1RBTEw9JFBXRC9pbnN0YWxsCkJVSUxEPSRQ
V0QvYnVpbGQKbWtkaXIgLXAgJEJVSUxEICRJTlNUQUxMClNSQz0kUFdECmNkICRCVUlMRAokU1JD
L2NvbmZpZ3VyZSAtLWNjPSRDQyAtLXByZWZpeD0kSU5TVEFMTAptYWtlIC1qNAojIFhYWDogd2Ug
bmVlZCByZWxpYWJsZSBjbGVhbiB1cAojIG1ha2UgY2hlY2sgLWo0IFY9MQptYWtlIGluc3RhbGwK
CmVjaG8KZWNobyAiPT09IEVOViA9PT0iCmVudgoKZWNobwplY2hvICI9PT0gUEFDS0FHRVMgPT09
IgpycG0gLXFhCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgcWFwaS9xbXAtcmVn
aXN0cnkubwogIENDICAgICAgcWFwaS9xbXAtZGlzcGF0Y2gubwoKV2FybmluZywgdHJlYXRlZCBh
cyBlcnJvcjoKL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTYzdGJ6aWtvL3NyYy9kb2NzL2Rl
dmVsL3Rlc3RpbmcucnN0OjYyNzpUaXRsZSB1bmRlcmxpbmUgdG9vIHNob3J0LgoKVGhlIGBgYXZv
Y2Fkb19xZW11Lk1hY2hpbmVUZXN0YGAgYmFzZSB0ZXN0IGNsYXNzCgoKVGhlIGZ1bGwgbG9nIGlz
IGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDYyNTEwMTUyNC4xMzQ0
Ny0xLXBoaWxtZEByZWRoYXQuY29tL3Rlc3RpbmcuczM5MHgvP3R5cGU9bWVzc2FnZS4KLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=


