Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB652C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:43:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A49F20671
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHvNwBuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A49F20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbmQ3-00021b-Ot
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jbmP7-000179-U5; Thu, 21 May 2020 10:42:37 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:54158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jbmP7-0001es-52; Thu, 21 May 2020 10:42:37 -0400
Received: by mail-pj1-x1041.google.com with SMTP id ci21so3187090pjb.3;
 Thu, 21 May 2020 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RjB5XoJxOe1JrbW9Ms03ygMw66G/3IfRQiMJxv34Yg0=;
 b=LHvNwBuq9UfNJV7LJrRhYgYE89mJY4QAel/jlwXSX83jQ1F+6cHGBxfSSS6q6Kr8W2
 5685wYn341CICBHctoAbnX3zhgWhEors9h2YhXnvDi/PUE33LyaaNEc48e8yKnCyeStG
 QKLSElMy4Uc3OQlu2KCft8iUOewwei9GAvWAaEEvPSG6DVRCGCYpysWfh3eO25yhKx1j
 8pKjyFcrLSTirGBXgCPgapaDuyeiACTYPl6FQ9T/av6dOtr+/QFkXNemp0c5aopaQyD/
 zXHAYEYucFukSAAW0XJVtwzHFB8DsOXuLd9Cw3v9iaf9C5UqHXSCtUi/fWhNsdtxEwpg
 MVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RjB5XoJxOe1JrbW9Ms03ygMw66G/3IfRQiMJxv34Yg0=;
 b=MalM+4JFpkBMzv9iuac3nuU8oJ3EiUdsU/J6yRyThH9K29mYnezjKOJqBQFqNLkp2C
 bWE6dlgpyOv6RdcqDxL4qafv9zwTrkC2m9KZSieOoHyYv6s2D0pKO88nNkI/GKoWx3cP
 OEnIMMQdSATN6YZYLfcMVdaagLzPU6SDnVEPgIotUPqkQTCTZqXdPy1URaUktX4mTlge
 nyYgpY7pCUlLdrto+TfwzB5JJk6gYs9Wc2FRGVZ6V0AMOQe/oiD9MDfmfAHkj6Nm3RDO
 RgLSVadMjmrDy4R1Nui2pJtfmH/LmTSOw/ED1gT5AkiLvE0fQgQWG+3XqSQkWVNTd54C
 7ODg==
X-Gm-Message-State: AOAM531C5VoF2hTnlQJqZUl3/U3PIuOutcpqPtc9chu6qt4oOVsESlN6
 AAHa7DvN27P57qLsk9Ht8Fw=
X-Google-Smtp-Source: ABdhPJx4ktthtsYXx3eA1SlbWwKYYyD09TOeeBUqm0LvhydukQUHE7pYUd41LElkLfQ9E7k55M+o3Q==
X-Received: by 2002:a17:902:bd87:: with SMTP id
 q7mr9890456pls.92.1590072155364; 
 Thu, 21 May 2020 07:42:35 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v1sm4335820pgl.11.2020.05.21.07.42.34
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 21 May 2020 07:42:35 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 2/2] hw/riscv: virt: Remove the riscv_ prefix of the machine*
 functions
Date: Thu, 21 May 2020 07:42:27 -0700
Message-Id: <1590072147-13035-2-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1590072147-13035-1-git-send-email-bmeng.cn@gmail.com>
References: <1590072147-13035-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Remove the riscv_ prefix of the machine* functions.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/virt.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index c695a44..f1d6b61 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -471,7 +471,7 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
     return dev;
 }
 
-static void riscv_virt_board_init(MachineState *machine)
+static void virt_machine_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = virt_memmap;
     RISCVVirtState *s = RISCV_VIRT_MACHINE(machine);
@@ -632,32 +632,32 @@ static void riscv_virt_board_init(MachineState *machine)
     g_free(plic_hart_config);
 }
 
-static void riscv_virt_machine_instance_init(Object *obj)
+static void virt_machine_instance_init(Object *obj)
 {
 }
 
-static void riscv_virt_machine_class_init(ObjectClass *oc, void *data)
+static void virt_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "RISC-V VirtIO board";
-    mc->init = riscv_virt_board_init;
+    mc->init = virt_machine_init;
     mc->max_cpus = 8;
     mc->default_cpu_type = VIRT_CPU;
     mc->pci_allow_0_address = true;
 }
 
-static const TypeInfo riscv_virt_machine_typeinfo = {
+static const TypeInfo virt_machine_typeinfo = {
     .name       = MACHINE_TYPE_NAME("virt"),
     .parent     = TYPE_MACHINE,
-    .class_init = riscv_virt_machine_class_init,
-    .instance_init = riscv_virt_machine_instance_init,
+    .class_init = virt_machine_class_init,
+    .instance_init = virt_machine_instance_init,
     .instance_size = sizeof(RISCVVirtState),
 };
 
-static void riscv_virt_machine_init_register_types(void)
+static void virt_machine_init_register_types(void)
 {
-    type_register_static(&riscv_virt_machine_typeinfo);
+    type_register_static(&virt_machine_typeinfo);
 }
 
-type_init(riscv_virt_machine_init_register_types)
+type_init(virt_machine_init_register_types)
-- 
2.7.4


