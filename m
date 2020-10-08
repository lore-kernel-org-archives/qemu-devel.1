Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12003C4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8610B206E5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXF5TV0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8610B206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQVeu-0007kE-H2
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 09:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQVU1-0003sC-1g
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:57:21 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33945)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQVTz-0001zb-BX
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:57:20 -0400
Received: by mail-oi1-x243.google.com with SMTP id n2so6207918oij.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 05:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WANLQRCpycKiqrfSXuwWnjHW6iUlbU2o8NExmAhiBGo=;
 b=QXF5TV0BxmDTyIbxpCbgR2bu7kOgo49+AdaYR4dQ6Ll7eLyjcWRMWncxYC0vCahXw6
 KL1PV/e1IAmCFF59wjidHoSKT99d5VfONgQjJDAWmxwvpbiOiOw/68Nj82Pf1gpDALcc
 FtiCvK6ARNDZhiS8nVv2ifdsWql13zbAV4kg9woy4rVXZR4vSz3uARhPScKM8bO9li04
 y0PIDbnfcauk0I4nb+tY0J6xErDCkOlMGLOPeqobJQdBSbgdeW7WHPF40mnLYjZ6o7aA
 woxIZK7yEjyuRYH5kA30gejs9wqqFIoMZH5kF+LcJDvfemw77qC5bTNAQz+JZG9GhuQ3
 1oWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WANLQRCpycKiqrfSXuwWnjHW6iUlbU2o8NExmAhiBGo=;
 b=tCw5D1bvuBmFhdmSJWIxISqT4bAtysYBckzSqNKALwaKpcG4zYCZLH0Jam+M7lIL4O
 H74DSNM8zS5pEDz77d2dZnr+Q8tSsalH7m9JK1P6XabhLTrq9vDRgtBwn7OY2qrjoPHr
 Adq/gGJhvM/72LL8wkZoxVELf5DXFSEb+gMvyrK2tzhwniZ/Qs43Nkzz+Z+7roUrj1Bi
 ryo/L0i0i5VOohQi5jnWbpknQjCp1Gy6hgJU5MxfcbNy9OL/lACIMm/+1oQUABSJ43cx
 8fvXP2zQuGRui0EIKAekL6SyAXh8+7LnLRz15AMCz271Tnx3Jk1JplKnxv5YNZTGbVh+
 ocTg==
X-Gm-Message-State: AOAM533rWl7jN85MBa8agsjlne52yCI4/xIEXbtKp+yfThyPojELeQ07
 fYMbXouWNfF4MJyiP5Stc3ivpg5Sx5rxmqqT
X-Google-Smtp-Source: ABdhPJzMNz47BsNq2eUTd7xppwUyA5V82k4zPp6DD0k1Se9smXfXLm6UBqtjL3U6MtNXHHKTutaLVg==
X-Received: by 2002:aca:5058:: with SMTP id e85mr3872845oib.79.1602161837812; 
 Thu, 08 Oct 2020 05:57:17 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id w64sm4701933oig.31.2020.10.08.05.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 05:57:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/11] tcg/optimize: Fold dup2_vec
Date: Thu,  8 Oct 2020 07:56:57 -0500
Message-Id: <20201008125659.49857-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008125659.49857-1-richard.henderson@linaro.org>
References: <20201008125659.49857-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x243.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the two arguments are identical, this can be reduced to
dup_vec or to mov_vec from a tcg_constant_vec.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 53aa8e5329..220f4601d5 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1109,6 +1109,21 @@ void tcg_optimize(TCGContext *s)
             }
             goto do_default;
 
+        case INDEX_op_dup2_vec:
+            assert(TCG_TARGET_REG_BITS == 32);
+            if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
+                tmp = arg_info(op->args[1])->val;
+                if (tmp == arg_info(op->args[2])->val) {
+                    tcg_opt_gen_movi(s, op, op->args[0], tmp);
+                    break;
+                }
+            } else if (args_are_copies(op->args[1], op->args[2])) {
+                op->opc = INDEX_op_dup_vec;
+                TCGOP_VECE(op) = MO_32;
+                nb_iargs = 1;
+            }
+            goto do_default;
+
         CASE_OP_32_64(not):
         CASE_OP_32_64(neg):
         CASE_OP_32_64(ext8s):
-- 
2.25.1


