Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D01C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF8442075E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w0oXvjuN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8442075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60928 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLA1f-0007x6-V0
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:25:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9fD-0005Id-Q4
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9f5-0006uc-Jq
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:55636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9f0-0006Zq-6w
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:47 -0400
Received: by mail-wm1-x333.google.com with SMTP id o25so150674wmf.5
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=eTbZj0yNxBgy+nnqwFFdjnetdUZKzGCHFuJh3epfaNs=;
	b=w0oXvjuNrBmN3lwaqC091UnPSA+Nip6L1D1gNhXabdyOVWLqgwM2ZepC/QlQytehDC
	/0reAkO4mgWAD0wt334tCQ6ZAiA1nWuhGT1O/XWrnQZflAuN1caZsUPN5qnQgyBTQUun
	trdJp0Phz0LW6IRjmPuZPwfZRrPTZ3QSHcNum3jty62mvpbOm09HW1eTYZuCFPR9d8wF
	yY3/tqQ5dd9QkK0kQkKCKyZHAianqZMD/rj7kTThIOTa2S+PEBu4QOi6pmYVzlKTluuZ
	oMa07i0fechMDRRzGZxDNDFoWDo2+whe5w77yKS+/1ihR/5QntW6VH8g5EyvIAOvzLLy
	y74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=eTbZj0yNxBgy+nnqwFFdjnetdUZKzGCHFuJh3epfaNs=;
	b=Er2cjoTmD1ZuG+aCmxMKIc9ur+3yoYdor1bFJoRr8yHCrV+XjdsVxTTMRCGusJ0hlM
	Z1pM2dOKJYTPf+OW4kP1H3YyYi8awhWoLJC0SVUsjxr8Jfa5sofiGDPbRV/llARsPGpq
	PzLORwvo6KlDif517eOTa6kG6icjX/FNQs8G/fEBt8nhZGerS23P3pjSnuaYw52IS2cz
	9jAQLjvFxoPdXOsVcHFnXdlFk1q7oBYtX73ODnblqKR7W8vnz2g0V5G9zNsOrCJDF5Z1
	lRXTbo/ygqbcLLRrHKzF5u153eyIY7eknsS+HV2JWJehOozmu7qHUki/iqOHcNGfjrQg
	HT2A==
X-Gm-Message-State: APjAAAW9RVtYlPKY6BClPO54MMpvp+RyWxfJ8rhvd+2ClJbkHyhvRXQ3
	blI/AlTBfH0LU/gG26kF6ZyBQP/EfQM=
X-Google-Smtp-Source: APXvYqwZ+C8OmR/drQxNnKAaRy9LnIaH9CKL3JPw75SK4gPFRZvAZygzt88Bum9vEfOpV4Dtp4RK8A==
X-Received: by 2002:a1c:4c09:: with SMTP id z9mr24312wmf.87.1556557270116;
	Mon, 29 Apr 2019 10:01:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.08
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 18:00:17 +0100
Message-Id: <20190429170030.11323-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::333
Subject: [Qemu-devel] [PULL 29/42] target/arm: Enable FPU for Cortex-M4 and
 Cortex-M33
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429170017._OR5zMEI1m2DqxT6zk-7Vgs3muaveSFrnsVgdCHwYFY@z>

Enable the FPU by default for the Cortex-M4 and Cortex-M33.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-27-peter.maydell@linaro.org
---
 target/arm/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7deccda2404..a181fa8dc1a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1493,8 +1493,12 @@ static void cortex_m4_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_M);
     set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
+    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     cpu->midr = 0x410fc240; /* r0p0 */
     cpu->pmsav7_dregion = 8;
+    cpu->isar.mvfr0 = 0x10110021;
+    cpu->isar.mvfr1 = 0x11000011;
+    cpu->isar.mvfr2 = 0x00000000;
     cpu->id_pfr0 = 0x00000030;
     cpu->id_pfr1 = 0x00000200;
     cpu->id_dfr0 = 0x00100000;
@@ -1521,9 +1525,13 @@ static void cortex_m33_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
     set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
+    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     cpu->midr = 0x410fd213; /* r0p3 */
     cpu->pmsav7_dregion = 16;
     cpu->sau_sregion = 8;
+    cpu->isar.mvfr0 = 0x10110021;
+    cpu->isar.mvfr1 = 0x11000011;
+    cpu->isar.mvfr2 = 0x00000040;
     cpu->id_pfr0 = 0x00000030;
     cpu->id_pfr1 = 0x00000210;
     cpu->id_dfr0 = 0x00200000;
-- 
2.20.1


