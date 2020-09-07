Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4ACC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:13:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A74CA206B5
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s8v1bztA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74CA206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLeN-0006sg-QJ
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 14:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLW0-0003yj-Qg
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:05:16 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:46182)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLVy-0002Q1-JM
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:05:16 -0400
Received: by mail-pl1-x634.google.com with SMTP id q3so2886622plr.13
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 11:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R/+aDRJdVbA7mUdPidQK/w3cut6NOnimDPbWUZWCJxA=;
 b=s8v1bztAsYrkgNNmQdBmVYSm35EDEmahsrRlbIiZqwWf8TFOiSW0F+ps2O/ZPGyHJ5
 XagUuMnTn/xXEsVHbFVFuryE+6TqX220upji3kd9CgGTBDS1xw1QEnGOBhs+wG+xREzz
 E9MAuayVP2Tq6NJ2exyQyjR2EVE5i1BAqSIRvuciu3BPdy89d5OBS7kiua3kZu3xIzEF
 akisB7K036khAIKLu8Z4ITeykvuE9m9dLxxs2KNCkUNtqaax+lC2TBuPB3WmmGC7kO9N
 PDDsg9et167KjjZN2al4updJ1zHOzvkZXYLqqEeiGXsFD4SXrT2q9TqF8QVoPB5giZKX
 eVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R/+aDRJdVbA7mUdPidQK/w3cut6NOnimDPbWUZWCJxA=;
 b=MqRUayrdfApW1rVTwflrYLy/kXHSl0vwatlJUi6EZlfYNkFiE7qBFOBDe+hEXavu0Y
 ZE5TSMrmjFb1415WDWIIpwWwlBBtGN1PLoOFXUFk0pI3IdenpO/VOTKnB5hSfwny2tCJ
 y5YdrnSiGbbftLKVaAJ7YFtclk2T2d+5T2N+CXQK+y/Nk/usMjC25M8sgLZn5jldZceR
 5X0AjCYfXzGKifh5Wu+vBBVc5i9aK/9A8gH30JpN22XgVynpLsd9+mwngJiLiIPCcB/C
 gsFZ9uFVi/ZnB3NUvxbuxh9cA2ZuNmeaZcrUE01FSkCUMuoAKF/hfINQaazBbHeX8ppw
 ZWOg==
X-Gm-Message-State: AOAM532QSCdGkVWENCzlZG5qOIjiGABK+ioci+sRLXzJ/Y0WPDl83+nR
 L5sFFCsjYKUhiMKclOO1lqAoMBAjOMI2ng==
X-Google-Smtp-Source: ABdhPJwcsBp9v5kR22Zs+M8y0qXr3J9G3uvkpBVHjqI3AmwTELKtksTylSyXdhgzMhKTYOaZ4JHg3Q==
X-Received: by 2002:a17:902:7405:: with SMTP id
 g5mr18579555pll.248.1599501912935; 
 Mon, 07 Sep 2020 11:05:12 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v6sm11367768pfi.38.2020.09.07.11.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 11:05:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/19] configure: Do not set TARGET_ABI32 for microblaze
Date: Mon,  7 Sep 2020 11:04:59 -0700
Message-Id: <20200907180459.29025-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907180459.29025-1-richard.henderson@linaro.org>
References: <20200907175102.28027-1-richard.henderson@linaro.org>
 <20200907180459.29025-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

In 19f27b6c2493 TARGET_ABI_LONG was reduced to 32 bits for
CONFIG_USER_ONLY.  There is no need to set this by hand; it will
now be set automatically by include/exec/user/abitypes.h.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configure b/configure
index 922adbc43a..83bdc91eed 100755
--- a/configure
+++ b/configure
@@ -7749,7 +7749,6 @@ case "$target_name" in
     TARGET_SYSTBL_ABI=common
     mttcg="yes"
     bflt="yes"
-    echo "TARGET_ABI32=y" >> $config_target_mak
   ;;
   mips|mipsel)
     mttcg="yes"
-- 
2.25.1


