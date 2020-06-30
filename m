Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501E7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:01:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12FEB206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPDsQL2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FEB206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqMRq-0004c1-D1
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 16:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqMNq-0008IH-UU; Tue, 30 Jun 2020 15:57:34 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqMNp-000459-Aw; Tue, 30 Jun 2020 15:57:34 -0400
Received: by mail-wm1-x343.google.com with SMTP id f139so20772138wmf.5;
 Tue, 30 Jun 2020 12:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iFQg1LbB7oBkec8SsW9c8MK3l/Vx4TGs6vo4R9ShZxw=;
 b=FPDsQL2xp+oHqcUjDOd1EGwxl0TNI6zelCf94c9ssNR0ni2Gj+sKEzXAacn4qMHNNl
 dD8qOBMs7O6xolYUaztQpFdjLFM90Rdh15hEtLQzR+A/N69wvfXtWIflA8y9dhF+2f7N
 RJHRB+8pij5SURMVoAQGJOHGVG1GjW2zN50cg+yT07QxQtU/gq70erYpTnHDnl0yvLIC
 kTsnTP2mNpxdwiI7MOzbYRld+UzpHmln6vJqLv4VG9MUjmxkgOv5r5Oy41PDogQ/bV78
 QExHJ2h/Pf2LIjASHeJpfHf923MEeaeZZIUv7N3Ya+6Di+7E05nL8imFT2MZkRt1bbeh
 oAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=iFQg1LbB7oBkec8SsW9c8MK3l/Vx4TGs6vo4R9ShZxw=;
 b=VetMNtfUh4Kj77WrY2FhhMQyRuU5mnlvgw9L7I5K3yFT7Y3v+X7Mr2TmEcsp6vpsyC
 E6EQi9cyztvJg/LQCvanH8wgZcWp/luzCEOhB3kHkX7hkocH/QhKUQRg6Ll0TOqbhLNr
 3UJhHpOZhao9VHJ2UAE7mTJV4FjNzXcvCp+8B4s+ZprHRuwtr3jogiMvUDR8WifK7G7S
 Gv1bJVyfpCPGD8qcs4CJ6PdU9FdhzI9kh+V/NTneslNVmgpa+gysUfNcmTWoZqn0P3+8
 YRl1Wf+7YnbNaVAt3lkw0gsldKGbKwUr/z8tcTv4ZT7eyGnd1umqcU0lb/0jnyrBMBAM
 7tLw==
X-Gm-Message-State: AOAM532Vbir3EFGmhOSR1NqwxXrCvvthlnAvljP0TjCknMKGUVspqDGU
 WPicPUDvtgVx/dJ5mNMmGSJGoJN6ogs=
X-Google-Smtp-Source: ABdhPJyZD8J1RdqAOXU6Zegu7pmBx7Jmt8x99Z+U8qagNZgEX7gN3VgTkCF1LLJjVlSkM/GyBXEJLg==
X-Received: by 2002:a05:600c:241:: with SMTP id
 1mr18833233wmj.119.1593547050191; 
 Tue, 30 Jun 2020 12:57:30 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id k11sm5172979wrd.23.2020.06.30.12.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 12:57:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, Yunqiang Su <ysu@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v3 4/5] hw/mips/malta: Introduce the 'malta-strict' machine
Date: Tue, 30 Jun 2020 21:57:22 +0200
Message-Id: <20200630195723.1359-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630195723.1359-1-f4bug@amsat.org>
References: <20200630195723.1359-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce the 'malta-strict' machine, aiming to have the same
limitations as real hardware.

Start with 32 MB which is the default on the CoreLV, and allow
up to 256 MB which is the maximum this card can accept.

See datasheet 'MIPS Document Number: MD00051 Revision 01.07'.

Example when asking a too big amount of memory:

  $ qemu-system-mips -M malta-strict -bios /dev/null -m 512
  qemu-system-mips: Too much memory for this machine: 512 MiB, maximum 256 MiB

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/malta.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index fd4964e8b0..ac4a618751 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1478,12 +1478,34 @@ static void malta_machine_default_class_init(ObjectClass *oc, void *data)
     mmc->max_ramsize = 2 * GiB;
 }
 
+static void malta_machine_strict_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    MaltaMachineClass *mmc = MALTA_MACHINE_CLASS(oc);
+
+    mc->desc = "MIPS Malta Core LV (physically limited as real hardware)";
+    mc->block_default_type = IF_PFLASH;
+    mc->max_cpus = 1;
+#ifdef TARGET_MIPS64
+    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("5Kc");
+#else
+    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("4Kc");
+#endif
+    mc->default_ram_size = 32 * MiB;
+    mmc->max_ramsize = 256 * MiB; /* 32 MByte PC100 SDRAM DIMMs x 4 slots */
+};
+
 static const TypeInfo malta_machine_types[] = {
     {
         .name          = MACHINE_TYPE_NAME("malta"),
         .parent        = TYPE_MALTA_MACHINE,
         .class_init    = malta_machine_default_class_init,
     },
+    {
+        .name          = MACHINE_TYPE_NAME("malta-strict"),
+        .parent        = TYPE_MALTA_MACHINE,
+        .class_init    = malta_machine_strict_class_init,
+    },
     {
         .name          = TYPE_MALTA_MACHINE,
         .parent        = TYPE_MACHINE,
-- 
2.21.3


