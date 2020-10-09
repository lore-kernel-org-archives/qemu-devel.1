Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BDCC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:09:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23DAA22265
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a1UJY9UU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DAA22265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvtm-0006Fe-1f
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 13:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvrx-0004Kc-Mm
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:07:49 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvrv-0001J1-VR
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:07:49 -0400
Received: by mail-wm1-x344.google.com with SMTP id j136so10534341wmj.2
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 10:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H1zBaXIPUFkoRX522wNIGvBuniNlrLtU+nW3sIqZkhk=;
 b=a1UJY9UUndOq/LM+zjcD4nSmLuV1s0Xc6DJ1lJbq8GujJOJKZ9agpdBHdtM1rQyArc
 Y7SUFRAjetL3Aq9jM7ulzCeBA7kZMCXx7NjJkWJ5+/6qjExXr89fEzfNBpnxd31jUgrE
 kp1A/GiNWKr2TERmq0A0q+H6LuZRIURRVzhaFKSgG+N9ADvfHqvk5Ej0BGZqMto/wIIQ
 2jELF/Pn9i8FLna2zd7RzgcUBUh2ORV3jrbPqIfa5mtMblQ9OQRBj+Geq/Y7U5Owl/B+
 fkTqcBVyu1lyG5O6soA2zDA290qCgF1sNb/4noOmPB4DxaMwvc6zRm0iEuJCiX5Wi/IA
 JTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H1zBaXIPUFkoRX522wNIGvBuniNlrLtU+nW3sIqZkhk=;
 b=BbA89aV0bbzfW8Sw8OQyjppDyVsxgQt/oiy2IKd807QFcKwm7/h95ikoyAG7YfEqfp
 c3jHjCEZ4DVEnrc/q8Ur8A9WQsfVisL7afsHLL+EQ2qeq5r8LjPH5FIji4QDoE/msZlY
 b8QZhJAIkhWFpLUPfn8zvCx38LJ0Rmt7mQVpFSmhE05ZBgN2OwgVdrqLEPVZhjeTRjW5
 RaA0b9I1pJo+1qHJG4ht4DmXdUIzVRNzq+UtIXrdjwj70FC/K9XTVIctKM6ceFzUNLrF
 ZYk1BslwxNzzjct+7IU6OtDNntm+9xtrabIp2jbtCq+PTXW/+VsWm+gWYBrqGpmTOC0/
 8kDQ==
X-Gm-Message-State: AOAM532EYhEeghZ3CTgCRgcdbXoqVq3MD3MdpXmb1yvY0OtEUZU1wOyO
 zLJ4MEv0V+T1f4DISbXDenQ0LA==
X-Google-Smtp-Source: ABdhPJw8FRMgfC7wNrTD6RRMQN2j4IoWnGsmeodKV4EKmU7C84r/n8cbeIQE+V1x4aXKRgAEu00miQ==
X-Received: by 2002:a1c:35c5:: with SMTP id c188mr15663479wma.11.1602263266496; 
 Fri, 09 Oct 2020 10:07:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p9sm12037660wmm.4.2020.10.09.10.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 10:07:43 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 360001FF8C;
 Fri,  9 Oct 2020 18:07:43 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH  2/4] hw/riscv: migrate fdt field to generic MachineState
Date: Fri,  9 Oct 2020 18:07:40 +0100
Message-Id: <20201009170742.23695-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201009170742.23695-1-alex.bennee@linaro.org>
References: <20201009170742.23695-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: julien@xen.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 masami.hiramatsu@linaro.org, andre.przywara@arm.com,
 stefano.stabellini@linaro.org, takahiro.akashi@linaro.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>, stefano.stabellini@xilinx.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a mechanical change to make the fdt available through
MachineState.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/riscv/virt.h |  1 -
 hw/riscv/virt.c         | 18 +++++++++---------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index b4ed9a32eb..6505ae8d23 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -41,7 +41,6 @@ struct RISCVVirtState {
     DeviceState *plic[VIRT_SOCKETS_MAX];
     PFlashCFI01 *flash[2];
 
-    void *fdt;
     int fdt_size;
 };
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 41bd2f38ba..17c0706156 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -194,7 +194,7 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
     hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
 
-    fdt = s->fdt = create_device_tree(&s->fdt_size);
+    fdt = mc->fdt = create_device_tree(&s->fdt_size);
     if (!fdt) {
         error_report("create_device_tree() failed");
         exit(1);
@@ -434,12 +434,12 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     g_free(name);
 
     name = g_strdup_printf("/soc/flash@%" PRIx64, flashbase);
-    qemu_fdt_add_subnode(s->fdt, name);
-    qemu_fdt_setprop_string(s->fdt, name, "compatible", "cfi-flash");
-    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
+    qemu_fdt_add_subnode(mc->fdt, name);
+    qemu_fdt_setprop_string(mc->fdt, name, "compatible", "cfi-flash");
+    qemu_fdt_setprop_sized_cells(mc->fdt, name, "reg",
                                  2, flashbase, 2, flashsize,
                                  2, flashbase + flashsize, 2, flashsize);
-    qemu_fdt_setprop_cell(s->fdt, name, "bank-width", 4);
+    qemu_fdt_setprop_cell(mc->fdt, name, "bank-width", 4);
     g_free(name);
 }
 
@@ -613,9 +613,9 @@ static void virt_machine_init(MachineState *machine)
             hwaddr end = riscv_load_initrd(machine->initrd_filename,
                                            machine->ram_size, kernel_entry,
                                            &start);
-            qemu_fdt_setprop_cell(s->fdt, "/chosen",
+            qemu_fdt_setprop_cell(machine->fdt, "/chosen",
                                   "linux,initrd-start", start);
-            qemu_fdt_setprop_cell(s->fdt, "/chosen", "linux,initrd-end",
+            qemu_fdt_setprop_cell(machine->fdt, "/chosen", "linux,initrd-end",
                                   end);
         }
     } else {
@@ -636,11 +636,11 @@ static void virt_machine_init(MachineState *machine)
 
     /* Compute the fdt load address in dram */
     fdt_load_addr = riscv_load_fdt(memmap[VIRT_DRAM].base,
-                                   machine->ram_size, s->fdt);
+                                   machine->ram_size, machine->fdt);
     /* load the reset vector */
     riscv_setup_rom_reset_vec(start_addr, virt_memmap[VIRT_MROM].base,
                               virt_memmap[VIRT_MROM].size, kernel_entry,
-                              fdt_load_addr, s->fdt);
+                              fdt_load_addr, machine->fdt);
 
     /* SiFive Test MMIO device */
     sifive_test_create(memmap[VIRT_TEST].base);
-- 
2.20.1


