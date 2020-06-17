Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52850C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:33:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1999121852
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Thm2aHey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1999121852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfgB-0000I7-9y
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEs-0004d9-Ll
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:54 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:46918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEm-0000OY-VU
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:54 -0400
Received: by mail-qt1-x844.google.com with SMTP id g18so2725211qtu.13
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Gn2vKDOISxQzKy44RYpzzeOAg/5NGEBTOA6wtcYZvN4=;
 b=Thm2aHeyJvMESgiuasvN/HjzFdRSeqqVQq4LmqV7D6GB6694ajgYvGe/9WpkcXcr7F
 H6koOjMcYHMlU58jiBD/na7kpp3MbsoTyX0KplAxlwrt2ZmSeI/rh5fM8TdZticOuv0p
 Z1vjrEEY1KGN1jCiWJwqToxP+qrfb2n72GLHYu9mJqEYeG3CUlJzq4Eky3Kx2UvuHPHN
 aMlcJ1moeBFKEZ07hjG6Nhi29ltknA7u72gd+Wrac+8dyTBBsAfs1wIVelDyGhrH+pG+
 PPsjFOGYYUXi0b4Dv6yGb227Q5Ef2PKsuQMeOhRBSfupxxYGQECJ0uMoPk4M83egmmQx
 rsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Gn2vKDOISxQzKy44RYpzzeOAg/5NGEBTOA6wtcYZvN4=;
 b=eK+bamCd/z262bhZrdAt9o1bJRpRneSS+H1nOJqtmyNSaC6hbb+uaKBxEAAbDv3Lmb
 IWFDcC1ucWfvAXg2J0zoFksB/58J7NpNkqVF3m08mplZDVZdoNp9t14uZpOWIfBRJUmf
 PsEH7PcmefK05FG9QBP6+T69O9kHBBaBYk79fMqs2E3gO9oN2wfI10DkNj7XC5UVPa8Q
 pcj1rm6Ov43tH0VHH4Wst1pJ5jsWjdp5wz241rXZm1AxZy7+FW/Ew+l90n2nNWhPWx0/
 D6Wmwbnr083jaVTWuAURHM+Xczvw5sHyHHJYhS+H7phe1xAUCHn1bI264mHR8ry01QHP
 n9Gw==
X-Gm-Message-State: AOAM531hWh/5SWwtiDRLiLha723myIuM73+b4DGDrBbiWIry9QQY4/jb
 snnozBt+aYlfCBtWt42P/BkNLu/09ol46w==
X-Google-Smtp-Source: ABdhPJxAKNubapx5PrPPbM5wErYiPAmdGaZpL0L5IGJIvowKMl1c2emXMR/ej2SGxbckZ5RV2i/pjg==
X-Received: by 2002:ac8:51d5:: with SMTP id d21mr1141796qtn.154.1592427887822; 
 Wed, 17 Jun 2020 14:04:47 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:47 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 64/73] mips: convert to cpu_has_work_with_iothread_lock
Date: Wed, 17 Jun 2020 17:02:22 -0400
Message-Id: <20200617210231.4393-65-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x844.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, robert.foley@linaro.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, cota@braap.org,
 peter.puhov@linaro.org, alex.bennee@linaro.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Soon we will call cpu_has_work without the BQL.

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/mips/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 761d8aaa54..ec9dde5100 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -58,6 +58,8 @@ static bool mips_cpu_has_work(CPUState *cs)
     bool has_work = false;
     uint32_t interrupt_request = cpu_interrupt_request(cs);
 
+    g_assert(qemu_mutex_iothread_locked());
+
     /*
      * Prior to MIPS Release 6 it is implementation dependent if non-enabled
      * interrupts wake-up the CPU, however most of the implementations only
@@ -193,7 +195,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     device_class_set_parent_reset(dc, mips_cpu_reset, &mcc->parent_reset);
 
     cc->class_by_name = mips_cpu_class_by_name;
-    cc->has_work = mips_cpu_has_work;
+    cc->has_work_with_iothread_lock = mips_cpu_has_work;
     cc->do_interrupt = mips_cpu_do_interrupt;
     cc->cpu_exec_interrupt = mips_cpu_exec_interrupt;
     cc->dump_state = mips_cpu_dump_state;
-- 
2.17.1


