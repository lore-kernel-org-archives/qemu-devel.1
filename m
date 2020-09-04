Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CC1C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1881B20684
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yaSi5v4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1881B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEH84-0006Nz-5h
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 15:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH54-0001gL-27
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:09:02 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44128)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH52-0000of-4c
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:09:01 -0400
Received: by mail-pf1-x444.google.com with SMTP id o20so5107002pfp.11
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 12:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hA0Q3ZvS9ZMt8mExwk35iB2Bwjpw4Nf408fgP9XSgOU=;
 b=yaSi5v4VF54FRNN7slfKtz7hCHljk4RfoQqRR5KR6oDsfB/vwDMRogTKPKNOo3OCS0
 od4eFLgXKVe++ec0mAXhhScfwwYk/a1e5EQzWD7NAmntRMOS+A0Ae6eCsPP8lrhuPJew
 aQ+xEDl0tm5+MlgMq38xZ6M+bZWa1aIBgfA0dfqrbUHKaE5aBqHL5hi418WGeZsfO/bi
 Jc7JPwYe3VEEVjKQeY5YB+i3HibCtYEaWu9kY9/HMS7Akl1PwUyO5WSHzglJJo3Dpt/c
 I4XlXBCLi2WY5Bk9jpwImsTerWrRWGEbePHlIHJ3gvxet01szBUR4hBaTomIyvZGQMmy
 c6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hA0Q3ZvS9ZMt8mExwk35iB2Bwjpw4Nf408fgP9XSgOU=;
 b=Bzx6jrIKOsWd5iSoRMMDq6iihJ82O+ChhtWMswl2en1mlvOjNj5E+/QBu2ViVqaqio
 1lZMnMmgtVoxgMnRes6nU6XCuJPBVD+oWsTLnGKIfy/ynP8dvRRrKVLe0Ysb2hwdUs+B
 1tJBxKfZ42yXwokJ57ukIfTZhkcm2TBst3QgOwj80Skf6rw3FsSd0do2gTG2UUIcyka9
 svlZlszt8VsaHU2+6XFZDrScJ5/Nkd5nuIJVey9SH/ZPuMafqMwXY739QmtNeivZ23UG
 fk4VX3whQRvR4hdLOCk/MoKP9ek2N8Z62jVrtAOY2UZrSbmkBu3Xb8LLeyFkyhtGWqrS
 TKdA==
X-Gm-Message-State: AOAM530sQ88QfObqBVOz/70b9X4Th4u0Mreumks6ZIlHZnmXgnf9jpsn
 WXgM+9rAX4Wo+Z+rHPfdSQlpJOx5LloztQ==
X-Google-Smtp-Source: ABdhPJwUGtlumyDUK9bpizDElKKodM5ayECPWHzlcjx8wmXJjOV424hwk27bP7jlYT9q0tKCDlga/Q==
X-Received: by 2002:a63:c30e:: with SMTP id c14mr8243673pgd.225.1599246538513; 
 Fri, 04 Sep 2020 12:08:58 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x19sm1897941pge.22.2020.09.04.12.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 12:08:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/19] target/microblaze: Use tcg_gen_lookup_and_goto_ptr
Date: Fri,  4 Sep 2020 12:08:33 -0700
Message-Id: <20200904190842.2282109-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904190842.2282109-1-richard.henderson@linaro.org>
References: <20200904190842.2282109-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: edgar.iglesias@xilinx.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Normal indirect jumps, or page-crossing direct jumps, can use
tcg_gen_lookup_and_goto_ptr to avoid returning to the main loop
simply to find an existing TB for the next pc.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index da84fdb20b..d98572fab9 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -147,7 +147,7 @@ static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
         tcg_gen_exit_tb(dc->base.tb, n);
     } else {
         tcg_gen_movi_i32(cpu_pc, dest);
-        tcg_gen_exit_tb(NULL, 0);
+        tcg_gen_lookup_and_goto_ptr();
     }
     dc->base.is_jmp = DISAS_NORETURN;
 }
@@ -1803,7 +1803,7 @@ static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
         if (unlikely(cs->singlestep_enabled)) {
             gen_raise_exception(dc, EXCP_DEBUG);
         } else {
-            tcg_gen_exit_tb(NULL, 0);
+            tcg_gen_lookup_and_goto_ptr();
         }
         return;
 
-- 
2.25.1


