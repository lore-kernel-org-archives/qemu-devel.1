Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B35C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:01:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D651D2133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OT1zxDqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D651D2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3iq-0001EH-LH
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qN-0004a1-KD
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qM-0007oS-Dl
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:11 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35144)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qM-0007my-71
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:10 -0400
Received: by mail-wr1-x442.google.com with SMTP id v8so20392627wrt.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8G3roByUGItcwQtca2zwULbmKM2iR6HUV7McNJf7Obk=;
 b=OT1zxDqDPBU3AN+lfEC4VQEcIGPKj/tQ1YKOHwRRb/L4Cp4OVWhGsNSgBzRKx+84ak
 pJaDWBGcu0O0ZQAWOM2ETAM666TRmU728lsb9a5kI6BDltZ1uiKQ6/5UFxVu/oLZi6Lx
 duVv56bB3ixEK1J01zH8lCA5u3eoamPUmv+cht3AQIwuYNwEVJwq8kGP2YkEHUfIPIM0
 LVxRT43nLn8Y2t4E4Jj9a/eDuq/b5ugZQDcIQ24WWCzx0/yuSm4zcEIt093QeyIh++8/
 lTf3jCiFeV+tV47DeHtyTY2HPe9c5Mzm1JkJ4gt4x11syMszZmswb+JaNFlemeFmEdGO
 qXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8G3roByUGItcwQtca2zwULbmKM2iR6HUV7McNJf7Obk=;
 b=KbncdyGIVaGfTlctKh92EKVM1qjwjt2/y8v7USrEGYjZ1N79WC+Y7eYGgD6uKyivmB
 2VkUrhCX4kJYy6tlrVFFDdEqn+mpoj4lwEakp80wxciQicc9yP78US60AgOD3jqhxCZt
 iw5L4HoHCa1bvl9Dd21lqf7RvPnm6OaKCqsEK0x5uip7Z1h5LbyoMdgDkZALFibVhUjB
 3f5R6nWDEoorMgTqXtOxoDmUPUTmqRuNHQNiI8+hXc9V1uoJ9UO0rgr5ZsP7JEOyiRYA
 MPhmVXBcmEIfAjRvj38wX4O9VKYtcTFdc8ZAElDx3Iz+chdoHRuC3j5f62V4LM7HcoI3
 zVXw==
X-Gm-Message-State: APjAAAV4fjdoDY8HWhiax/ry6SDwHA1F4aqqHBSIRSDKt7qV3nuVWMse
 QIKRVW9oel4mXK2ZTK+1YRnplWlCrl9vpw==
X-Google-Smtp-Source: APXvYqykYaNVgC3tL1Axx5tgXNN+j6Ewxw+l3pzObIBMQzFx5qhhqiE9Q1Ds//mwHosdDn6KbYBzSw==
X-Received: by 2002:adf:de85:: with SMTP id w5mr25896216wrl.278.1571069108940; 
 Mon, 14 Oct 2019 09:05:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/68] target/arm/arm-semi: Factor out implementation of
 SYS_FLEN
Date: Mon, 14 Oct 2019 17:03:32 +0100
Message-Id: <20191014160404.19553-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

Factor out the implementation of SYS_FLEN via the new
function tables.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190916141544.17540-13-peter.maydell@linaro.org
---
 target/arm/arm-semi.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index b5e1d73eb80..87c911f0187 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -391,6 +391,7 @@ typedef uint32_t sys_readfn(ARMCPU *cpu, GuestFD *gf,
 typedef uint32_t sys_isattyfn(ARMCPU *cpu, GuestFD *gf);
 typedef uint32_t sys_seekfn(ARMCPU *cpu, GuestFD *gf,
                             target_ulong offset);
+typedef uint32_t sys_flenfn(ARMCPU *cpu, GuestFD *gf);
 
 static uint32_t host_closefn(ARMCPU *cpu, GuestFD *gf)
 {
@@ -454,6 +455,17 @@ static uint32_t host_seekfn(ARMCPU *cpu, GuestFD *gf, target_ulong offset)
     return 0;
 }
 
+static uint32_t host_flenfn(ARMCPU *cpu, GuestFD *gf)
+{
+    CPUARMState *env = &cpu->env;
+    struct stat buf;
+    uint32_t ret = set_swi_errno(env, fstat(gf->hostfd, &buf));
+    if (ret == (uint32_t)-1) {
+        return -1;
+    }
+    return buf.st_size;
+}
+
 static uint32_t gdb_closefn(ARMCPU *cpu, GuestFD *gf)
 {
     return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
@@ -486,12 +498,19 @@ static uint32_t gdb_seekfn(ARMCPU *cpu, GuestFD *gf, target_ulong offset)
                            gf->hostfd, offset);
 }
 
+static uint32_t gdb_flenfn(ARMCPU *cpu, GuestFD *gf)
+{
+    return arm_gdb_syscall(cpu, arm_semi_flen_cb, "fstat,%x,%x",
+                           gf->hostfd, arm_flen_buf(cpu));
+}
+
 typedef struct GuestFDFunctions {
     sys_closefn *closefn;
     sys_writefn *writefn;
     sys_readfn *readfn;
     sys_isattyfn *isattyfn;
     sys_seekfn *seekfn;
+    sys_flenfn *flenfn;
 } GuestFDFunctions;
 
 static const GuestFDFunctions guestfd_fns[] = {
@@ -501,6 +520,7 @@ static const GuestFDFunctions guestfd_fns[] = {
         .readfn = host_readfn,
         .isattyfn = host_isattyfn,
         .seekfn = host_seekfn,
+        .flenfn = host_flenfn,
     },
     [GuestFDGDB] = {
         .closefn = gdb_closefn,
@@ -508,6 +528,7 @@ static const GuestFDFunctions guestfd_fns[] = {
         .readfn = gdb_readfn,
         .isattyfn = gdb_isattyfn,
         .seekfn = gdb_seekfn,
+        .flenfn = gdb_flenfn,
     },
 };
 
@@ -687,16 +708,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return set_swi_errno(env, -1);
         }
 
-        if (use_gdb_syscalls()) {
-            return arm_gdb_syscall(cpu, arm_semi_flen_cb, "fstat,%x,%x",
-                                   gf->hostfd, arm_flen_buf(cpu));
-        } else {
-            struct stat buf;
-            ret = set_swi_errno(env, fstat(gf->hostfd, &buf));
-            if (ret == (uint32_t)-1)
-                return -1;
-            return buf.st_size;
-        }
+        return guestfd_fns[gf->type].flenfn(cpu, gf);
     case TARGET_SYS_TMPNAM:
         qemu_log_mask(LOG_UNIMP, "%s: SYS_TMPNAM not implemented", __func__);
         return -1;
-- 
2.20.1


