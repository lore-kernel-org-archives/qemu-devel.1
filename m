Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C292CC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 778F42098B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NcUqBCiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778F42098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8PE-0000CS-Fs
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kD85r-0004zA-8B
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:21:07 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:41947)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kD85j-0006fO-BT
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:21:06 -0400
Received: by mail-pl1-x629.google.com with SMTP id l9so686881plt.8
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cJQwd8RXC2jtaqIhnYKg7+XP5Yhz5tiCGX7IypB/AME=;
 b=NcUqBCiT0fEmG13b6YB85xbPjL/39kA4HDBESchCm8lgXzUmhbMhZXRPlf2t4hRG00
 dHt95dh/yx1mmZInsr/gaTAg7PvYxwooVa4lyz0mBCtbWeRJsJHbsWVcvPGy54R0PwXJ
 +kxFMIYRGm079x2Lv04to3W3DCFL0DTBp3UXI5cfe7l80vNtLu8SEGS3r3g0fmqWfAEu
 FUmGpX5opey314MKJI/IAf085g9pkVZn/unu0HGiPDk2NexMazyLz/EvDWRMgT+TZY5Y
 wUI00nNgguXxTai1SUbTh7RuyO3l5NDFc2G5b4/PiO9dPNMSqUOimskRtMYm53LW09MF
 lDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cJQwd8RXC2jtaqIhnYKg7+XP5Yhz5tiCGX7IypB/AME=;
 b=exn1PcNuaVOEP+jCdGLwWkPyPqy+ZNh7dneLL8KNLRefV8hh9aN2mLDynZeTNMgGmV
 4g7NOW6AlRtwkir14htyiYvAWHFVsomTP1BOPlNTLVCHcy3Ur8ms/7K/EPleEtmKw4ee
 JAKBd6c9968pAA5O9W8ou8HGnvj/ZoXH1Ui2wVa3KEsAow2D8aW3U+MqUMJzZZXTr/bZ
 Q4Oxk2WnaBIhstYumnEESKT5ZN6Up4NYIEj+MfFQMtSUNrMD7k+KYGJJkujoAV8R4OcY
 hibTbq7wj4ZOEAQ/qEDFW59nXD5QUjdCdDWrxrqIq1rHJPCBIdloU648/Cs3k0r9aATw
 KVUA==
X-Gm-Message-State: AOAM532qvXUA1hJmdnmGqHjDHG+EamqBbY4zqH8Sy7j/ZXvGAkDBozQj
 5JK3nKJ+wMsVBjJYpgwM9KrANfjexLNzfw==
X-Google-Smtp-Source: ABdhPJwM59XWZmaQc3f6OZhVNZzTq2HCD03cWS83E/lyM/9P7xZGdIQvQ2YqyefLVJFO1e9RREGHlQ==
X-Received: by 2002:a17:90a:a50d:: with SMTP id
 a13mr2051816pjq.180.1598973657320; 
 Tue, 01 Sep 2020 08:20:57 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f28sm2402473pfq.191.2020.09.01.08.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:20:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 58/76] tcg: Add tcg_get_insn_start_param
Date: Tue,  1 Sep 2020 08:20:54 -0700
Message-Id: <20200901152054.922595-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200901152054.922595-1-richard.henderson@linaro.org>
References: <20200901152054.922595-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MicroBlaze will shortly need to update a parameter in place.
Add an interface to read to match that for write.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index d40c925d04..53ce94c2c5 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -777,11 +777,26 @@ static inline TCGv_i32 TCGV_HIGH(TCGv_i64 t)
 }
 #endif
 
+static inline TCGArg tcg_get_insn_param(TCGOp *op, int arg)
+{
+    return op->args[arg];
+}
+
 static inline void tcg_set_insn_param(TCGOp *op, int arg, TCGArg v)
 {
     op->args[arg] = v;
 }
 
+static inline target_ulong tcg_get_insn_start_param(TCGOp *op, int arg)
+{
+#if TARGET_LONG_BITS <= TCG_TARGET_REG_BITS
+    return tcg_get_insn_param(op, arg);
+#else
+    return tcg_get_insn_param(op, arg * 2) |
+           ((uint64_t)tcg_get_insn_param(op, arg * 2 + 1) << 32);
+#endif
+}
+
 static inline void tcg_set_insn_start_param(TCGOp *op, int arg, target_ulong v)
 {
 #if TARGET_LONG_BITS <= TCG_TARGET_REG_BITS
-- 
2.25.1


