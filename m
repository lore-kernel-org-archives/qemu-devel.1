Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD88AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E18220706
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pP7FzMup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E18220706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqQM-00014I-PM
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4V-00036p-Gk
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:21 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4U-0006eY-06
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:19 -0400
Received: by mail-wr1-x442.google.com with SMTP id q5so9851234wru.6
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=cRLle7QXbXZMLIYjz446cs4YjOdvOo9M3dbhN/BEdfk=;
 b=pP7FzMupdSLPzn0fYRHFicdfG5GQGFo7PselHzcYNAAueM7GhFqjUpDpuafy001MwJ
 X1QluxFo5pGLwd8HNRJa5WZJJgC/jVPLYAGPxA01XpVHAh4OkbfUvJlO2R5a+8nGB1Bk
 vaxoIkxEYeBYdTwu/Lau+31hgGDnX5TNzrCn80FnLnDmH+zPonCe08qEE93lLPvOp/Qf
 HZChrfgbULq3qZsZQWlY66h83k0sigB314Vd2NV5vK8hFVunXvXDgIXf23oD8fjRDEyq
 9LKHjLFw67RSjO24LaKiBn3/gwqYwewUFmbIHU4sDtXxuot824QDTv3qRGebvvWmq4NE
 bX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cRLle7QXbXZMLIYjz446cs4YjOdvOo9M3dbhN/BEdfk=;
 b=S8E8IcFZC+8oHux4Jq4q10shDY/WlsRcOKv1HjsvMCOn8BJ9pCjTJVXAGartXzgc97
 qOEr5zmAKtQnclx7cJMHprnrYk2ocmf9Y5g/D5bWLRaCXYs/oawfe6rkFYKHRz7kHK1Z
 Z3/aL/qq5qGti6w1bnik5KTcurdcE4fqtZ7JifEjFDGpNbsShdM6eOIYUscW5O+OUiVa
 H+KjG12lnk2Nnu77xMJptRDcFIVhiwo8D6e+y98rfqwilE3NPw9Rc7N2zTcdRUbliLWw
 63bcvGmKwkyqyp4TTfO7yg/cgGJq7k6tnqgtvkPILic3kX7kRjP9fqhLqTXkLmMEKPMk
 1gDQ==
X-Gm-Message-State: AOAM533Hjgshva1qoAcfRIElGgJRGCc8x5gorkvX4LwpiSppQaQujoO9
 13P41P0gevnebXAKBFBxbpCXnSKOCWl/Nw==
X-Google-Smtp-Source: ABdhPJzW5JOSVkFxtPvFyxdgY7Ek5BuSIFAI20qsXqLoQfF+leGtAHVVN2kx0FKXIPy8yuMVWI/SKw==
X-Received: by 2002:adf:fe0b:: with SMTP id n11mr4246827wrr.245.1593184515866; 
 Fri, 26 Jun 2020 08:15:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.15.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:15:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/57] target/arm: Use mte_check1 for sve LD1R
Date: Fri, 26 Jun 2020 16:14:09 +0100
Message-Id: <20200626151424.30117-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-31-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 4a613ca6892..4fa521989de 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4892,7 +4892,7 @@ static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a)
     unsigned esz = dtype_esz[a->dtype];
     unsigned msz = dtype_msz(a->dtype);
     TCGLabel *over = gen_new_label();
-    TCGv_i64 temp;
+    TCGv_i64 temp, clean_addr;
 
     /* If the guarding predicate has no bits set, no load occurs.  */
     if (psz <= 8) {
@@ -4915,7 +4915,9 @@ static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a)
     /* Load the data.  */
     temp = tcg_temp_new_i64();
     tcg_gen_addi_i64(temp, cpu_reg_sp(s, a->rn), a->imm << msz);
-    tcg_gen_qemu_ld_i64(temp, temp, get_mem_index(s),
+    clean_addr = gen_mte_check1(s, temp, false, true, msz);
+
+    tcg_gen_qemu_ld_i64(temp, clean_addr, get_mem_index(s),
                         s->be_data | dtype_mop[a->dtype]);
 
     /* Broadcast to *all* elements.  */
-- 
2.20.1


