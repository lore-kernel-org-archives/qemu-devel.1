Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02528C54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5DEC20735
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbL09V9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DEC20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8EB-0006DD-SZ
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amanieu@gmail.com>)
 id 1jY8DU-0005eS-LV; Mon, 11 May 2020 09:11:32 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33735)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amanieu@gmail.com>)
 id 1jY8DT-00017X-Uz; Mon, 11 May 2020 09:11:32 -0400
Received: by mail-wm1-x342.google.com with SMTP id d207so3904014wmd.0;
 Mon, 11 May 2020 06:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qV+WPsyPxR6+lt2ti2yn0mOEjpo225y5D7KTke+SxoI=;
 b=EbL09V9B/eLfPenF2TnjUhuEkhV+qymLv3U7PpNKuamXivLL5QDmRIdlUKgYRrI5fQ
 SkzE+PSWvkeEdhA5bsVkuAzQigpQE3hjbGBjZV0S9VanIW0FKscmM5EDnfyy5AjfGe1T
 U20hKxdbWYgrNY6/nKvxU9jiL75kKVI2yPgbqIrnMNs8etHFLpysxjw4czh25V1TU4St
 rNhi9VgmC07CJaclTm6BEp5JYdrnQbS3WzL9IH0I1qLCz4BemGAd3cM5cB9ikxfkvy6Z
 QL1WvxYGNqOpdwMS2Q3azQ5CNqcWXCxG4HOmQnXU4eMTU9w2oAyKdkiOMShE3udJkTvn
 lqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qV+WPsyPxR6+lt2ti2yn0mOEjpo225y5D7KTke+SxoI=;
 b=sHbpTUWlZz0+aj71B42V1JV+AnjpAyofTo6MjOHzsfFXEmhIva+Tx/RKh151Su+WwH
 k6Aa3Rv5xYF6e35+bK4Yyv2G6xkckSMX/oNP6KLHRpWSk7wfzKkwZPn0ckHZzZ7UEs6d
 0gekZ4m5n/tLC1p+7CicHiQmEEVnLf7QzvnaaqQFiiFDFMnSUgSui5ajc0JnMygtRVQ1
 S3vl1IVWmNK/5J35D3R/aYa1pFz3vQz2exvxVFfG62X01jJIxGaHsDyxrChb4dgtJCEK
 GRez7oBBVyW3bSzHfgSH82Uwm6WNO7o+I/7qiGEkLjgpLTi7y4b8/C6KslVKw8gH1syi
 bjrQ==
X-Gm-Message-State: AGi0PubiRChtmLihQ+UmM24pfO1XjqXWtv1XuE6R+A3lhK0hu+ui+89s
 WbFxXKJgqX9ivRkISvdFaH6V5TCnt4g=
X-Google-Smtp-Source: APiQypKQ4qH2xPrj8fLnpWSk0Lnt+EbFXPgwlcG1BEFj4f0fs0Ee/wxBuE0Zc5wBBvNkQSbyxjzNPA==
X-Received: by 2002:a1c:7e82:: with SMTP id z124mr23960192wmc.53.1589202688548; 
 Mon, 11 May 2020 06:11:28 -0700 (PDT)
Received: from amanieu-laptop.home ([2a00:23c6:f081:f801:76b2:7504:9791:6959])
 by smtp.gmail.com with ESMTPSA id
 a7sm25831081wmj.12.2020.05.11.06.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 06:11:27 -0700 (PDT)
From: Amanieu d'Antras <amanieu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] linux-user/arm: Reset CPSR_E when entering a signal handler
Date: Mon, 11 May 2020 14:11:17 +0100
Message-Id: <20200511131117.2486486-1-amanieu@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=amanieu@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-arm@nongnu.org, Amanieu d'Antras <amanieu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes signal handlers running with the wrong endianness if the
interrupted code used SETEND to dynamically switch endianness.

Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
---
 linux-user/arm/signal.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
index d96fc27ce1..a475a103e9 100644
--- a/linux-user/arm/signal.c
+++ b/linux-user/arm/signal.c
@@ -244,6 +244,11 @@ setup_return(CPUARMState *env, struct target_sigaction *ka,
     } else {
         cpsr &= ~CPSR_T;
     }
+    if (env->cp15.sctlr_el[1] & SCTLR_E0E) {
+        cpsr |= CPSR_E;
+    } else {
+        cpsr &= ~CPSR_E;
+    }
 
     if (ka->sa_flags & TARGET_SA_RESTORER) {
         if (is_fdpic) {
@@ -287,7 +292,8 @@ setup_return(CPUARMState *env, struct target_sigaction *ka,
     env->regs[13] = frame_addr;
     env->regs[14] = retcode;
     env->regs[15] = handler & (thumb ? ~1 : ~3);
-    cpsr_write(env, cpsr, CPSR_IT | CPSR_T, CPSRWriteByInstr);
+    cpsr_write(env, cpsr, CPSR_IT | CPSR_T | CPSR_E, CPSRWriteByInstr);
+    arm_rebuild_hflags(env);
 
     return 0;
 }
-- 
2.26.2


