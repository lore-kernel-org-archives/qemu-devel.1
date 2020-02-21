Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741A9C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 341D82073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ES52HhmX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341D82073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58Dg-0000nE-DE
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:19:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582X-0007bV-Lv
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582W-00038N-Jw
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:21 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:42085)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582W-000374-Dc
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:20 -0500
Received: by mail-wr1-x435.google.com with SMTP id k11so1985055wrd.9
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8O3SsjgKcLhfOeNTmM2193LemAhafTVhhnio75aha0c=;
 b=ES52HhmXrBeNfyKKeub1XgMCtuMpWVMSyduLW+qPVMOcgCbcqEKPm6djfO/Syl3r6W
 OIHUGwIQS3BjSojabD823K402qnwUSnlsgAfgwhqtZX2NNlyRjObFeGqNhFXpQ7x3bRM
 tnWyh5/61KdPARYTKQg9pi9fCOCFJz0Fn6gZADG0dDep2qUGqLyi7UwK8BmmiHQLXQZs
 9glL462l2XcsVaD+xH5sg2ek55DM6kZB1GrEsEcIMEz3Y7j8OmnT7PBqIw/ADyzumwia
 uiRvJomsU6ZyYKC5Maw076DYR0rR1P84vx+DeknWSMC9w0L6z5nS4qbs6dzJw/Zpbvvj
 kCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8O3SsjgKcLhfOeNTmM2193LemAhafTVhhnio75aha0c=;
 b=GgJ77NgSxL8frC3ZLRJKj42A7DRQPQvWMg7vmpEK+vsMZyW67CtQCB0WT9R9iHxiaN
 IYiP62AQho7fHppeXk7q+S/rwIqykO6CV19FizUnixLejFTav0LJYNjGiH9P6XrA8g/G
 PwLHQdaE+uQMVea4+fKH8uf8aqJCBnvC1Z6TYj/qYO4r50QUottw9ozaQ+C4jWGOdIDV
 WDoKfzeuOf9/81JrIjHXGNANc2mqNTAPDFk1bakAsCFHN7vF4w6BOezZxW/A8JtV18Ow
 wJi1qneTgfOzEYPUb9J79KYBVQo7soUba/Os+ltFLZRVGwSXnDlufQ9+8xH63h4LjYCs
 aonQ==
X-Gm-Message-State: APjAAAV0B6hsF/LYmpRUhI2hPoFVaL+kunuzKa4NEv456KCxJ8Evx/+o
 dAVD7dnmkt+GrnnUeKX4Ncvq7eHMbkraFQ==
X-Google-Smtp-Source: APXvYqwVO/maJb4fQANun8IvjPhPjiTDvHx80csrb/Hp4m2zDMtrbIMEBpw01ktBNFuVmxQNFRc1tQ==
X-Received: by 2002:a5d:560d:: with SMTP id l13mr22512115wrv.222.1582290499179; 
 Fri, 21 Feb 2020 05:08:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/52] target/arm: Correct handling of PMCR_EL0.LC bit
Date: Fri, 21 Feb 2020 13:07:18 +0000
Message-Id: <20200221130740.7583-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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

The LC bit in the PMCR_EL0 register is supposed to be:
 * read/write
 * RES1 on an AArch64-only implementation
 * an architecturally UNKNOWN value on reset
(and use of LC==0 by software is deprecated).

We were implementing it incorrectly as read-only always zero,
though we do have all the code needed to test it and behave
accordingly.

Instead make it a read-write bit which resets to 1 always, which
satisfies all the architectural requirements above.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200214175116.9164-18-peter.maydell@linaro.org
---
 target/arm/helper.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e868b08cc18..15a840f530b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1023,6 +1023,11 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
 #define PMCRC   0x4
 #define PMCRP   0x2
 #define PMCRE   0x1
+/*
+ * Mask of PMCR bits writeable by guest (not including WO bits like C, P,
+ * which can be written as 1 to trigger behaviour but which stay RAZ).
+ */
+#define PMCR_WRITEABLE_MASK (PMCRLC | PMCRDP | PMCRX | PMCRD | PMCRE)
 
 #define PMXEVTYPER_P          0x80000000
 #define PMXEVTYPER_U          0x40000000
@@ -1577,9 +1582,8 @@ static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
         }
     }
 
-    /* only the DP, X, D and E bits are writable */
-    env->cp15.c9_pmcr &= ~0x39;
-    env->cp15.c9_pmcr |= (value & 0x39);
+    env->cp15.c9_pmcr &= ~PMCR_WRITEABLE_MASK;
+    env->cp15.c9_pmcr |= (value & PMCR_WRITEABLE_MASK);
 
     pmu_op_finish(env);
 }
@@ -6370,7 +6374,8 @@ static void define_pmu_regs(ARMCPU *cpu)
         .access = PL0_RW, .accessfn = pmreg_access,
         .type = ARM_CP_IO,
         .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcr),
-        .resetvalue = (cpu->midr & 0xff000000) | (pmcrn << PMCRN_SHIFT),
+        .resetvalue = (cpu->midr & 0xff000000) | (pmcrn << PMCRN_SHIFT) |
+                      PMCRLC,
         .writefn = pmcr_write, .raw_writefn = raw_write,
     };
     define_one_arm_cp_reg(cpu, &pmcr);
-- 
2.20.1


