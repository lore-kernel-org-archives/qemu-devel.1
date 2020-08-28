Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB11C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:46:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B0D207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u6tTUMXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B0D207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfdh-0002DA-AP
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFI-0001ql-Qz
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:48 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e]:33382)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFH-0005OL-1M
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:48 -0400
Received: by mail-pj1-x102e.google.com with SMTP id q93so601932pjq.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p+iYZfUiWvOiZ4jhf/t12sD37PNbPvTJo79LCNu2vXI=;
 b=u6tTUMXlTFMqkGCJPjS+Fqg7bx3jqAlkFCWLf0fJf+jIFMP+N7q6oCWmVv55xza2Ya
 1RJS4AZBGWoGqbEQYXZJHS+T59yGXOfhCiAuElDNJaZ5UoXa9tBMFLeatsoBcKa5p0YI
 4eIg8ssqHSL0NQx1Y6dAHcm8a8jqKpBhWlWwh63OHMcKpD7Wz0uaorDZzU5HVSq59bJ9
 QrBbtD7y39vvTOx0b870OvnvEUAq5cRVtoh7hsbWdvTEQySEOlHzhlX72n9rWdJicnoq
 zK07EBX2h5hMG0Juxa7FqJfkquYcFUrybNHfm7dmnA0rJQrgV1swI27YElqtjAMyhHvQ
 q/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p+iYZfUiWvOiZ4jhf/t12sD37PNbPvTJo79LCNu2vXI=;
 b=fsH27lsOESdMVKXuG61UxYQUAOpCXzJsQFO++22wrIW/wwv1uq5oHLZeQ+cVJFFco1
 uD7kwWL8TwenWh2P0QF0n08Lxdp5IE58fPM+7QKtecFbW7oofY4S34aMrHmNXYFTJ4T9
 WagQ6f2GeyuVNdxI5rrnBTD95AB6WmZs1ahD2MKbZANmaraEbDukzniA1rdIetWTtPuY
 b9Ytt3C08/hNz7hExXRaZLbSUewy5ZmIBfOWbkwEyhi48RMolKSo9BAZlqvqZWApJfBI
 rWTz1swFV23K5AHis9Dr7d/F+IpFKgBSg6GqtRDht++KQurESDaXKv4q4HDDkzo0qmEH
 K37w==
X-Gm-Message-State: AOAM530chb4JAiI4YkB+vj4eE2wlIiLTMrMvNw51OnmtZauZFovXzg7o
 a1vXtqtpkYRXyUxJ62Ht25fy99iVYEz0+A==
X-Google-Smtp-Source: ABdhPJy/ZeniDALRsZOSe/VsQ+stzj5bXZ/qqjGHTfMCy4y2jSNNcqOdNkhQqGmhDjDA8pRBVYPCNw==
X-Received: by 2002:a17:902:8304:: with SMTP id
 bd4mr1546497plb.250.1598624445277; 
 Fri, 28 Aug 2020 07:20:45 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 58/76] tcg: Add tcg_get_insn_start_param
Date: Fri, 28 Aug 2020 07:19:11 -0700
Message-Id: <20200828141929.77854-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MicroBlaze will shortly need to update a parameter in place.
Add an interface to read to match that for write.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index d40c925d04..15da46131b 100644
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
+           (tcg_get_insn_param(op, arg * 2 + 1) << 32);
+#endif
+}
+
 static inline void tcg_set_insn_start_param(TCGOp *op, int arg, target_ulong v)
 {
 #if TARGET_LONG_BITS <= TCG_TARGET_REG_BITS
-- 
2.25.1


