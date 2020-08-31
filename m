Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B06C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC5B2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a20srPZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC5B2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmZ9-0001iO-Az
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKX-0004gM-8R
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:49 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:56177)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKV-00061M-I8
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:48 -0400
Received: by mail-pj1-x1036.google.com with SMTP id 2so20236pjx.5
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LC4GQajG5DLWT6OieJHaqxMjuNV3BYGqh/KPNTdIZYE=;
 b=a20srPZ4PiffYT2aLUDso+oU5pqf87z8CeU6XnBiJFEBZOANK86sl/eC4EOf/if0O4
 vNFkxRc//ITmWuGAD/ZWlQvHq939N0ZekTNN7QvJGpzTYCRUIut8I6UQMYJoRms7WB9t
 8k2IKIRv5UcElqcvdq5WiB1h1hTd3FEW6taorbJZiycOUnYMCukK5W2KHMNG1bW3N1W4
 8GZYJdRmyClWF5jdyFoiYZQsUxofb5a4BCDIuQ7zGgat2BKL9kSjIioqwCCtD1pTQe+v
 HhIXrVR4hxnfFih1XFpU/wToLKhuSj0SplqCg3n2l27SZP4bNLYYxTvcNxQO6MY4obPZ
 Nr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LC4GQajG5DLWT6OieJHaqxMjuNV3BYGqh/KPNTdIZYE=;
 b=erZ6pQcfbDWudv+Rg3oR7Tg/PdGVIt/akB82kDsMWJUFvciJlQFtdIk1AbDMxoyhx/
 oOhgv7r7imQwp7pbSTz989d7i/XEOSXsOMCbhPZXbXYndSSWTQJ4jqmw+a2EwppD542C
 fbQJo4VHJIrxwqFEq8wj9Fv01G/MqTSiCW+D+VQsi42ZyzobvIa3MEx/EZitQFmX9y9K
 VP2380qW3pADL3segQe9hOQ73ayV2SfN5+SwJDkhSyTV3r8hBKg4OvWmZ9XgzPh+T5Mi
 4ktO4GId8exUkVtSGgynu6ui4YyLR2Urg3BPXP1jMnmYo207Ev5UClmudUOUgkyduajv
 JrNA==
X-Gm-Message-State: AOAM531W2GIl4Ptm8bBqSOmHGDX+Fzqp3GzXz1Q9P4I3pecMqsUh2PVf
 6q2acRzyj4s//91jdOQeEVOP7Vujo5JtIQ==
X-Google-Smtp-Source: ABdhPJxeuCg22wmjnFhPwkZz/ueEcV36N7yVB7YvMVFR+8F2B4JD4Ge0UDPoDhVYjCmtRlF1s0qQWw==
X-Received: by 2002:a17:90b:1988:: with SMTP id mv8mr82524pjb.23.1598890005880; 
 Mon, 31 Aug 2020 09:06:45 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/76] target/microblaze: Remove DISAS_GNU
Date: Mon, 31 Aug 2020 09:05:16 -0700
Message-Id: <20200831160601.833692-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

This is never used.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index a90e56a17f..6757720776 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -34,7 +34,6 @@
 #include "exec/log.h"
 
 
-#define DISAS_GNU 1
 #define DISAS_MB 1
 #if DISAS_MB
 #  define LOG_DIS(...) qemu_log_mask(CPU_LOG_TB_IN_ASM, ## __VA_ARGS__)
-- 
2.25.1


