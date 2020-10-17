Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB31C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:30:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC7A20756
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dj1g7CUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC7A20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTnE4-00049S-FR
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmpx-0004TE-0q
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:05:33 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmpv-00040a-6e
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:05:32 -0400
Received: by mail-wm1-x342.google.com with SMTP id f21so6140835wml.3
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Bt4oVFiiKF8ndprKkDoZPz+ozlge1hSxtT3OwSh/bHU=;
 b=dj1g7CUaMqX1C9a9Dv6DxW9I6/lfX6YWm4e1j8eV0sM4WoSB7umnyUa8ZFJkGx+UI0
 ZR6XFCJGOBAOQXHpkc7zg5F0Rlzu6gLXnQgGihXHW8YOF3Ey3xtme6dmfjm3xaGN4A3F
 xNODDjq/5FjX71Z2/Zl9MY2UF2Ae8EuN9Pg74bhiMp+NtErQ8y8Yl5KoEmcKR6f/Egxt
 jZ53ej5Ib9EPTEmB5ZWjtncMEIgKhh+F6gu9i3dTrK7COyJayZNSvlWgyplVfTOT4uqB
 6W6qzSdK9tou4X0l/MpdTlnS6CWI5G+4c18uWc38294G1Z/dU/lomMXUkRlDnBnBbioL
 RLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Bt4oVFiiKF8ndprKkDoZPz+ozlge1hSxtT3OwSh/bHU=;
 b=G8O/GZyHq5UQuZ3NIHzdFUS0ciEAIL6DkRVK/IcuHfiFDwEgbbf4wWI0VWHsvS4Tme
 kGpOKhahZI2R9zPHQlk8KbCrp9bGAbN66/xvQFrqQAmNyX939enQt4rFPuFZyiVHqnaf
 J+khwXgbSWcq2dEbR1VubGAc8W6ulfugAUiDUTT2V69KAR4K39kXnVimMi3sgBPkObQB
 KoRdFffYsOnSW0/m/Qjsk2arYDdmFEUnSo5eukREOG/nYLbGnsv62BdhlHIFI5QCqZom
 7E22/50MmdmToTF1fjcEIF/louqNlZT/ByURjAcRAjk25ONtUwiVhVWUPUJXsKEXKwax
 BXhQ==
X-Gm-Message-State: AOAM532JnqoQEnaK6AoE9s2SPN0hxs+nNY8VpqIAMaY4x4E8UE1TWhvs
 R2Ai4UWk42bkIm9oCQ/DUZ4s1DR66lg=
X-Google-Smtp-Source: ABdhPJw+zfUVnonjZrl9qJe5J05dKOVnePJdxGV9kyOZYKmqTxzOeg9qFj7gFA3cPHB7VEQMN1wasQ==
X-Received: by 2002:a1c:4006:: with SMTP id n6mr8459943wma.46.1602943529605;
 Sat, 17 Oct 2020 07:05:29 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id c18sm8821587wrt.10.2020.10.17.07.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:05:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/44] hw/mips: Simplify code using ROUND_UP(INITRD_PAGE_SIZE)
Date: Sat, 17 Oct 2020 16:02:34 +0200
Message-Id: <20201017140243.1078718-36-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of using a INITRD_PAGE_MASK definition, use the
simpler INITRD_PAGE_SIZE one which allows us to simplify
the code by using directly the self-explicit ROUND_UP()
macro.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200927163943.614604-3-f4bug@amsat.org>
---
 include/hw/mips/mips.h | 4 +++-
 hw/mips/fuloong2e.c    | 3 +--
 hw/mips/malta.c        | 6 +++---
 hw/mips/mipssim.c      | 3 +--
 hw/mips/r4k.c          | 3 +--
 5 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/hw/mips/mips.h b/include/hw/mips/mips.h
index 0af4c3d5d74..6c9c8805f3f 100644
--- a/include/hw/mips/mips.h
+++ b/include/hw/mips/mips.h
@@ -2,8 +2,10 @@
 #define HW_MIPS_H
 /* Definitions for mips board emulation.  */
 
+#include "qemu/units.h"
+
 /* Kernels can be configured with 64KB pages */
-#define INITRD_PAGE_MASK (~((1 << 16) - 1))
+#define INITRD_PAGE_SIZE (64 * KiB)
 
 #include "exec/memory.h"
 
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index b8234f61083..de66215f95f 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -133,8 +133,7 @@ static int64_t load_kernel(CPUMIPSState *env)
     if (loaderparams.initrd_filename) {
         initrd_size = get_image_size(loaderparams.initrd_filename);
         if (initrd_size > 0) {
-            initrd_offset = (kernel_high + ~INITRD_PAGE_MASK) &
-                            INITRD_PAGE_MASK;
+            initrd_offset = ROUND_UP(kernel_high, INITRD_PAGE_SIZE);
             if (initrd_offset + initrd_size > ram_size) {
                 error_report("memory too small for initial ram disk '%s'",
                              loaderparams.initrd_filename);
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index ff3225bb8e3..beb0f43941a 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1077,9 +1077,9 @@ static int64_t load_kernel(void)
              * the initrd.  It takes at most 128kiB for 2GB RAM and 4kiB
              * pages.
              */
-            initrd_offset = (loaderparams.ram_low_size - initrd_size
-                             - (128 * KiB)
-                             - ~INITRD_PAGE_MASK) & INITRD_PAGE_MASK;
+            initrd_offset = ROUND_UP(loaderparams.ram_low_size
+                                     - (initrd_size + 128 * KiB),
+                                     INITRD_PAGE_SIZE);
             if (kernel_high >= initrd_offset) {
                 error_report("memory too small for initial ram disk '%s'",
                              loaderparams.initrd_filename);
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index afef4f2e77a..97dcc232476 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -90,8 +90,7 @@ static int64_t load_kernel(void)
     if (loaderparams.initrd_filename) {
         initrd_size = get_image_size(loaderparams.initrd_filename);
         if (initrd_size > 0) {
-            initrd_offset = (kernel_high + ~INITRD_PAGE_MASK) &
-                            INITRD_PAGE_MASK;
+            initrd_offset = ROUND_UP(kernel_high, INITRD_PAGE_SIZE);
             if (initrd_offset + initrd_size > loaderparams.ram_size) {
                 error_report("memory too small for initial ram disk '%s'",
                              loaderparams.initrd_filename);
diff --git a/hw/mips/r4k.c b/hw/mips/r4k.c
index 7ee37c49689..38308543421 100644
--- a/hw/mips/r4k.c
+++ b/hw/mips/r4k.c
@@ -115,8 +115,7 @@ static int64_t load_kernel(void)
     if (loaderparams.initrd_filename) {
         initrd_size = get_image_size(loaderparams.initrd_filename);
         if (initrd_size > 0) {
-            initrd_offset = (kernel_high + ~INITRD_PAGE_MASK) &
-                             INITRD_PAGE_MASK;
+            initrd_offset = ROUND_UP(kernel_high, INITRD_PAGE_SIZE);
             if (initrd_offset + initrd_size > ram_size) {
                 error_report("memory too small for initial ram disk '%s'",
                              loaderparams.initrd_filename);
-- 
2.26.2


