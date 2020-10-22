Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D532C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 10:16:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC2F2419B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 10:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2UnRY9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC2F2419B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVXeM-0000eg-HH
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 06:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kVXdn-0000EZ-Hp
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 06:16:15 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:40726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kVXdl-0004hS-Th
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 06:16:15 -0400
Received: by mail-pj1-x1043.google.com with SMTP id l2so729391pjt.5
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 03:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=/mU1ILRS8rfSLtKIKKtvN0NpPwtch42REJWHZodQfho=;
 b=r2UnRY9/+GaMysxcN4EuHBf/zm72f5DLKYFWiD5FBVLbgJ7VJ/fxgoJwAWhXIia8NE
 0toNJWhay8NjYHVj+Xsm+B7wI2BAYfBE14JhZCawuNtkS1tzQJC/5V/dF64DilIVrFoB
 su1AJIRT6bSHWzanVzbS/yl9PgOnl9Bf4tGMrYBE+6/aD5nKeZg+Kf45YUeXcDcVp6Bd
 O9gDa3/8pTNy+zwJoXEZkRI+RhBZkOqC0TQ7GWWKVm4L5/n7FTDU997itvvnR6I3Ltlm
 aAaCDhmMsJ6ggpUb3Knqj2foX/rg4OpLkD1suotp0AlStTfLpCENPJKhCmIoU4gpCAjK
 Eo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=/mU1ILRS8rfSLtKIKKtvN0NpPwtch42REJWHZodQfho=;
 b=EcpLiNZ5cD4ZgbS6pd74gDTURvfwHsl1f7UuVCd3G1ZkTGrLsttTz/YibeQHSbLbxK
 osSXuZ2rtgEh6CiWflxQqDwmmFXw4SfdBJdbqtAlh+6M3zVgcBQS0FJPRWn91A+vsBSQ
 cQyzhsrBKQgP8eXsgoCKQxRS7OpdVtTAmdLkbSK3Hylj3dDjs6kvIFXZbws+fh0c98ci
 jN+HuTVUjpmojbeof0BC4SkaiRia8fMBmmY1yHJZDTdeibiLHwLp7PTX9WYC+fUYYEtW
 Nlv4xu5MGx/8p88GWcoaJloWJYJZ3/AJsWEQ6mrFWtO0mmPYwxujU4tLEMtopfKoKwRO
 Q5uQ==
X-Gm-Message-State: AOAM533BMXksKjwvlfkdgsEBGKH4Az3vwB1CEAiK+9LDXKzAL6DREZ1Q
 yM/X48HHvyxgJzosq7hzIvU=
X-Google-Smtp-Source: ABdhPJzUpYcG6i+DjmJz7wQeD8QddB83x9az/VEUONMEwVDQX8oexnXj9/Yxft5kFewDVDc6uzI0Lw==
X-Received: by 2002:a17:90a:e147:: with SMTP id
 ez7mr1754836pjb.72.1603361772252; 
 Thu, 22 Oct 2020 03:16:12 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id c13sm1639349pfo.35.2020.10.22.03.16.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 22 Oct 2020 03:16:11 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Subject: [PATCH] target/i386: seg_helper: Correct segement selector
 nullification in the RET/IRET helper
Date: Thu, 22 Oct 2020 18:16:02 +0800
Message-Id: <1603361762-43062-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Per the SDM, when returning to outer privilege level, for segment
registers (ES, FS, GS, and DS) if the check fails, the segment
selector becomes null, but QEMU clears the base/limit/flags as well
as nullifying the segment selector, which should be a spec violation.

Real hardware seems to be compliant with the spec, at least on one
Coffee Lake board I tested.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 target/i386/seg_helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index be88938..d8766d8 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -2108,7 +2108,10 @@ static inline void validate_seg(CPUX86State *env, int seg_reg, int cpl)
     if (!(e2 & DESC_CS_MASK) || !(e2 & DESC_C_MASK)) {
         /* data or non conforming code segment */
         if (dpl < cpl) {
-            cpu_x86_load_seg_cache(env, seg_reg, 0, 0, 0, 0);
+            cpu_x86_load_seg_cache(env, seg_reg, 0,
+                                   env->segs[seg_reg].base,
+                                   env->segs[seg_reg].limit,
+                                   env->segs[seg_reg].flags);
         }
     }
 }
-- 
2.7.4


