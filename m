Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C1AC4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 16:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D052158C
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 16:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcePoqC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D052158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMZm6-0004ka-Ps
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 12:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMZiJ-0002Bf-DH
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 12:39:52 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMZiH-0005Iw-UB
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 12:39:51 -0400
Received: by mail-wm1-x341.google.com with SMTP id x23so4056062wmi.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2020 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v2AAXqYVbggYqD2O82lQGNTgT9BbKcX2OEontmBjDXk=;
 b=kcePoqC/il0PHMHBaHYw5MgQELKldh1nRgODSlIBuKx6G2WYyw3idFGnVwxnJFwG2T
 GbOmzBngiqtRUJmcn7gJJQOkT++H7HnZk2lFxcAk/TTrMLuf2Wr4p6JGTNI2n2PZLGpO
 kmd24enYnaMR/HMA8r2fWzlawbcGYYNHIbYyyuwIgjytMWEDJ6lKFZOFiSQ/qugNQJcT
 pfnyZkCdAscH8Aut237MZEG5IebugPjgh47IG4kUyIsuVcVc31Pees85r0vHpc7UqWUW
 4lRTQFVHiEN5jsUFkBmBIWHO5wQSfiYSWRG1Hqbu26R1oLE7BGlrdJbO8s0nftQfJZ93
 XyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=v2AAXqYVbggYqD2O82lQGNTgT9BbKcX2OEontmBjDXk=;
 b=PH+SqUUBbRo/oopB34Wg40iQtYonwJgJ0hFjLmKJT9QFtBS5+ZIoJbVsrt1AmQTFAo
 /iWH6O4NRT13Bk/qaG2kTSGp5uL8QGl4Lxm8ROGYquOCU6Z52j6KqmUlylKely3mgkN6
 K4HM8xnof2LV32wK30sUq+CMIfbaPCvDhy0wh/aszihHELJWoRrsq1A4veXut+GfYSKI
 boPYQd4c5BiCDtsEOfko5y+Tow9SwBhwwjU4IRL70W3AadyYXDFabCvNMNmRI8uU/TiQ
 ahO/HExSd0dNhgf6TXkglJyFHKKVxu6uDrnOw4/J8lU/2WR/FatbX6SZhdk2vx5vSc5/
 P/mw==
X-Gm-Message-State: AOAM533EojzWwPHQVF5Mhe954LtRPSfrA2MFo5bpipE1mNlk3YEZo83j
 E48CYk0uGfqZo1bzWAIFB8VMXgy9IKU=
X-Google-Smtp-Source: ABdhPJydbLG609apzb9XsDTaup4cXrqHD2NRV3RLa8xV3fimjfRKwQu71axI1dkCjKL7N9/JkmI7OQ==
X-Received: by 2002:a05:600c:2054:: with SMTP id
 p20mr7475146wmg.173.1601224788309; 
 Sun, 27 Sep 2020 09:39:48 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id m10sm5820184wmi.9.2020.09.27.09.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2020 09:39:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/mips: Simplify code using ROUND_UP(INITRD_PAGE_SIZE)
Date: Sun, 27 Sep 2020 18:39:43 +0200
Message-Id: <20200927163943.614604-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200927163943.614604-1-f4bug@amsat.org>
References: <20200927163943.614604-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.078,
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of using a INITRD_PAGE_MASK definition, use the
simpler INITRD_PAGE_SIZE one which allows us to simplify
the code by using directly the self-explicit ROUND_UP()
macro.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
index f28609976bf..ef5dbe97b7d 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -132,8 +132,7 @@ static int64_t load_kernel(CPUMIPSState *env)
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
index 4019c9dc1a8..5de5cb152eb 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1074,9 +1074,9 @@ static int64_t load_kernel(void)
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
index 3aeb1207e1a..1862eeda396 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -89,8 +89,7 @@ static int64_t load_kernel(void)
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
index 74f916a3982..24cee357f34 100644
--- a/hw/mips/r4k.c
+++ b/hw/mips/r4k.c
@@ -114,8 +114,7 @@ static int64_t load_kernel(void)
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


