Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B47EC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:04:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A2B20936
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xsqp2k2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A2B20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBijl-0002zb-5u
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBiiB-0001NN-Br
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:02:51 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:50839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBii9-0002HK-J7
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:02:51 -0400
Received: by mail-pj1-x1042.google.com with SMTP id i13so93276pjv.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=VyJnYP7qAols/iC/DSxuiqYaX1lrROChX36Ffe0CjsQ=;
 b=Xsqp2k2qBPtA8+olX+1YI0tuJcxzPTIIOF4OVphA373zeaF4z4eO4eqoa+WVCKsOPn
 YFojTm14v/lF5tlvk9XMZ3f3hXjPD7PNx/sP1cTkoK91X1dP3OZCNApnS8DvF9ZJQEb9
 29P9qPD//jXpdq3lmQO5qKPLU5g/pBiZ3dRSE7LM+hNJNHbn0uB2FI1ECFFB6CjHOT+M
 iJqCGWkLxCBCdE0NA5Unvir4Ur0+yIPHr2KPe+L3lJ+9BagxFCAyF5d3hncLeSxy22ls
 RnB4icsi94nk3zZdpRSrXUq7kOOqe25ubbIBjTm6MXp/7R7blIe6rxdVFoAjahUi6iKw
 9a7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VyJnYP7qAols/iC/DSxuiqYaX1lrROChX36Ffe0CjsQ=;
 b=NPEXIV6tCtAYxYiug/BQa+wQSp8L5h4neVncujsN+klxSGDTxHsokM2oQhZqDVOmPl
 ELG7LuPazg11cghM8XZgp8a1NSRocx+zyUiYO3nrFrP9hOiV5JFeB4cwQFV5GJ9+yU42
 EZkLZMlD+ypXu+CHhdaFQQ0OcG82+b/05ffZtmsKuumbpfWxkWziscN7qC2J6awn7K5W
 RuwphrBtYiCl7vVxNma9kTmp2C5xwz9iTGERb6yXs9nyGfFJ6S8p3xh7JoXRtVlcRPCy
 ENYOaTP7E8tZmsbS+wtMIfSiWXLmM0xl8j+FnvSxv2bgu0RzBR5rDbeZUPqeKUW2u/Rt
 PUag==
X-Gm-Message-State: AOAM533TJtirvO+DE03ZFoPMuyNqqZ9u77VCs1Td3PsUAasR6Ww/PgX7
 mEqpKfI5IWoVdV2VFfNArLTsXOEMXLm/KA==
X-Google-Smtp-Source: ABdhPJxDdGzi2BVho6DoQiJm5CAhnFrh+V23N2HqYmbPKBZvcVI6WNQM4aZAW0e+6eOS3K5h3gXc1Q==
X-Received: by 2002:a17:90b:4b03:: with SMTP id
 lx3mr167302pjb.143.1598637767860; 
 Fri, 28 Aug 2020 11:02:47 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id w14sm41656pfi.211.2020.08.28.11.02.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:02:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] tcg: Eliminate one store for in-place 128-bit dup_mem
Date: Fri, 28 Aug 2020 11:02:42 -0700
Message-Id: <20200828180243.443016-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828180243.443016-1-richard.henderson@linaro.org>
References: <20200828180243.443016-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not store back to the exact memory from which we just loaded.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 793d4ba64c..fcc25b04e6 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1581,7 +1581,7 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
             TCGv_vec in = tcg_temp_new_vec(TCG_TYPE_V128);
 
             tcg_gen_ld_vec(in, cpu_env, aofs);
-            for (i = 0; i < oprsz; i += 16) {
+            for (i = (aofs == dofs) * 16; i < oprsz; i += 16) {
                 tcg_gen_st_vec(in, cpu_env, dofs + i);
             }
             tcg_temp_free_vec(in);
@@ -1591,7 +1591,7 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
 
             tcg_gen_ld_i64(in0, cpu_env, aofs);
             tcg_gen_ld_i64(in1, cpu_env, aofs + 8);
-            for (i = 0; i < oprsz; i += 16) {
+            for (i = (aofs == dofs) * 16; i < oprsz; i += 16) {
                 tcg_gen_st_i64(in0, cpu_env, dofs + i);
                 tcg_gen_st_i64(in1, cpu_env, dofs + i + 8);
             }
-- 
2.25.1


