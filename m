Received: from eggs.gnu.org ([2001:4830:134:3::10]:33438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fvOAP-0005A2-CK
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fvNur-0003dW-5k
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:27:22 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1fvNup-0003bx-NA
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:27:20 -0400
Received: by mail-wr1-x444.google.com with SMTP id v16-v6so8258255wro.11
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 07:27:19 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Thu, 30 Aug 2018 17:27:05 +0300
Message-Id: <20180830142708.14311-4-sameeh@daynix.com>
In-Reply-To: <20180830142708.14311-1-sameeh@daynix.com>
References: <20180830142708.14311-1-sameeh@daynix.com>
Subject: [Qemu-devel] [RFC 3/6] vhost-net: Expose vhost_net_get_fd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Yan Vugenfirer <yan@daynix.com>

From: Sameeh Jubran <sjubran@redhat.com>

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
---
 hw/net/vhost_net.c             | 2 +-
 include/hw/virtio/virtio-net.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index e037db63a3..c0bff725c9 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -129,7 +129,7 @@ uint64_t vhost_net_get_acked_features(VHostNetState *net)
     return net->dev.acked_features;
 }
 
-static int vhost_net_get_fd(NetClientState *backend)
+int vhost_net_get_fd(NetClientState *backend)
 {
     switch (backend->info->type) {
     case NET_CLIENT_DRIVER_TAP:
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 02484dc94c..a7b53edc96 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -107,4 +107,6 @@ typedef struct VirtIONet {
 void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
                                    const char *type);
 
+int vhost_net_get_fd(NetClientState *backend);
+
 #endif
-- 
2.13.6
