Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2460C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:43:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CF3C20738
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EsVENMG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF3C20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADgm-0007hX-Ll
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADUE-0000Sw-2Q
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:30:14 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADUB-0002mi-KV
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:30:13 -0400
Received: by mail-wr1-x443.google.com with SMTP id p17so3239488wrj.8
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 07:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=IkFQo+GYBfR/QC0YRa+lSr9XAhK0cCAa4Tqr7T1eAMU=;
 b=EsVENMG9/IwdJjMtaHC4stzc/khwP4qFIB4oi35LDF9IW7IbPUvtvaDzyQe3MdhklQ
 g66Nn9Y3w2mOE3HR/PHuod/zJfVH9Zy/ihgGiVgHEhHaSFMT+mgPxqGsuXeyJNC2SqN4
 TOoqkdEbRG8nHCFAa7T0J4/AF2eeThkvhJugqlUfveMfjqSKziWN4xiKymcbk0f6LLja
 U8CxqCBOv5F+o7jPOjEA+506LV4OyMPO7Yb+6bPkx2hhHLf3qE6ZnAt1rkOJoyiphR+2
 mxCphPJvjcwpuOjfS7ah/afbnv1nDnO8dqy2znLjir3TeAt0LIuRcLX4k5+cau0nrfOF
 cvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IkFQo+GYBfR/QC0YRa+lSr9XAhK0cCAa4Tqr7T1eAMU=;
 b=GD2IWlIxG4oXIVyncbHTZ5Mrkes2H242bHCu/D87MxDqmKJf8xhE0DziDTqYaPdZyW
 eSBW4oFOWC/wgtkWJRmGp1KfNlr7AgBktl8r1+mQsZ7lek8UnIYNLhIyESpCPvmJ6ZdR
 AAmmTXsuJBI8nkLgJco471D0f70C3AvDE+1dqhkXajaoAAAQCiwF4ATnRt/7T9S6CQTJ
 JDphuqvLW7TervdjelKvb7hca48GQFdR5RbVCxV4Fo5DXyz1st+Wtw6sAtF/S6ngy+ra
 dM5dp3XiiEt8ghrzjI0o5QuzeP2A2V+sg2JrQfIkSMXL9924Y75By9MILbi9CLRboW8a
 eJlA==
X-Gm-Message-State: AOAM530LSPoQ7esJH/RiQah0Ccp7ZWMW0G/Q/nb8iglOt6F4aeFjZ8mL
 i+26GX5PWis5Yn7Ojaj3eMTvEZnfHzdWORro
X-Google-Smtp-Source: ABdhPJzJcJZHN7dZfLO9/SCOrDFSp9hiNrIs2gPjZayn/gp7sUF0wG/ont32SZdmARnW6/mWHtnmOg==
X-Received: by 2002:adf:f8c7:: with SMTP id f7mr6564230wrq.117.1598279399011; 
 Mon, 24 Aug 2020 07:29:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b14sm24499091wrj.93.2020.08.24.07.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 07:29:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 21/22] target/arm: Implement VFP fp16 VMOV between gp and
 halfprec registers
Date: Mon, 24 Aug 2020 15:29:33 +0100
Message-Id: <20200824142934.20850-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824142934.20850-1-peter.maydell@linaro.org>
References: <20200824142934.20850-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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

Implement the VFP fp16 variant of VMOV that transfers a 16-bit
value between a general purpose register and a VFP register.

Note that Rt == 15 is UNPREDICTABLE; since this insn is v8 and later
only we have no need to replicate the old "updates CPSR.NZCV"
behaviour that the singleprec version of this insn does.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vfp.decode          |  1 +
 target/arm/translate-vfp.c.inc | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 9a79e99f1b0..51f143b4a51 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -74,6 +74,7 @@ VDUP         ---- 1110 1 b:1 q:1 0 .... rt:4 1011 . 0 e:1 1 0000 \
              vn=%vn_dp
 
 VMSR_VMRS    ---- 1110 111 l:1 reg:4 rt:4 1010 0001 0000
+VMOV_half    ---- 1110 000 l:1 .... rt:4 1001 . 001 0000    vn=%vn_sp
 VMOV_single  ---- 1110 000 l:1 .... rt:4 1010 . 001 0000    vn=%vn_sp
 
 VMOV_64_sp   ---- 1100 010 op:1 rt2:4 rt:4 1010 00.1 ....   vm=%vm_sp
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 4b26156eccc..28e0dba5f14 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -809,6 +809,40 @@ static bool trans_VMSR_VMRS(DisasContext *s, arg_VMSR_VMRS *a)
     return true;
 }
 
+static bool trans_VMOV_half(DisasContext *s, arg_VMOV_single *a)
+{
+    TCGv_i32 tmp;
+
+    if (!dc_isar_feature(aa32_fp16_arith, s)) {
+        return false;
+    }
+
+    if (a->rt == 15) {
+        /* UNPREDICTABLE; we choose to UNDEF */
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    if (a->l) {
+        /* VFP to general purpose register */
+        tmp = tcg_temp_new_i32();
+        neon_load_reg32(tmp, a->vn);
+        tcg_gen_andi_i32(tmp, tmp, 0xffff);
+        store_reg(s, a->rt, tmp);
+    } else {
+        /* general purpose register to VFP */
+        tmp = load_reg(s, a->rt);
+        tcg_gen_andi_i32(tmp, tmp, 0xffff);
+        neon_store_reg32(tmp, a->vn);
+        tcg_temp_free_i32(tmp);
+    }
+
+    return true;
+}
+
 static bool trans_VMOV_single(DisasContext *s, arg_VMOV_single *a)
 {
     TCGv_i32 tmp;
-- 
2.20.1


