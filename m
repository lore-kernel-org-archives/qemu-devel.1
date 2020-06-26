Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBF4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 04:04:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70A4820767
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 04:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RvnyuXDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A4820767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofb1-0008D4-Nn
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 00:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6g-0001Zh-4T
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:50 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6e-00029a-LN
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:49 -0400
Received: by mail-pf1-x442.google.com with SMTP id b16so4033616pfi.13
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8SXI3lbgZ0UAYQNgtyM7Qe9sZGMnhZE8cWfw/l5JLCg=;
 b=RvnyuXDpI+gKZktcyestmDB7I9NQqDabkurOrmxomrmouuZbHMaA5ocFxOB3UhHANY
 qNAQtKf9amHCQUuaZ1iuY39WZ5GlEpfOKRnsYbb0hm4wMiFqFPsJrdDqF59MVvBR18+D
 TfYy8Sv262IQ/ymkMugQIU9b7vubFzs0cUoeZl/cbbKbhazi0yP8VP/hwCzi75+EbsRq
 pvs4CFtW77f5CJgkqoItQPQqPQtqF732F/5yhhxnUcMOvr8ImxeONw7bf8ptAkqhR6Sd
 IefYuSnw5vcPSS/M97+IlkIah2w8Dfriatgqqn3pR5T7C8lLIaK10tR/ObKDBiFAmuJ8
 NIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8SXI3lbgZ0UAYQNgtyM7Qe9sZGMnhZE8cWfw/l5JLCg=;
 b=KSTckJEiKuY/nQ/+w/PtzEJqCVPYYnyM6q05tlw/Fo1tFCPTjWjTrF/ljGL4nyS7sG
 ZjEamE/O7y3UAlXS6NLp8hKLCy4rSTA3p/xMaFpEsArmENzHMDG/36TIQ1IEvV+bXnoZ
 Zq/NCndJLoAUgE/5+cSbBNKZ1WoffBVJAt4qwkPrHiRdU3xW0A4cGFSxVq49k7ECF/FB
 K13NZORyY1yrwL4IrPAEwkXjuhb1qV+waxBtvoqwZCKXlBYutR/EfMGA63u1vX0TBJxq
 i7Nv5COl6/paxvB05CLFWR26sS/ygxF3sLtxdm8Igs3qYhMt1ZlbTfVsNUmA05YaT62H
 +nBw==
X-Gm-Message-State: AOAM532wD6QJ0Gba6LLfIfwQJ0P16ecN0cZvG3yOsxEh5OGfrqHse//K
 nCVyRv33fh383tTXaqFj5UrBBxZFWzU=
X-Google-Smtp-Source: ABdhPJzyIHTyWWHX7DqLWTHh/7I6NAm5DcCGIElu+exjcv2uHNoPy/HBfqsKWd+PLuYSgKkSjk3LaQ==
X-Received: by 2002:a65:6393:: with SMTP id h19mr911005pgv.278.1593142366938; 
 Thu, 25 Jun 2020 20:32:46 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:32:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 45/46] target/arm: Enable MTE
Date: Thu, 25 Jun 2020 20:31:43 -0700
Message-Id: <20200626033144.790098-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We now implement all of the components of MTE, without actually
supporting any tagged memory.  All MTE instructions will work,
trivially, so we can enable support.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v6: Delay user-only cpu reset bits to the user-only patch set.
v9: Add some commentary (pmm)
---
 target/arm/cpu64.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index a0c1d8894b..a2f4733eed 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -654,6 +654,11 @@ static void aarch64_max_initfn(Object *obj)
 
         t = cpu->isar.id_aa64pfr1;
         t = FIELD_DP64(t, ID_AA64PFR1, BT, 1);
+        /*
+         * Begin with full support for MTE; will be downgraded to MTE=1
+         * during realize if the board provides no tag memory.
+         */
+        t = FIELD_DP64(t, ID_AA64PFR1, MTE, 2);
         cpu->isar.id_aa64pfr1 = t;
 
         t = cpu->isar.id_aa64mmfr1;
-- 
2.25.1


