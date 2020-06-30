Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07B5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BE7D20759
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+2MdmF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE7D20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqBSs-0008Ck-Ls
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqBOZ-0001Ti-Dz
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:13:35 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:39993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqBOX-0003CM-U3
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:13:35 -0400
Received: by mail-ed1-x541.google.com with SMTP id b15so15300707edy.7
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 01:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EGAPVCNqBfM+j6qn1eWFdt+mVuBKEEQjee2Ni0amWQk=;
 b=c+2MdmF3y4Drt8+7PrjwFanvG10QM1608Chgll3SignKIHVxh21qZ9TyYHLJ9/XOvl
 Kfzq4AVG+Z4HVCdRuzF20yntiMBP9BQeKzFRH+FL+52aaLCmc9Ri9ByrsSzGI1ePej89
 phvkqhviMPwAPe3b4vfvOoBOqsX87oGqD7Ep/Lf9lPSMFwuhdPC7awQaba4/2zlIsApC
 P/2p2WchYVzSKqO5Xi6279BkW5jXUxqoI6OHmjx6rb2s0pWLluwIJCW5bN5cfcZbCaN3
 3U9ujN8WyUEWKXgRWLapqPZgfZxkDBkX1u/rCaVc3SJj7P/lHvCFIm7QvlfXwyU+FfUK
 Fviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=EGAPVCNqBfM+j6qn1eWFdt+mVuBKEEQjee2Ni0amWQk=;
 b=LVw43QObD9OJk6PU/XZJ0K4UL/6Od/3I+fYYCKuBgPi7m6bSilKgAnF3G/Vj6gltyI
 TSRB3+qsZAJUcCkTOtfkxBXY1OTccdzZhFLEhZH4ui7v/INlv+Ny8G7QeAZnFGNWbog+
 wfRnVYA9ly8Qi7IcpjkD5QA9KXqFM9gXtNw2EXoMikDiAgcflrDHzHs0LHv9G0UtuvDl
 IlYfCyLonNG0fbLarCSpOZLicb4k2V0UHQ+1YwHSSjYKBrj2U2iKs5mylrY8A6W6xaII
 b/S7DOTobCiQCuf3rKrf+rdc0ln5NXVLxFThsirjP8tetnT1+0KLc/+5BD1bO6+c4YOY
 R+WQ==
X-Gm-Message-State: AOAM530vMq8Dm4dA34X6u4vhorpGKXvmqvLQ32Sm6CYdCqUehxKF3lK8
 l/4wrzyb4nxHsT5LK/g6MFE=
X-Google-Smtp-Source: ABdhPJwHYfygBUcjXgwu6bStYkIMN5N3kFYIVkxqw8tZgz60tYlmxCnzTtgDO0G/kBcGjKq9JFd+KQ==
X-Received: by 2002:aa7:d989:: with SMTP id u9mr3992723eds.85.1593504812625;
 Tue, 30 Jun 2020 01:13:32 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id z1sm1425948ejb.41.2020.06.30.01.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 01:13:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Yunqiang Su <ysu@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-devel@nongnu.org
Subject: [PATCH 6/7] hw/mips/malta: Verify malta-phys machine uses correct
 DIMM sizes
Date: Tue, 30 Jun 2020 10:13:21 +0200
Message-Id: <20200630081322.19146-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630081322.19146-1-f4bug@amsat.org>
References: <20200630081322.19146-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x541.google.com
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

The machine has 4 DIMM slots. Each DIMM must be a power of 2.
Add a check the total RAM is a good combination of DIMMs.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/malta.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 013bf9272c..5768b88183 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -71,6 +71,8 @@
 
 #define MAX_IDE_BUS         2
 
+#define DIMM_SLOTS_COUNT    4
+
 #define TYPE_MALTA_MACHINE       MACHINE_TYPE_NAME("malta")
 #define MALTA_MACHINE_CLASS(klass) \
      OBJECT_CLASS_CHECK(MaltaMachineClass, (klass), TYPE_MALTA_MACHINE)
@@ -82,6 +84,7 @@ typedef struct MaltaMachineClass {
     MachineClass parent_obj;
     /* Public */
     ram_addr_t max_ramsize;
+    bool verify_dimm_sizes;
 } MaltaMachineClass;
 
 typedef struct {
@@ -1260,6 +1263,12 @@ void mips_malta_init(MachineState *machine)
     /* create CPU */
     mips_create_cpu(machine, s, &cbus_irq, &i8259_irq);
 
+    if (mmc->verify_dimm_sizes && ctpop64(ram_size) > DIMM_SLOTS_COUNT) {
+        error_report("RAM size must be the combination of %d powers of 2",
+                     DIMM_SLOTS_COUNT);
+        exit(1);
+    }
+
     /*
      * The GT-64120A north bridge accepts at most 256 MiB per SCS for
      * address decoding, so we have a maximum of 1 GiB. We deliberately
@@ -1494,6 +1503,7 @@ static void malta_machine_phys_class_init(ObjectClass *oc, void *data)
 #endif
     mc->default_ram_size = 32 * MiB;
     mmc->max_ramsize = 256 * MiB; /* 32 MByte PC100 SDRAM DIMMs x 4 slots */
+    mmc->verify_dimm_sizes = true;
 };
 
 static const TypeInfo malta_machine_types[] = {
-- 
2.21.3


