Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E3BC3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 08:28:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E5F420658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 08:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fywPq+Yh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5F420658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36041 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyX5w-0005T3-Mb
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 03:28:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iyX3u-0002DO-QS
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:26:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iyX3t-00011l-1j
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:26:30 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55913)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iyX3s-00011F-Rs; Mon, 03 Feb 2020 03:26:28 -0500
Received: by mail-wm1-x342.google.com with SMTP id q9so14722384wmj.5;
 Mon, 03 Feb 2020 00:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EpUTRq0kxtJ0Er2jTMdb5IFTVrAUR3PzkNabxGsF4V8=;
 b=fywPq+YhIU+m28yFYLG6vh+ESwLEVWNCo/gl2Px9g0Q4TZgCJWnV0kmQVeXAOr1YCg
 OxjQWaDmn59Ktu19BxXfsCgaMZme9hgS1ECZkle7ZyvbdFgdt+T733EWMznrleXHUzJp
 8M9bwZJNoAh1eiec5eREX3kMryrB/4WkrKhm/DNx6G1H3UGspky0jOvdXxOiKHiCEuNK
 QoauoNjYKzZb1I+s6XEIwAGlk4w/1KWpTpdUFBIGbE6I0gzIGC0hNAEfdc9sGkW1zUS9
 6M/60oYaoth0V49RiZX/EZmQ0YeBkTESe+F0qtiK6LfxmbYVsp1VEANdFspNCUjww0AH
 gbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=EpUTRq0kxtJ0Er2jTMdb5IFTVrAUR3PzkNabxGsF4V8=;
 b=KzQ5lyEBnWT4lEQ1PRfpEf2z5vXcmlcAWkIorsuCoEjqrdPus76snAQwVaOBipj2Eg
 cgHyanRvGdB7DQ7+ZbPWXzpt/ebmlQxc7dnryFT3hiJo72K8Dx9bpiKCPmPA+zwM+al6
 nJ97tr3yDhTTySxLKH6bjJv+HjBSxG/p93oR5gUn9OxPDjs5zGU0H7q3FX5rsyC7s7rI
 H4FxhQWkf9YfvUO9jZyDjmt4BQ7ZQCYElylcQmAk21C6HMxjCv1xJJ/mJw8CjL+pT/9z
 1tT9/0zC5rUS8+rRWejwrPeY2uKVYGG19ay0IJiCGqiUOD6mfZbMSGwtNuMdIuoPgkYx
 O8Gw==
X-Gm-Message-State: APjAAAVJOwMWFpjMNuEJufZ8+P7FHdv8aWKtVFQGEucuSqE7eN5MGFpS
 dP1eCiNPv17ZVb05uj+1o/40ryii
X-Google-Smtp-Source: APXvYqwnDfQj625IvnQJF4yI5+KpOihczsKwND7QYeXRSIzExO9aXO/o0p3cixT1GJdq3ICNgaKArQ==
X-Received: by 2002:a1c:9c87:: with SMTP id f129mr28804653wme.26.1580718386542; 
 Mon, 03 Feb 2020 00:26:26 -0800 (PST)
Received: from localhost.localdomain (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id w20sm22396778wmk.34.2020.02.03.00.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 00:26:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] hw/arm/raspi: Get the SoC type name from the revision code
Date: Mon,  3 Feb 2020 09:26:16 +0100
Message-Id: <20200203082619.7426-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200203082619.7426-1-f4bug@amsat.org>
References: <20200203082619.7426-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already know the Chip ID, let's name it with the
board_soc_name() helper.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index eaa8c49009..f5e54fe876 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -31,6 +31,18 @@
 
 #define MACH_TYPE_BCM2708   3138 /* Linux board IDs */
 
+enum BoardIdChip {
+    C_BCM2836 = 1,
+    C_BCM2837 = 2,
+};
+
+static const struct {
+    const char *soc_name;
+} soc_config[] = {
+    [C_BCM2836] = {TYPE_BCM2836},
+    [C_BCM2837] = {TYPE_BCM2837},
+};
+
 typedef struct RasPiState {
     BCM283XState soc;
     MemoryRegion ram;
@@ -69,6 +81,11 @@ static int board_version(const RaspiBoardInfo *config)
     return board_chip_id(config) + 1;
 }
 
+static const char *board_soc_name(const RaspiBoardInfo *config)
+{
+    return soc_config[board_chip_id(config)].soc_name;
+}
+
 static void write_smpboot(ARMCPU *cpu, const struct arm_boot_info *info)
 {
     static const uint32_t smpboot[] = {
@@ -213,8 +230,7 @@ static void raspi_init(MachineState *machine, const RaspiBoardInfo *config)
     }
 
     object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                            version == 3 ? TYPE_BCM2837 : TYPE_BCM2836,
-                            &error_abort, NULL);
+                            board_soc_name(config), &error_abort, NULL);
 
     /* Allocate and map RAM */
     memory_region_allocate_system_memory(&s->ram, OBJECT(machine), "ram",
-- 
2.21.1


