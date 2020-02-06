Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66745C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B93D217BA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B93D217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgkY-00034r-Cm
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:59:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1izgck-0001VH-Bl
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1izgci-0006Wq-Tk
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:14 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:37713)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1izgci-0006Sf-JS; Thu, 06 Feb 2020 07:51:12 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MAOeB-1ipXCI3Q7f-00BsBg; Thu, 06 Feb 2020 13:50:54 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 12/12] MAINTAINERS: Cc the qemu-arm@nongnu.org for the ARM
 machines
Date: Thu,  6 Feb 2020 13:50:27 +0100
Message-Id: <20200206125027.1926263-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206125027.1926263-1-laurent@vivier.eu>
References: <20200206125027.1926263-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YjSXEMg85EuQe8WpdOigmHHgR2M7GCMGYoHmBoQQoMd5qPirpPF
 dNHT0XutPVET5RJXlDseqc2xjqeVGPoHp39p419hrt/H8e4Gx+H+wVqSivQyWlBQ86HS6cN
 19IRjuldxbnvSzBwV3+QNjhOqpn2PhonuhWtqJMzN9GnKSfmNSbXsNP35s9pznv4hGrM8dT
 GX+CVIKyx4pvN/1i5WC0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rjQcTHsO2Uk=:GdAH29v1/BasAHa1hwqcXE
 jlmwrX3mD6V7rA9KPG0ElN8oBnZesElcEubbmES99olraZFilAY6kGcz+JcKCbw/4bCl4b9bg
 wfSV3AZzTIfjV9BWYt8D1LoF58rYMPUkWNvWV3CILW9yeOnIIC7AtB6tbFjmP18X5jfczFFx3
 BkGhsr2hz876N68cl5q6R6oemhS/LqvVnQPf9c68yBuhgPTWaKxB12tQyg208NKMEiO6b9UKs
 Ckw0AGc1fE/BKXl3aM1wZVGps59J8VE/IsviDHnPXly+pQAeIdz1tlxHUMzfeW6CAXhP1haqG
 U+atmMvfZ7dRQIt7tbL3eRHUuptw8mZSuPL+CaLsxae0mxgZmBEUP8+3do1B52KzfGHxG9E+F
 O6iDgnAjls5JjClWmtRPDPtvI2hXZHjyUhTh4sUxKxCcIbTVsDRDZ6hCIzs40yyl+SlLXGxJd
 AfQ8V2bjpaIl20JydHxpYEpqn6KeIBGXtGfjgP45jYDAdOXKW9MkDQKwPty63M/V16vfUkxkl
 ZHd6gypPO+0Nu1tqtmKuyovXbAWCugCwQBwk0Ju+gnthMiVNq3waNO2L7E4+O1vPyzzrPEjCV
 j/uUGwPdgmFdwYLlkOoFkbJRZL+4KVZ2N6+uS6AkikYx9kSpyMZJjjPbCgVjafYpVtLVjBKsn
 /wsSTg3lxBBbXETCcwyeNk+xp8gDW8zyyIgJGnqSJTQBXhqlwA09mrPHTkhF1UvYqzmPf5345
 Ldtru3sAOnJikUx6UQeqbFncLlEmO9vYeuw7+UHLfAFqUSve2XHFOMOvjqgUxDrN6E1/t4WhN
 DcQ7tLGyHhPmtkhDnh0krgmi5rfwyiFEl4WD2mm6qJrW1mb9xMSR67yIImvb3qOrid4kh2Y
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-trivial@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Not all ARM machines sections Cc the qemu-arm@nongnu.org list,
fix this.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200120185928.25115-2-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d45ac274ed7..e72b5e5f6968 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -809,6 +809,7 @@ F: hw/arm/virt-acpi-build.c
 STM32F205
 M: Alistair Francis <alistair@alistair23.me>
 M: Peter Maydell <peter.maydell@linaro.org>
+L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/stm32f205_soc.c
 F: hw/misc/stm32f2xx_syscfg.c
@@ -821,6 +822,7 @@ F: include/hw/*/stm32*.h
 STM32F405
 M: Alistair Francis <alistair@alistair23.me>
 M: Peter Maydell <peter.maydell@linaro.org>
+L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/stm32f405_soc.c
 F: hw/misc/stm32f4xx_syscfg.c
@@ -829,18 +831,21 @@ F: hw/misc/stm32f4xx_exti.c
 Netduino 2
 M: Alistair Francis <alistair@alistair23.me>
 M: Peter Maydell <peter.maydell@linaro.org>
+L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/netduino2.c
 
 Netduino Plus 2
 M: Alistair Francis <alistair@alistair23.me>
 M: Peter Maydell <peter.maydell@linaro.org>
+L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/netduinoplus2.c
 
 SmartFusion2
 M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
+L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/msf2-soc.c
 F: hw/misc/msf2-sysreg.c
@@ -854,6 +859,7 @@ F: include/hw/ssi/mss-spi.h
 Emcraft M2S-FG484
 M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
+L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/msf2-som.c
 
@@ -1402,6 +1408,7 @@ T: git https://github.com/jnsnow/qemu.git ide
 
 OMAP
 M: Peter Maydell <peter.maydell@linaro.org>
+L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/*/omap*
 F: include/hw/arm/omap.h
-- 
2.24.1


