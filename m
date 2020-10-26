Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6CAC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CE07207F7
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmSh1O10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE07207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXC26-0002tj-4S
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 19:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXBwO-0003Ch-2e
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 19:30:17 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634]:44809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXBwL-0000Jh-Bt
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 19:30:15 -0400
Received: by mail-ej1-x634.google.com with SMTP id d6so11818677ejb.11
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 16:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XhnjuVobHMzU6+7R+rNCPQc+fD9fjM3UbUM8qny37GM=;
 b=fmSh1O100g+ggujU0fOeG1lI443JULq4WW/bGa3PZ4NsygMZjUhUEJ+r1II/W9QVhz
 DgshmaODpuRkjmF9QaubUmAACcq70utUbq4afukVTzpdlwPQJizcFwSO1ptfQNvdAAiC
 QrG4rgxMjz622CdmG3oM9HwsKMItaOjoouqUqhoFhYklIu1GbdQ/Lk54wqVbubYjS28h
 o6MiK3pmzjesXXS0K4H054iTLyRxjgdn5rLAX3M8+cDw3BdwniSsOb8gESc8E+ev7Nvb
 JnGZQrj+tLNm1s/S6zoxBoFXCBS7vjJNOzE7umQ517bSJOdffBb9QVFRGrod+I/+5mPh
 A5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=XhnjuVobHMzU6+7R+rNCPQc+fD9fjM3UbUM8qny37GM=;
 b=kCnE3qWS6HinkYC4BLNIXtPOex8qyYoPq1LnKsqK7ZVJx2w86l3d52XE1U5WFraISo
 IHRJ/pYhDRcjh/Rb36F1zeuuAIOEMEIsumKFtN8tnL6bUP7dbE/YYqj5KcS9jj285xiG
 lBaYSVmbgfy32auKAEuPHc4F4FsKRB+5gn+QVYoVfqYrEXg/dqi5MH/NTL3+5KFPS/px
 NnDxwYbSxQyKMSATzuisHKOV8Mxh6VHffmSY7nSxKiMd6A9+tSkcz1wibHg+fWYrhxbK
 TB+dC6Q7Q2C+bWWx6HAWOVAKDPfdlQaDS6ARBofF4tlw6TUFybgOAjWFvJ+CZcuOh935
 zpPg==
X-Gm-Message-State: AOAM5325HvqwmPT+X+j4+E99VBLULe1PSQLTKCGNGWy2WZWmmxwU/dQO
 JO4Supv7f0I+/Z+8fOoXTlR1apqh7fE=
X-Google-Smtp-Source: ABdhPJxdJ/T0Qj0ELeG+hiYmQBkWvA5R8uuBXtIUB1ZeqFuY3VHcf2hLlB41R7Dx9x8qeJGzQWcwEw==
X-Received: by 2002:a17:906:1b51:: with SMTP id
 p17mr8622847ejg.462.1603755010770; 
 Mon, 26 Oct 2020 16:30:10 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id o15sm6717627ejm.38.2020.10.26.16.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 16:30:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/8] target/sh4: fix some comment spelling errors
Date: Tue, 27 Oct 2020 00:29:33 +0100
Message-Id: <20201026232935.92777-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026232935.92777-1-f4bug@amsat.org>
References: <20201026232935.92777-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x634.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: David Edmondson <david.edmondson@oracle.com>,
 Lichang Zhao <zhaolichang@huawei.com>, Magnus Damm <magnus.damm@gmail.com>,
 Philippe Mathieu-Daude <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lichang Zhao <zhaolichang@huawei.com>

There are many spelling errors in the comments of target/sh4.
Use spellcheck to check the spelling errors, then fix them.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
Reviewed-by: Philippe Mathieu-Daude<f4bug@amsat.org>
Message-Id: <20201009064449.2336-10-zhaolichang@huawei.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/sh4/cpu.h       | 2 +-
 target/sh4/op_helper.c | 2 +-
 target/sh4/translate.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index dbe58c7888f..714e3b56413 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -160,7 +160,7 @@ typedef struct CPUSH4State {
     uint32_t pteh;		/* page table entry high register */
     uint32_t ptel;		/* page table entry low register */
     uint32_t ptea;		/* page table entry assistance register */
-    uint32_t ttb;		/* tranlation table base register */
+    uint32_t ttb;               /* translation table base register */
     uint32_t tea;		/* TLB exception address register */
     uint32_t tra;		/* TRAPA exception register */
     uint32_t expevt;		/* exception event register */
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index fcd9ac7271c..c0cbb953828 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -401,7 +401,7 @@ float32 helper_fsrra_FT(CPUSH4State *env, float32 t0)
     /*
      * Since this is supposed to be an approximation, an imprecision
      * exception is required.  One supposes this also follows the usual
-     * IEEE rule that other exceptions take precidence.
+     * IEEE rule that other exceptions take precedence.
      */
     if (get_float_exception_flags(&env->fp_status) == 0) {
         set_float_exception_flags(float_flag_inexact, &env->fp_status);
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index ec5b04889e1..93127906237 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1960,7 +1960,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
     switch (ctx->opcode & 0xf00f) {
     case 0x6003: /* mov Rm,Rn */
         /*
-         * Here we want to recognize ld_dst being saved for later consumtion,
+         * Here we want to recognize ld_dst being saved for later consumption,
          * or for another input register being copied so that ld_dst need not
          * be clobbered during the operation.
          */
-- 
2.26.2


