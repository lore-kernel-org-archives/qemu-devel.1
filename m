Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CF7C47420
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:12:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F5E120774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UiEheWB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5E120774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNL2y-00033h-At
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKwV-0002Zz-KJ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:05:39 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029]:33744)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKwU-0001lH-0V
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:05:39 -0400
Received: by mail-pj1-x1029.google.com with SMTP id md22so4170622pjb.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tBEYWiyR/++gCKYsI5lV56MeXltwNHPIVH6DpiEKsns=;
 b=UiEheWB6/go99Jlo5xaacVfZNwO4R44fQCUoUGBqbUzvSeae8bloHq/0MDxbb8SKiL
 qNokzvFxXnIbkv3OW/3P45931fmh+oe/HT1jAVj+739Hhzp2SVgJyTNLmamiQiBqDRM+
 PqglC/S3g799LrQnydIrhqTgnqKu9xVhNj18AuheLX53L6WTFtdzZyB9TlC6eENYV1sH
 hJ+ArnzTiYXKj8EA31ylnC2WRiE7gYfPrXWelV6ovRNgvjW9UbLk1o2e7cm27ozPZAth
 AtdPUle0UcxIpcnO68/7sCuIRCiaKfPAiW6iidKBJiO2sS8Vi6XjmYgtbwHFf0F7Q9N8
 Sq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tBEYWiyR/++gCKYsI5lV56MeXltwNHPIVH6DpiEKsns=;
 b=kjbOHouum9MU0vXvJOn8UgdDDtLIlXapviUO5iOLYrUfZpFvxAm/hZCqRStCCzcMF7
 TjuX98zXBTGMH/pVSsd6bRgP1H+DDfGGmBx4zUOevQQtYhZuqgpfPijzygmDbo78UMrp
 XwKDJ/ZPqqh4UYn+h14S5jnH3m8pzeyUESAq7dYme0gvJYpXSTrTI5qN37M0I86qcsuF
 XOlJxduhq3mb9yexYYFPWVfjKkBwMUvg5Vem0V12Olos62wV4vr5PYClXjsRrtOE1zwb
 LVMSP5p8W6AN544MCIKCRd5xwnuj2COYnnhpjkYpUORIeicyxSyx0oWyjTeO0yi6NXzK
 z0nw==
X-Gm-Message-State: AOAM5329ASYUqBP8Uz/577FyaH3Eo3qVEDbOjh301kA/uuy2V9QWvYsh
 3fPNpRsQeXQ3YEius3uO49CGGPrtXpJs0w==
X-Google-Smtp-Source: ABdhPJx1YcIvdS9muaEk80BqZMXrCmbshkNIvcK5k68+MgPnkTRWLwCGviNQa+1kyXmgep1r4+7PsA==
X-Received: by 2002:a17:90a:9f09:: with SMTP id
 n9mr5135788pjp.88.1601406336511; 
 Tue, 29 Sep 2020 12:05:36 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:05:36 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 07/68] target/riscv: rvv-1.0: remove rvv related codes from
 fcsr registers
Date: Wed, 30 Sep 2020 03:03:42 +0800
Message-Id: <20200929190448.31116-8-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1029.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

* Remove VXRM and VXSAT fields from FCSR register as they are only
  presented in VCSR register.
* Remove RVV loose check in fs() predicate function.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/csr.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 9292ee9963..3117fdbe2e 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -46,10 +46,6 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops)
 static int fs(CPURISCVState *env, int csrno)
 {
 #if !defined(CONFIG_USER_ONLY)
-    /* loose check condition for fcsr in vector extension */
-    if ((csrno == CSR_FCSR) && (env->misa & RVV)) {
-        return 0;
-    }
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -RISCV_EXCP_ILLEGAL_INST;
     }
@@ -223,10 +219,6 @@ static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
 #endif
     *val = (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
         | (env->frm << FSR_RD_SHIFT);
-    if (vs(env, csrno) >= 0) {
-        *val |= (env->vxrm << FSR_VXRM_SHIFT)
-                | (env->vxsat << FSR_VXSAT_SHIFT);
-    }
     return 0;
 }
 
@@ -237,13 +229,8 @@ static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
         return -RISCV_EXCP_ILLEGAL_INST;
     }
     env->mstatus |= MSTATUS_FS;
-    env->mstatus |= MSTATUS_VS;
 #endif
     env->frm = (val & FSR_RD) >> FSR_RD_SHIFT;
-    if (vs(env, csrno) >= 0) {
-        env->vxrm = (val & FSR_VXRM) >> FSR_VXRM_SHIFT;
-        env->vxsat = (val & FSR_VXSAT) >> FSR_VXSAT_SHIFT;
-    }
     riscv_cpu_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
     return 0;
 }
-- 
2.17.1


