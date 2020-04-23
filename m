Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2AFC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5D82073A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5D82073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRby3-0002WU-TX
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 09:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRbu2-0004fP-Vi
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:28:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRbu1-0005Im-D3
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:28:30 -0400
Resent-Date: Thu, 23 Apr 2020 09:28:30 -0400
Resent-Message-Id: <E1jRbu1-0005Im-D3@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jRbu0-0005IE-TP; Thu, 23 Apr 2020 09:28:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587648501; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Bgdus4PjdXvQDDOwE8SNs7TNTDVMTDzmSJjxCCmk9nddhdEPxSnGH6vMkC2GHbGfOgpexJSLi4PnOXvbvDADSintLnqK/HlRjUOx6jx78FLeXKQH6CTleLdNlwXEOFAAStTZJdJ8o7aXxOOlebbf1q0fB7iEDL1WAVPqef3eH8M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587648501;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=/xxIBj5ZoBVxwpVcgWGWufrcZ39XDX4NJlP9rmN3ujo=; 
 b=ARCE30CMkqAbuh8g4XJZudMVFi5WbGpiPasKUsGmH23fjAIEzPk0mnlKK7tx1WBrK7HZLpL9luXZIE0euduc6i5Tq/f6YzqwmizsEI17O/3a/PK79l6ql76Bo+36yxPxbeHxEGMl/itAfYJYfXIErVKo5z2V4/N0dfWGQIs3dRE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587648499707417.61477244133255;
 Thu, 23 Apr 2020 06:28:19 -0700 (PDT)
In-Reply-To: <20200423124305.14718-1-f4bug@amsat.org>
Subject: Re: [PATCH] target/arm: Use correct variable for setting 'max' cpu's
 MIDR_EL1
Message-ID: <158764849856.10590.12218018471221690073@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Thu, 23 Apr 2020 06:28:19 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 09:27:50
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyMzEyNDMwNS4xNDcx
OC0xLWY0YnVnQGFtc2F0Lm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgYnVpbGQgdGVz
dCBvbiBGcmVlQlNEIGhvc3QuIFBsZWFzZSBmaW5kIHRoZSBkZXRhaWxzIGJlbG93LgoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAojIFRlc3Rpbmcgc2NyaXB0IHdpbGwgYmUg
aW52b2tlZCB1bmRlciB0aGUgZ2l0IGNoZWNrb3V0IHdpdGgKIyBIRUFEIHBvaW50aW5nIHRvIGEg
Y29tbWl0IHRoYXQgaGFzIHRoZSBwYXRjaGVzIGFwcGxpZWQgb24gdG9wIG9mICJiYXNlIgojIGJy
YW5jaAppZiBxZW11LXN5c3RlbS14ODZfNjQgLS1oZWxwID4vZGV2L251bGwgMj4mMTsgdGhlbgog
IFFFTVU9cWVtdS1zeXN0ZW0teDg2XzY0CmVsaWYgL3Vzci9saWJleGVjL3FlbXUta3ZtIC0taGVs
cCA+L2Rldi9udWxsIDI+JjE7IHRoZW4KICBRRU1VPS91c3IvbGliZXhlYy9xZW11LWt2bQplbHNl
CiAgZXhpdCAxCmZpCm1ha2Ugdm0tYnVpbGQtZnJlZWJzZCBKPTIxIFFFTVU9JFFFTVUKZXhpdCAw
Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgoKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDIzMTI0MzA1LjE0NzE4LTEtZjRidWdAYW1z
YXQub3JnL3Rlc3RpbmcuRnJlZUJTRC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

