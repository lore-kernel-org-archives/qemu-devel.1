Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91566C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0470820756
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bkm3wJea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0470820756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYK93-0006VO-TI
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 22:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYK7X-000500-Fg
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 22:26:27 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYK7V-0005uY-T4
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 22:26:27 -0400
Received: by mail-pg1-x543.google.com with SMTP id g12so3914825pgm.8
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 19:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PzEKwCdPZHtQpaS3rSzSooMjXk0UfsubT3zCzhcVGPc=;
 b=bkm3wJea1zNcaojLSIBcUZoqK8kiSOY5nOwAXlfCTiPs8D2D1/kDSc/t+ci9c/hXhW
 dbM3qnSPoEePGmQDPsgb9eoQDpVrWEnb2M7ouc/3Uj3lVOKunVFFiee87Hx5Jj6g68n5
 OAQTHmDDsULgzFuZSWa1IAEqCu8v/ikTmCsyHdesUF1QB+7b+d3VOSCkCqdXDWUjOzxK
 85uzDMrQvteYOXOin5mSJMpiggOaYI6Efpx0oNFSsVbbIVpYQ9Zeai9KyvbTYlqAI4dV
 suLXHn0py0E2BYb49uHlOypYh/mSvtnALCeN49L/WX7jIdAT8zZvtxldX2XgYx90eBKu
 c3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PzEKwCdPZHtQpaS3rSzSooMjXk0UfsubT3zCzhcVGPc=;
 b=lohll/K2PL379tnCxADl0nCKxyVmKkDn7UZ3890w5+NEGhy7WwRSO0BQWEcE3uD2HX
 QAfMkemizQjC1PviYQyHqMry9yjuLcwDbOP8XP6fHuIdDuVxLD9lSIiFUNEhqbJgYrm0
 XrbBQpsQErefCHtI1VwXeGlcp76rgzOQFnnzKHlBKfHZUimJjTdhNanaEOuCySVdDWXB
 WwTKj/po5A3pyRGlNpFvDAmROfrWLPWqoc736PGWvOuZ78dxvJ8CQd6lHQok2N9FQkTE
 nsr7Z1eIPGTVloXBGzNRhY84420+kLjfccpBCX+Ufdp2ZiINomg/hXUcQbXbM9iCqN+V
 Buag==
X-Gm-Message-State: AOAM5321tqZ96GA1DSv+/G+xVvzT5IorfPBgRn0I4CIOsxrwzfav65gy
 9fLAY/6CPPo0WvhRG5EEqvGqBdwutkOZ1A==
X-Google-Smtp-Source: ABdhPJyfpVn6MZvV6omJsoDUwzsUXiAYaUjeybWkdVwPqX3IBtVWg583+MGh3+oyhccK7QCuX/S1XQ==
X-Received: by 2002:a17:90a:5b15:: with SMTP id o21mr92188pji.45.1604024784188; 
 Thu, 29 Oct 2020 19:26:24 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b7sm4446517pfr.171.2020.10.29.19.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 19:26:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/11] target/arm: Use neon_element_offset in
 neon_load/store_reg
Date: Thu, 29 Oct 2020 19:26:10 -0700
Message-Id: <20201030022618.785675-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030022618.785675-1-richard.henderson@linaro.org>
References: <20201030022618.785675-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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

These are the only users of neon_reg_offset, so remove that.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index bf0b5cac61..88a926d1df 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1137,26 +1137,16 @@ static inline long vfp_reg_offset(bool dp, unsigned reg)
     }
 }
 
-/* Return the offset of a 32-bit piece of a NEON register.
-   zero is the least significant end of the register.  */
-static inline long
-neon_reg_offset (int reg, int n)
-{
-    int sreg;
-    sreg = reg * 2 + n;
-    return vfp_reg_offset(0, sreg);
-}
-
 static TCGv_i32 neon_load_reg(int reg, int pass)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_ld_i32(tmp, cpu_env, neon_reg_offset(reg, pass));
+    tcg_gen_ld_i32(tmp, cpu_env, neon_element_offset(reg, pass, MO_32));
     return tmp;
 }
 
 static void neon_store_reg(int reg, int pass, TCGv_i32 var)
 {
-    tcg_gen_st_i32(var, cpu_env, neon_reg_offset(reg, pass));
+    tcg_gen_st_i32(var, cpu_env, neon_element_offset(reg, pass, MO_32));
     tcg_temp_free_i32(var);
 }
 
-- 
2.25.1


