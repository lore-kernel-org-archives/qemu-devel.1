Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0037DC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41BE206C2
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41BE206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAcho-0001ZH-50
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 12:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbt0-0007zR-Uw
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsz-0007G9-Gu
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbsz-0007Fe-A7
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id u72so30713pgb.10
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=MhpoxMmHxg0lKHxp/4pAOLqG726Jjd89bWqoZDT3AGo=;
 b=V5rOsXVm/VBS8wm6uI2rMIMhoqkWEGRNmT5E0HEjq2G/amz37z1vuuoJ7WNAmpAkba
 LIfGcU5U3ixtNOOcGmSmXNohvGVRUSLCUiFPsYmsn00scSFARsSHOwMLahDT/8ZM6ZLp
 8VFCD8gX1s5JZhn+zfECsaKPPaQpA9go//iN/yFzylUWMDRxLxUDI2EZCXb64SuyqhiK
 1zc8DEQGfgHKqRLnfLRMJZgDB8wvLPB0gphLHhnIcdCWHaulAh+0c/bGS2Lr+fduCW8q
 NY18hiYEaHul0qkflCxPGl9cx8Bemi4yiEWLyezOGj6t3OFpb7YcDJ/QDlf7+gNga3Oc
 /JSQ==
X-Gm-Message-State: APjAAAUelcWrkT3euAbrYEDJd5vL4z+I4ZZ7QoL+uegYkTp+9yPtdD9r
 oxO363lHV9mk+RtvHznJNK0O0vhSL8o=
X-Google-Smtp-Source: APXvYqwPQ1oQ1Qz9FhVPFZZl2I+e0I+cO0pEPLeCvedK2TKe3T3Dgg2Ck8T9+R5AhfdWSSPauB786A==
X-Received: by 2002:a63:6947:: with SMTP id e68mr4588266pgc.60.1568820531931; 
 Wed, 18 Sep 2019 08:28:51 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id 5sm4269904pgk.75.2019.09.18.08.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:28:51 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:56:40 -0700
Message-Id: <20190918145640.17349-49-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918145640.17349-1-palmer@sifive.com>
References: <20190918145640.17349-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.195
Subject: [Qemu-devel] [PULL 48/48] gdbstub: riscv: fix the fflags registers
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: KONRAD Frederic <frederic.konrad@adacore.com>

While debugging an application with GDB the following might happen:

(gdb) return
Make xxx return now? (y or n) y
Could not fetch register "fflags"; remote failure reply 'E14'

This is because riscv_gdb_get_fpu calls riscv_csrrw_debug with a wrong csr
number (8). It should use the csr_register_map in order to reach the
riscv_cpu_get_fflags callback.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/gdbstub.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 27be93279b..ded140e8d8 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -313,7 +313,8 @@ static int riscv_gdb_get_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
          * register 33, so we recalculate the map index.
          * This also works for CSR_FRM and CSR_FCSR.
          */
-        result = riscv_csrrw_debug(env, n - 33 +  8, &val, 0, 0);
+        result = riscv_csrrw_debug(env, n - 33 + csr_register_map[8], &val,
+                                   0, 0);
         if (result == 0) {
             return gdb_get_regl(mem_buf, val);
         }
@@ -335,7 +336,8 @@ static int riscv_gdb_set_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
          * register 33, so we recalculate the map index.
          * This also works for CSR_FRM and CSR_FCSR.
          */
-        result = riscv_csrrw_debug(env, n - 33 + 8, NULL, val, -1);
+        result = riscv_csrrw_debug(env, n - 33 + csr_register_map[8], NULL,
+                                   val, -1);
         if (result == 0) {
             return sizeof(target_ulong);
         }
-- 
2.21.0


