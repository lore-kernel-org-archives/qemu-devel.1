Received: from eggs.gnu.org ([2001:4830:134:3::10]:47354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eJbon-0001qe-LA
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 04:04:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eJbol-0001qP-Au
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 04:04:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eJbok-0001jW-G7
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 04:04:39 -0500
From: Gonglei <arei.gonglei@huawei.com>
Date: Tue, 28 Nov 2017 17:03:09 +0800
Message-ID: <1511859789-43680-5-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1511859789-43680-1-git-send-email-arei.gonglei@huawei.com>
References: <1511859789-43680-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 4/4] cryptodev-vhost-user: set the key length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, weidong.huang@huawei.com, stefanha@redhat.com, jianjay.zhou@huawei.com, pasic@linux.vnet.ibm.com, longpeng2@huawei.com, xin.zeng@intel.com, roy.fan.zhang@intel.com, Gonglei <arei.gonglei@huawei.com>

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 backends/cryptodev-vhost-user.c       | 4 ++++
 include/sysemu/cryptodev-vhost-user.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index 061c0e5..c7a9848 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -226,6 +226,10 @@ static void cryptodev_vhost_user_init(
                          1u << VIRTIO_CRYPTO_SERVICE_MAC;
     backend->conf.cipher_algo_l = 1u << VIRTIO_CRYPTO_CIPHER_AES_CBC;
     backend->conf.hash_algo = 1u << VIRTIO_CRYPTO_HASH_SHA1;
+
+    backend->conf.max_size = UINT64_MAX;
+    backend->conf.max_cipher_key_len = VHOST_USER_MAX_AUTH_KEY_LEN;
+    backend->conf.max_auth_key_len = VHOST_USER_MAX_AUTH_KEY_LEN;
 }
 
 static int64_t cryptodev_vhost_user_sym_create_session(
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
-- 
1.8.3.1
