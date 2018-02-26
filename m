Received: from eggs.gnu.org ([2001:4830:134:3::10]:47087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eqHtX-0007YN-Lo
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:28:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eqHtW-0008NL-O6
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:28:39 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2169 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1eqHtV-0008Ku-VX
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:28:38 -0500
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Mon, 26 Feb 2018 20:27:37 +0800
Message-ID: <0596094b09f50289bf9d6a48cebd1cd211bfd20b.1519647019.git.arei.gonglei@huawei.com>
In-Reply-To: <cover.1519647019.git.arei.gonglei@huawei.com>
References: <cover.1519647019.git.arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v7 4/4] cryptodev-vhost-user: set the key length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, weidong.huang@huawei.com, stefanha@redhat.com, jianjay.zhou@huawei.com, pasic@linux.vnet.ibm.com, longpeng2@huawei.com, xin.zeng@intel.com, roy.fan.zhang@intel.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com

From: Gonglei <arei.gonglei@huawei.com>

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 backends/cryptodev-vhost-user.c       | 4 ++++
 include/sysemu/cryptodev-vhost-user.h | 3 +++
 2 files changed, 7 insertions(+)

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
