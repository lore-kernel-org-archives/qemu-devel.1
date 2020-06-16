Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE32C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:59:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A02B2078E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EfVwMS7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A02B2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8Nl-0003Uh-Kv
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 05:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8L7-0006z1-GS
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:09 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:52152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8L6-00040a-0c
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:09 -0400
Received: by mail-wm1-x329.google.com with SMTP id b82so2263771wmb.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 02:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=JzYyFW+vzLvI4vaFh4vSRbwrxnE5oiZj4mGhEnDfHXw=;
 b=EfVwMS7I+YMmgoybQm5hZBYlImAfIwEsU2JLusQJdoIskQwpUub6G1DqjVi56G4N7o
 hRGSQU3jnTkfsLX0EgTwXeOkFo0GWHR+KpUjJoI7AboHaX/9lc9+jmQw3AL3lpAwK7DE
 gyGUehtgE6tQygGnpusr+INBNQw2JOw5FbvCVq+NKegV4kPKRGnRSHwAR4ilPLmLWR8f
 buvpcjJx1PsEVXm5oqM6oJivNXnNWRgWvbtq4QWFDDCURpgpRI89bOP4gSM5/2n1RCGr
 ikSn3T7F3O0+tvqS4A6SAP87PEq81jrZY1rGUghp/7OV5mQ8bEEqtLUCX6s0Qe8qY9+g
 dMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JzYyFW+vzLvI4vaFh4vSRbwrxnE5oiZj4mGhEnDfHXw=;
 b=CGkEF/m9VOX6VQSQ6KMoUclRrwvYf0RMuVOpQouJ/cEbc61/e5xQjmGr5pN7+AaEzF
 GVTAoIyZrRkdwtMg8Z2efbEWRgKUohRLq5DGLsJInGknY/NY9Ccfpjx6G9AGxFeia66p
 WCAEgq7YUKwwf26dUUCkXt6rX/u1NnS2oW1YhFkWAemVVlERqSIKrcUGnYKaPNIzxPtD
 R5nyrqm4uAwwg9KadasZndRsLMxz/PORTsDoORard7/cEMm748OUhmwnTmWfL8Pke8sR
 109I5o44e8ZPRiC23z6rS51qunCuYdIBPWoNqI9d+UDXA2vqEyX2UXQa0+CHMjSEaZi/
 2dNQ==
X-Gm-Message-State: AOAM532He2SY+rNrOU0Om5IP/JIU+k7+D7vvR/juj3qO0bfni1IxQsxI
 54d5blpBz9UCJKSAhdOuAi6bggjWHWiAmg==
X-Google-Smtp-Source: ABdhPJyr/OjPZ1ivu9WTaeZrZbVkA3YwATDH5VO1+jvbVsnmbRD30CjzLsvmI8DiydglD7V5QvTpBQ==
X-Received: by 2002:a1c:9c8c:: with SMTP id f134mr2302012wme.142.1592301426419; 
 Tue, 16 Jun 2020 02:57:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z12sm31090851wrg.9.2020.06.16.02.57.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 02:57:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/23] target/arm: Fix missing temp frees in do_vshll_2sh
Date: Tue, 16 Jun 2020 10:56:40 +0100
Message-Id: <20200616095702.25848-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616095702.25848-1-peter.maydell@linaro.org>
References: <20200616095702.25848-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

The widenfn() in do_vshll_2sh() does not free the input 32-bit
TCGv, so we need to do this in the calling code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/arm/translate-neon.inc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 664d3612607..299a61f067b 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1624,6 +1624,7 @@ static bool do_vshll_2sh(DisasContext *s, arg_2reg_shift *a,
     tmp = tcg_temp_new_i64();
 
     widenfn(tmp, rm0);
+    tcg_temp_free_i32(rm0);
     if (a->shift != 0) {
         tcg_gen_shli_i64(tmp, tmp, a->shift);
         tcg_gen_andi_i64(tmp, tmp, ~widen_mask);
@@ -1631,6 +1632,7 @@ static bool do_vshll_2sh(DisasContext *s, arg_2reg_shift *a,
     neon_store_reg64(tmp, a->vd);
 
     widenfn(tmp, rm1);
+    tcg_temp_free_i32(rm1);
     if (a->shift != 0) {
         tcg_gen_shli_i64(tmp, tmp, a->shift);
         tcg_gen_andi_i64(tmp, tmp, ~widen_mask);
-- 
2.20.1


