Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D183AC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:30:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50022073A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50022073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43369 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRbwA-0007iV-Ln
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 09:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRbv8-00066T-26
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRbv7-0006fs-JL
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:29:37 -0400
Resent-Date: Thu, 23 Apr 2020 09:29:37 -0400
Resent-Message-Id: <E1jRbv7-0006fs-JL@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jRbv7-0006cJ-1p; Thu, 23 Apr 2020 09:29:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587648569; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=W3+QhayLc/L7OvHB25cR/dqUPkowjIxkDgWRGsAHwNZogo44xPsu5TqBqNcy4J4WlbF8qKTooSkyn8wf1sXlB/pUP4Z8sRwckaWXYLFRptCoAU3HDFZ8+758D4qYr7g7h7hQZ8x50yyWQqn1p0Y6j7+PleLWG+ET87H6yrfFRGQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587648569;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=N0mbElxuE25wID2H1dJW+He3lrXa8zXWDPs/ORJYI6k=; 
 b=FMTEXhxQgprrMjJEJq2KNmS1OQ4c3117bQOjCfx85c1UVvagM1KpdTuo6wt7d74ihUAb4nXyo7xGCy2PANJQvFP46pjQOxvv9/LR7HWD4Zq8QhPFIghOnfHkUfZ/kPksjs49F0lcgWW1ga46ZI0rG2jyldcIGQCo5VydCp2MsKg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587648567658811.4739422473675;
 Thu, 23 Apr 2020 06:29:27 -0700 (PDT)
In-Reply-To: <20200423124305.14718-1-f4bug@amsat.org>
Subject: Re: [PATCH] target/arm: Use correct variable for setting 'max' cpu's
 MIDR_EL1
Message-ID: <158764856650.10590.13077926961387104800@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Thu, 23 Apr 2020 06:29:27 -0700 (PDT)
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
OC0xLWY0YnVnQGFtc2F0Lm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tl
ci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1pbWFn
ZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3Jh
IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgoKCgpUaGUgZnVsbCBsb2cg
aXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDIzMTI0MzA1LjE0
NzE4LTEtZjRidWdAYW1zYXQub3JnL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1t
ZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0
cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXct
ZGV2ZWxAcmVkaGF0LmNvbQ==

