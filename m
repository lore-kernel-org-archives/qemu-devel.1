Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B699DC35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 15:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B58720643
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 15:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="dQsPJnVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B58720643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyHH7-0004J4-KJ
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 10:35:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jrtc27@jrtc27.com>) id 1iyHGZ-0003pt-V5
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 10:34:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jrtc27@jrtc27.com>) id 1iyHGY-0006L1-Ma
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 10:34:31 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52789)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jrtc27@jrtc27.com>) id 1iyHGY-0006Jq-FZ
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 10:34:30 -0500
Received: by mail-wm1-x341.google.com with SMTP id p9so13202428wmc.2
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2020 07:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jrtc27.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kcaQswwdYaICvCGD6ZMLcY/AHwZRWhw/gJoFx3vd0gg=;
 b=dQsPJnVbIWrKm+UvriIM1BzWywK5abnR8/+nmruxc6Bidkf/uiQm3aAmq5fxq2TuYC
 CgCGdTxRipNCgL+3sYRWHfvwIErauCc5+w10wuvqotQEJs8iouGR7LedxbNb/628bDAg
 RxaL21VHGKZ4/PuQWNZifvlO1LahqLLbHI7QE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kcaQswwdYaICvCGD6ZMLcY/AHwZRWhw/gJoFx3vd0gg=;
 b=IfOrLcQzAYaB4EcMSRDrfDnEIlwmzwDHUhP/CzxByYOhdb94EUn6UBkVUra/BMI2I6
 4LIjtAZiOgh5YOP5hkhq2nxp7rKxgq0mRVnJ9hpYCwKhqu2aSyi1Tx26SLmE0c+gqpFe
 VFxaR3n5Y8rLY5DFgOIg49eZC9xVzbtMOq+gqSymzPPs470emDa6Uf2LzM1PiTEc04B7
 kA6bqNZG44xDqz7W39wZjML7Vij77rxI68lcG46h2al0XE1RjDR7TeUcqp4RHq55Pk3y
 KGukG368tylhAnjKBL07VLgs5lAh05FRxa4wmiZOq3mF7XiPuB8wrzdIH5ao+H6Q8j/N
 ps1w==
X-Gm-Message-State: APjAAAVkLJbBP/dknDh6JbOBzfk54HkylRwXEW1+SsKAe53L1gAEkC5t
 qR5O/LFZxrdC1b2jV+QIu83NoQ==
X-Google-Smtp-Source: APXvYqzZxNhJWKcMFOb69XMFZ+gYJVPc6t9x3Wmi0iSWJBxbzJIONLRZ9/chz2LE7hW0kWTzLK4dfw==
X-Received: by 2002:a7b:cf0d:: with SMTP id l13mr25476562wmg.13.1580657669087; 
 Sun, 02 Feb 2020 07:34:29 -0800 (PST)
Received: from Jamess-MacBook.local (trinity-students-nat.trin.cam.ac.uk.
 [131.111.193.104])
 by smtp.gmail.com with ESMTPSA id b16sm22358334wrj.23.2020.02.02.07.34.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 02 Feb 2020 07:34:28 -0800 (PST)
Received: by Jamess-MacBook.local (Postfix, from userid 501)
 id B4B2320660B99A; Sun,  2 Feb 2020 15:34:27 +0000 (GMT)
From: James Clarke <jrtc27@jrtc27.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/mips: Fix ll/sc after
 7dd547e5ab6b31e7a0cfc182d3ad131dd55a948f
Date: Sun,  2 Feb 2020 15:34:09 +0000
Message-Id: <20200202153409.28534-1-jrtc27@jrtc27.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 James Clarke <jrtc27@jrtc27.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>

After 7dd547e5ab6b31e7a0cfc182d3ad131dd55a948f the env->llval value is
loaded as an unsigned value (instead of sign-extended as before).
Therefore, the CMPXCHG in gen_st_cond() in translate.c fails if the sign
bit is set in the loaded value.
Fix this by sign-extending the llval value for the 32-bit case.

I discovered this issue because FreeBSD MIPS64 was looping forever in an
atomic helper function when trying to start /sbin/init.

Signed-off-by: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>
Fixes: 7dd547e5ab6b ("target/mips: Use cpu_*_mmuidx_ra instead of MMU_MODE*_SUFFIX")
Buglink: https://bugs.launchpad.net/qemu/+bug/1861605
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Clarke <jrtc27@jrtc27.com>
---
 target/mips/op_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 15d05a5fbc..467914d1ca 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -305,7 +305,7 @@ static inline hwaddr do_translate_address(CPUMIPSState *env,
     }
 }

-#define HELPER_LD_ATOMIC(name, insn, almask)                                  \
+#define HELPER_LD_ATOMIC(name, insn, almask, do_cast)                         \
 target_ulong helper_##name(CPUMIPSState *env, target_ulong arg, int mem_idx)  \
 {                                                                             \
     if (arg & almask) {                                                       \
@@ -316,12 +316,12 @@ target_ulong helper_##name(CPUMIPSState *env, target_ulong arg, int mem_idx)  \
     }                                                                         \
     env->CP0_LLAddr = do_translate_address(env, arg, 0, GETPC());             \
     env->lladdr = arg;                                                        \
-    env->llval = cpu_##insn##_mmuidx_ra(env, arg, mem_idx, GETPC());          \
+    env->llval = do_cast cpu_##insn##_mmuidx_ra(env, arg, mem_idx, GETPC());  \
     return env->llval;                                                        \
 }
-HELPER_LD_ATOMIC(ll, ldl, 0x3)
+HELPER_LD_ATOMIC(ll, ldl, 0x3, (target_long)(int32_t))
 #ifdef TARGET_MIPS64
-HELPER_LD_ATOMIC(lld, ldq, 0x7)
+HELPER_LD_ATOMIC(lld, ldq, 0x7, (target_ulong))
 #endif
 #undef HELPER_LD_ATOMIC
 #endif
--
2.20.1


