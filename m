Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E35BC2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:40:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A3C206E5
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yms+dVno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A3C206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlHV-0005hF-9S
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 18:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDs-0006JD-EZ
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDr-0002jG-BG
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:37:04 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39444)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDr-0002id-4d; Sun, 12 Apr 2020 18:37:03 -0400
Received: by mail-wr1-x441.google.com with SMTP id p10so8517155wrt.6;
 Sun, 12 Apr 2020 15:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rNOvzQC0gAZiW9IjgvdXICw1FeldG6faD6QdyriSpSA=;
 b=Yms+dVnobgL/uTyskm/CPmGVpuY5K7rRdl/y/Xcw36vwxQ4cXdVkaf3wqlD8Za79ok
 U/eQ0KdvGCCuYFZ6RYlgmadQw237gtmd5zOSr/E+aphrQk0rOZiAm1wPzlXJDvs9JINY
 8VnhhvZP4diyOC0umPSzp9tvtLp/ucbCoD6izhWzKJqtl71n/GtUO9MS/z+54RzS5EuG
 TpszyNIilI0JzZmpURO6BKGFuZItPz4l9BMi0zWjeYqESlxn0f+uC1hL/8ZpSj+eM+4R
 oE/CzP/7uRejFlskPIu9dMheg0X2Cma9G7Y8Fnm3Aj7SCBA5yxD6SJn6AeZN8ankWpGb
 Xe7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rNOvzQC0gAZiW9IjgvdXICw1FeldG6faD6QdyriSpSA=;
 b=gSGniEl22W1ter74CjmVc3KYe9zSvzn8Ksi3aFaV5/Bj9NbFZBVj4lUEews8eICEzw
 bIHSRWnDtViC0op4xQRxiZX0Y2qBn9NXqsnF7UddayAQtfmHCYaibWOdyhbzpaz7BnDk
 /GL5iBb4NVq6U+499SblbENep/l9adNiw92XjTYxekSEnsBMHTG46NhztrmY4FUNMXnx
 b8iCy0eRlC/x824tz4yMgqyBj38KW3qYT6oJOqCoRJFySFcLPrE6Y+vjMGbv6LtdyNiJ
 gUuyE6kCqovhaCSxs39AZEtjrexBg2XRcuEtNs9MFL204NN5yO36uiv36FgkRhRqo1rM
 fmbw==
X-Gm-Message-State: AGi0PuZN0OCL7fDqB3ZhxvdLvqenrfR84NwbpIGko/tH9H3jirCw5Utn
 VDOaTMxoZ1AlPcPEA10N0VGyAbnQaGGP/w==
X-Google-Smtp-Source: APiQypLDnd72DBOXRbnDuWWsEfUNONBBfh/ms5TeKXv3Kg76nSxYgcVFqpN2VUF98/bEvc0lFqt5UQ==
X-Received: by 2002:adf:ee06:: with SMTP id y6mr16579217wrn.187.1586731021977; 
 Sun, 12 Apr 2020 15:37:01 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id d13sm12563559wrv.34.2020.04.12.15.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:37:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 11/24] hw/arm/msf2-soc: Store MemoryRegion in
 MSF2State
Date: Mon, 13 Apr 2020 00:36:06 +0200
Message-Id: <20200412223619.11284-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412223619.11284-1-f4bug@amsat.org>
References: <20200412223619.11284-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
  HANDLING: ./hw/arm/msf2-soc.c
  >>> possible moves from m2sxxx_soc_initfn() to m2sxxx_soc_realize() in ./hw/arm/msf2-soc.c:86

While reviewing we notice storing the MemoryRegion in the device
state, we'll be able to later automatically simplify the error
propagation calls.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/msf2-soc.h |  4 ++++
 hw/arm/msf2-soc.c         | 18 +++++++-----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/hw/arm/msf2-soc.h b/include/hw/arm/msf2-soc.h
index 3cfe5c76ee..e4c5110036 100644
--- a/include/hw/arm/msf2-soc.h
+++ b/include/hw/arm/msf2-soc.h
@@ -50,6 +50,10 @@ typedef struct MSF2State {
 
     ARMv7MState armv7m;
 
+    MemoryRegion sram;
+    MemoryRegion nvm;
+    MemoryRegion nvm_alias;
+
     char *cpu_type;
     char *part_name;
     uint64_t envm_size;
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 588d643b8d..e448b0ab74 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -90,13 +90,9 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     SysBusDevice *busdev;
     Error *err = NULL;
     int i;
-
     MemoryRegion *system_memory = get_system_memory();
-    MemoryRegion *nvm = g_new(MemoryRegion, 1);
-    MemoryRegion *nvm_alias = g_new(MemoryRegion, 1);
-    MemoryRegion *sram = g_new(MemoryRegion, 1);
 
-    memory_region_init_rom(nvm, OBJECT(dev_soc), "MSF2.eNVM", s->envm_size,
+    memory_region_init_rom(&s->nvm, OBJECT(dev_soc), "MSF2.eNVM", s->envm_size,
                            &error_fatal);
     /*
      * On power-on, the eNVM region 0x60000000 is automatically
@@ -104,15 +100,15 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
      * start address (0x0). We do not support remapping other eNVM,
      * eSRAM and DDR regions by guest(via Sysreg) currently.
      */
-    memory_region_init_alias(nvm_alias, OBJECT(dev_soc), "MSF2.eNVM", nvm, 0,
-                             s->envm_size);
+    memory_region_init_alias(&s->nvm_alias, OBJECT(dev_soc), "MSF2.eNVM",
+                             &s->nvm, 0, s->envm_size);
 
-    memory_region_add_subregion(system_memory, ENVM_BASE_ADDRESS, nvm);
-    memory_region_add_subregion(system_memory, 0, nvm_alias);
+    memory_region_add_subregion(system_memory, ENVM_BASE_ADDRESS, &s->nvm);
+    memory_region_add_subregion(system_memory, 0, &s->nvm_alias);
 
-    memory_region_init_ram(sram, NULL, "MSF2.eSRAM", s->esram_size,
+    memory_region_init_ram(&s->sram, NULL, "MSF2.eSRAM", s->esram_size,
                            &error_fatal);
-    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, sram);
+    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sram);
 
     armv7m = DEVICE(&s->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 81);
-- 
2.21.1


