Received: from eggs.gnu.org ([2001:4830:134:3::10]:49276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1erRLN-0006KK-A6
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:46:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1erRLM-00015N-BY
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:46:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57144 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1erRLM-00014Q-2s
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:46:08 -0500
Date: Thu, 1 Mar 2018 18:46:07 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1519922735-29054-14-git-send-email-mst@redhat.com>
References: <1519922735-29054-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519922735-29054-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 13/13] cryptodev-vhost-user: set the key length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gonglei <arei.gonglei@huawei.com>

From: Gonglei <arei.gonglei@huawei.com>

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/sysemu/cryptodev-vhost-user.h | 3 +++
 backends/cryptodev-vhost-user.c       | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/include/sysemu/cryptodev-vhost-user.h b/include/sysemu/cryptodev-vhost-user.h
index 937217b..6debf53 100644
--- a/include/sysemu/cryptodev-vhost-user.h
+++ b/include/sysemu/cryptodev-vhost-user.h
@@ -23,6 +23,9 @@
 #ifndef CRYPTODEV_VHOST_USER_H
 #define CRYPTODEV_VHOST_USER_H
 
+#define VHOST_USER_MAX_AUTH_KEY_LEN    512
+#define VHOST_USER_MAX_CIPHER_KEY_LEN  64
+
 
 /**
  * cryptodev_vhost_user_get_vhost:
diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index 9cd06c4..862d4f2 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -224,6 +224,10 @@ static void cryptodev_vhost_user_init(
                          1u << VIRTIO_CRYPTO_SERVICE_MAC;
     backend->conf.cipher_algo_l = 1u << VIRTIO_CRYPTO_CIPHER_AES_CBC;
     backend->conf.hash_algo = 1u << VIRTIO_CRYPTO_HASH_SHA1;
+
+    backend->conf.max_size = UINT64_MAX;
+    backend->conf.max_cipher_key_len = VHOST_USER_MAX_CIPHER_KEY_LEN;
+    backend->conf.max_auth_key_len = VHOST_USER_MAX_AUTH_KEY_LEN;
 }
 
 static int64_t cryptodev_vhost_user_sym_create_session(
-- 
MST
