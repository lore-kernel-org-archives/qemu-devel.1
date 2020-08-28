Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ED2C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 11:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C43020872
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 11:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ds+A/DpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C43020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBcl2-00025E-RQ
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 07:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBcjL-0000Pq-Fq; Fri, 28 Aug 2020 07:39:39 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:32912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBcjI-0004Q7-VG; Fri, 28 Aug 2020 07:39:39 -0400
Received: by mail-lj1-x243.google.com with SMTP id r13so955860ljm.0;
 Fri, 28 Aug 2020 04:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kL3W06mXnWndmR6GJLLJiTkowuaDiYxG06aqX/GvAOo=;
 b=Ds+A/DpWxMr4QUhDXo6LhmvMvEFdmuMAVsOegcyAl16/FNjVRDcwyC+T4e8xBL66/J
 tF7mCS9DU6sJJu+u/5N9I7k8fOtlNnzZTsYqRWk5+uR6k9eQT78QVj3R+3ETVC7Cpekz
 rM3LhuJEw9JYnXustqQIPFsUE4Nli07/MGVKNnkVS7aL8YyB+iDKTAfFiy5H5o/+jsMo
 PpHoRlpc6O8SkWn/fPi+OVZ63elVe+NwUnGf1Jr66K/eStLmBSwibDyLymofNVsOK8pG
 xA3/7npmEMkwKobOSLWAxZyGYExkBrxcoyns6jGbDdNU2yTejW+PAd0V76xPYiIZBkH5
 U68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kL3W06mXnWndmR6GJLLJiTkowuaDiYxG06aqX/GvAOo=;
 b=mmGP2RKN7Y6bxyXEQtISoVC5ShhgmpYiA3zYlITTgrMKAQ30XN1Bp+yFkUxS9zbjxJ
 p/dhFxrELeocrufNCXMMVkP3FmXXVWI5XHsvD4W2/Ra7cfrA/oxLGmxPcssTQ5199PJy
 Kbz8Nq8JMMsj4xvzhC24zRzlYiUM0UpnWsDfhvtkAWTIyG3yR0D4BQO9IPxgz+hRPY8e
 jR8GfIvaGBlb5x975ZsKvkIGChNfcr8GIdWa/kxwTjps+VWkyVA1L6Bhw5trtPHVaIH8
 WU7gPEwwOZlKVNucb4IJQx0sRiSXE280S3A8IxG0L2qfFlkSFK2egQxb39GH8Ogg2lyR
 P52A==
X-Gm-Message-State: AOAM532/MoscsaBkgXc2BZEjJLcnck7VIE8N0Ke+YH+oafCTK6RDnRnS
 C8P9mSA+fgMNT8JdmTNgBUoixT33/oA=
X-Google-Smtp-Source: ABdhPJy3M8urRwgid9mYK2ZdjxdftHs4YuzfyFQZePU305mFcgba2qjOqqfL6LTz8Ay11OIwXGBHjQ==
X-Received: by 2002:a2e:9b8e:: with SMTP id z14mr687999lji.47.1598614774836;
 Fri, 28 Aug 2020 04:39:34 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id a3sm155223ljm.7.2020.08.28.04.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 04:39:34 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/2] target/microblaze: Improve transaction failure handling
Date: Fri, 28 Aug 2020 13:39:31 +0200
Message-Id: <20200828113931.3252489-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828113931.3252489-1-edgar.iglesias@gmail.com>
References: <20200828113931.3252489-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.425, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

When the CPU has exceptions disabled, avoid unwinding CPU
state and clobbering registers if we're not going to raise
any exception.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/op_helper.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 13ac476199..190cd96c6a 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -483,22 +483,17 @@ void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
     cpu = MICROBLAZE_CPU(cs);
     env = &cpu->env;
 
-    cpu_restore_state(cs, retaddr, true);
     if (!(env->sregs[SR_MSR] & MSR_EE)) {
         return;
     }
 
-    env->sregs[SR_EAR] = addr;
-    if (access_type == MMU_INST_FETCH) {
-        if (cpu->cfg.iopb_bus_exception) {
-            env->sregs[SR_ESR] = ESR_EC_INSN_BUS;
-            helper_raise_exception(env, EXCP_HW_EXCP);
-        }
-    } else {
-        if (cpu->cfg.dopb_bus_exception) {
-            env->sregs[SR_ESR] = ESR_EC_DATA_BUS;
-            helper_raise_exception(env, EXCP_HW_EXCP);
-        }
+    if ((access_type == MMU_INST_FETCH && cpu->cfg.iopb_bus_exception) ||
+        (access_type != MMU_INST_FETCH && cpu->cfg.dopb_bus_exception)) {
+        cpu_restore_state(cs, retaddr, true);
+        env->sregs[SR_ESR] = access_type == MMU_INST_FETCH ?
+                             ESR_EC_INSN_BUS : ESR_EC_DATA_BUS;
+        env->sregs[SR_EAR] = addr;
+        helper_raise_exception(env, EXCP_HW_EXCP);
     }
 }
 #endif
-- 
2.25.1


