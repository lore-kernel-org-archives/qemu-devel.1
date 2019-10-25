Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9ADCA9EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569E521D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569E521D71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNvKe-00048j-4S
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 04:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNv5Y-0001hf-5L
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNv5W-0008KZ-Ul
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:51 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:34557)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNv5P-0008CN-FA; Fri, 25 Oct 2019 04:36:43 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M4K6z-1iOC3d1MB7-000O1d; Fri, 25 Oct 2019 10:36:00 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 18/19] hw/rtc/xlnx-zynqmp-rtc: Remove unused "ptimer.h" include
Date: Fri, 25 Oct 2019 10:35:10 +0200
Message-Id: <20191025083511.11463-19-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025083511.11463-1-laurent@vivier.eu>
References: <20191025083511.11463-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bIVh4Atdz8bHUNgDKytO4sxywaGZPxNGPkscIkQ59ZOiIyIm/xq
 c8nPdAO8wITFiXU10dVK67Q/hD/eeRjyt7FlwozDNzVNUSu7N5VWqK4n9MHIEupT16Crppp
 +0UYhJlob30MSu6hlUpt/rYmmSIknby3svJtfkCbqClmTP2DvE77O6Cr/Vjh0/9KYswm32T
 w1Ix0+hjxjmif4ar3mGhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ra8smSEyvIs=:JTCe2FY0XoUYysYNNN89O1
 Aro3pi6I4fhHm4AXqjsGea1WxQ8lDqO8HwQEFWwhrLOhITnHTI5eUXJvhIt0GMXwm/DeFkNdR
 hwoS5iC4RNrZKP67fcCvcGfzLiSA9UTG4C9iXv22bVb8VvQXUkSA9dYfqd/dsLiRs45QUnad9
 zA/nUqmX8FuHrTAG0tIu/nU54+5tcZ4yzruXEVO3gmKT3Y57Vg3TgEMP6m5a1YD0dYifPr4Pd
 sXmSE/JT4TCZVAdDieQlFOlQvbKJRPIsceaIAmRxPqwBGs0HASYSfi+lfAwHw0U7Y0x5wsm3/
 9WJxT8d+CzM8spnitrE5LWibeOCMgXQIs1OHPLTGpeUzjDeN2VwO0T+Er2WnAJsor16ProFgS
 wAEVxOrsFTiWUV3lmudp0OACmpXsVweblTah713IRaExbhR/8dh0Mt13VZ0e/cQ6MHC38TaE0
 9kaFSItY77DwttlKpPO9H++p5pz30/gi+/218zR38dNd3kQhD8xRp1sM+9hU0WASgdwMJ8r4n
 TdVGDxjqw4EuezAQ8Oj8c/CLg1pXmsBW5K2db5k3aXxr6ZejRx7CrFXlLe8UJJaE7NIfd+9lA
 0QzMMrM8UMUV+e0eDDj6N9EqBfWifrQTW0K6cqBviaI0NY41Jkdz1Nrb8Tsa1eOJbmIEpnEou
 i90n4oLape0x7p56MhqJU6a3/17VV2xLf/+iQoZHWaulz5scPM0C+YT1BBp9XWHhZCJ0P6m/l
 m/ZN9K3mlbjRLF4NFqnVPHbc4j8RkIPBYHBFLZVbL+N8LlTHkUBasWh479xXMrKjxUT3dYn1w
 Y1NtT6Ae5egJGyc+vSkA61Alkz492aB6TBA+1GkOGAVQvyn9Wwp8KmcJQomuV6rs7nr+2U36q
 c7X5oYlwsc6k8qGcSOZEzK/5ySzyhlnCIxPACRGrk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.131
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
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Andrew Jeffery <andrew@aj.id.au>,
 Laurent Vivier <laurent@vivier.eu>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The "hw/ptimer.h" header is not used, remove it.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20191003230404.19384-14-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/rtc/xlnx-zynqmp-rtc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/rtc/xlnx-zynqmp-rtc.c b/hw/rtc/xlnx-zynqmp-rtc.c
index f9f09b72965a..2bcd14d7795d 100644
--- a/hw/rtc/xlnx-zynqmp-rtc.c
+++ b/hw/rtc/xlnx-zynqmp-rtc.c
@@ -32,7 +32,6 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/irq.h"
-#include "hw/ptimer.h"
 #include "qemu/cutils.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
-- 
2.21.0


