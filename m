Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5972DC4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 05:31:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA8520867
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 05:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=berkeley-edu.20150623.gappssmtp.com header.i=@berkeley-edu.20150623.gappssmtp.com header.b="yUzZV1ZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA8520867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=berkeley.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHLcV-0006Zx-4R
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 01:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dayeol@berkeley.edu>) id 1iHLZK-0004TB-P6
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 01:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dayeol@berkeley.edu>) id 1iHLZI-0001DZ-9p
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 01:28:26 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:43410)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dayeol@berkeley.edu>) id 1iHLZI-00018c-0f
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 01:28:24 -0400
Received: by mail-qt1-x844.google.com with SMTP id c4so4815467qtn.10
 for <qemu-devel@nongnu.org>; Sun, 06 Oct 2019 22:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=berkeley-edu.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Rr3IprOX7AO10O0bgWlRAZKUNbbkrLFaHkwJpmsGJ1g=;
 b=yUzZV1ZZonu0IV2QjRwfg62rBkuA5fykVYUIG5pgA1My17z4dvaXCC6ZEKuKX6+0SJ
 lFzKoT9PIOITxYuTSSSU6bORNIioAk8cgR2U85p6IGo3YQXAaCwCR94bD8u253XAu5Xb
 nTW7oR/rHWwwGSK1mPB8sDhjR3AH8g/eqg4QRvKnVc6Y5jvWQ23jPjqLn6akHZSFvuA2
 +UH3UTKBvOZWMC5XFrCizjJMQ2CK1kItRiMIwmDTpI4XCGNEyse58Ut6wM6AtV8XxhnP
 NuM3qYbUECEVC3TMmpeGqnYwOortKmoAXnHQyQv0ie7ju43N20Jmik9puYHTe75ehNdn
 0F3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Rr3IprOX7AO10O0bgWlRAZKUNbbkrLFaHkwJpmsGJ1g=;
 b=hqccjC6X6v8r4tfReoFiGL+sFk/ZT9TODHmSTI0MjpZxm0NXNU7sKX4lCapKEDnkfF
 hGMMEpbWPZQ+b72rcaPoKKez32PLfO4nCrIcN98TDweJUBanTd9enfIPhM0sQay6U3Rb
 d6Nf5NksMUQXSln+Ylhd0ErEgvEkSPU3wKsDMmfZl2AlCqO9FVd3qJUVIdvebqaUb0gs
 7MdYN3BpB3MCX0hrFmU6whGaRkgkcnwAUG/C4fBumd+vBSw2qdPjElna110YGS6EYrhQ
 dsZBdnKl4pIojugxWXjWlWsUtgGvOb7gyehoSKhAOGc7BBB4dQscOMpfQKCtUwAE6bKh
 yHGw==
X-Gm-Message-State: APjAAAVdNFiTMi8msQALTJsmGAZfLf40KGpM/vBmJK5o03RtV41PPoEB
 oL50yD3IwCbk6i4qgIVAco526SeDrzA=
X-Google-Smtp-Source: APXvYqz7oompv1PkWuor1GOd0uwy3WSIQk59nDPqLP94kJKcHzyyKBOKp6d9IAfYtcJnf61rEHh1Ng==
X-Received: by 2002:ac8:f1c:: with SMTP id e28mr27645328qtk.161.1570426101169; 
 Sun, 06 Oct 2019 22:28:21 -0700 (PDT)
Received: from ip-172-31-33-50.ec2.internal
 (ec2-34-206-44-154.compute-1.amazonaws.com. [34.206.44.154])
 by smtp.gmail.com with ESMTPSA id p7sm7188080qkc.21.2019.10.06.22.28.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 06 Oct 2019 22:28:20 -0700 (PDT)
From: Dayeol Lee <dayeol@berkeley.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/riscv: PMP violation due to wrong size parameter
Date: Mon,  7 Oct 2019 05:28:13 +0000
Message-Id: <20191007052813.25814-1-dayeol@berkeley.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

riscv_cpu_tlb_fill() uses the `size` parameter to check PMP violation
using pmp_hart_has_privs().
However, the size passed from tlb_fill(), which is called by
get_page_addr_code(), is always a hard-coded value 0.
This causes a false PMP violation if the instruction presents on a
PMP boundary.

In order to fix, simply correct the size to 4 if the access_type is
MMU_INST_FETCH.

Signed-off-by: Dayeol Lee <dayeol@berkeley.edu>
---
 target/riscv/cpu.h        | 1 +
 target/riscv/cpu_helper.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0adb307f32..386c80e764 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -88,6 +88,7 @@ enum {
 #define MMU_USER_IDX 3
 
 #define MAX_RISCV_PMPS (16)
+#define RISCV_INSN_LENGTH 4
 
 typedef struct CPURISCVState CPURISCVState;
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e32b6126af..877e89dbf2 100644
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
@@ -460,9 +461,15 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                   "%s address=%" VADDR_PRIx " ret %d physical " TARGET_FMT_plx
                   " prot %d\n", __func__, address, ret, pa, prot);
 
+    if (access_type == MMU_INST_FETCH) {
+      pmp_size = RISCV_INSN_LENGTH;
+    } else {
+      pmp_size = size;
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


