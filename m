Received: from eggs.gnu.org ([2001:4830:134:3::10]:41419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebnbz-0004K8-D9
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:18:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebnbv-0007p0-J5
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:18:39 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:38241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebnbv-0007oL-FL
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:18:35 -0500
Received: by mail-qk0-x242.google.com with SMTP id j185so25164502qkc.5
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 05:18:35 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 17 Jan 2018 10:18:20 -0300
Message-Id: <20180117131821.18700-3-f4bug@amsat.org>
In-Reply-To: <20180117131821.18700-1-f4bug@amsat.org>
References: <20180117131821.18700-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 2/3] virtio: let virtio_add/clear_feature()
 use QEMU_WARN_NONNULL_ARGS()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, Stefan Weil <sw@weilnetz.de>, "Michael S. Tsirkin" <mst@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/virtio/virtio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 098bdaaea3..d63be28039 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -292,12 +292,14 @@ void virtio_queue_aio_set_host_notifier_handler(VirtQueue *vq, AioContext *ctx,
 VirtQueue *virtio_vector_first_queue(VirtIODevice *vdev, uint16_t vector);
 VirtQueue *virtio_vector_next_queue(VirtQueue *vq);
 
+QEMU_WARN_NONNULL_ARGS(1)
 static inline void virtio_add_feature(uint64_t *features, unsigned int fbit)
 {
     assert(fbit < 64);
     *features |= (1ULL << fbit);
 }
 
+QEMU_WARN_NONNULL_ARGS(1)
 static inline void virtio_clear_feature(uint64_t *features, unsigned int fbit)
 {
     assert(fbit < 64);
-- 
2.15.1
