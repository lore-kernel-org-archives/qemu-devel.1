Received: from eggs.gnu.org ([2001:4830:134:3::10]:35686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgb4-00053H-7g
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgb2-0000td-DY
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:34:58 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e]:45874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fmgb2-0000tJ-6N
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:34:56 -0400
Received: by mail-ed1-x52e.google.com with SMTP id s16-v6so5239646edq.12
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 07:34:56 -0700 (PDT)
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon,  6 Aug 2018 16:33:53 +0200
Message-Id: <20180806143412.27722-16-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH v2 15/34] tests/qgraph: rename
 qvirtio_mmio_init_device functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Rename qvirtio_mmio_init_device in qvirtio_mmio_device_new, since the function
actually allocates a new QVirtioMMIODevice and initialize it.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/libqos/virtio-mmio.c | 2 +-
 tests/libqos/virtio-mmio.h | 2 +-
 tests/virtio-blk-test.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/libqos/virtio-mmio.c b/tests/libqos/virtio-mmio.c
index 7aa8383338..6f4c1b0955 100644
--- a/tests/libqos/virtio-mmio.c
+++ b/tests/libqos/virtio-mmio.c
@@ -187,7 +187,7 @@ const QVirtioBus qvirtio_mmio = {
     .virtqueue_kick = qvirtio_mmio_virtqueue_kick,
 };
 
-QVirtioMMIODevice *qvirtio_mmio_init_device(uint64_t addr, uint32_t page_size)
+QVirtioMMIODevice *qvirtio_mmio_device_new(uint64_t addr, uint32_t page_size)
 {
     QVirtioMMIODevice *dev;
     uint32_t magic;
diff --git a/tests/libqos/virtio-mmio.h b/tests/libqos/virtio-mmio.h
index e3e52b9ce1..bcc09895fd 100644
--- a/tests/libqos/virtio-mmio.h
+++ b/tests/libqos/virtio-mmio.h
@@ -41,6 +41,6 @@ typedef struct QVirtioMMIODevice {
 
 extern const QVirtioBus qvirtio_mmio;
 
-QVirtioMMIODevice *qvirtio_mmio_init_device(uint64_t addr, uint32_t page_size);
+QVirtioMMIODevice *qvirtio_mmio_device_new(uint64_t addr, uint32_t page_size);
 
 #endif
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 3e8f98e528..267cf28376 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -699,7 +699,7 @@ static void mmio_basic(void)
 
     arm_test_start();
 
-    dev = qvirtio_mmio_init_device(MMIO_DEV_BASE_ADDR, MMIO_PAGE_SIZE);
+    dev = qvirtio_mmio_device_new(MMIO_DEV_BASE_ADDR, MMIO_PAGE_SIZE);
     g_assert(dev != NULL);
     g_assert_cmphex(dev->vdev.device_type, ==, VIRTIO_ID_BLOCK);
 
-- 
2.17.1
