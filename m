Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5300C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:30:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD7152067C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7152067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKMH-0004i9-TG
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBK3e-0001LQ-2Z
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBK3c-0000Al-Tq
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:11:05 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:32827)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBK3a-00007m-6F; Mon, 09 Mar 2020 11:11:02 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MxUfn-1jZqAI2tKr-00xr6l; Mon, 09 Mar 2020 16:09:51 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 29/33] dma/xlnx-zdma: Remove redundant statement in
 zdma_write_dst()
Date: Mon,  9 Mar 2020 16:08:33 +0100
Message-Id: <20200309150837.3193387-30-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309150837.3193387-1-laurent@vivier.eu>
References: <20200309150837.3193387-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VR7JvRspay92/RpC3019xh/+yKSsaZhhChauw/DzrILMmPwVQbl
 KT4mJuwv7zsMg8kFmidAhL99c1eGnnbg5NNW/kWiba09T5ch/Xk+uCGHmODaXNx4gqY9foN
 MHoIHGw1idZjYnPtI+UwJ0/GC0NKFMGfrCLc4/0mWRW2Ci0UJzNhUSWtgfS1YWnWTBrFo5J
 WgnNnY1Gd1b1rSq0R9iNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d/Zn4yl+QlE=:bGwabL+x5posZ6fqHJw5as
 cbs5eAUKfZbTwBoLi20DntdUpuY1+oivFuvbLrQ3Sqy7FFk6BSHr1InaA+3IInPAYXrYZObX6
 Ss7HORg+et8/6Ve5saonFY7g+ytd6/EthYjPSeE0Ot9S1VmimpI2JVz0zNdBZESUrulqkrBVR
 ZULkjXUwca+BMN1wUILV/jYp+hGhsc2nMa4ZYWgVBtqOjCX0z0dg7+9pcAZIa/UjtI3Kg3LRJ
 Y2J9VZ1UcEbEllt/+H3gkuwni7WU0+c4IQTw7lYV2wdWpHN6y0IITPCbCAPRNimU/JEnVe2mH
 Qbb15PdX8Scgp0zU6WxwjhCXQAdifK2y3I0CQBdpac4sRwX9fbzjMS0XLY+S1L27FHyS3S+Wi
 7kqNnpN6n4uNt65GW1Y2xpyjFZ5gQcRajJ/BVAr9HLZrxHpoFi+GtjPvaGRD9U+DbfVxisMLM
 VPhupl0DIfC67sSmh91aao/kkmxhD1ie+stKIgVMI7Oobcrr61Ntl/I5ZW3o10meYsZ/Cz5Gg
 5z2QnwAUwXpg9OXWYIOlVhBwhzroe2TZvzOoNQu8dM0zSHpH+Vvhg4/hOYSHMp1b15N1nLmVl
 hYuUxGiE/XVYIid6DntY0XMzHlaToiQ9QkaH7gSawR+FmKpopFR+T253t2zKGlNHdH5Miw7ke
 kP04ynScr7SwHy0/ZAT1iFfGrRd2dqOSm4hbV9EY0g4Eo1ysEjYzYbspsc0HplGPYqFb6vBmI
 pguoy+EqZy+Ll4xvB6p1meABu/CAZ8YvuLf0DofO2CeWnvyXOxlHDrRJgTpRm2L10mGjqIvmT
 dAQR4AAmHLyZiElb9iF33OIfDetvDh/kRUEI7e/yDVhNkVQ2tvMCozg2+AsKadReuG9lIt4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
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
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Francisco Iglesias <frasse.iglesias@gmail.com>,
 Helge Deller <deller@gmx.de>,
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
hw/dma/xlnx-zdma.c:399:13: warning: Value stored to 'dst_type' is never read
            dst_type = FIELD_EX32(s->dsc_dst.words[3], ZDMA_CH_DST_DSCR_WORD3,
            ^          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-Id: <20200302130715.29440-11-kuhn.chenqun@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/dma/xlnx-zdma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 1c1b142293a6..2d9c0a0d5e19 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -372,7 +372,7 @@ static uint64_t zdma_update_descr_addr(XlnxZDMA *s, bool type,
 static void zdma_write_dst(XlnxZDMA *s, uint8_t *buf, uint32_t len)
 {
     uint32_t dst_size, dlen;
-    bool dst_intr, dst_type;
+    bool dst_intr;
     unsigned int ptype = ARRAY_FIELD_EX32(s->regs, ZDMA_CH_CTRL0, POINT_TYPE);
     unsigned int rw_mode = ARRAY_FIELD_EX32(s->regs, ZDMA_CH_CTRL0, MODE);
     unsigned int burst_type = ARRAY_FIELD_EX32(s->regs, ZDMA_CH_DATA_ATTR,
@@ -386,17 +386,17 @@ static void zdma_write_dst(XlnxZDMA *s, uint8_t *buf, uint32_t len)
     while (len) {
         dst_size = FIELD_EX32(s->dsc_dst.words[2], ZDMA_CH_DST_DSCR_WORD2,
                               SIZE);
-        dst_type = FIELD_EX32(s->dsc_dst.words[3], ZDMA_CH_DST_DSCR_WORD3,
-                              TYPE);
         if (dst_size == 0 && ptype == PT_MEM) {
             uint64_t next;
+            bool dst_type = FIELD_EX32(s->dsc_dst.words[3],
+                                       ZDMA_CH_DST_DSCR_WORD3,
+                                       TYPE);
+
             next = zdma_update_descr_addr(s, dst_type,
                                           R_ZDMA_CH_DST_CUR_DSCR_LSB);
             zdma_load_descriptor(s, next, &s->dsc_dst);
             dst_size = FIELD_EX32(s->dsc_dst.words[2], ZDMA_CH_DST_DSCR_WORD2,
                                   SIZE);
-            dst_type = FIELD_EX32(s->dsc_dst.words[3], ZDMA_CH_DST_DSCR_WORD3,
-                                  TYPE);
         }
 
         /* Match what hardware does by ignoring the dst_size and only using
-- 
2.24.1


