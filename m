Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256C0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1BA82075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrrC+YyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1BA82075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb5yA-00062e-4c
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 13:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jb50O-00007m-1r
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:22:12 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jb50N-0008TY-BO
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:22:11 -0400
Received: by mail-wm1-x343.google.com with SMTP id u188so4339225wmu.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 09:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WgQ2lUBbzmR6637b2t29iBGO13yjSvaFbByDwQhQzFg=;
 b=IrrC+YyDylJ0xTeut8LfctSaF1PoN+zl/oGoisV235QyfWQzbT1Pa9xMSzo3R1TQz+
 wxqScfSsdQ0Frkcqibp+OAYi6TQH+ttiky7pjL06obmspCA0Yk5so1FfRTxVNoz4IDEI
 NnVpMtfikiP1XetLexqUX1uWSCmz+v8neHbiXVWOSu/tuYV3N22bwkA8qJ1cWbJwNl/h
 CKssA5we1cZiMHhDWZmP77b+i4TbR5sMDZrFIpTEdznzsByqUc2KCbjsdpCUPDJTf9WP
 +vsHBwiL/ngCF2hlwE350MTOpv7qu/mpUgT+C8EeD28ekh+edEx6TX5wXffaYCmtVsS4
 yr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WgQ2lUBbzmR6637b2t29iBGO13yjSvaFbByDwQhQzFg=;
 b=qnDoq2q7BVBYvt1fmo72re+HDVJqgeBCgXLNEg5omAwxv9AR7wcVmc5FuEWt9AG2MT
 2wCYpqpIT8p6JfuLA4mYKfVErW6oVLGBQ8hIXqCFPixO+frcYGJDGLjLPQrVw4Dod25p
 8VES7mnKKcrS1C2aCU7cBbRehn8XDSwkKKYa9WUSbC9K2gcis1BlyToSZLxFhqNsDO7p
 tKrPaBJDExWcohhS6l6Ftsx/3dFK32SufxfsqyqZGgUJAHuP4BWv0/SlQxBfWFJNiage
 zCC/uBEkWS8r8gCdrJDe7PLvqyZo8T+sVkChm0yPyPDnbaQ9M7PhqG6b24Vu9eSMt64B
 Gd/A==
X-Gm-Message-State: AOAM533W+AKmE8gl9fI6++uM07XjF6bnoKfSO9BMHScvZMhCQluAuAmd
 NtHR6xJbo+6W+e1Hvr9AZGKXHiQK
X-Google-Smtp-Source: ABdhPJwTRG+6rnYSZ3MXVJiq9gH0GAyvtyOB1CdM7O68Rz1KxD5uPxue/kVLpMFjF7KgWZIzz75v9Q==
X-Received: by 2002:a05:600c:2c53:: with SMTP id
 r19mr173209wmg.83.1589905329663; 
 Tue, 19 May 2020 09:22:09 -0700 (PDT)
Received: from AK-L.domain.name ([41.40.225.250])
 by smtp.gmail.com with ESMTPSA id j190sm202729wmb.33.2020.05.19.09.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 09:22:08 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org,
	rth@twiddle.net,
	ysato@users.sourceforge.jp
Subject: [PATCH 1/2] target/hppa: Check page crossings in use_goto_tb() only
 in system mode
Date: Tue, 19 May 2020 18:21:43 +0200
Message-Id: <20200519162144.10831-2-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519162144.10831-1-ahmedkhaledkaraman@gmail.com>
References: <20200519162144.10831-1-ahmedkhaledkaraman@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_BL=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 19 May 2020 13:21:16 -0400
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

Restrict page crossing check to system mode only. By doing this, the
hppa target performance in user mode improves by up to 6.93%. Of course,
the amount of performance improvement will vary depending on the nature
of the hppa executable being emulated by QEMU.

While doing this correction, this patch adds some more verbose
comments in use_goto_tb() as well.

Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
---
 target/hppa/translate.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 52d7bea1ea..7c9180cd76 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -817,10 +817,20 @@ static bool gen_illegal(DisasContext *ctx)
 
 static bool use_goto_tb(DisasContext *ctx, target_ureg dest)
 {
-    /* Suppress goto_tb for page crossing, IO, or single-steping.  */
-    return !(((ctx->base.pc_first ^ dest) & TARGET_PAGE_MASK)
-             || (tb_cflags(ctx->base.tb) & CF_LAST_IO)
-             || ctx->base.singlestep_enabled);
+    /* No direct translation block linking with CF_LAST_IO or in singlestep */
+    if ((tb_cflags(ctx->base.tb) & CF_LAST_IO) ||
+        ctx->base.singlestep_enabled) {
+        return false;
+    }
+
+#ifndef CONFIG_USER_ONLY
+    /* Directly link translation blocks only from inside the same guest page */
+    if ((ctx->base.pc_first ^ dest) & TARGET_PAGE_MASK) {
+        return false;
+    }
+#endif
+
+    return true;
 }
 
 /* If the next insn is to be nullified, and it's on the same page,
-- 
2.17.1


