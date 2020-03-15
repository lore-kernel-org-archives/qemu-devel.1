Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0C4C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A36420637
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAV47tzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A36420637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDTfX-0007Bc-Ny
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 09:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTda-00069o-7W
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:49:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTdZ-0000IO-0b
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:49:06 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39759)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTdY-0000CK-QC; Sun, 15 Mar 2020 09:49:04 -0400
Received: by mail-wm1-x344.google.com with SMTP id f7so15126492wml.4;
 Sun, 15 Mar 2020 06:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=r2HeUlgZPGznn3qDRP6dKLB5LdEIIfNvBnBheGi+K3c=;
 b=fAV47tzkDfTrTn8i6wXvasDjUhX62cHIl2Ge6SIhny/HsP+ohpVKzgUi4jnOdSx9UT
 xTfUj1AAj5ApdBAEAlr5FVH00j5z25s/hYdfGpSuJMOjBroAll9dMGiltKqOpw7yC7aC
 eqIWxMLWSKW/hdtckGVJBaNTp92OxJPRtZo6OyyWKqvvKGEI0DB+53iWousFdVIrcYk7
 FOAg31FK7d2nkcybOxFa+vYbn6g3l6ySAWzwi54iTO819sdrp/+TmTwUT/QI/0h7zfmh
 POxMQBbtZw6ZnlTM54aKMI4car3gRa1fYQHV99T3w2cX1VJzGRu+ARm2AriIj369tsgf
 Ruow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=r2HeUlgZPGznn3qDRP6dKLB5LdEIIfNvBnBheGi+K3c=;
 b=aeIlXDr+ut9Ny9LJ3Rsp2pB4rx6JMM45DIDBFX1Fnph8gB4QNV+yKC4Xsk8ZZ42YXL
 HO6A7cKYi57PC7r/rQARo+HlFpA3Tlyeuyt3Kvybk/o+EuA562uxlPpvI7UCiU/py3eT
 7uv0mRGRgiltnu2nhkWZ5TTcegn4Zclj84VA+ZbPnvwGcT+LUAIyaV/XRl0YZLahzopO
 yYnSwjzem8quxDCVwIr6bUlapzkfwkGY9Y4kPp55bw0oUs6ce9YryBFiClvX/pIKnvbx
 8niWb/b794aKQ+fYxN9yvs+YnF5BE9X799tSzyu8vXbDHPdDYPE3XkC+TBqiS7w3WxJd
 PAFw==
X-Gm-Message-State: ANhLgQ0+RioD7Igzd6wMrIWjzHbs5wx1Q8qRXQXQlbRSHQHawE4B8/YN
 KdWenQa4Mc/FpWogdSmm0ybpz7Dz
X-Google-Smtp-Source: ADFU+vsRvWboPVFkW7c7iwn4qG220KPPK8VTnUzdU2yOZ4lvi1Q6N04hnAWaqBZBosO24n6B+UYrQg==
X-Received: by 2002:a1c:9815:: with SMTP id a21mr22086396wme.11.1584280142934; 
 Sun, 15 Mar 2020 06:49:02 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id c13sm29234085wro.96.2020.03.15.06.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 06:49:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/rx/cpu: Use address_space_ldl() to read reset vector
 address
Date: Sun, 15 Mar 2020 14:48:59 +0100
Message-Id: <20200315134859.9547-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-block@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Stephanos Ioannidis <root@stephanos.io>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The RX code flash is not a Masked ROM but a EEPROM (electrically
erasable programmable flash memory).
When implementing the flash hardware, the rom_ptr() returns NULL
and the reset vector is not set.
Instead, use the address_space ld/st API to fetch the reset vector
address from the code flash.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Based-on: <20200315132810.7022-1-f4bug@amsat.org>

Same issue might occurs in Cortex-M arm_cpu_reset()
---
 target/rx/cpu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 9c224a273c..d3bd09e753 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -26,6 +26,8 @@
 #include "hw/loader.h"
 #include "fpu/softfloat.h"
 
+#define CPU_RESET_VECTOR 0xfffffffc
+
 static void rx_cpu_set_pc(CPUState *cs, vaddr value)
 {
     RXCPU *cpu = RXCPU(cs);
@@ -51,17 +53,13 @@ static void rx_cpu_reset(CPUState *s)
     RXCPU *cpu = RXCPU(s);
     RXCPUClass *rcc = RXCPU_GET_CLASS(cpu);
     CPURXState *env = &cpu->env;
-    uint32_t *resetvec;
 
     rcc->parent_reset(s);
 
     memset(env, 0, offsetof(CPURXState, end_reset_fields));
 
-    resetvec = rom_ptr(0xfffffffc, 4);
-    if (resetvec) {
-        /* In the case of kernel, it is ignored because it is not set. */
-        env->pc = ldl_p(resetvec);
-    }
+    env->pc = address_space_ldl(cpu_get_address_space(s, 0),
+                                CPU_RESET_VECTOR, MEMTXATTRS_UNSPECIFIED, NULL);
     rx_cpu_unpack_psw(env, 0, 1);
     env->regs[0] = env->isp = env->usp = 0;
     env->fpsw = 0;
-- 
2.21.1


