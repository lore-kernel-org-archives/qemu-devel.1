Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8653C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 18:52:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4A0206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 18:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kCptQpt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4A0206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZfRo-0005fd-M6
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 14:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZfPk-0003iY-5A
 for qemu-devel@nongnu.org; Fri, 15 May 2020 14:50:32 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZfPi-0006ys-LZ
 for qemu-devel@nongnu.org; Fri, 15 May 2020 14:50:31 -0400
Received: by mail-wm1-x343.google.com with SMTP id h4so3302997wmb.4
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 11:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qO0DEQsgPpTJ3W4/yS4w/C15HNNzg8b4HlcX8EpUruc=;
 b=kCptQpt3JTZf6kKb6JUO50b9sOrJ7fChepBTI0ddUNdY+l+yYWT/Zt0MMn0dILfVGZ
 T/wsV/NRL/2tDCbLdbcRlFenRkyKkpEi1mXIvRaEGuqYJJ0W1du1tF+wYOwXKuAbew8e
 ewuD7cQMezcDzFyweundxVOnGry6jB+VMokUdsIF3AoJaS8dyY3qjifn9KxSurqX0ECg
 RmeC45Rm0Q1wNMM3OZqJuJl39Rq7iVMrbOpwb4jdAgRdK1f0b6Eg/mexqe4jZoU5PYdd
 gKQ88UmGZV/JkcxA+Q1qQLQfPZNxoZUkxUDyj1j5EqooCNE0hFnG2xe390yx3VfX+geK
 AN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qO0DEQsgPpTJ3W4/yS4w/C15HNNzg8b4HlcX8EpUruc=;
 b=DAjxYnZGei4qQdkLiy5Pk4GvUnu0dk54p/2GGjv5r22qbc7rdHKlhE7vBPccZYop9y
 19eh/InU8e8SrV15Fi5mi7F+eVnuie7dcP+BqEBGsi8Ct9p6Ylk79TJDbOeQiGH0JrxM
 rgjdlSErhS5zU6k0/qDPJOSN1pHeH1KurZRlWeuccWX6z9+bf22TTUGq7Q+Ff3HCjZwZ
 qTJBHaJa+KL8s/WdHbiZ/H1+zN3HXw99k0eGa1C4DjFQ4xfUIWElFYB0EIawHujeWR3S
 O3csodWWCta2UpZOOix4oK5ONN7EZAlk3ORez+TDlqavr68NLvVxoYXigH0TNfdjvGKo
 t3XA==
X-Gm-Message-State: AOAM5315GDQcj3zmiS3phUKHFdDkMl+yntYkn2rsX5QC39+riyuXu69t
 Y9SnoWei/fnpoNYFrzfaYa3gcknTGxNxZg==
X-Google-Smtp-Source: ABdhPJyySNXoTJi3gbz+pEbw9adexcQr0W13ZyJSOIY7sqzFmU2ibfQ8WBcoB+RWgbdV8a2KZjZSkA==
X-Received: by 2002:a05:600c:2197:: with SMTP id
 e23mr5476238wme.162.1589568629067; 
 Fri, 15 May 2020 11:50:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g10sm4640651wrx.4.2020.05.15.11.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 11:50:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Allow user-mode code to write CPSR.E via MSR
Date: Fri, 15 May 2020 19:50:26 +0100
Message-Id: <20200515185026.30080-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using the MSR instruction to write to CPSR.E is deprecated, but it is
required to work from any mode including unprivileged code.  We were
incorrectly forbidding usermode code from writing it because
CPSR_USER did not include the CPSR_E bit.

We use CPSR_USER in only three places:
 * as the mask of what to allow userspace MSR to write to CPSR
 * when deciding what bits a linux-user signal-return should be
   able to write from the sigcontext structure
 * in target_user_copy_regs() when we set up the initial
   registers for the linux-user process

In the first two cases not being able to update CPSR.E is a
bug, and in the third case it doesn't matter because CPSR.E
is always 0 there. So we can fix both bugs by adding CPSR_E
to CPSR_EXEC.

(The recommended way to change CPSR.E is to use the 'SETEND'
instruction, which we do correctly allow from usermode code.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Bug reported on IRC. Quick-and-dirty test case at:
 https://people.linaro.org/~peter.maydell/msr-setend.c

 target/arm/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5d995368d4f..677584e5da0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1230,7 +1230,7 @@ void pmu_init(ARMCPU *cpu);
 #define CACHED_CPSR_BITS (CPSR_T | CPSR_AIF | CPSR_GE | CPSR_IT | CPSR_Q \
     | CPSR_NZCV)
 /* Bits writable in user mode.  */
-#define CPSR_USER (CPSR_NZCV | CPSR_Q | CPSR_GE)
+#define CPSR_USER (CPSR_NZCV | CPSR_Q | CPSR_GE | CPSR_E)
 /* Execution state bits.  MRS read as zero, MSR writes ignored.  */
 #define CPSR_EXEC (CPSR_T | CPSR_IT | CPSR_J | CPSR_IL)
 
-- 
2.20.1


