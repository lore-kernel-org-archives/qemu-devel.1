Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35A3C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7DE224658
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7DE224658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4MTJ-0001AQ-RQ
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 05:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4MPV-0003HB-4J
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:16:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4MPS-0004ok-Bu
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:16:51 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:44133)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j4MPP-0004kW-U2; Wed, 19 Feb 2020 05:16:48 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M5g68-1j77Hq3oh0-007Btt; Wed, 19 Feb 2020 11:16:29 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 05/17] hw/arm/xlnx-versal: Remove superfluous semicolon
Date: Wed, 19 Feb 2020 11:16:00 +0100
Message-Id: <20200219101612.1033925-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219101612.1033925-1-laurent@vivier.eu>
References: <20200219101612.1033925-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0UIaGymRkHOi2DF4lkrvQbjocJ0VXLaz83FHsdOiumnOiiA1zHi
 LIhV4jNl/px6A4GtPrTRho0kYUTAI3Od93K1c5BZ5afLvIEVCAAeJA6HIwgsBN0dlKUvT6k
 aO99u8WR0pGgEZOuXBOakFLhxtsGMsbyTvGANEx5N33KelG6S/Rc16t1m8qj5SQnMAGhz4E
 QprhmyVDnmkWg8o7b64ZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LErVUMfUeNE=:hppZXitRdXM4wjlR2gIdh2
 1dtI5dXUv9Jp8Nx04NdkI3sNFJrTldxXXwJoYlirzeUbtFGtk09k3+6+qwcmql4QBYgbDuJGM
 WxETmvirw4SeR1UEmDyTBBdZpg5eVgGHaxc3iz9NvilcIG3VRhvuPr7HycSGUH0398r8Vf4Vl
 kStSX/o7ZES/Y5PU0zkvQ2QInxtvHLsQMSZVayvyhhAQJT44LUcUbz1DJI64XZXpUTvi5SPng
 izJmUHcR5qMAZBQSXBCp6tnGo1hG77j581TA2RmwxoeDoWjx2DmXhEcZHGnxUYRLx55mKoWys
 6kXiE80W2NGo4UUIsrQY9/Djf7XHDyBg6Y8Aw/dRt2rp9IqXfJsgtBGpK54pDyO1/BBVGVrUZ
 NDOzFSM8f/wPxnp86YWToEI/wNWU0hRqZCju5W6kACXRF3zQxalk9DTMB8AwALyKf/vIFedCc
 ImikLPDOZRgz8xM1+Z0Y7TFkFMmEbTsPFVg9wLaApsM6JgGiMi63rYfP8R9V06eWEiMvrE5lc
 oUngbJUHs5xVzWP8ViZBXKBk7wI2t2oNHM7q3Cj/s+ta4L9P4MTdjmcowjDyLiCtMnTJ4U5eN
 ORcrSjOmsCMNATt3DQYPw1fQJZqMac1wULduwNmilKWL8OK1FfMR+lASbP9H1ayxDoNwEUvoI
 o+A1MG7UMVQLPoPuAzz4D8EXGaz3T42WSoU/Pd1b2bHXV1QQ13CihydIrEpq+UFtwXYLi5jI7
 Qdmso8A+sgnXYQ+uxr53REL9d7ZfJ0XZy7Hdp118kx8f1D4VEifE+WmKcJ1Tcp5GRKwbH0f6j
 1MJ/lenEmsPcgHBjHLNHFLQubrWkIMsMbG/zqSLnlD7+fAtTDckpE40JELJDFSbpDWgQjtr
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
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Chris Wulff <crwulff@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Fixes: 6f16da53ffe
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20200218094402.26625-6-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/arm/xlnx-versal-virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 462493c46711..0d2e3bdda169 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -350,7 +350,7 @@ static void create_virtio_regions(VersalVirt *s)
     int i;
 
     for (i = 0; i < NUM_VIRTIO_TRANSPORT; i++) {
-        char *name = g_strdup_printf("virtio%d", i);;
+        char *name = g_strdup_printf("virtio%d", i);
         hwaddr base = MM_TOP_RSVD + i * virtio_mmio_size;
         int irq = VERSAL_RSVD_IRQ_FIRST + i;
         MemoryRegion *mr;
-- 
2.24.1


