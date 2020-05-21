Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31747C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:20:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBFDC2072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OETcZUng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFDC2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jborP-0003E8-5f
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJK-0004iL-Is
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:46 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:38358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJJ-0006ri-FR
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:46 -0400
Received: by mail-qt1-x843.google.com with SMTP id i68so6009353qtb.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6TzpYxGK0GGtfS/yX1tAPOw7mokCgDn/OgQamWItqo8=;
 b=OETcZUngW8+ch1W5uE52zNiye3q1W86VbkyEv5+fZbPKIvyJ8FqVOOeZo6eM67GIa3
 eUf4HSTMgUepe8mDcxX3dbJUgBKa09kkL6HRaYKXIY3yOdIu7KB02ecI8czeI62YHRPE
 oKQ8N4VxjagC99xTXzKcgulzWJmJkTPuxPT3r6o7kLOTz62sQ4VeiX5UTaNdhciNdY+1
 4GcWSAU404xmKt8uCXIiU26rR9816/ZULVQamL5aihOYVKGZa+qzDmtKV91i8iR7f6uZ
 x4/RiSIJFqMxvMyllcrFu+dHqRKRnFTrum3UwYRf99Dg7rKOOX566s9/cqJM0lW6lw0g
 XC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6TzpYxGK0GGtfS/yX1tAPOw7mokCgDn/OgQamWItqo8=;
 b=of/8UV8QSooBxpikm9mbIacL14BQ75BtmlfczKEWCb7MPuWpHTbWaVe4C9+fQTVGFJ
 bc1Mmg6S4/7Et+VgqBYn3cJSeSYUL5F9DZFd4PdO6xQEJQ4sZSofF6/Wx0IXIYt17tM3
 wmXftrzenQitKqEy4FarZ5Z0RV18opXxZGiU65AkDL6i33++1uNbBMUZvItYTka4XMZh
 R2hzizWanBRF/S40BIst1h90Y3y/b4NMAb0Es4C0eXAtl2ecdkTqeU1OqKd/QWb5FS4I
 xp5az1ka+/s8RqGTaCM0vGM6bONeZ9MQI+kIPoDBpMhQ1/4+/TqAZzLLwM5m2J+ZFGi7
 MMHQ==
X-Gm-Message-State: AOAM532FSXqgXOdDd7H8q5f7f477m3Z5zyzgI/tQ9XZaJkt0XkLM18hZ
 Wy8yAagjZCABjqVumQuvKB+cAQKLX2xELQ==
X-Google-Smtp-Source: ABdhPJwCVdm4ttUpG+5C4hsMaCbaRlO93N/CTXcAeNfp16J3FqN61YkaCfNzlinFeDjcYA7b/SohSg==
X-Received: by 2002:aed:3047:: with SMTP id 65mr7307271qte.277.1590079484343; 
 Thu, 21 May 2020 09:44:44 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:43 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 67/74] riscv: convert to cpu_has_work_with_iothread_lock
Date: Thu, 21 May 2020 12:40:04 -0400
Message-Id: <20200521164011.638-68-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
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
Cc: robert.foley@linaro.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 richard.henderson@linaro.org, cota@braap.org, peter.puhov@linaro.org,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Soon we will call cpu_has_work without the BQL.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/riscv/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 059d71f2c7..87827f69cd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -323,6 +323,9 @@ static bool riscv_cpu_has_work(CPUState *cs)
 #ifndef CONFIG_USER_ONLY
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+
+    g_assert(qemu_mutex_iothread_locked());
+
     /*
      * Definition of the WFI instruction requires it to ignore the privilege
      * mode and delegation registers, but respect individual enables
@@ -524,7 +527,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     device_class_set_parent_reset(dc, riscv_cpu_reset, &mcc->parent_reset);
 
     cc->class_by_name = riscv_cpu_class_by_name;
-    cc->has_work = riscv_cpu_has_work;
+    cc->has_work_with_iothread_lock = riscv_cpu_has_work;
     cc->do_interrupt = riscv_cpu_do_interrupt;
     cc->cpu_exec_interrupt = riscv_cpu_exec_interrupt;
     cc->dump_state = riscv_cpu_dump_state;
-- 
2.17.1


