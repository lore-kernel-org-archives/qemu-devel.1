Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA899C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:38:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4FA720578
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FA720578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKUP-0008L3-Pb
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBK32-0000TZ-K9
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBK31-00088I-KR
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:10:28 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:58415)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBK2v-0007zo-C1; Mon, 09 Mar 2020 11:10:21 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mv2tK-1jSzTQ44v2-00qzTi; Mon, 09 Mar 2020 16:09:25 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 18/33] hw/timer/hpet: Include "exec/address-spaces.h"
Date: Mon,  9 Mar 2020 16:08:22 +0100
Message-Id: <20200309150837.3193387-19-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309150837.3193387-1-laurent@vivier.eu>
References: <20200309150837.3193387-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:O5ktA5u/pvyBqK+lJEE+rKA/tVmNCUJ8OU4Z4k0rTqvuYlimz6i
 zz5oDt9n7A5K5U6qdBg+9And87yDAwyhK9O4lur6RV8vEajaOF+C8CsCQBL3n7+T3N31dTV
 G1pRP6Htz2hbJt7FWPJNyDHsqKaic4trqLzYucN6GzIBjQTPgCbRXIpJfnap/Zzg3Wg5mtg
 8EvDCJ+xA1OdsbxcQtiqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:515utrpxNXo=:RiGyt17IZdJ98n0ovCeb4p
 I3JIIC5TapNk/BxUyyZ0u33IlpH42C4UYBtNGtbHRaE3yLlvja2v6459g0Gxm7/3MPvwUBqqa
 XkSVXaZJevXpHFocvlkvuq967E/ppVlhjbhkmOJXkT0juDsvn2A0M+k58mFSC/6SleYLpYZaM
 9KfAdza59Gg9MINcDQ7wuI8HTB0AztnjO+nvIYM8sXO+X6+f53YrZKdvkbrfhs2Ytf15lK5/8
 k40qP2Ds8V9Or7ZPX6n8K2Xa1VDCTZJtrEqOElZZYG3jcUImQtiBJF/wRheSLdvbgCJd7/aE+
 ZvMc7WdfcJskgKWUWq5AJtk2URs6KbUeLL0amun2501bMehfAs/ocpXzT8joXm63webEMOBA+
 RyjaDCuk8zzuC9vXZUK3FsOtsVh2rfnZNgF9FUcgcY8QN7izrD/iI3efDF4vowEBHT5AdEvhQ
 OE3aNSR2hSCBZpXkifG20W1TJh8s1CUNXj1Qg7f0PGDA/qCOJDL1evsbD0eCavIOxju3mZZct
 MA+JjYpkvN9fDH/lwxemkkeAVLuRk2s+sGW8LmsdA9wwEMWRsbvD5q0HJo0Lk4sx8N8gITo2U
 F51qmdfWW18MNNLOqPN5EmnFsEzZZFBscuMUG17X4Ys5j+bXzjjnWfHDKB02o9fTAznEint5o
 aIm5DzlODVRAV+pjVZNq/77T0oKWTm2p4tgRhhdgQICnjbSbwCdIIBCOcWDZTPcBDZvFgWHk7
 Qi4P+WvcPAT6AOs3QxA0gGSoh5QPV+GEqT49Qp9FhRi1XR20q56Mq2O6324sHUXHIpBPKCoVL
 O71gEHKw5XxiBJpu5KDXqAg0KXGTbju2tdh+ILPGw8YxAXcr1T5uK6L4fBezgB805fE/NJZ
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, Greg Kurz <groug@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

hw/timer/hpet.c calls address_space_stl_le() declared in
"exec/address-spaces.h". Include it.

This fixes (when modifying unrelated headers):

  hw/timer/hpet.c:210:31: error: use of undeclared identifier 'address_space_memory'
          address_space_stl_le(&address_space_memory, timer->fsb >> 32,
                               ^~~~~~~~~~~~~~~~~~~~

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200228114649.12818-12-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/timer/hpet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 4f30dd50a40a..380acfa7c8a5 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -36,6 +36,7 @@
 #include "hw/rtc/mc146818rtc_regs.h"
 #include "migration/vmstate.h"
 #include "hw/timer/i8254.h"
+#include "exec/address-spaces.h"
 
 //#define HPET_DEBUG
 #ifdef HPET_DEBUG
-- 
2.24.1


