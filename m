Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC48C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:40:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC48220706
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ioqI5UDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC48220706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqTJ-0006ZF-U7
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4j-0003TQ-FM
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:33 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4h-0006kS-Pt
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:33 -0400
Received: by mail-wr1-x444.google.com with SMTP id o11so9851344wrv.9
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=QI9bNB2EpS4MZeeUod3oWI+GTuJGD4bNcPhcROXkwsU=;
 b=ioqI5UDsqy8wD18Qr6O9qqbqnZFfzrtpxQ4TGDEveTKHRP8aSK0tsTfzmvj/SE9XHc
 k+dITtsv+OKmiFimAXcsyu3fkdZyEPoXNNx1VXYoj1n19Xye4S1KAm29tadHbQh2IsWC
 6N2fTz8Evo4sel7uZtoq+IMBL9MJ3jSRdf0bnY0XZHTqW6N/0Kk4nIh8WVPMUUdCKzkf
 EwPJ/+9ndwFMLYl7iqbbHu1WY9l4M/AL4f9AvuWt0oXnUKXiGjVAdk6VDUpIwtYUsmt5
 ub/He9JimaCJE5/50+GXusxgduypksDxRhpGVPoR8TkX/HmAR2sjn2D7WsjNmQIEFwLT
 PsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QI9bNB2EpS4MZeeUod3oWI+GTuJGD4bNcPhcROXkwsU=;
 b=qdg5OC3AIzr6qVygGoNdg+bltCIeivoY8c1BQpfHoPko14hZHFOfhdDdm24Lmf6oUl
 PayKaAFLuM2WdrrA63M6H42Q3uP3Cbf0qzkYYBEVcHqiD+28H+S/ntaoIOnklt1637Je
 vbHwMg5d942l7c4Tqs7ZlhoDSH3e8b2dr0kjLjihNPTXB4fvQD+00Ivk51vuTtYtElz9
 e2JOvza8LeqL0PtwQ5QFd/vmfuUjvQ8zyDeQgZfqnCvaB7jA8eUdocbDFPw0X3hOIzwg
 YvrAhDwS8li+HvC1HOL8pa/i8+Nsg7ph1d7xY0CFpZl/zlDtWBFBlTtSj61kWUwmPEXl
 toIg==
X-Gm-Message-State: AOAM531iHDDS+aqge1U5lRAusy63DGOgQLQkMtne5ND28ZUQVXBMiO6K
 F8BUvGWRW80/O2Xs5/iIxrrqj4v1ztnoSw==
X-Google-Smtp-Source: ABdhPJx6cRpwV6zWFLeWLT0IruPvgsQPqP/rVQsMeCPX2Y7lEn/mCIGFW2FEAXSFp5Cf1yX/zbeaMw==
X-Received: by 2002:adf:97d6:: with SMTP id t22mr4107725wrb.385.1593184530175; 
 Fri, 26 Jun 2020 08:15:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.15.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:15:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 52/57] target/arm: Set PSTATE.TCO on exception entry
Date: Fri, 26 Jun 2020 16:14:19 +0100
Message-Id: <20200626151424.30117-53-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

D1.10 specifies that exception handlers begin with tag checks overridden.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-41-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 23cf44fcf42..d220612a201 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9704,6 +9704,9 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
             break;
         }
     }
+    if (cpu_isar_feature(aa64_mte, cpu)) {
+        new_mode |= PSTATE_TCO;
+    }
 
     pstate_write(env, PSTATE_DAIF | new_mode);
     env->aarch64 = 1;
-- 
2.20.1


