Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526F9C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A502098B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dz4gDTBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A502098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfUB-00072S-6b
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDi-0002uf-3C
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:42 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:39416)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDf-0008Sd-Sw
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:41 -0400
Received: by mail-qt1-x841.google.com with SMTP id k22so2752340qtm.6
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Vm7jFPC3E4tKVChYDNiheUybVx+cA91nQK1Z4PmgN4c=;
 b=dz4gDTBPsD18T3Jayz0+UMxJvvLmkge2RVqGqhqy7tNMCT8cngvkz43bMlSqYwKNWY
 zaAdaU4Oj4V8J6wmSlQDg5uqY+sBUYWOmbvlu5Q4in73BLiwvGZsDdA+lY98aFQckC6Q
 8YO0/A0ssfFJFohg4VdBqI2QR2DNpzxuh5sz09A5aZSS8EXs82w/QMi7MhhEsP5bYp9K
 fJlODxSPzYmfKakZBh9h4hKaIOUFHUayYnmhBqv/ozlKy+hwePlv3Kp9krckIA88qe8F
 QBpmI2pEAX8UvUhbISrebCG3s0aZd53QbZKgwIwu1RdpjPvYm9ndQfgxylpu9BCl3VjH
 jClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Vm7jFPC3E4tKVChYDNiheUybVx+cA91nQK1Z4PmgN4c=;
 b=TWUU0xoGTpU8Sw/BlRT1mNR3SoXM6hGWhUDHIKLogHP+QHYvM7+KxTyFAi9Tdh3HgT
 BxMrIqBH0+Dty9tWA26Ad1RIil/YE/fU+IgS+YCFTnLBr2BUZ3r0Sh2jLckIr3JVcy2Y
 0OLbJI8rXIoEg8wquomEj1npHBPkAi1xJIMWnO18XzN4t5kCtN2jhiGxPQYpMTaZRAui
 /l/3R4CKOoVtcEZBPnvXyJngzchopz8IvQJHop43tTA5DZrQEADnUDT6qNlffxcWylqT
 8cC0jWYaVFA653qiZpdHlChLUzlIlpVBK9506dX5U1PTBef0XGQ9RUUgkII/2w8ysTQE
 z9Ig==
X-Gm-Message-State: AOAM533iLD7C1I8qgTgtU4XgHNOl9K4kl2Jt2UZrrxr5mW7Z8ceLuAnr
 C/a4zH5lH8A0RoFhV+Sg7FmWMLpucXD74A==
X-Google-Smtp-Source: ABdhPJyR200q311vm/KlL44kfm4YHNTK9/UoI7pDxirR6xG1gwU+vX9FAJqnzFfIwSL+ZGBfmRsKkg==
X-Received: by 2002:ac8:1285:: with SMTP id y5mr1096548qti.245.1592427818712; 
 Wed, 17 Jun 2020 14:03:38 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:38 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 16/73] hw/semihosting: convert to cpu_halted_set
Date: Wed, 17 Jun 2020 17:01:34 -0400
Message-Id: <20200617210231.4393-17-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::841;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x841.google.com
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/semihosting/console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
index 22e7827824..01cafa4bca 100644
--- a/hw/semihosting/console.c
+++ b/hw/semihosting/console.c
@@ -130,7 +130,7 @@ static void console_wake_up(gpointer data, gpointer user_data)
 {
     CPUState *cs = (CPUState *) data;
     /* cpu_handle_halt won't know we have work so just unbung here */
-    cs->halted = 0;
+    cpu_halted_set(cs, 0);
     qemu_cpu_kick(cs);
 }
 
@@ -153,7 +153,7 @@ target_ulong qemu_semihosting_console_inc(CPUArchState *env)
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


