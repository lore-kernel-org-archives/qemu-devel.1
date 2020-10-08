Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8776C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BFAF21D7D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYrxlRye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BFAF21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQYhf-0003oQ-SK
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 12:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQYgL-0002V1-44
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 12:22:17 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQYgD-0007eD-8F
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 12:22:13 -0400
Received: by mail-oi1-x243.google.com with SMTP id u17so6901508oie.3
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 09:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y/sfKn+XuwGfbi+75v+dyxssWOv3tQu5rJvj1rCENB4=;
 b=JYrxlRyeslbCAV+j4xnxnv+kYYMbx2eoa7afZh9689kb5n/YgR7Te2x75S1tLra7Zj
 OrrGfdIUSX33vdwyIGmCKX8tCG+5+IYFapYtKGvc9iQUCsuaKxh0B6Gnu22/fWe0Ox0l
 1R+Ko+c+Tu3P2LNYoeCuuoCQmfALkAPdOeGUmy3xTGgFrfEiSIYPb/0ZmS3aLXXlSmbU
 h2gv063OLYqCL7bk3FIx5KEV/ZjZEe55eCJqd3dg8DiQ9E8bGdZNb8EOn0ijZJeEhZqP
 TaCpeCU31oN1gBcYGfGN42Lg8Ntfs4MFr/Urpc0xzH5YeTJEnCaqW4xU7t68hBEp0JCA
 xMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y/sfKn+XuwGfbi+75v+dyxssWOv3tQu5rJvj1rCENB4=;
 b=uULweEjDoNGmR6WBffn0R/iGxVoePA8IauXJ+dUVLmBSDaW+uLObsteGb2wOvJzOvC
 b1SmUlKaDaYpn2gdSCt1PbgZPODZker3sO2a+NXtB9huTn9EKPJT9frZ7BAUZltVF6FH
 GD53cDdjgjUIF+9uglx5zQqNxbkyrzo+tfFSOCsBYBXCS9uVl5Zrh19KxUfNzrqi9jq/
 uHhD2ia03D0XlpmLNd1ktjqYm0y+XKyp5OjNEetKuDsE1WMw8L9dfDlMOkZUN8D6e86v
 /SaM+AqyItQOvK4O7sVji3ZVG4hv2t9xWgl0vvSnMk0w1rBwipy36O4lLrC86YKgCs0U
 hX/w==
X-Gm-Message-State: AOAM533Uw4rHXyYX2e4K1nQk9dnETzpuqn7YthyJLGKMyRrA6djlEMQ9
 ZAYfArEYq9PFo5J5IM8bTv2ZxMfM/RjE0f6b
X-Google-Smtp-Source: ABdhPJwpjuud2h5UvNkZqwE8En7D3o2lJg7FHFsGbAkvSZnvL7JXb2nLEBdakmsq8M6dN5m/gfOsdw==
X-Received: by 2002:aca:1b0b:: with SMTP id b11mr1314457oib.114.1602174121611; 
 Thu, 08 Oct 2020 09:22:01 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id l138sm5076218oih.32.2020.10.08.09.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 09:22:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] target/arm: Fix reported EL for mte_check_fail
Date: Thu,  8 Oct 2020 11:21:54 -0500
Message-Id: <20201008162155.161886-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008162155.161886-1-richard.henderson@linaro.org>
References: <20201008162155.161886-1-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, vincenzo.frascino@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The reporting in AArch64.TagCheckFail only depends on PSTATE.EL,
and not the AccType of the operation.  There are two guest
visible problems that affect LDTR and STTR because of this:

(1) Selecting TCF0 vs TCF1 to decide on reporting,
(2) Report "data abort same el" not "data abort lower el".

Reported-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/mte_helper.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 734cc5ca67..153bd1e9df 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -525,14 +525,10 @@ static void mte_check_fail(CPUARMState *env, uint32_t desc,
     reg_el = regime_el(env, arm_mmu_idx);
     sctlr = env->cp15.sctlr_el[reg_el];
 
-    switch (arm_mmu_idx) {
-    case ARMMMUIdx_E10_0:
-    case ARMMMUIdx_E20_0:
-        el = 0;
+    el = arm_current_el(env);
+    if (el == 0) {
         tcf = extract64(sctlr, 38, 2);
-        break;
-    default:
-        el = reg_el;
+    } else {
         tcf = extract64(sctlr, 40, 2);
     }
 
-- 
2.25.1


