Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0404AC4741F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A503207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gl9tzsEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A503207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMwmH-0005sp-Mw
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 13:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwki-0004BM-QF
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:15:53 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:40491)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwkf-0006Lo-Qf
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:15:51 -0400
Received: by mail-wm1-x335.google.com with SMTP id k18so1926421wmj.5
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 10:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kbD39lA/Bt4aiLOqktVNNjYJqK4efqGmJbNwuoiH4c0=;
 b=gl9tzsEg/1a3PWr1gtKO5dRNe5Rwq9b9Bqvyl2OKozX5Y4MQfyZmaATkEhJbnjMbyv
 /BLBgT9j1FRDffWxIjSsGzjTrvxUlnmG3vSI1VNIsZgxTDMovdpChAYly92RG8OGE2Ix
 DOzgwkZCyvcoNQfxYw82ug+FjG8MZpw+LN8pJoougEXBr2VxCik/xBO3kJcPO8HzIjFS
 Wdti+lg0X4lBu2+MsEtoaFpyQ1Fka7Rsb8NdcMm5NKOjrZbyUrpLmRWc4kvG0jUWFoc+
 Lh4pBmqzhM4rEeisWgJ+nGJmADnQbEKooCatqpbmIwLWlZr4XFq7+gIGsVy5LFoYrJij
 znTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=kbD39lA/Bt4aiLOqktVNNjYJqK4efqGmJbNwuoiH4c0=;
 b=OTO7Wf8QioZJzMmtTxJyR7dVhENrA993EAZm0yQtT3nbRLBIaHeUk2vw44ZkS++QIC
 dD7GZ4d/D94wDi5obd57ntlaWDwfnS21mWPHfdC6YeZ/jiI/xigkkvX15D6Aqtnf8jwP
 ErDe5QCahKZnyL4ky+582vWD6t1/pUfX0ZpYViIVsNiulWHtha/Iu8VTjn/8tRCL1tcR
 BonN9qXiCX6e59pu0DN6hi0yFjjKhXDbAlrVzmS1V6h8gvk/P5rH3MDT/sJof6nq1Lgh
 AHDcHkjgloc6hC0NucPx686+01TcBj+GxysJzQVotGIzVuxCd0PShRS4z35MKDQinn71
 dLIQ==
X-Gm-Message-State: AOAM531qQxDlaC5GyE3ONEQRj3i5RWhJoN6AotpQj8ku32cJVEnMXuHf
 qqhruHJM1NL8+A/0rwnzrke40n8MVqA=
X-Google-Smtp-Source: ABdhPJzBovmNdBafTTruSAxg4RxwLabXLBhpBzcJwxkvx4ILGpkJHYpJ3UmnL9mhB525W4lzgfFCKg==
X-Received: by 2002:a1c:9d42:: with SMTP id g63mr241626wme.20.1601313348296;
 Mon, 28 Sep 2020 10:15:48 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id z67sm464787wme.41.2020.09.28.10.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 10:15:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/16] target/mips/cpu: Introduce mips_cpu_properties[]
Date: Mon, 28 Sep 2020 19:15:27 +0200
Message-Id: <20200928171539.788309-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928171539.788309-1-f4bug@amsat.org>
References: <20200928171539.788309-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To allow objects creating CPU objects to set non-default properties
before qdev-realizing() it, add an empty mips_cpu_properties array
in MIPSCPUClass.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/cpu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index e86cd065483..c1c0f2e12ba 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -26,7 +26,7 @@
 #include "qemu/module.h"
 #include "sysemu/kvm.h"
 #include "exec/exec-all.h"
-
+#include "hw/qdev-properties.h"
 
 static void mips_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -181,6 +181,10 @@ static ObjectClass *mips_cpu_class_by_name(const char *cpu_model)
     return oc;
 }
 
+static Property mips_cpu_properties[] = {
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void mips_cpu_class_init(ObjectClass *c, void *data)
 {
     MIPSCPUClass *mcc = MIPS_CPU_CLASS(c);
@@ -190,6 +194,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     device_class_set_parent_realize(dc, mips_cpu_realizefn,
                                     &mcc->parent_realize);
     device_class_set_parent_reset(dc, mips_cpu_reset, &mcc->parent_reset);
+    device_class_set_props(dc, mips_cpu_properties);
 
     cc->class_by_name = mips_cpu_class_by_name;
     cc->has_work = mips_cpu_has_work;
-- 
2.26.2


