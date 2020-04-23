Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D841AC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACBE72073A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBE72073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRbuR-0004nI-R7
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 09:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRbtU-00041N-2N
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRbtR-0004kO-Pb
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:27:55 -0400
Resent-Date: Thu, 23 Apr 2020 09:27:55 -0400
Resent-Message-Id: <E1jRbtR-0004kO-Pb@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jRbtR-0004cE-7d; Thu, 23 Apr 2020 09:27:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587648465; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QpHaC5WyO/npImWr7uO/V6wo5leAHnBEP53pm2fXV351KSS732G9xK51d5aUxArzsextyNDyFQ+jkuFIqPEEK1lfrnxZPea3XfkZwj3c24yOQkPokSGzArfmQhoue6f5uFgYBw3242Miph+Mz+7W9PUl62TtFxHlEAE+4nLF4e0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587648465;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=5vbeQ+FkkXK8pQZM2SCNF1+zR79pPQdIELJE7I6w7VI=; 
 b=ntKmPKLDhMQ9LpzovDmBkRtpdjwEvgWq1jSmIte1CvNdBX7rKUuZ0aGVjC0bydEl2ww9SIe8LxqZuS4dEpH9x0a4L/WSUnepQf8nd+MPboiQSXlw6vWCPaYDPBm9jIyPohm/SwDrvF44SmJzZxsx8Cu3dnRPPEgblTI3kj7jG+8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158764846267898.20209728325824;
 Thu, 23 Apr 2020 06:27:42 -0700 (PDT)
In-Reply-To: <20200423124305.14718-1-f4bug@amsat.org>
Subject: Re: [PATCH] target/arm: Use correct variable for setting 'max' cpu's
 MIDR_EL1
Message-ID: <158764846144.10590.796159814554977319@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Thu, 23 Apr 2020 06:27:42 -0700 (PDT)
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
OC0xLWY0YnVnQGFtc2F0Lm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGFzYW4g
YnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91
dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJs
eSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmlu
L2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9eDg2
XzY0LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCgoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA0
MjMxMjQzMDUuMTQ3MTgtMS1mNGJ1Z0BhbXNhdC5vcmcvdGVzdGluZy5hc2FuLz90eXBlPW1lc3Nh
Z2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEByZWRoYXQuY29t

