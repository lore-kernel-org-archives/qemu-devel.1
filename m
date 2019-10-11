Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42687C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 23:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078522089F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 23:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=berkeley-edu.20150623.gappssmtp.com header.i=@berkeley-edu.20150623.gappssmtp.com header.b="kp4iHyo3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078522089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=berkeley.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ4Ai-0001YJ-2C
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 19:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dayeol@berkeley.edu>) id 1iJ47H-0000eL-3D
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 19:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dayeol@berkeley.edu>) id 1iJ47F-0001Jd-Dl
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 19:14:34 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:44330)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dayeol@berkeley.edu>) id 1iJ47F-0001JJ-4B
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 19:14:33 -0400
Received: by mail-qt1-x843.google.com with SMTP id u40so16174428qth.11
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 16:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=berkeley-edu.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UtUDd5e/TA51h4IZxO1cpupAltRdyzMyfziFMZdbB/U=;
 b=kp4iHyo3TaywfyDOiK+F/61RdOqMWz28RUJq+PdXiO1NrDfhTErkDbHUfv7T7DBUog
 56eoIOFMtMQ6sDZgwzHDUNIpjbxQ5xVJyhP8G16BbbB1wricN8KJ7I9L6JeGEir3zccP
 lqyDfyRrhToeGaGp6m6ZBOMwUpWkObz+YDVnToCoiv/mcUDA/dqzB/WnYrVnF9NVh953
 VkAB89aNLnurH8364HssS2pz/5hMudAUTEu8Vxr+En7IJuANWCZlKXSIxZ2BV42s69Y3
 Z7yfEt/SN7b/9V6aGOEnsYwUm56op4HYcQLiuOVlf49s56itglAUta6V5JoOA6L/FVbf
 G+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UtUDd5e/TA51h4IZxO1cpupAltRdyzMyfziFMZdbB/U=;
 b=W9D6z5ryMHR9iemkuqK/HMON1vaUy+dVbjaMo3r7W8Y1+aef8JtE03yBhU5IvOUskO
 5rdh0hvgc2evkn0qZzk8CPFBMxY+yamz5094oI2/5KZSRHtW55uXKG42dzy3OUzpRgp1
 hStXAVg798ujSOFn6KcECZ/2rPug/q0VFdJUkNWWn1IIf9Z3ni2AAJixJ/x3g4llsgP7
 1V0vAaSXN42G02PpS65V0fXSqWssq9b2VRIQBFPnnJ5x7USRap0TWZz3B3ngK27cfrCW
 7vs7gu4nrO6oI8HRMNm5+9gXcHU4jlziKzrk0ZmsczEjO+jhB6AJGzPWsKoZQGox/F3k
 f41g==
X-Gm-Message-State: APjAAAU1t8XnMbVqvaGD4eiTT3h84Sw+QmrtxCKqJIMwhlY1mFLouy0y
 X1akm7LBDhtHG5c/XvQxDghKKLgoqi+LUQ==
X-Google-Smtp-Source: APXvYqzRNlsgXmhqdup3Wb2rVu1disrPOOGbhEAj28ZsHBVFKB0kQ+GIZwMy/rvDVtwhuBL4a4QGxw==
X-Received: by 2002:ac8:550d:: with SMTP id j13mr19683509qtq.37.1570835671728; 
 Fri, 11 Oct 2019 16:14:31 -0700 (PDT)
Received: from ip-172-31-33-50.ec2.internal
 (ec2-34-206-44-154.compute-1.amazonaws.com. [34.206.44.154])
 by smtp.gmail.com with ESMTPSA id 194sm4305953qkm.62.2019.10.11.16.14.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 11 Oct 2019 16:14:30 -0700 (PDT)
From: Dayeol Lee <dayeol@berkeley.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/riscv: PMP violation due to wrong size parameter
Date: Fri, 11 Oct 2019 23:14:06 +0000
Message-Id: <20191011231406.9808-1-dayeol@berkeley.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Dayeol Lee <dayeol@berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, diodesign@tuta.io
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

riscv_cpu_tlb_fill() uses the `size` parameter to check PMP violation
using pmp_hart_has_privs().
However, if the size is unknown (=0), the ending address will be
`addr - 1` as it is `addr + size - 1` in `pmp_hart_has_privs()`.
This always causes a false PMP violation on the starting address of the
range, as `addr - 1` is not in the range.

In order to fix, we just assume that all bytes from addr to the end of
the page will be accessed if the size is unknown.

Signed-off-by: Dayeol Lee <dayeol@berkeley.edu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu_helper.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e32b6126af..7d9a22b601 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -441,6 +441,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     CPURISCVState *env = &cpu->env;
     hwaddr pa = 0;
     int prot;
+    int pmp_size = 0;
     bool pmp_violation = false;
     int ret = TRANSLATE_FAIL;
     int mode = mmu_idx;
@@ -460,9 +461,19 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                   "%s address=%" VADDR_PRIx " ret %d physical " TARGET_FMT_plx
                   " prot %d\n", __func__, address, ret, pa, prot);
 
+    /*
+     * if size is unknown (0), assume that all bytes
+     * from addr to the end of the page will be accessed.
+     */
+    if (size == 0) {
+        pmp_size = -(address | TARGET_PAGE_MASK);
+    } else {
+        pmp_size = size;
+    }
+
     if (riscv_feature(env, RISCV_FEATURE_PMP) &&
         (ret == TRANSLATE_SUCCESS) &&
-        !pmp_hart_has_privs(env, pa, size, 1 << access_type, mode)) {
+        !pmp_hart_has_privs(env, pa, pmp_size, 1 << access_type, mode)) {
         ret = TRANSLATE_PMP_FAIL;
     }
     if (ret == TRANSLATE_PMP_FAIL) {
-- 
2.20.1


