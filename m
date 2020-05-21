Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871B5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D0052070A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X176vZ6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0052070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboOl-0007sI-Ey
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIF-0002MU-4A
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:39 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:33066)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIE-0006X6-9r
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:38 -0400
Received: by mail-qt1-x843.google.com with SMTP id e16so118815qtg.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bFdbQSB6mgaVAkP73ZpxdyRWP8s8cwxd+Gs2aZb+ids=;
 b=X176vZ6T83RSIA15N/NW0PIad7u0EDLMItBw7GiLqVzDxhQ5rUJoBbSinbFS9RmW3O
 5pEu29Hg5kDDpl+KCqf5uPt338u7KtIcsvMBVJmqkHneJjCWDd2RnBCxXpck/u/gmJLu
 gJVzzlEp0GfuwDYVDXMSDJ+wZovPT7cXgIMTTSzam29y/76InNUQ2inPYHQkSJGoF/MM
 eUo4NnULI/AWHX32wqqzj7Bx5ZBa2+XqTr6evOzfHKMbcuCi/u4a+rmNHmyPQPK5KMqS
 fXpbFd5tu0wPCqaceVeQ+n647k9dMdy2oxisu965EoFtDZDSX3Xg0ZUe8ddEMePF9pPb
 yIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bFdbQSB6mgaVAkP73ZpxdyRWP8s8cwxd+Gs2aZb+ids=;
 b=f34XcuSTF2qMpftDiuwPT8SUcOeUVcWknDVelVRae9IvHli84l7PrQcdpAa52PTOz8
 NQsuwUY6L8AzJD80ca69TurwYRPhRRJhn2jPAVbNuT+4W/4ukOW2+Fl5k8PmdDI4QDwp
 WMnBSuQNa/eN/5mrMkW+OeFh+T7Om+6H4lVFDCxLj2OVA5DlLBvEbiZpnJ3vqKUPY1vE
 ZWoW002J9Dyyaujr9e+9Filixd1KseLjjicfMiCD/D0szXlhxl46Qzlx4rX9MnMVoLGB
 bvsy1zibU55hJ+ojr6dHJyxt3EXwH7BJk6r/AE9Mbsr1otd3qJ705l09Ecw96bUiQbT3
 xiSQ==
X-Gm-Message-State: AOAM533/h2/j2TlBPff96SM6NQzotveLkBaBTuY3Z4LMDNQXasGIj4im
 v/GdRu2y+gOjz0lFxF6P5r0HF09xI/m1SQ==
X-Google-Smtp-Source: ABdhPJzS/kIh+IDgTtCgFcgdrgQokicAItbq9vmZFTfp4mz7mBLPtsp9uLt+LBF76wjN5f2X6bOnpw==
X-Received: by 2002:ac8:326d:: with SMTP id y42mr11349417qta.243.1590079417200; 
 Thu, 21 May 2020 09:43:37 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:36 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 17/74] hw/semihosting: convert to cpu_halted_set
Date: Thu, 21 May 2020 12:39:14 -0400
Message-Id: <20200521164011.638-18-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::843;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x843.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: richard.henderson@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/semihosting/console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
index 6346bd7f50..f70085f3c1 100644
--- a/hw/semihosting/console.c
+++ b/hw/semihosting/console.c
@@ -131,7 +131,7 @@ static void console_wake_up(gpointer data, gpointer user_data)
 {
     CPUState *cs = (CPUState *) data;
     /* cpu_handle_halt won't know we have work so just unbung here */
-    cs->halted = 0;
+    cpu_halted_set(cs, 0);
     qemu_cpu_kick(cs);
 }
 
@@ -154,7 +154,7 @@ target_ulong qemu_semihosting_console_inc(CPUArchState *env)
     g_assert(current_cpu);
     if (fifo8_is_empty(&c->fifo)) {
         c->sleeping_cpus = g_slist_prepend(c->sleeping_cpus, current_cpu);
-        current_cpu->halted = 1;
+        cpu_halted_set(current_cpu, 1);
         current_cpu->exception_index = EXCP_HALTED;
         cpu_loop_exit(current_cpu);
         /* never returns */
-- 
2.17.1


