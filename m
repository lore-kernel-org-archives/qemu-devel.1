Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240EDC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:14:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63B720684
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V9VwJ97J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63B720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEH9t-0001LU-Nt
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 15:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH5C-00024n-ND
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:09:10 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46410)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH59-0000qw-MI
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:09:10 -0400
Received: by mail-pf1-x442.google.com with SMTP id b124so5094672pfg.13
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 12:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9EdNBb10Sfbn2mMJNyHJYDo3G9R+Hpt4lWBI6fpuCLk=;
 b=V9VwJ97J4nBlWCrQ8o8wBXH7LRag9Rx4uMA5RVFH/wICTvqSf/pM2rQaDH7EA2171W
 Tsctjkgz+a+bcTlntznbMp+KhVTUUDhJncd2XbccfhI4FglQcO9a8Cd+mewcqcWSAXEt
 OyeCqckF4C1MnSWHSLL12SG90WqLD74Ft+ABfULDvANBC46rVnhAoA4Q3AgBZRhc/ehG
 /ssI3jGvqyrw3izkvCjV1GSsSA7iF6NZUg4qRMFvHgsVW4jjikwm80J6xFaBCiQ5DISZ
 W7TWLn8rNwGGgl7MeMctssEwEzyKNTpaTcM5HmECxRvnPhu/DY1t7YxRn4UpEla42JBz
 Y7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9EdNBb10Sfbn2mMJNyHJYDo3G9R+Hpt4lWBI6fpuCLk=;
 b=gMu3qAWs0Xhts02NSBZJ02TE0jWfzE03rCaJHVt4+LyDiR0wihbhqstUzDr+u99m0m
 sBRPS+bFbK5dMIwQK0zjG7Z8ZEccYJGP6t8qASZvwgkY4z+asfz36+KWKFL5Z/gl7iax
 rnhTyBjXArYPMePVOsOpSOxP8gijxYezRD0HfHGQsgBini75Q6KKQppdKz14YqzOEyE+
 1yVJ7tnaXZvmIRY6tZ4p0InXTvhZVylvK/C/+S3APozcA9aj57sLlkSfolwcXDWUJZnH
 PLsYWQwV0W/xGI5Pk3a6k8YrRGPWQxAkfaHRPgoKNzIFMebkMfxie4RMvdmpasXhA7Su
 8+5A==
X-Gm-Message-State: AOAM533DH7LmZ/XIHKChvDX5Jij02CQ6EUmirNdf3Z1HneBpbzP4GiPg
 cWK2oOmAkBVTM5WDf/WF64gz7kzP8UpcqQ==
X-Google-Smtp-Source: ABdhPJwNm1Dvu7iCKCvZ9GE/ZB9G0Uy+XR32+42tVd6W5l14RZ2fahcn+tz/QRp1OjZm5d6dUDrR3g==
X-Received: by 2002:aa7:80d3:0:b029:13c:1611:66ba with SMTP id
 a19-20020aa780d30000b029013c161166bamr8289174pfn.5.1599246545894; 
 Fri, 04 Sep 2020 12:09:05 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x19sm1897941pge.22.2020.09.04.12.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 12:09:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 15/19] target/microblaze: Treat pvr_regs as constant
Date: Fri,  4 Sep 2020 12:08:38 -0700
Message-Id: <20200904190842.2282109-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904190842.2282109-1-richard.henderson@linaro.org>
References: <20200904190842.2282109-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: edgar.iglesias@xilinx.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not allow gdb to set the values, and don't bother dumping
unchanging values with -d cpu.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/gdbstub.c   | 4 ----
 target/microblaze/translate.c | 5 -----
 2 files changed, 9 deletions(-)

diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index 9e3b9ac824..be39fd4540 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -132,10 +132,6 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     case GDB_BTR:
         env->btr = tmp;
         break;
-    case GDB_PVR0 ... GDB_PVR11:
-        /* PVR12 is intentionally skipped */
-        cpu->cfg.pvr_regs[n - GDB_PVR0] = tmp;
-        break;
     case GDB_EDR:
         env->edr = tmp;
         break;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 9e4551d99b..eca422b3db 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1919,11 +1919,6 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                  env->esr, env->fsr, env->btr, env->edr,
                  env->ear, env->slr, env->shr);
 
-    for (i = 0; i < 12; i++) {
-        qemu_fprintf(f, "rpvr%-2d=%08x%c",
-                     i, env->pvr.regs[i], i % 4 == 3 ? '\n' : ' ');
-    }
-
     for (i = 0; i < 32; i++) {
         qemu_fprintf(f, "r%2.2d=%08x%c",
                      i, env->regs[i], i % 4 == 3 ? '\n' : ' ');
-- 
2.25.1


