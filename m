Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F8CC3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 18:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B5B2206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 18:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B5B2206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hygjl-000494-8Y
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 14:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1hygiy-0003YL-4z
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 14:13:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hygix-0005jX-0G
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 14:13:16 -0400
Resent-Date: Fri, 16 Aug 2019 14:13:16 -0400
Resent-Message-Id: <E1hygix-0005jX-0G@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hygiu-0005gI-1g; Fri, 16 Aug 2019 14:13:12 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1565979184; cv=none; d=zoho.com; s=zohoarc; 
 b=Yxo0LVKbIGXEJbqjAyeNgYEBOj8RHKWpN2/oSts1Il3LRPP9BtF0yKmMt3NqD19a0hP0oIQWm8Gm6RBO0PPfw5tr0Qs79yAy9Ucx45/d+IRKFW5ckaUM/eewSFWP4tTHvQaRsad1GApkNHgoQ/+YnlJnobh8unLenK4Fu6krbc0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1565979184;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=IaGT54kZbzOjSd3CRI794MsPy/X9i9kR0FbdXgHoWjw=; 
 b=OLmTuvsQ0Ii+MFDtXapKMf/6ovW054ILT/IYD14uxCFfLUczYLDJ7yHE2pAJr3h7zf6/onuGTdgkNDT4hmFIbRkFWTM20uPuuVhuZHLS84veU4rI9EC+9JY7xkWEqpzwmklSzVokxaQbwLgLYzWCKlt8o0NPsz8Vaq3vA3SXZzw=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1565979183452526.6729052566353;
 Fri, 16 Aug 2019 11:13:03 -0700 (PDT)
In-Reply-To: <20190816125802.25877-1-peter.maydell@linaro.org>
Message-ID: <156597918248.21161.13741702560701675516@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: peter.maydell@linaro.org
Date: Fri, 16 Aug 2019 11:13:03 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [PATCH 0/2] target/arm: Take exceptions on ATS
 instructions
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgxNjEyNTgwMi4yNTg3
Ny0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
YnVpbGQgdGVzdCBvbiBzMzkweCBob3N0LiBQbGVhc2UgZmluZCB0aGUgZGV0YWlscyBiZWxvdy4K
Cj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKIyBUZXN0aW5nIHNjcmlwdCB3
aWxsIGJlIGludm9rZWQgdW5kZXIgdGhlIGdpdCBjaGVja291dCB3aXRoCiMgSEVBRCBwb2ludGlu
ZyB0byBhIGNvbW1pdCB0aGF0IGhhcyB0aGUgcGF0Y2hlcyBhcHBsaWVkIG9uIHRvcCBvZiAiYmFz
ZSIKIyBicmFuY2gKc2V0IC1lCgplY2hvCmVjaG8gIj09PSBFTlYgPT09IgplbnYKCmVjaG8KZWNo
byAiPT09IFBBQ0tBR0VTID09PSIKcnBtIC1xYQoKZWNobwplY2hvICI9PT0gVU5BTUUgPT09Igp1
bmFtZSAtYQoKQ0M9JEhPTUUvYmluL2NjCklOU1RBTEw9JFBXRC9pbnN0YWxsCkJVSUxEPSRQV0Qv
YnVpbGQKbWtkaXIgLXAgJEJVSUxEICRJTlNUQUxMClNSQz0kUFdECmNkICRCVUlMRAokU1JDL2Nv
bmZpZ3VyZSAtLWNjPSRDQyAtLXByZWZpeD0kSU5TVEFMTAptYWtlIC1qNAojIFhYWDogd2UgbmVl
ZCByZWxpYWJsZSBjbGVhbiB1cAojIG1ha2UgY2hlY2sgLWo0IFY9MQptYWtlIGluc3RhbGwKPT09
IFRFU1QgU0NSSVBUIEVORCA9PT0KCgoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0
cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA4MTYxMjU4MDIuMjU4NzctMS1wZXRlci5tYXlkZWxs
QGxpbmFyby5vcmcvdGVzdGluZy5zMzkweC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


