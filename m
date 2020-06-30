Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E0FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:55:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F9520675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZopjwyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F9520675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqHfW-0005rU-Gs
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 10:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqHcs-0000Ql-8F
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 10:52:46 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:46610)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqHcq-0002Tq-G4
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 10:52:45 -0400
Received: by mail-ej1-x643.google.com with SMTP id p20so20912700ejd.13
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 07:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OmTsclZ69krbHFkGlVdVDCpgvstqHpOQutI2E4eWTJE=;
 b=fZopjwytNwyQsTLUd/UOL9mfsfLzLQJET/2L8bvvhoJMyYcPtA0tK1hljSpi9UrWdp
 UNc28Pa1otI9tRQ+NF8LR/elqjtLB95fmt+gQlsjnVn9e/Cr8O4DOlhKr5zW4yGLozN0
 cKyvdMFnE8qvVYXaSPLPZMHH9FvsasgFFkprQ8NDS8BXHnsXiNoCqAJckvkhMkJ+u4vU
 HaKO5TC9NDOwy4XB4IxZfYUeueeliGBWdwR/fbGDB/mifkSMRHJ4VDV82pOp0wJCNRj1
 wy5R20A17UJY5/ilk1Ox9FMQYuFjfSZv6PVePTnI+PxJ6+LfX7qEHEDkFb4Wr6MSFGDq
 AkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=OmTsclZ69krbHFkGlVdVDCpgvstqHpOQutI2E4eWTJE=;
 b=QN6rsdfiaB2ZoS/rB7LFNNfHBJN2oS3VUUdmJ0bWcEChOpc2LQ3pFIPwP6DwTXE8q/
 +EHEU0Zrq/CxzmVzwiViQiXiqaa2BzpwDctbSz1aQ3MEooH7ikUYEKxI0LpLoc89n5VZ
 qQysA8LbKLf71GGvdsxPK9kDPUUHpDhA1prBQf1ICnYTLF8UD2QkUjQ+OmkaxlwhcZRh
 7TLaO2ISTs4H5hmI1WmJeZWNnDY4KSFJVkpFOPntp1XkELFE1aDAbRW9aYCTtxE0uYcj
 iIbCZityLjZ6QBb855/ZgYfcULPwRNnXBpnCiM0VjPUU1SRglmiewSv5EkmaCw4NnpT8
 Bbbg==
X-Gm-Message-State: AOAM532jlfcBfEwoglcW0R/lx7K4LgS5KR+mtdwb7QOaVguD+P0FlZUp
 MjVg6Pqo0L9vQjk6S75Kz1TTffnH/9I=
X-Google-Smtp-Source: ABdhPJz18CMp0sTk7YgIRkVpirhMUHapCk3D8bc9H5ytvQqVrsaPZfICH8x6x+fbeZf2IPqx10gTjg==
X-Received: by 2002:a17:907:9484:: with SMTP id
 dm4mr19631272ejc.56.1593528763349; 
 Tue, 30 Jun 2020 07:52:43 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p9sm2144569ejd.50.2020.06.30.07.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 07:52:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Aurelien Jarno <aurelien@aurel32.net>, Yunqiang Su <ysu@wavecomp.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 4/6] hw/mips/malta: Introduce the 'malta-strict' machine
Date: Tue, 30 Jun 2020 16:52:34 +0200
Message-Id: <20200630145236.27529-5-f4bug@amsat.org>
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

Introduce the 'malta-strict' machine, aiming to have the same
limitations as real hardware.

Start with 32 MB which is the default on the CoreLV, and allow
up to 256 MB which is the maximum this card can accept.

See datasheet 'MIPS Document Number: MD00051 Revision 01.07'.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/malta.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 17a1c0d1c4..209237d066 100644
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


