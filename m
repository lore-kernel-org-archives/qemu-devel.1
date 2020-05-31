Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1486C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 13:46:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB48206F1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 13:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAroXM2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB48206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfOIT-0005Fo-UH
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 09:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jfOHV-0004QC-R7
 for qemu-devel@nongnu.org; Sun, 31 May 2020 09:45:41 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jfOHU-0001Io-Sr
 for qemu-devel@nongnu.org; Sun, 31 May 2020 09:45:41 -0400
Received: by mail-wm1-x342.google.com with SMTP id f5so8779413wmh.2
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 06:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FDtt4hhovTOqiq12eFMR0M+ifUtKcmSGgY7FVE6ZkVY=;
 b=MAroXM2P63KdKj9wVN18cTd/u2OzCL712PZJw6zw9fOWBNM8fvJW+31ulAsSRQU+/e
 8c4xPxiKsDB0Vp7yWIAlmO0r8cGAW2tEYFaA/zkowvspTL+t4j2EFxNu9+Jssiu99OH8
 s/Lkbjj6U4jYFsuq2dR6btPVXUZfzYVsBJNjwrR22aG0UMZjXSJoeKBbmWy9YxKePmR+
 w7KyN7WGNBIoqjVk+Aj9Z1AWk3Mbaug+SzfQ9Qwi/AbZzn69I6cNKN0yHLfHhR5i45SH
 zv1Etxxi2i7742FZDbq2ORc0vFi3KUL51zmgxk6GEr8JvIPGv/JGv/vTk0SlOPcnA4zR
 hx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FDtt4hhovTOqiq12eFMR0M+ifUtKcmSGgY7FVE6ZkVY=;
 b=Ct44cztg+KO3sFkApBlXBwiy5QbQX8XZhm8qmNh1SFfy1qbovgYdMHF9oueiBzcdAz
 xi3+phUeVROWMOQzBvqWcWmCDOniv/xZRICRMxtpLIO8G9WujkklY4NVtO3bABzEB8iq
 xD+RmXtL7Cyxlhv6AzmbMye+qlGU6eGsE3WG7QeUfvL4u3ZCVgrz++qHG+fLzvqLeTyT
 r1XD0DzNxo8jZXEPmEVCUUyAO6kzYzxv5mjh328pnAHqQQjMXcZyFJUXTup0HyKqfdQS
 m8P3itKEdXF7xK74zLvDT/+jvZfz2Jyp/DNGRMheal2LEGLAh6x+eFOj0B1p0fWzfGpQ
 4l9A==
X-Gm-Message-State: AOAM530PWEULsQbJMjwqDaBaCodCGLAeTq9AdiVO0lgk9JCq553ckmDY
 j/9WNxImWfkm5cbbTxqC8MpaAYp5/FU=
X-Google-Smtp-Source: ABdhPJwbHvYgOqvCagRIR/jc+aFxnDVwCd7Bvf/bsyhLx/tWkxE+pcjAKOCzdSThaz9ec/cqqyEVpA==
X-Received: by 2002:a1c:f708:: with SMTP id v8mr17021650wmh.131.1590932739253; 
 Sun, 31 May 2020 06:45:39 -0700 (PDT)
Received: from AK-L.domain.name ([41.232.117.148])
 by smtp.gmail.com with ESMTPSA id a15sm18006483wra.86.2020.05.31.06.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 06:45:38 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org,
	rth@twiddle.net,
	ysato@users.sourceforge.jp
Subject: [PATCH v2 1/1] target/rx: Check for page crossings in use_goto_tb()
Date: Sun, 31 May 2020 15:45:12 +0200
Message-Id: <20200531134512.7923-2-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200531134512.7923-1-ahmedkhaledkaraman@gmail.com>
References: <20200531134512.7923-1-ahmedkhaledkaraman@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 aleksandar.qemu.devel@gmail.com, alex.bennee@linaro.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the page crossings check in use_goto_tb(). If this check is not
applied, a number of bugs may occasionally occur during target rx
system mode emulation.
Also, this check is needed in user mode related to emulation of system
call mmap(). rx target does not currently support user mode, but it is
better to prepare use_goto_tb() in that sense in advance.

Rename parameter dc of type DisasContext* to the more common name ctx,
to keep consistency with other targets.

Add detailed comments.

Buglink: https://bugs.launchpad.net/qemu/+bug/1880763
Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
---
 target/rx/translate.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index 61e86653a4..85a884c7dd 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -143,12 +143,15 @@ void rx_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 }
 
-static bool use_goto_tb(DisasContext *dc, target_ulong dest)
+static bool use_goto_tb(DisasContext *ctx, target_ulong dest)
 {
-    if (unlikely(dc->base.singlestep_enabled)) {
+    /* No direct translation block linking in singlestep */
+    if (unlikely(ctx->base.singlestep_enabled)) {
         return false;
     } else {
-        return true;
+        /* Directly link translation blocks only within the same guest page */
+        return (ctx->base.tb->pc & TARGET_PAGE_MASK) ==
+               (dest & TARGET_PAGE_MASK);
     }
 }
 
-- 
2.17.1


