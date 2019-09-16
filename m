Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41CFC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41E820678
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41E820678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9uJV-0006gM-St
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 12:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i9uII-0005cF-NB
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 12:56:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i9uIC-0005kr-Eg
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 12:56:06 -0400
Resent-Date: Mon, 16 Sep 2019 12:56:06 -0400
Resent-Message-Id: <E1i9uIC-0005kr-Eg@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21416)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i9uIC-0005js-70
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 12:56:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568652935; cv=none; d=zoho.com; s=zohoarc; 
 b=A5HS6hRcRaNlBxa511bGerFc5HX/VmMYi67cU3lBQ13ItXCgfDWg4UM3EcTdaNcaya4xkwYCQbvEi5wRXlhSB5vFuVGag0U9c5dFD3NxyYJi4RHTkvC0+AlT48fw+aB3hDPtDko/dYMAa/AetOf9BGBvM1eC4TG/m/DXK7B1K3g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568652935;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=YIWAm69jVTeBlmgsjxalCz5Dk9Zqaid6Q0GgEFeGyEw=; 
 b=eFX7TOU6nXDwPIRuvqo8OPY+uMHQsagPh7S03XCyZZGWmUsUYyhED/AW2M5X8zZlF4Jv73aOKImjZJnIbPoENI/oPIVMZVvEq1vm/oKbp10GZAhu5BGte/as/Kx4PxVGzYpwjxiM7Q7HYETPuv7yK9NnwODRzV3lLoTYN7EbZ3c=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568652934301646.3635861999046;
 Mon, 16 Sep 2019 09:55:34 -0700 (PDT)
In-Reply-To: <20190916155545.29928-1-olivier.dion@polymtl.ca>
Message-ID: <156865293339.13319.14341537067777555620@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: olivier.dion@polymtl.ca
Date: Mon, 16 Sep 2019 09:55:34 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.54
Subject: Re: [Qemu-devel] [PATCH v2 0/1] Handle /proc/self/exe in execve
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
Cc: olivier.dion@polymtl.ca, qemu-devel@nongnu.org, john.ogness@linutronix.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxNjE1NTU0NS4yOTky
OC0xLW9saXZpZXIuZGlvbkBwb2x5bXRsLmNhLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCBi
dWlsZCB0ZXN0IG9uIEZyZWVCU0QgaG9zdC4gUGxlYXNlIGZpbmQgdGhlIGRldGFpbHMgYmVsb3cu
Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCiMgVGVzdGluZyBzY3JpcHQg
d2lsbCBiZSBpbnZva2VkIHVuZGVyIHRoZSBnaXQgY2hlY2tvdXQgd2l0aAojIEhFQUQgcG9pbnRp
bmcgdG8gYSBjb21taXQgdGhhdCBoYXMgdGhlIHBhdGNoZXMgYXBwbGllZCBvbiB0b3Agb2YgImJh
c2UiCiMgYnJhbmNoCmlmIHFlbXUtc3lzdGVtLXg4Nl82NCAtLWhlbHAgPi9kZXYvbnVsbCAyPiYx
OyB0aGVuCiAgUUVNVT1xZW11LXN5c3RlbS14ODZfNjQKZWxpZiAvdXNyL2xpYmV4ZWMvcWVtdS1r
dm0gLS1oZWxwID4vZGV2L251bGwgMj4mMTsgdGhlbgogIFFFTVU9L3Vzci9saWJleGVjL3FlbXUt
a3ZtCmVsc2UKICBleGl0IDEKZmkKbWFrZSB2bS1idWlsZC1mcmVlYnNkIEo9MjEgUUVNVT0kUUVN
VQpleGl0IDAKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCgoKClRoZSBmdWxsIGxvZyBpcyBhdmFp
bGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA5MTYxNTU1NDUuMjk5MjgtMS1v
bGl2aWVyLmRpb25AcG9seW10bC5jYS90ZXN0aW5nLkZyZWVCU0QvP3R5cGU9bWVzc2FnZS4KLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhh
dC5jb20=


