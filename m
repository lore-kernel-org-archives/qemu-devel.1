Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39094C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05459206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NQfygxxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05459206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYXE-00053W-69
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKC-0006ZZ-TA
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKB-0001Vf-Qg
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:56 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:42621)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKB-0001VM-Mg
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:55 -0400
Received: by mail-qt1-x844.google.com with SMTP id t9so6522247qto.9
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Ja5jtqBc7H99f27FAjdrB7FncoyyAxec67WX9+PhDps=;
 b=NQfygxxJFmusy3RgjUq6zaZAmnBBDKaMp47ANLxKsvYwyQyB7p3Sm9NZa37/ruJdmY
 80uErA9Muspj+zA9p8glIeK9uzQr4AMhnVT4+ZleafJJ7/fsjgSLQkxm3AV0n/gsrhe6
 9g9KWzJvtX4tq0LbBO6IquZT7NvoGIVLDaP0puI9l5LeMu3pBkbL8G3O29r/Ib1x/UIw
 cHQ2nxzWPRR8L2sA25XRHa1NCv01Aj1QeL3M3InKzo8BToNHabemn4e1whlwi1x5ot5i
 MsEDRaCWQE2TphWcNPGg92SDU8QnhY+96P+DobOGrIyUIfILpbx5Jbl/H21DIvqvO79u
 h+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Ja5jtqBc7H99f27FAjdrB7FncoyyAxec67WX9+PhDps=;
 b=bz/km7Vcn8rrEPAUUXNvo90HZHE7006YZHOicTBcvsHXLN2E3fSY9XSiPi7gQ1sh2a
 5krRi00WIodOl1YTQmZyAhxop91I4LRuFcFZv9zBzXyeaw9wxSNdIcdpFPZ8b8jroI6U
 +BeN6Um49o9mrG7ZqS2xInIweiWoFaPL4XzvD7Jt0oqWG8pfxi78bq23LPf14sl4iUq4
 BtikRFEt55bViMc7lBn2+Auc9mk6Pm4PjpiBI8BTdztV4zLVFup7JBk/9YC0fkXaJ17C
 habXEgJpwmA9WCXK+TEaZhHNNT6l4Krsp5IWOcuiU56grT6ApQxEHX6G6Yw8OL3xH5Et
 1bCQ==
X-Gm-Message-State: ANhLgQ1qTYyCvCZmrvkgyPEclcgHoOcR9UscAEbA9JjIGbmqSrJ/YLIA
 oukmgllwGqkXPkYqKwaln5nnTv2Fz/6+Vg==
X-Google-Smtp-Source: ADFU+vuzsVUqu/6su+glkGW68YG5QEMpQr4BZoUGrl5JGBUa2VHJiuB1fViFIF9cwJq7WmawEsG8ow==
X-Received: by 2002:ac8:748d:: with SMTP id v13mr10390444qtq.390.1585251474881; 
 Thu, 26 Mar 2020 12:37:54 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:37:54 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 17/74] hw/semihosting: convert to cpu_halted_set
Date: Thu, 26 Mar 2020 15:30:59 -0400
Message-Id: <20200326193156.4322-18-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
Cc: richard.henderson@linaro.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Robert Foley <robert.foley@linaro.org>
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


