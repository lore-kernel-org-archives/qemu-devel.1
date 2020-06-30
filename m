Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EF5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:17:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6929D20759
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pe71eC0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6929D20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqBSX-0007Xd-MX
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqBOY-0001QK-3I
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:13:34 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:44344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqBOW-0003Bv-L7
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:13:33 -0400
Received: by mail-ed1-x542.google.com with SMTP id by13so5435989edb.11
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 01:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o9MheSyfE8UMIhLbV+ncpbSwjga0svuWXC9D1+WgrXc=;
 b=pe71eC0F2ALAT20eM/ZcZb6ej2fmvO0uDyHCOcF1yTet9KaZ44wtHBym4lYIBRC99r
 xLuwbH9x4ivc+sk/Z0RvTkE8QoplES18oXy5rKISQjT6sI2sgLoUdBeqaeeXuKXp/1JN
 vREMXkXSc2Oxqeqq09yjvC76xtL+FBAN5UNJtnMgJ3oowHbGGPAOucAEXtj5lMEyifUS
 mLnDDU98Or4k/q+CzjRgQgkEanNFmgBYig76DeQd+JeKJe5QUiS7AOAck1sxhAKmDL8B
 hl9rZTPTS8K8aucFQxfaD873U7rM1wgSPrl+ckhHs7K99y8cBUZQoKpsyN9rokXv4uXM
 ZNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=o9MheSyfE8UMIhLbV+ncpbSwjga0svuWXC9D1+WgrXc=;
 b=qn9vH10YuXne1faodF3ACeZC0Ob5aiW4O3/gieDPSxdYR/GqrzRPOVQOuNjD0v6u1c
 4Kx3pL7HUd6Rq9kbkV82mbge/lVqahEYD/+EPCFOV8UWT7yZ8P1wfjQixPRCxYiXTOP5
 jpaYes0ti0KeO/7s4K4Nc3+BxLmJ6ZFCrQ7yJH70wfh6Kot6cE5RfcOSe7HWk9PmW5zN
 Nga/rFykgaWI3A0fwk5CMSsHu0Qz489OZvmTLxTdIrPpje7mEW8suqVSGEh38nJpeE/I
 ncNV6aYdrEvZ5uXj3OG0LRgRPdFugLYoj1jcwERm2UehOxhpcFgCZaO9boF+se9+/4el
 angg==
X-Gm-Message-State: AOAM532D9HQ1qY3ejRSaLW3ZUOFxJFVRNat+Ghks6PQMfdkZ5Ir82vYl
 av/94WjQTTw+DliTzk9whNU=
X-Google-Smtp-Source: ABdhPJx0HIyo14FvgFOEIRxpqWInW9YAFn7TMtZwSm/jrlRcEgZ13uv4/0lIkHrM2oQ4Jxl3/1uHwA==
X-Received: by 2002:a05:6402:2212:: with SMTP id
 cq18mr22866189edb.173.1593504811362; 
 Tue, 30 Jun 2020 01:13:31 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id z1sm1425948ejb.41.2020.06.30.01.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 01:13:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Yunqiang Su <ysu@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-devel@nongnu.org
Subject: [PATCH 5/7] hw/mips/malta: Introduce the 'malta-phys' machine
Date: Tue, 30 Jun 2020 10:13:20 +0200
Message-Id: <20200630081322.19146-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630081322.19146-1-f4bug@amsat.org>
References: <20200630081322.19146-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
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

Introduce the 'malta-phys' machine, aiming to have the same
limitations as real hardware. Start by restricting the RAM
to 1GB, which is the maximum amount of memory the GT-64120A
north bridge can address.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/malta.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 1ca41b44db..013bf9272c 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1479,11 +1479,32 @@ static void malta_machine_virt_class_init(ObjectClass *oc, void *data)
     mmc->max_ramsize = 2 * GiB;
 }
 
+static void malta_machine_phys_class_init(ObjectClass *oc, void *data)
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
         .name          = MACHINE_TYPE_NAME("malta-virt"),
         .parent        = TYPE_MALTA_MACHINE,
         .class_init    = malta_machine_virt_class_init,
+    }, {
+        .name          = MACHINE_TYPE_NAME("malta-phys"),
+        .parent        = TYPE_MALTA_MACHINE,
+        .class_init    = malta_machine_phys_class_init,
     }, {
         .name          = TYPE_MALTA_MACHINE,
         .parent        = TYPE_MACHINE,
-- 
2.21.3


