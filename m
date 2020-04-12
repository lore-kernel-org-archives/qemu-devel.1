Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294C4C2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:42:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E61CE206E5
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eav2ieLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61CE206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlJS-000183-UW
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 18:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDw-0006VH-CD
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:37:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDv-0002o1-8J
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:37:08 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39096)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDv-0002nZ-28; Sun, 12 Apr 2020 18:37:07 -0400
Received: by mail-wm1-x344.google.com with SMTP id y24so8373979wma.4;
 Sun, 12 Apr 2020 15:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ACqwWM6q3w6eeeLf6eS/r0Fpb4qEkaBMb1O9yAVXZQo=;
 b=Eav2ieLzABrzdmyoyQLXT0s+gUm8FmjTYgeO1M9o97/Eye7qBD+gvSslPT2P3Pc+Ud
 ggZsT5Idy3aq0F6f7iMv6LebW8kajzKG3N/SlidMBZswf32BI6fW0kJaIQDGS143rcGj
 zZ6bzwJ0+d8QdTt75WYP1CmcW7bEo7TimspI9bI9niKWcTGEvwF95gYWNQKngztxv3FU
 jPoK5/Rvzhk+zVpLplUk9WfD71g8IeIEO9JbPifkaZRzTLWLJK1VWjR9cRnqnuZDatIs
 q/TcdZtepwLzIDJkt7aukefK6IWzO+SE9YK9qAAJnLD43cAzvWczyhcMFsqogOTrDqtE
 FqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ACqwWM6q3w6eeeLf6eS/r0Fpb4qEkaBMb1O9yAVXZQo=;
 b=qDP5Bl8a4gk8Gep+Hq6k/IsmmbrG9+8Hry8cght345lS0ft9aOhvyf5bUmIkjFmdRF
 /qNcSR1fiWpwj9NUNAMOjNhN+nW9vt5CnMUvySFoA1/Q+gFD7AcDTT1+nbe65oGeBoCh
 K4aND3VnrFvwtRhVliiL9knFbsPQremeQv0+sP1YqYPPw5RnM420PNtl/kEVAkV425HQ
 6AGXHG8+Pe35OOCqDriorjnlOB0qvekg0g3dkkyeVCTLTuoXUSONChXngny9oTkTQz8y
 F3/kHqFBGxigOfJY6/4dpjMl0WIfQaCifErTmTxuFNA4XZXS1xt41eRcliJakL3aneC8
 TSvA==
X-Gm-Message-State: AGi0PuY7p0jJ6tIuEjVKM04MEh2ZEfA4gp/wV7skZyhyKmVD5YsyNqb0
 SdZWAF/P51SSBDvUkvbqMu4ZjgocEMLpRg==
X-Google-Smtp-Source: APiQypKttr4FiVT/PS0gYMZsNpgDa0+VuPdUBSHMQiO3U4JSk6VmIIPcdbAkXJDkJo202g4v3HoamA==
X-Received: by 2002:a7b:cc01:: with SMTP id f1mr16694131wmh.39.1586731025908; 
 Sun, 12 Apr 2020 15:37:05 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id d13sm12563559wrv.34.2020.04.12.15.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:37:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 12/24] hw/arm/stm32f205_soc: Store MemoryRegion in
 STM32F205State
Date: Mon, 13 Apr 2020 00:36:07 +0200
Message-Id: <20200412223619.11284-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412223619.11284-1-f4bug@amsat.org>
References: <20200412223619.11284-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coccinelle reported:

  $ spatch ... --timeout 60 --sp-file \
    scripts/coccinelle/simplify-init-realize-error_propagate.cocci
  HANDLING: ./hw/arm/stm32f205_soc.c
  >>> possible moves from stm32f205_soc_initfn() to stm32f205_soc_realize() in ./hw/arm/stm32f205_soc.c:83

While reviewing we notice storing the MemoryRegion in the device
state, we'll be able to later automatically simplify the error
propagation calls.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/stm32f205_soc.h |  4 ++++
 hw/arm/stm32f205_soc.c         | 18 +++++++-----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/hw/arm/stm32f205_soc.h b/include/hw/arm/stm32f205_soc.h
index 922a733f88..63e7e7c825 100644
--- a/include/hw/arm/stm32f205_soc.h
+++ b/include/hw/arm/stm32f205_soc.h
@@ -56,6 +56,10 @@ typedef struct STM32F205State {
 
     ARMv7MState armv7m;
 
+    MemoryRegion sram;
+    MemoryRegion flash;
+    MemoryRegion flash_alias;
+
     STM32F2XXSyscfgState syscfg;
     STM32F2XXUsartState usart[STM_NUM_USARTS];
     STM32F2XXTimerState timer[STM_NUM_TIMERS];
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 118c342559..42f4e44134 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -87,23 +87,19 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     SysBusDevice *busdev;
     Error *err = NULL;
     int i;
-
     MemoryRegion *system_memory = get_system_memory();
-    MemoryRegion *sram = g_new(MemoryRegion, 1);
-    MemoryRegion *flash = g_new(MemoryRegion, 1);
-    MemoryRegion *flash_alias = g_new(MemoryRegion, 1);
 
-    memory_region_init_rom(flash, OBJECT(dev_soc), "STM32F205.flash",
+    memory_region_init_rom(&s->flash, OBJECT(dev_soc), "STM32F205.flash",
                            FLASH_SIZE, &error_fatal);
-    memory_region_init_alias(flash_alias, OBJECT(dev_soc),
-                             "STM32F205.flash.alias", flash, 0, FLASH_SIZE);
+    memory_region_init_alias(&s->flash_alias, OBJECT(dev_soc),
+                             "STM32F205.flash.alias", &s->flash, 0, FLASH_SIZE);
 
-    memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, flash);
-    memory_region_add_subregion(system_memory, 0, flash_alias);
+    memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->flash);
+    memory_region_add_subregion(system_memory, 0, &s->flash_alias);
 
-    memory_region_init_ram(sram, NULL, "STM32F205.sram", SRAM_SIZE,
+    memory_region_init_ram(&s->sram, NULL, "STM32F205.sram", SRAM_SIZE,
                            &error_fatal);
-    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, sram);
+    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sram);
 
     armv7m = DEVICE(&s->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 96);
-- 
2.21.1


