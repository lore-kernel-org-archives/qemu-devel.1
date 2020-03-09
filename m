Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF68C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCBE320578
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBE320578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKSz-00058Q-0x
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBK3L-000133-VO
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBK3K-0008Rc-U3
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:10:47 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:48315)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBK3K-0008QD-KH; Mon, 09 Mar 2020 11:10:46 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mnq0K-1jhv381qnK-00pMwm; Mon, 09 Mar 2020 16:09:56 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 31/33] display/pxa2xx_lcd: Remove redundant statement in
 pxa2xx_palette_parse()
Date: Mon,  9 Mar 2020 16:08:35 +0100
Message-Id: <20200309150837.3193387-32-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309150837.3193387-1-laurent@vivier.eu>
References: <20200309150837.3193387-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0ZarNXicwnBKj9J9FMdMNcdU3DRCu0rkKMaoTuRHns0GqwH3ZvJ
 N14XFeavkwMTWI4zaDmKiaQdapB0uzbHlSrNBFE9B6eTbYoJrLepzSJVlF1pXBLKo88fMP2
 P0qpb0etOg5/BSz/bTRTZdYZbWPBowIaxCg7NKX/lZtUXNk6zTqaRPMivTvIRDZIErdH7wo
 BG4vKVERVC1sx3TLIjdVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kjGuiN/P8HU=:rT5JMBaeRa6M9Vlj0MdT/Y
 Pl7es7mxm+MfAt4MnjJtzfzmDv2xe6rCQf++J156YGGkasOoma8krVX7KOYC/DAAWCZxW5FKx
 nFbcSZU009zR4zFKaMABf5DgTLrVFdduWtOW4A19Jm9cYnOMhmiw656EkOmesWbwWKPSDCELp
 wMC41K3oKgWo84p5DnFjkZo2jv0wJvut1xuaLP26llgzt9L3A+2lZG+wG0Z/b0vR04q3cOSyn
 ArV/yuqJKrPZGimphVTQFmH4gX3uwdAck26/VfYBqZWAKRCYgqI9ANfhupb3MfNe3JgJe8jM2
 YQYNV5JRkjbxgYUEEsf3E7QzuFbqsnk8DlsADUcKa9admhrEJqztFUpH43R8bEB26w1/Zmvfi
 kXnPsuDPyVWjgb9CRPrVUCIgEoRmPEpfJnr2Fd6+ugJtJIFDSdYU1eeLWI8MI0uQtiiMq0D1P
 +qr90FEnNvSSOXyntUjbzL/uXYK3wa6HbTKq2VRmGeUMgPrI/bt2llNvLJzRG4EoA++6JBczq
 8olLJFnLtNc04MDVEgags9FsM2+27l7z0Haw1M7+PZLvU+/etB8px/FRdrn6qZhBEYjjB/E4D
 JK8s+jOyp6wLYy4sz1hn1kehmjiJEY0LaAwF6k7oVFvGFtAb6SIvWk6wJg1yeSJfaA80EGwLZ
 pI/e/Ov02oRRPl13OK1eP1byqDzFc6XaA4T75LZuotnZRJPqj8GfplPCCWcpg2uXzwqAMPNSH
 mzQLmw+kZPIJMR4/uvWRlb7chTMAeyBsPzjM3ppnGpGu/V6c5E7WMmoT2tRMhPn0Bp3ip2tJ2
 edFskB9w09y66oJ9apTzuFxOE3sWz7yPjtl97hJAwIMcWBq0HCTY5TA8Qv18ZrlsNUGe7O2
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
 Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Chen Qun <kuhn.chenqun@huawei.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Euler Robot <euler.robot@huawei.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

Clang static code analyzer show warning:
hw/display/pxa2xx_lcd.c:596:9: warning: Value stored to 'format' is never read
        format = 0;
        ^        ~

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200302130715.29440-8-kuhn.chenqun@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/display/pxa2xx_lcd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/display/pxa2xx_lcd.c b/hw/display/pxa2xx_lcd.c
index 05f5f8467123..464e93161a21 100644
--- a/hw/display/pxa2xx_lcd.c
+++ b/hw/display/pxa2xx_lcd.c
@@ -593,7 +593,6 @@ static void pxa2xx_palette_parse(PXA2xxLCDState *s, int ch, int bpp)
         n = 256;
         break;
     default:
-        format = 0;
         return;
     }
 
-- 
2.24.1


