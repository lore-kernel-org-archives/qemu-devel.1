Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1827C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96F420868
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96F420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47396 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTTxa-00035f-1F
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 12:19:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTnI-0002Xj-Kp
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTnE-0004qR-SC
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:08:42 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:47827)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hTTn2-0004Co-5p; Wed, 22 May 2019 12:08:28 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MQ5jC-1hGC5U0D8i-00M2WB; Wed, 22 May 2019 18:07:32 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 18:07:15 +0200
Message-Id: <20190522160723.31484-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522160723.31484-1-laurent@vivier.eu>
References: <20190522160723.31484-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RMi5HTURvFvdxGe93BOeChtzHT4SQolFxxyjn4qxM628gfPOrQm
	9CzKi3I0voJlrGHPjHQwMWhuYDfkpy+FQPDdvn+SM5PE+4se3u3zykeXqbqneXfvEP1sDi1
	BskIPvYECJC5dnA7RjcYVwHxxEaphkhBLA+1Qd8J/GI2eILGeUq71TjZ1fzgEFheVbcwnhE
	5NgGjmhUQkRhiTFJHKgnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mFBRIQu3+8M=:iyEpLawWpc5VYp9Z0Cue6k
	l2yOr05OejsDO47E2wV0hkYVWSLE9TFlp4RDIN7xNJkEw12JGW6G7Ul6J6U5nq2EsTfHETiVF
	xJsiC/1V3rxDr09fCaUhrCqA484CuMT4Cn/Uwzm0anH9rNl1XzXVmZ0qlonXqFUsm42CusYQU
	wfJH6ZA2gsN/vNOj0OktSx/rDU7cTWO8WYI1vwCThqKKr9ukmYC5i60cRvDUbeBbCRuVvDWfp
	jILAGKFqz1O8ZKPRM6vLhyRswS2JYabEnDS8tFmMN8bvpwT5HoGrwvG+YGPJMnEaIaI7I19GM
	OzYhTZ/TgzZaG3yEjE+nC0ryfDBT9zmFhR525RvWbHE5vOdz7EUFM0bxKBVoJrEKV1PqgiRDM
	cZ/l23TtJQjofiWo85ybsaL1PqnBuSrlnWL9UYOUub2koGNC9EAE942WcXLPIoIRTyThY9WSv
	SgMwmaxMvquBNdf/kTN5eL2I1MZj1H/z/tix1wU3Ae/FGvRMHHoL5CAy0WEqstPDSqNwGddnp
	I3MZnEfuxYSGATKqlKXoqUdKazXzFq5QidfmE9YB2EAm0NJWR01yYc0DjdGSLeC50ehn+PhS3
	Yw4xz6/DkPTJjAb3lBeghAH2JyRfNgG9b4C6uJlyarrxvM2vm3QmfaymabnftKxHL36bNOTnM
	0AZ7VKhYnp2BI10qVGmlyBxHagbK2TCvuUbn1aDjG3jxtV8x61z5PzaKB3iuKd3qm8v7BFoBM
	sM9mNmL2YBAAATkRyxRiKywnYxkmx+FMjKcIA0658ntffdKqEfn6sxtsGks=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: [Qemu-devel] [PULL 1/9] hw/virtio/virtio-mmio: Convert DPRINTF to
 trace and log
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
	Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Alex Williamson <alex.williamson@redhat.com>,
	Yuval Shaia <yuval.shaia@oracle.com>, Laurent Vivier <laurent@vivier.eu>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Boxuan Li <liboxuan@connect.hku.hk>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Boxuan Li <liboxuan@connect.hku.hk>

Use traces for debug message and qemu_log_mask for errors.

Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Message-Id: <20190503154424.73933-1-liboxuan@connect.hku.hk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/virtio/trace-events  |  7 +++++++
 hw/virtio/virtio-mmio.c | 44 ++++++++++++++++++++---------------------
 2 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 60c649c4bc96..e28ba48da621 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -46,3 +46,10 @@ virtio_balloon_handle_output(const char *name, uint64_t gpa) "section name: %s g
 virtio_balloon_get_config(uint32_t num_pages, uint32_t actual) "num_pages: %d actual: %d"
 virtio_balloon_set_config(uint32_t actual, uint32_t oldactual) "actual: %d oldactual: %d"
 virtio_balloon_to_target(uint64_t target, uint32_t num_pages) "balloon target: 0x%"PRIx64" num_pages: %d"
