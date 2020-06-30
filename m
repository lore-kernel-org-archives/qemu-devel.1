Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2DEC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:53:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19D2120675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzrqMhyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D2120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqHdw-0002hu-Aa
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 10:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqHcp-0000Nx-WC
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 10:52:44 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:41919)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqHco-0002TU-52
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 10:52:43 -0400
Received: by mail-ej1-x643.google.com with SMTP id dp18so20955949ejc.8
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 07:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2da/4yJ3T3tR57ruAg59KszQSssdYRjB2tAYUevjx6c=;
 b=BzrqMhyfyWJmJYb6+hLmV4UlnhaVaMRNqER4QghTe3FZ7e9Np6XMWC2WoW0lLNWeSB
 toKe2sx8h15wmDFnQMDZkj5JntKSzxpHgxbfL8q0BaAnNw8/qGMG3JQwW42jgKMAaKUw
 QzJvqP6YjVnGfds2/12XqovfegXzLJP8jNnC8PTiItK/nqL4d6t49+mxZYpUQRzPDHMO
 WLhUhu5ixupvvUdJktuoJEWeMTHQnIWy9yDF6uQ5RwSbjQ4F3h1sUrHPTxgZoo4OxYnE
 6mecL7utyT3XWxfYuzoy5jht6kOKWWmR5HzskHqhes5LZ/hqYe70YEq9bVOqzPDktxfs
 EN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2da/4yJ3T3tR57ruAg59KszQSssdYRjB2tAYUevjx6c=;
 b=DqDtFR4mVGi0CWqefq6GX/Rd3ew6k8kM5ubpEFOScCWGzwBvOUOnsoSn3xq7y4xaZi
 fhEUZHirQLffqhbGEVeF9VPQRLe+LaO+VmyKLe505yED0Nwcuzub1L3mLksfS4V/Ho+v
 hLYq9aAb5xB8QVNyokIx+Tai0WbHImKfPc5Dl5XsR7ZsS6BQxR5lM5gfAGQcE33Mg3Cr
 aqkqHZRc5LO46tjYA8jaqr6oAlZpOxPLnOFTkxXy5Kf5kGm1Re+TAT1bbvAx6CplzSbd
 5NzwY8B21s8I1e3DiE1K2ULqVb5weq96duACVcUkrld5SKY+5C3m5igVxHoR+bz7n4T9
 Zu3A==
X-Gm-Message-State: AOAM531eGKQ2xjuwNWwz7psAHLVsQLQR9Dl/PPNuR2rcBX73KaVl45U6
 7KuVCUQCQ4s2YK1oEA+gBvI=
X-Google-Smtp-Source: ABdhPJxNkjSwEEXJY1xkSwZuBCZjf9MjJ5eLKqJJ4M358aSBGYn241bkEzH5hf+ZAPQwY8vwguIUEA==
X-Received: by 2002:a17:907:7294:: with SMTP id
 dt20mr18194278ejc.355.1593528760882; 
 Tue, 30 Jun 2020 07:52:40 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p9sm2144569ejd.50.2020.06.30.07.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 07:52:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Aurelien Jarno <aurelien@aurel32.net>, Yunqiang Su <ysu@wavecomp.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 2/6] hw/mips/malta: Register the machine as a TypeInfo
Date: Tue, 30 Jun 2020 16:52:32 +0200
Message-Id: <20200630145236.27529-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630145236.27529-1-f4bug@amsat.org>
References: <20200630145236.27529-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to add more machines. First convert from the old
DEFINE_MACHINE() API to the more recent DEFINE_TYPES(TypeInfo[])
one.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/malta.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 5b371c1e34..2c363fe099 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -70,6 +70,8 @@
 
 #define MAX_IDE_BUS         2
 
+#define TYPE_MALTA_MACHINE       MACHINE_TYPE_NAME("malta-base")
+
 typedef struct {
     MemoryRegion iomem;
     MemoryRegion iomem_lo; /* 0 - 0x900 */
@@ -1433,10 +1435,19 @@ static void mips_malta_register_types(void)
 
 type_init(mips_malta_register_types)
 
-static void mips_malta_machine_init(MachineClass *mc)
+static void malta_machine_common_class_init(ObjectClass *oc, void *data)
 {
-    mc->desc = "MIPS Malta Core LV";
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->init = mips_malta_init;
+    mc->default_ram_id = "mips_malta.ram";
+}
+
+static void malta_machine_default_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "MIPS Malta Core LV";
     mc->block_default_type = IF_IDE;
     mc->max_cpus = 16;
     mc->is_default = true;
@@ -1445,7 +1456,20 @@ static void mips_malta_machine_init(MachineClass *mc)
 #else
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
 #endif
-    mc->default_ram_id = "mips_malta.ram";
 }
 
-DEFINE_MACHINE("malta", mips_malta_machine_init)
+static const TypeInfo malta_machine_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("malta"),
+        .parent        = TYPE_MALTA_MACHINE,
+        .class_init    = malta_machine_default_class_init,
+    },
+    {
+        .name          = TYPE_MALTA_MACHINE,
+        .parent        = TYPE_MACHINE,
+        .class_init    = malta_machine_common_class_init,
+        .abstract      = true,
+    }
+};
+
+DEFINE_TYPES(malta_machine_types)
-- 
2.21.3


