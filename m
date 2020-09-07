Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77633C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 17:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 070FA2080A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 17:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGvT2kbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070FA2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLKi-00015u-48
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 13:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLIN-0004iK-Js
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 13:51:11 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:38449)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLIM-0000kr-1t
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 13:51:11 -0400
Received: by mail-pj1-x1044.google.com with SMTP id u3so3537125pjr.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 10:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m0GTL/th73zAOOPhUOn5M7H75WJeN6n2LDCntpwQd3k=;
 b=fGvT2kbKCBaFQi2Rrgx/fsZPReKvG5KXhBI6xTxJLxqCFYSTapIKMnqawf0EnA39gz
 2OKbTB1q2mFe21dxLrOT94EedmO24v95I7sAT98aRrbU4DYBtKRTb6w+LgXWqWoTZtTz
 vQyfmHeLSxLjA3huYrwqvysX8GLQu7zaNnXzejNzg7y78v4/1kthwUdSHjYPT4U5Zq26
 lFpkBEwHP/L/S8UzksFR6iS81NKVzQuU+rJ6sKCwHfnRO+cVCG2oE6ILQrhABZ+UVpeC
 WELkmSsIHc7fvh+g7APGrxUJ4WozKAQ+snMKH/Mqf9AEL69rjGZr+ySS9URDHea5ujHN
 uOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m0GTL/th73zAOOPhUOn5M7H75WJeN6n2LDCntpwQd3k=;
 b=Pf5kR62WGragOV4JijZ54zQdn8KVfY11T5QYOiP7PWZPvzMWbU4jkmaeJHJOGds9QV
 yaJy3L1EOT70HdOxTDYq0pQ6/5PqXP5Dram+dwAWMhYz3ju+ktg9fYIW+74lo+86E/1l
 j5wUOcLBVNUdjj31PPpiwCLSLUxpDeMw2B4GRoC0MO3D2ik8lH3naDzAvVCAVp0yJsVx
 IfyZjCHceEqvDDs066wmQ3UNoGB0dLAmu1TIdVOoAl1SvvEOwYra5dsKybJPBpDYm6iz
 8BOvYVAatuCreoBMsETICJMMgW4bKtHU3Yw6a7yfHHPqJh+YB+TTNoUZDEU5T7Ug4gbl
 qY2A==
X-Gm-Message-State: AOAM5338gcLOaarMhxj2JRpS4ql6vSz5fzD5F0zRVKT6hELKIiQipSZk
 HzFcINnLyf2XCfyawA2uIsuxKIPuBfmoHg==
X-Google-Smtp-Source: ABdhPJwbJzB5U5vANWDs/GqbeyKF4SyAETJ0tA8YFXStyIMACY3fIKM9lMx2TcNZu9dQG+n0trK+eQ==
X-Received: by 2002:a17:90a:e391:: with SMTP id
 b17mr361934pjz.127.1599501067954; 
 Mon, 07 Sep 2020 10:51:07 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id ga3sm1651496pjb.18.2020.09.07.10.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 10:51:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/19] target/microblaze: Renumber D_FLAG
Date: Mon,  7 Sep 2020 10:50:45 -0700
Message-Id: <20200907175102.28027-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907175102.28027-1-richard.henderson@linaro.org>
References: <20200907175102.28027-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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

ESS[DS] is bit 19 in the manual, but the manual uses big-endian bit
numbering.  This corresponds to bit 12 in little-endian numbering.
Let the comment about matching the ESR be true by renumbering it.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index a25a2b427f..32811f773d 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -264,10 +264,10 @@ struct CPUMBState {
 /* MSR_UM               (1 << 11) */
 /* MSR_VM               (1 << 13) */
 /* ESR_ESS_MASK         [11:5]    -- unwind into iflags for unaligned excp */
+#define D_FLAG		(1 << 12)  /* Bit in ESR.  */
 #define DRTI_FLAG	(1 << 16)
 #define DRTE_FLAG	(1 << 17)
 #define DRTB_FLAG	(1 << 18)
-#define D_FLAG		(1 << 19)  /* Bit in ESR.  */
 
 /* TB dependent CPUMBState.  */
 #define IFLAGS_TB_MASK  (D_FLAG | BIMM_FLAG | IMM_FLAG | \
-- 
2.25.1


