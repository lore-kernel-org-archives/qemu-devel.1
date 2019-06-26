Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6321C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 11:53:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01F820663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 11:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01F820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg6UO-00077c-QC
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 07:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43668)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hg6NH-0001KL-3p
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hg6NF-0005wf-Mz
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:46:02 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:60774 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hg6NF-0005ts-EE
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:46:01 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id E478A1A46A1;
 Wed, 26 Jun 2019 13:45:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id B5A811A4651;
 Wed, 26 Jun 2019 13:45:56 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 13:45:42 +0200
Message-Id: <1561549550-3501-10-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561549550-3501-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561549550-3501-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 09/17] dma/rc4030: Minor code style cleanup
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Fix some simple checkpatch.pl warnings in rc4030.c.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <1561472838-32272-3-git-send-email-aleksandar.markovic@rt-rk.=
com>
---
 hw/dma/rc4030.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index 88ff271..155af9b 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -58,8 +58,8 @@ typedef struct dma_pagetable_entry {
=20
 #define TYPE_RC4030_IOMMU_MEMORY_REGION "rc4030-iommu-memory-region"
=20
-typedef struct rc4030State
-{
+typedef struct rc4030State {
+
     SysBusDevice parent;
=20
     uint32_t config; /* 0x0000: RC4030 config register */
@@ -152,8 +152,9 @@ static uint64_t rc4030_read(void *opaque, hwaddr addr=
, unsigned int size)
     case 0x0058:
         val =3D s->cache_bmask;
         /* HACK */
-        if (s->cache_bmask =3D=3D (uint32_t)-1)
+        if (s->cache_bmask =3D=3D (uint32_t)-1) {
             s->cache_bmask =3D 0;
+        }
         break;
     /* Remote Speed Registers */
     case 0x0070:
@@ -538,8 +539,9 @@ static void rc4030_reset(DeviceState *dev)
=20
     s->memory_refresh_rate =3D 0x18186;
     s->nvram_protect =3D 7;
-    for (i =3D 0; i < 15; i++)
+    for (i =3D 0; i < 15; i++) {
         s->rem_speed[i] =3D 7;
+    }
     s->imr_jazz =3D 0x10; /* XXX: required by firmware, but why? */
     s->isr_jazz =3D 0;
=20
@@ -551,7 +553,7 @@ static void rc4030_reset(DeviceState *dev)
=20
 static int rc4030_post_load(void *opaque, int version_id)
 {
-    rc4030State* s =3D opaque;
+    rc4030State *s =3D opaque;
=20
     set_next_tick(s);
     update_jazz_irq(s);
@@ -591,7 +593,8 @@ static void rc4030_do_dma(void *opaque, int n, uint8_=
t *buf, int len, int is_wri
     hwaddr dma_addr;
     int dev_to_mem;
=20
-    s->dma_regs[n][DMA_REG_ENABLE] &=3D ~(DMA_FLAG_TC_INTR | DMA_FLAG_ME=
M_INTR | DMA_FLAG_ADDR_INTR);
+    s->dma_regs[n][DMA_REG_ENABLE] &=3D
+           ~(DMA_FLAG_TC_INTR | DMA_FLAG_MEM_INTR | DMA_FLAG_ADDR_INTR);
=20
     /* Check DMA channel consistency */
     dev_to_mem =3D (s->dma_regs[n][DMA_REG_ENABLE] & DMA_FLAG_MEM_TO_DEV=
) ? 0 : 1;
@@ -603,8 +606,9 @@ static void rc4030_do_dma(void *opaque, int n, uint8_=
t *buf, int len, int is_wri
     }
=20
     /* Get start address and len */
-    if (len > s->dma_regs[n][DMA_REG_COUNT])
+    if (len > s->dma_regs[n][DMA_REG_COUNT]) {
         len =3D s->dma_regs[n][DMA_REG_COUNT];
+    }
     dma_addr =3D s->dma_regs[n][DMA_REG_ADDRESS];
=20
     /* Read/write data at right place */
--=20
2.7.4