+
+# virtio-mmio.c
+virtio_mmio_read(uint64_t offset) "virtio_mmio_read offset 0x%" PRIx64
+virtio_mmio_write_offset(uint64_t offset, uint64_t value) "virtio_mmio_write offset 0x%" PRIx64 " value 0x%" PRIx64
+virtio_mmio_guest_page(uint64_t size, int shift) "guest page size 0x%" PRIx64 " shift %d"
+virtio_mmio_queue_write(uint64_t value, int max_size) "mmio_queue write 0x%" PRIx64 " max %d"
+virtio_mmio_setting_irq(int level) "virtio_mmio setting IRQ %d"
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 5807aa87fe8e..96c762f0bf88 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -27,16 +27,8 @@
 #include "sysemu/kvm.h"
 #include "hw/virtio/virtio-bus.h"
 #include "qemu/error-report.h"
-
-/* #define DEBUG_VIRTIO_MMIO */
-
-#ifdef DEBUG_VIRTIO_MMIO
-
-#define DPRINTF(fmt, ...) \
-do { printf("virtio_mmio: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+#include "qemu/log.h"
+#include "trace.h"
 
 /* QOM macros */
 /* virtio-mmio-bus */
@@ -107,7 +99,7 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
     VirtIOMMIOProxy *proxy = (VirtIOMMIOProxy *)opaque;
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
 
-    DPRINTF("virtio_mmio_read offset 0x%x\n", (int)offset);
+    trace_virtio_mmio_read(offset);
 
     if (!vdev) {
         /* If no backend is present, we treat most registers as
@@ -144,7 +136,9 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
         }
     }
     if (size != 4) {
-        DPRINTF("wrong size access to register!\n");
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: wrong size access to register!\n",
+                      __func__);
         return 0;
     }
     switch (offset) {
@@ -182,10 +176,12 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
     case VIRTIO_MMIO_QUEUE_ALIGN:
     case VIRTIO_MMIO_QUEUE_NOTIFY:
     case VIRTIO_MMIO_INTERRUPT_ACK:
-        DPRINTF("read of write-only register\n");
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: read of write-only register\n",
+                      __func__);
         return 0;
     default:
-        DPRINTF("bad register offset\n");
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad register offset\n", __func__);
         return 0;
     }
     return 0;
@@ -197,8 +193,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
     VirtIOMMIOProxy *proxy = (VirtIOMMIOProxy *)opaque;
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
 
-    DPRINTF("virtio_mmio_write offset 0x%x value 0x%" PRIx64 "\n",
-            (int)offset, value);
+    trace_virtio_mmio_write_offset(offset, value);
 
     if (!vdev) {
         /* If no backend is present, we just make all registers
@@ -226,7 +221,9 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
         return;
     }
     if (size != 4) {
-        DPRINTF("wrong size access to register!\n");
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: wrong size access to register!\n",
+                      __func__);
         return;
     }
     switch (offset) {
@@ -246,8 +243,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
         if (proxy->guest_page_shift > 31) {
             proxy->guest_page_shift = 0;
         }
-        DPRINTF("guest page size %" PRIx64 " shift %d\n", value,
-                proxy->guest_page_shift);
+        trace_virtio_mmio_guest_page(value, proxy->guest_page_shift);
         break;
     case VIRTIO_MMIO_QUEUE_SEL:
         if (value < VIRTIO_QUEUE_MAX) {
@@ -255,7 +251,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
         }
         break;
     case VIRTIO_MMIO_QUEUE_NUM:
-        DPRINTF("mmio_queue write %d max %d\n", (int)value, VIRTQUEUE_MAX_SIZE);
+        trace_virtio_mmio_queue_write(value, VIRTQUEUE_MAX_SIZE);
         virtio_queue_set_num(vdev, vdev->queue_sel, value);
         /* Note: only call this function for legacy devices */
         virtio_queue_update_rings(vdev, vdev->queue_sel);
@@ -303,11 +299,13 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
     case VIRTIO_MMIO_DEVICE_FEATURES:
     case VIRTIO_MMIO_QUEUE_NUM_MAX:
     case VIRTIO_MMIO_INTERRUPT_STATUS:
-        DPRINTF("write to readonly register\n");
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to readonly register\n",
+                      __func__);
         break;
 
     default:
-        DPRINTF("bad register offset\n");
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad register offset\n", __func__);
     }
 }
 
@@ -327,7 +325,7 @@ static void virtio_mmio_update_irq(DeviceState *opaque, uint16_t vector)
         return;
     }
     level = (atomic_read(&vdev->isr) != 0);
-    DPRINTF("virtio_mmio setting IRQ %d\n", level);
+    trace_virtio_mmio_setting_irq(level);
     qemu_set_irq(proxy->irq, level);
 }
 
-- 
2.20.1


