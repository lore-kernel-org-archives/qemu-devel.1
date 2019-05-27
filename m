Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3735C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 10:47:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F26214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 10:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnPHGGvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F26214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43493 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVDAS-0001XM-0o
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 06:47:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1hVD9U-0001Cc-57
	for qemu-devel@nongnu.org; Mon, 27 May 2019 06:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1hVD9T-0002G7-4n
	for qemu-devel@nongnu.org; Mon, 27 May 2019 06:46:48 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1hVD9S-0002F6-TE
	for qemu-devel@nongnu.org; Mon, 27 May 2019 06:46:47 -0400
Received: by mail-pg1-x543.google.com with SMTP id t1so8916316pgc.2
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 03:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=YULeuaw6Jc86bWQlKIn+WYEbp/WlRteTq6uuOLuLmgE=;
	b=gnPHGGvc3H5whBiSLcsGnQAPbOAcnvtQRKdl/vtEacTw2uoUUb55Z/1g33VtJeM8f7
	Dny7JXEXAA4aTNuVqnZlSWTPyE2raU1rCEWDAClUzECIt2Pr1zeK+MjRTxueCrHE6N2g
	OBivMwsMQrV/ahBijej/AkRweU/BSjVJ6KCEKALUsbFedxkrN8n7MUgKIcNh2lkmUcHH
	xE/+M7M5uBSDGzYLMhyYYkDOxXgA8f5LDhaNsVnn7ak0ZS05zgNYQ0C9Waqiy3kOnSVp
	XLZWxTVybRQmvLsfd5nvSleX/qTywlAKqEq6SwemuXtOujyncAUx0pf73ZS0UPoBctu7
	u8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=YULeuaw6Jc86bWQlKIn+WYEbp/WlRteTq6uuOLuLmgE=;
	b=My3n05r+bLj2Af0tUcskPcSLIoH3ZPf30Ynd/qbJurL53PLb0LIsF8Qa0/ejeUBSEu
	CsvIGTY4LVHzclBNOThAG/OCm3rpta4KWZsFRWVfTa7RInFTmt2zx1B+3gCgTegkxx0D
	FT40hAbt/Kqvew7OkI3SZhz7/P0oO8MfLgwAKOcDq4qzoSUpjJGmAEoPDoYV48w+xpx6
	1XzwsnYxwGFUODUqEkM29EaLMERxVNk/bNBfngZqM+Op1SbKGaGVU8TFXFJGx3c1VaLG
	XO1AzcRsWvmD5mKpWddKgOeDDaSBK6/BQFvC+nsKAPq4Gi/1bZuPb0nqfqfMzs5t6fH1
	/x6g==
X-Gm-Message-State: APjAAAUMxX6oLibqKZIaEHJCY73AI2iiHZ/z9HUkdDT0fBbeiSEMopRl
	INcLUTG1CY3f0/In52xLScch8i8N
X-Google-Smtp-Source: APXvYqyC7V1Bddt2ayGRgVkCJMHVJ9PYyLGgL/wJtpD3rLj4iNTzMOYpMH7u5Gm9y1nUaW+68DgSvA==
X-Received: by 2002:a17:90a:9281:: with SMTP id
	n1mr29517336pjo.25.1558954004814; 
	Mon, 27 May 2019 03:46:44 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
	by smtp.googlemail.com with ESMTPSA id
	k13sm10174792pgr.90.2019.05.27.03.46.43
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 27 May 2019 03:46:44 -0700 (PDT)
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Date: Mon, 27 May 2019 18:46:40 +0800
Message-Id: <1558954000-9715-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH] target-i386: adds PV_SCHED_YIELD CPUID feature
 bit
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wanpeng Li <wanpengli@tencent.com>

Adds PV_SCHED_YIELD CPUID feature bit.

Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5f07d68..f4c4b6b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -902,7 +902,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
             "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-pv-unhalt",
             NULL, "kvm-pv-tlb-flush", NULL, "kvm-pv-ipi",
-            NULL, NULL, NULL, NULL,
+            "kvm-pv-sched-yield", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             "kvmclock-stable-bit", NULL, NULL, NULL,
-- 
2.7.4


