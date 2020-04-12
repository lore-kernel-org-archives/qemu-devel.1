Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CA1C2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:55:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF18620692
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkWHmv9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF18620692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlVQ-0000e8-RJ
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 18:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlIr-0000oU-6P
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlIp-0005sI-3h
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:42:12 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36958)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlIo-0005rq-TR; Sun, 12 Apr 2020 18:42:11 -0400
Received: by mail-wm1-x344.google.com with SMTP id z6so8411628wml.2;
 Sun, 12 Apr 2020 15:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YIEKjYaSehnFfLSFKx18jrIeGBK5qNFrnpqQGnepkJE=;
 b=HkWHmv9gZdAw6lY5Jeo+ZU3aN9GLylM+Ya9qK82xklS8Tekd0/puSmBaHntEalEqRh
 r/tq6JZBZVDWbw3wOcrZrYiS9T/YZiUw4KY+PBSUXHDuW4SaosMbDi4zVYJi2ZgypIR4
 TvQzH/tDSunadtLYjDoXD1iKM2tnkf4RQNWWa3yzE6IlX3pHmCI2lh0pPix5seBiDajS
 Y2lhGPddSPRMzl7f1NCSzaQeygFAqn5vGbLWe9wGdP3ICo7ExwPHsl7PmfydNmAngHf3
 k617tTbMhtc7ZGbPTuT/OJwDfbcqrb443fJT6y3VKWeoPG08VkRDP4DfO0TXsOXLN+GX
 bH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=YIEKjYaSehnFfLSFKx18jrIeGBK5qNFrnpqQGnepkJE=;
 b=Jwh3MrCxYiNs+GIlX+YarcEFArAZm3pPlI78igal4M6beRuJU+iIDfi2Zbnx43kAMB
 /JDX+gF/e3b9T0+Oc0xr7edHKO5gx18KqpK6Ymfr5PyMhhP5H50Jz9dYmYTh2fBMfNyI
 jmvR03r6IhVtfLo6H2k5773vxWaFwClZYAenqUtyxKCFfIyVf1r/AcBbBqls9wpciBbL
 yf5csNdoA9A7UnIeMZFSkYpfOW+TEhe289KQmjzJvKw9T4FAE1nPV02M3bk6OWSWc4mm
 VFzGTrvmTrS2CYCGTaa7H+FWoF4HWXBB4i/VW+tW5ebvot/s+4qirII3aHFfw7oP6iea
 139A==
X-Gm-Message-State: AGi0PuZu6qClR43MvLpWfEaOnGs3jfqEJiaTndJkbuHEQDxsqPGsTINI
 0rjossj0iW0pib54/r4cj09OHYrcsf+FIg==
X-Google-Smtp-Source: APiQypKrQPv+6xzEvjFq4PzgYagIvOcnW/FwDVO+CfV6DACkMAlfP8FqxaQe3tP5DL8tOMtxcAuwKA==
X-Received: by 2002:a1c:5448:: with SMTP id p8mr15519826wmi.173.1586731329787; 
 Sun, 12 Apr 2020 15:42:09 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f63sm12083825wma.47.2020.04.12.15.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:42:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 06/23] hw/arm/msf2-soc: Add missing
 error-propagation code
Date: Mon, 13 Apr 2020 00:41:27 +0200
Message-Id: <20200412224144.12205-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412224144.12205-1-f4bug@amsat.org>
References: <20200412224144.12205-1-f4bug@amsat.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/use-error_propagate-in-realize.cocci \
    --keep-comments --smpl-spacing --in-place --dir hw

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/msf2-soc.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index e448b0ab74..7619e71cfa 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -93,7 +93,11 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     MemoryRegion *system_memory = get_system_memory();
 
     memory_region_init_rom(&s->nvm, OBJECT(dev_soc), "MSF2.eNVM", s->envm_size,
-                           &error_fatal);
+                           &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     /*
      * On power-on, the eNVM region 0x60000000 is automatically
      * remapped to the Cortex-M3 processor executable region
@@ -107,7 +111,11 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion(system_memory, 0, &s->nvm_alias);
 
     memory_region_init_ram(&s->sram, NULL, "MSF2.eSRAM", s->esram_size,
-                           &error_fatal);
+                           &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sram);
 
     armv7m = DEVICE(&s->armv7m);
@@ -115,7 +123,11 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),
-                                     "memory", &error_abort);
+                                     "memory", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
@@ -184,8 +196,12 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
         bus_name = g_strdup_printf("spi%d", i);
         object_property_add_alias(OBJECT(s), bus_name,
                                   OBJECT(&s->spi[i]), "spi",
-                                  &error_abort);
+                                  &err);
         g_free(bus_name);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
     }
 
     /* Below devices are not modelled yet. */
-- 
2.21.1


