Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA88AC4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ABD22083B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="asyC2R8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABD22083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQVca-0004Ma-2L
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 09:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQVU4-0003ui-4f
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:57:26 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:41590)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQVU1-0001zt-2t
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:57:23 -0400
Received: by mail-ot1-x333.google.com with SMTP id q21so5351496ota.8
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 05:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3WLaue+ohvo+ZmGquck7e37eq47w4KHNDVCyGwhwpsE=;
 b=asyC2R8OX0WPqNzMwC/sBb/N/5pYUvJ8+JIAbbXPEDRS8VSjJ8FCJSi6jg8lQK1I6o
 cBrXkvEddLkwcN8fpiSB9FKzZEXCG1Ph/AG6fiMvC622n5pLNf/Mo1qBB9kwPEH6pm98
 5scTeT63oMpC3Hl0TSttwrxbu/2jqzYNJ8GYqdHwNdd7ww48HzZRGMtIrCDgapeHRQgB
 wYPUofTy5mg+chVr1fMJGVLHfdTIHclOpcUFE6TfgvErGQDHy67yxDKwSXiilhu2olin
 BQLBJBkQsLStjvyb7g1Fp5HrruyMLtTEKZmWxchKKvXphgyruGE0huxU8JZS0/KyBTMX
 IWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3WLaue+ohvo+ZmGquck7e37eq47w4KHNDVCyGwhwpsE=;
 b=WuHBB887vMxu1AbP3UJegi/RHIQCqN2qJATsOWgAJFsVEENlMGiIG7M+Dz15WMk4vz
 ZhiGFpAOiezgPyLsW+I1Qn1AfOAjpQAm5uEZ11DGJyRJRJvmavqCNGGe6ZevURHWhSS7
 diKVpD0wfhHXJbYGyjC+t6Q4qqPzRWRurSZyR59Wu86vC956OyfghUYatgDruOLOkmz4
 6+E0NwC9QxPMsdHzQZW5rDPzn6kq9ENtvgR2pqL52damuAmmsswOhykzzjIW3OzsmN0j
 SfpxZfGBWepu2mG9doXMFKT3d4wQHqD0Wcv+SFOO80VKU32F5USvIrBgEzZjm/r8A7gj
 Wozw==
X-Gm-Message-State: AOAM530nDENCWP+8+8HoBWf7cHu7kmiNNDfD1ufw9o4JI/kcd/3ilZnU
 lABpHbGLbKkDBVkzum3VRx9PWQL7ECLlDuMe
X-Google-Smtp-Source: ABdhPJwJtBPj6YzcbiiL4mZ1F1FzwrkRkddMiycQ+oQwv2ZEc22TLwTVBVPeyIyjUljKJ9X5PMjieg==
X-Received: by 2002:a9d:6488:: with SMTP id g8mr4789878otl.211.1602161839641; 
 Thu, 08 Oct 2020 05:57:19 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id w64sm4701933oig.31.2020.10.08.05.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 05:57:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/11] tcg: Remove TCG_TARGET_HAS_cmp_vec
Date: Thu,  8 Oct 2020 07:56:58 -0500
Message-Id: <20201008125659.49857-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008125659.49857-1-richard.henderson@linaro.org>
References: <20201008125659.49857-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The cmp_vec opcode is mandatory; this symbol is unused.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h | 1 -
 tcg/i386/tcg-target.h    | 1 -
 tcg/ppc/tcg-target.h     | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 9bc2a5ecbe..663dd0b95e 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -139,7 +139,6 @@ typedef enum {
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          1
-#define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index d2baf796b0..abd4ac7fc0 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -189,7 +189,6 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          1
 #define TCG_TARGET_HAS_shv_vec          have_avx2
-#define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index aee38157a2..be10363956 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -169,7 +169,6 @@ extern bool have_vsx;
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          1
-#define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
-- 
2.25.1


