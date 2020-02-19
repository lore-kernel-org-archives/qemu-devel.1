Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100A7C34056
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB8D2465D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB8D2465D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4MWJ-0000XF-0k
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 05:23:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4MQ8-0004Ax-Rp
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:17:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4MQ3-0005oo-Sb
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:17:32 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:43541)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j4MPu-0005VQ-Iy; Wed, 19 Feb 2020 05:17:18 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1McHM2-1jaONM07IK-00cgh9; Wed, 19 Feb 2020 11:16:52 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 17/17] hw/xtensa/xtfpga:fix leak of fdevice tree blob
Date: Wed, 19 Feb 2020 11:16:12 +0100
Message-Id: <20200219101612.1033925-18-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219101612.1033925-1-laurent@vivier.eu>
References: <20200219101612.1033925-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2d2DdnBIT4QzL6xniwXm6iBbRodr9Z9EJgRhZyD11lTxEOZi5ih
 jzkXcdw805ZSlb6qs8qrMskTlO9hiW7BdZveZ84yjog/lIFx1wRSYviWMpcjXcPI0zgAubW
 NXKwC90SodKEbaHPzlw6hOApbQf9VEM90b94R7XuCuiutC24oWen4Tz8gyudsuQGxB/EIfE
 FbJTPSbTwBM0rX0y4XZuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ARdIMovQ8QM=:/udeQ+opwPyE+3PMD2T7+V
 LV1U6CoLgQ6itRUERxmiE70V3DBGdEpWWaMs9IB3K6bXN4f1/BByhpLE9O+36Ar4pPe1HwvIH
 TOXgnrH/qnnWVCIEUe2rTH/h5wIPATlnj8sdzWb3qJnGHJZ1fRNH4dLx6zppMCTxCYZvpJgOe
 eeV55IDrlwpTr72z5x2LI88zvd0sInaReVNpp89HjCf9P/99WQHaqVEx4viTpHCpes20Fpcmz
 4wm76XRFL//ozV/V+TRQ19ouAd8LfuFNYkXoNkj5Yq8BSsVlRdhruTH2zHfjDJovglTb0OzMZ
 zeo7Lq5T1YgbRPBaO2nPSCQR51p0qEXqEpgsDMvKlj/1gSV5Eza8uHgoZ+KK+guCQcJl3xKs0
 RTUIs7GaNcJsmJo3cxdvpO7MKCX5BNeEtx3SrgwjXIqT3LogOnNGwtU0C1Z9m4jwYEbElEUgV
 zJZeSSJ8nQ+wjcYatF3hE+tJ9PDd3TVFob3RXuGDkZS0mD72NS8RYRhJ8eWXWPUUpNcW71ngP
 f8shO4TBD2W8uoShLtCpe9Bz+f0vMkL1z9/8Aihhy2A3tVFesQi1WzcjgLdGsn8j8gdY593Rk
 PTUKcEhlHnId5M9KkGzPxjXGpLsLFnWCXVIiPu+OasCTE+UTfmQkcB9WIbRBfLMUqAFJWO4Dk
 IIhi8BzCaYWpWqzuwa5955FTb9kYgtchip15rCD4ZxPV2cTKHQ99wOE6H6Utlnvj7osOJsEG9
 5J3rPAECW7z7U6AMb754HNcxu3XmyQuhRV3ujJdcV2iE6tK4S2omcn6b0pE9sopU03yXkm+oF
 ZHND4497IU9FXGHMi6zCtg9ZP+50YP7QCiwPQQPY+4+/yUo1ouO6KBbko3Kj7FFOmaNhqDz
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
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
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Chen Qun <kuhn.chenqun@huawei.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Euler Robot <euler.robot@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

The device tree blob returned by load_device_tree is malloced.
We should free it after cpu_physical_memory_write().

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200218091154.21696-4-kuhn.chenqun@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/xtensa/xtfpga.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 8e2dd1327a46..60ccc74f5f1d 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -380,6 +380,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
             cur_tagptr = put_tag(cur_tagptr, BP_TAG_FDT,
                                  sizeof(dtb_addr), &dtb_addr);
             cur_lowmem = QEMU_ALIGN_UP(cur_lowmem + fdt_size, 4 * KiB);
+            g_free(fdt);
         }
 #else
         if (dtb_filename) {
-- 
2.24.1


