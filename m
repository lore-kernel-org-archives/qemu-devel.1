Received: from eggs.gnu.org ([2001:4830:134:3::10]:36901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJy0-0000mu-Ve
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxy-0000Ac-4Q
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:56 -0500
Received: from mail.kernel.org ([198.145.29.136]:56904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxx-00008w-MU
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:54 -0500
Date: Thu, 19 Jan 2017 23:09:47 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484860116-25361-14-git-send-email-mst@redhat.com>
References: <1484860116-25361-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484860116-25361-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 13/17] virtio_crypto: header update
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

Update header from latest linux driver.  Session creation structs gain
padding to make them same size. Formatting cleanups.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Gonglei <arei.gonglei@huawei.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
---
 include/standard-headers/linux/virtio_crypto.h | 481 +++++++++++++------------
 1 file changed, 251 insertions(+), 230 deletions(-)

diff --git a/include/standard-headers/linux/virtio_crypto.h b/include/standard-headers/linux/virtio_crypto.h
index 82275a8..5ff0b4e 100644
--- a/include/standard-headers/linux/virtio_crypto.h
+++ b/include/standard-headers/linux/virtio_crypto.h
@@ -1,5 +1,5 @@
-#ifndef _LINUX_VIRTIO_CRYPTO_H
-#define _LINUX_VIRTIO_CRYPTO_H
+#ifndef _VIRTIO_CRYPTO_H
+#define _VIRTIO_CRYPTO_H
 /* This header is BSD licensed so anyone can use the definitions to implement
  * compatible drivers/servers.
  *
@@ -14,52 +14,54 @@
  * 3. Neither the name of IBM nor the names of its contributors
  *    may be used to endorse or promote products derived from this software
  *    without specific prior written permission.
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS''
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
- * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
- * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
- * SUCH DAMAGE. */
-
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
+ * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
+ * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
 #include "standard-headers/linux/types.h"
-#include "standard-headers/linux/virtio_config.h"
 #include "standard-headers/linux/virtio_types.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_config.h"
 
 
 #define VIRTIO_CRYPTO_SERVICE_CIPHER 0
-#define VIRTIO_CRYPTO_SERVICE_HASH 1
-#define VIRTIO_CRYPTO_SERVICE_MAC  2
-#define VIRTIO_CRYPTO_SERVICE_AEAD 3
+#define VIRTIO_CRYPTO_SERVICE_HASH   1
+#define VIRTIO_CRYPTO_SERVICE_MAC    2
+#define VIRTIO_CRYPTO_SERVICE_AEAD   3
 
 #define VIRTIO_CRYPTO_OPCODE(service, op)   (((service) << 8) | (op))
 
 struct virtio_crypto_ctrl_header {
 #define VIRTIO_CRYPTO_CIPHER_CREATE_SESSION \
-       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x02)
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x02)
 #define VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION \
-       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x03)
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x03)
 #define VIRTIO_CRYPTO_HASH_CREATE_SESSION \
-       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x02)
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x02)
 #define VIRTIO_CRYPTO_HASH_DESTROY_SESSION \
-       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x03)
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x03)
 #define VIRTIO_CRYPTO_MAC_CREATE_SESSION \
-       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x02)
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x02)
 #define VIRTIO_CRYPTO_MAC_DESTROY_SESSION \
-       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x03)
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x03)
 #define VIRTIO_CRYPTO_AEAD_CREATE_SESSION \
-       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x02)
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x02)
 #define VIRTIO_CRYPTO_AEAD_DESTROY_SESSION \
-       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x03)
-    __virtio32 opcode;
-    __virtio32 algo;
-    __virtio32 flag;
-    /* data virtqueue id */
-    __virtio32 queue_id;
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x03)
+	uint32_t opcode;
+	uint32_t algo;
+	uint32_t flag;
+	/* data virtqueue id */
+	uint32_t queue_id;
 };
 
 struct virtio_crypto_cipher_session_para {
@@ -78,26 +80,27 @@ struct virtio_crypto_cipher_session_para {
 #define VIRTIO_CRYPTO_CIPHER_AES_F8             12
 #define VIRTIO_CRYPTO_CIPHER_AES_XTS            13
 #define VIRTIO_CRYPTO_CIPHER_ZUC_EEA3           14
-    __virtio32 algo;
-    /* length of key */
-    __virtio32 keylen;
+	uint32_t algo;
+	/* length of key */
+	uint32_t keylen;
 
 #define VIRTIO_CRYPTO_OP_ENCRYPT  1
 #define VIRTIO_CRYPTO_OP_DECRYPT  2
-    /* encrypt or decrypt */
-    __virtio32 op;
-    __virtio32 padding;
+	/* encrypt or decrypt */
+	uint32_t op;
+	uint32_t padding;
 };
 
 struct virtio_crypto_session_input {
-    /* Device-writable part */
-    __virtio64 session_id;
-    __virtio32 status;
-    __virtio32 padding;
+	/* Device-writable part */
+	uint64_t session_id;
+	uint32_t status;
+	uint32_t padding;
 };
 
 struct virtio_crypto_cipher_session_req {
-    struct virtio_crypto_cipher_session_para para;
+	struct virtio_crypto_cipher_session_para para;
+	uint8_t padding[32];
 };
 
 struct virtio_crypto_hash_session_para {
@@ -114,13 +117,15 @@ struct virtio_crypto_hash_session_para {
 #define VIRTIO_CRYPTO_HASH_SHA3_512      10
 #define VIRTIO_CRYPTO_HASH_SHA3_SHAKE128      11
 #define VIRTIO_CRYPTO_HASH_SHA3_SHAKE256      12
-    __virtio32 algo;
-    /* hash result length */
-    __virtio32 hash_result_len;
+	uint32_t algo;
+	/* hash result length */
+	uint32_t hash_result_len;
+	uint8_t padding[8];
 };
 
 struct virtio_crypto_hash_create_session_req {
-    struct virtio_crypto_hash_session_para para;
+	struct virtio_crypto_hash_session_para para;
+	uint8_t padding[40];
 };
 
 struct virtio_crypto_mac_session_para {
@@ -140,16 +145,17 @@ struct virtio_crypto_mac_session_para {
 #define VIRTIO_CRYPTO_MAC_CBCMAC_AES               49
 #define VIRTIO_CRYPTO_MAC_CBCMAC_KASUMI_F9         50
 #define VIRTIO_CRYPTO_MAC_XCBC_AES                 53
-    __virtio32 algo;
-    /* hash result length */
-    __virtio32 hash_result_len;
-    /* length of authenticated key */
-    __virtio32 auth_key_len;
-    __virtio32 padding;
+	uint32_t algo;
+	/* hash result length */
+	uint32_t hash_result_len;
+	/* length of authenticated key */
+	uint32_t auth_key_len;
+	uint32_t padding;
 };
 
 struct virtio_crypto_mac_create_session_req {
-    struct virtio_crypto_mac_session_para para;
+	struct virtio_crypto_mac_session_para para;
+	uint8_t padding[40];
 };
 
 struct virtio_crypto_aead_session_para {
@@ -157,273 +163,288 @@ struct virtio_crypto_aead_session_para {
 #define VIRTIO_CRYPTO_AEAD_GCM    1
 #define VIRTIO_CRYPTO_AEAD_CCM    2
 #define VIRTIO_CRYPTO_AEAD_CHACHA20_POLY1305  3
-    __virtio32 algo;
-    /* length of key */
-    __virtio32 key_len;
-    /* digest result length */
-    __virtio32 digest_result_len;
-    /* length of the additional authenticated data (AAD) in bytes */
-    __virtio32 aad_len;
-    /* encrypt or decrypt, See above VIRTIO_CRYPTO_OP_* */
-    __virtio32 op;
-    __virtio32 padding;
+	uint32_t algo;
+	/* length of key */
+	uint32_t key_len;
+	/* hash result length */
+	uint32_t hash_result_len;
+	/* length of the additional authenticated data (AAD) in bytes */
+	uint32_t aad_len;
+	/* encrypt or decrypt, See above VIRTIO_CRYPTO_OP_* */
+	uint32_t op;
+	uint32_t padding;
 };
 
 struct virtio_crypto_aead_create_session_req {
-    struct virtio_crypto_aead_session_para para;
+	struct virtio_crypto_aead_session_para para;
+	uint8_t padding[32];
 };
 
 struct virtio_crypto_alg_chain_session_para {
 #define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_HASH_THEN_CIPHER  1
 #define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_CIPHER_THEN_HASH  2
-    __virtio32 alg_chain_order;
+	uint32_t alg_chain_order;
 /* Plain hash */
 #define VIRTIO_CRYPTO_SYM_HASH_MODE_PLAIN    1
 /* Authenticated hash (mac) */
 #define VIRTIO_CRYPTO_SYM_HASH_MODE_AUTH     2
 /* Nested hash */
 #define VIRTIO_CRYPTO_SYM_HASH_MODE_NESTED   3
-    __virtio32 hash_mode;
-    struct virtio_crypto_cipher_session_para cipher_param;
-    union {
-        struct virtio_crypto_hash_session_para hash_param;
-        struct virtio_crypto_mac_session_para mac_param;
-    } u;
-    /* length of the additional authenticated data (AAD) in bytes */
-    __virtio32 aad_len;
-    __virtio32 padding;
+	uint32_t hash_mode;
+	struct virtio_crypto_cipher_session_para cipher_param;
+	union {
+		struct virtio_crypto_hash_session_para hash_param;
+		struct virtio_crypto_mac_session_para mac_param;
+		uint8_t padding[16];
+	} u;
+	/* length of the additional authenticated data (AAD) in bytes */
+	uint32_t aad_len;
+	uint32_t padding;
 };
 
 struct virtio_crypto_alg_chain_session_req {
-    struct virtio_crypto_alg_chain_session_para para;
+	struct virtio_crypto_alg_chain_session_para para;
 };
 
 struct virtio_crypto_sym_create_session_req {
-    union {
-        struct virtio_crypto_cipher_session_req cipher;
-        struct virtio_crypto_alg_chain_session_req chain;
-    } u;
+	union {
+		struct virtio_crypto_cipher_session_req cipher;
+		struct virtio_crypto_alg_chain_session_req chain;
+		uint8_t padding[48];
+	} u;
 
-    /* Device-readable part */
+	/* Device-readable part */
 
 /* No operation */
 #define VIRTIO_CRYPTO_SYM_OP_NONE  0
 /* Cipher only operation on the data */
 #define VIRTIO_CRYPTO_SYM_OP_CIPHER  1
-/* Chain any cipher with any hash or mac operation. The order
-   depends on the value of alg_chain_order param */
+/*
+ * Chain any cipher with any hash or mac operation. The order
+ * depends on the value of alg_chain_order param
+ */
 #define VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING  2
-    __virtio32 op_type;
-    __virtio32 padding;
+	uint32_t op_type;
+	uint32_t padding;
 };
 
 struct virtio_crypto_destroy_session_req {
-    /* Device-readable part */
-    __virtio64  session_id;
+	/* Device-readable part */
+	uint64_t  session_id;
+	uint8_t padding[48];
 };
 
-/* The request of the control viritqueue's packet */
+/* The request of the control virtqueue's packet */
 struct virtio_crypto_op_ctrl_req {
-    struct virtio_crypto_ctrl_header header;
-
-    union {
-        struct virtio_crypto_sym_create_session_req   sym_create_session;
-        struct virtio_crypto_hash_create_session_req  hash_create_session;
-        struct virtio_crypto_mac_create_session_req   mac_create_session;
-        struct virtio_crypto_aead_create_session_req  aead_create_session;
-        struct virtio_crypto_destroy_session_req      destroy_session;
-    } u;
+	struct virtio_crypto_ctrl_header header;
+
+	union {
+		struct virtio_crypto_sym_create_session_req
+			sym_create_session;
+		struct virtio_crypto_hash_create_session_req
+			hash_create_session;
+		struct virtio_crypto_mac_create_session_req
+			mac_create_session;
+		struct virtio_crypto_aead_create_session_req
+			aead_create_session;
+		struct virtio_crypto_destroy_session_req
+			destroy_session;
+		uint8_t padding[56];
+	} u;
 };
 
 struct virtio_crypto_op_header {
 #define VIRTIO_CRYPTO_CIPHER_ENCRYPT \
-    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x00)
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x00)
 #define VIRTIO_CRYPTO_CIPHER_DECRYPT \
-    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x01)
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x01)
 #define VIRTIO_CRYPTO_HASH \
-    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x00)
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x00)
 #define VIRTIO_CRYPTO_MAC \
-    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x00)
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x00)
 #define VIRTIO_CRYPTO_AEAD_ENCRYPT \
-    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x00)
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x00)
 #define VIRTIO_CRYPTO_AEAD_DECRYPT \
-    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x01)
-    __virtio32 opcode;
-    /* algo should be service-specific algorithms */
-    __virtio32 algo;
-    /* session_id should be service-specific algorithms */
-    __virtio64 session_id;
-    /* control flag to control the request */
-    __virtio32 flag;
-    __virtio32 padding;
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x01)
+	uint32_t opcode;
+	/* algo should be service-specific algorithms */
+	uint32_t algo;
+	/* session_id should be service-specific algorithms */
+	uint64_t session_id;
+	/* control flag to control the request */
+	uint32_t flag;
+	uint32_t padding;
 };
 
 struct virtio_crypto_cipher_para {
-    /*
-     * Byte Length of valid IV/Counter
-     *
-     * - For block ciphers in CBC or F8 mode, or for Kasumi in F8 mode, or for
-     *   SNOW3G in UEA2 mode, this is the length of the IV (which
-     *   must be the same as the block length of the cipher).
-     * - For block ciphers in CTR mode, this is the length of the counter
-     *   (which must be the same as the block length of the cipher).
-     * - For AES-XTS, this is the 128bit tweak, i, from IEEE Std 1619-2007.
-     *
-     * The IV/Counter will be updated after every partial cryptographic
-     * operation.
-     */
-    __virtio32 iv_len;
-    /* length of source data */
-    __virtio32 src_data_len;
-    /* length of dst data */
-    __virtio32 dst_data_len;
-    __virtio32 padding;
+	/*
+	 * Byte Length of valid IV/Counter
+	 *
+	 * For block ciphers in CBC or F8 mode, or for Kasumi in F8 mode, or for
+	 *   SNOW3G in UEA2 mode, this is the length of the IV (which
+	 *   must be the same as the block length of the cipher).
+	 * For block ciphers in CTR mode, this is the length of the counter
+	 *   (which must be the same as the block length of the cipher).
+	 * For AES-XTS, this is the 128bit tweak, i, from IEEE Std 1619-2007.
+	 *
+	 * The IV/Counter will be updated after every partial cryptographic
+	 * operation.
+	 */
+	uint32_t iv_len;
+	/* length of source data */
+	uint32_t src_data_len;
+	/* length of dst data */
+	uint32_t dst_data_len;
+	uint32_t padding;
 };
 
 struct virtio_crypto_hash_para {
-    /* length of source data */
-    __virtio32 src_data_len;
-    /* hash result length */
-    __virtio32 hash_result_len;
+	/* length of source data */
+	uint32_t src_data_len;
+	/* hash result length */
+	uint32_t hash_result_len;
 };
 
 struct virtio_crypto_mac_para {
-    struct virtio_crypto_hash_para hash;
+	struct virtio_crypto_hash_para hash;
 };
 
 struct virtio_crypto_aead_para {
-    /*
-     * Byte Length of valid IV data pointed to by the below iv_addr
-     * parameter.
-     *
-     * - For GCM mode, this is either 12 (for 96-bit IVs) or 16, in which
-     *   case iv_addr points to J0.
-     * - For CCM mode, this is the length of the nonce, which can be in the
-     *   range 7 to 13 inclusive.
-     */
-    __virtio32 iv_len;
-    /* length of additional auth data */
-    __virtio32 aad_len;
-    /* length of source data */
-    __virtio32 src_data_len;
-    /* length of dst data */
-    __virtio32 dst_data_len;
+	/*
+	 * Byte Length of valid IV data pointed to by the below iv_addr
+	 * parameter.
+	 *
+	 * For GCM mode, this is either 12 (for 96-bit IVs) or 16, in which
+	 *   case iv_addr points to J0.
+	 * For CCM mode, this is the length of the nonce, which can be in the
+	 *   range 7 to 13 inclusive.
+	 */
+	uint32_t iv_len;
+	/* length of additional auth data */
+	uint32_t aad_len;
+	/* length of source data */
+	uint32_t src_data_len;
+	/* length of dst data */
+	uint32_t dst_data_len;
 };
 
 struct virtio_crypto_cipher_data_req {
-    /* Device-readable part */
-    struct virtio_crypto_cipher_para para;
+	/* Device-readable part */
+	struct virtio_crypto_cipher_para para;
+	uint8_t padding[24];
 };
 
 struct virtio_crypto_hash_data_req {
-    /* Device-readable part */
-    struct virtio_crypto_hash_para para;
+	/* Device-readable part */
+	struct virtio_crypto_hash_para para;
+	uint8_t padding[40];
 };
 
 struct virtio_crypto_mac_data_req {
-    /* Device-readable part */
-    struct virtio_crypto_mac_para para;
+	/* Device-readable part */
+	struct virtio_crypto_mac_para para;
+	uint8_t padding[40];
 };
 
 struct virtio_crypto_alg_chain_data_para {
-    __virtio32 iv_len;
-    /* Length of source data */
-    __virtio32 src_data_len;
-    /* Length of destination data */
-    __virtio32 dst_data_len;
-    /* Starting point for cipher processing in source data */
-    __virtio32 cipher_start_src_offset;
-    /* Length of the source data that the cipher will be computed on */
-    __virtio32 len_to_cipher;
-    /* Starting point for hash processing in source data */
-    __virtio32 hash_start_src_offset;
-    /* Length of the source data that the hash will be computed on */
-    __virtio32 len_to_hash;
-    /* Length of the additional auth data */
-    __virtio32 aad_len;
-    /* Length of the hash result */
-    __virtio32 hash_result_len;
-    __virtio32 reserved;
+	uint32_t iv_len;
+	/* Length of source data */
+	uint32_t src_data_len;
+	/* Length of destination data */
+	uint32_t dst_data_len;
+	/* Starting point for cipher processing in source data */
+	uint32_t cipher_start_src_offset;
+	/* Length of the source data that the cipher will be computed on */
+	uint32_t len_to_cipher;
+	/* Starting point for hash processing in source data */
+	uint32_t hash_start_src_offset;
+	/* Length of the source data that the hash will be computed on */
+	uint32_t len_to_hash;
+	/* Length of the additional auth data */
+	uint32_t aad_len;
+	/* Length of the hash result */
+	uint32_t hash_result_len;
+	uint32_t reserved;
 };
 
 struct virtio_crypto_alg_chain_data_req {
-    /* Device-readable part */
-    struct virtio_crypto_alg_chain_data_para para;
+	/* Device-readable part */
+	struct virtio_crypto_alg_chain_data_para para;
 };
 
 struct virtio_crypto_sym_data_req {
-    union {
-        struct virtio_crypto_cipher_data_req cipher;
-        struct virtio_crypto_alg_chain_data_req chain;
-    } u;
-
-    /* See above VIRTIO_CRYPTO_SYM_OP_* */
-    __virtio32 op_type;
-    __virtio32 padding;
+	union {
+		struct virtio_crypto_cipher_data_req cipher;
+		struct virtio_crypto_alg_chain_data_req chain;
+		uint8_t padding[40];
+	} u;
+
+	/* See above VIRTIO_CRYPTO_SYM_OP_* */
+	uint32_t op_type;
+	uint32_t padding;
 };
 
 struct virtio_crypto_aead_data_req {
-    /* Device-readable part */
-    struct virtio_crypto_aead_para para;
+	/* Device-readable part */
+	struct virtio_crypto_aead_para para;
+	uint8_t padding[32];
 };
 
-/* The request of the data viritqueue's packet */
+/* The request of the data virtqueue's packet */
 struct virtio_crypto_op_data_req {
-    struct virtio_crypto_op_header header;
-
-    union {
-        struct virtio_crypto_sym_data_req  sym_req;
-        struct virtio_crypto_hash_data_req hash_req;
-        struct virtio_crypto_mac_data_req mac_req;
-        struct virtio_crypto_aead_data_req aead_req;
-    } u;
+	struct virtio_crypto_op_header header;
+
+	union {
+		struct virtio_crypto_sym_data_req  sym_req;
+		struct virtio_crypto_hash_data_req hash_req;
+		struct virtio_crypto_mac_data_req mac_req;
+		struct virtio_crypto_aead_data_req aead_req;
+		uint8_t padding[48];
+	} u;
 };
 
 #define VIRTIO_CRYPTO_OK        0
 #define VIRTIO_CRYPTO_ERR       1
 #define VIRTIO_CRYPTO_BADMSG    2
 #define VIRTIO_CRYPTO_NOTSUPP   3
-#define VIRTIO_CRYPTO_INVSESS   4 /* Invaild session id */
+#define VIRTIO_CRYPTO_INVSESS   4 /* Invalid session id */
 
 /* The accelerator hardware is ready */
 #define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
-#define VIRTIO_CRYPTO_S_STARTED  (1 << 1)
 
 struct virtio_crypto_config {
-    /* See VIRTIO_CRYPTO_* above */
-    __virtio32  status;
-
-    /*
-     * Maximum number of data queue legal values are between 1 and 0x8000
-     */
-    __virtio32  max_dataqueues;
-
-    /* Specifies the services mask which the devcie support,
-       see VIRTIO_CRYPTO_SERVICE_* above */
-    __virtio32 crypto_services;
-
-    /* Detailed algorithms mask */
-    __virtio32 cipher_algo_l;
-    __virtio32 cipher_algo_h;
-    __virtio32 hash_algo;
-    __virtio32 mac_algo_l;
-    __virtio32 mac_algo_h;
-    __virtio32 aead_algo;
-
-    /* Maximum length of cipher key */
-    uint32_t max_cipher_key_len;
-    /* Maximum length of authenticated key */
-    uint32_t max_auth_key_len;
-
-    __virtio32 reserve;
-
-    /* The maximum size of per request's content */
-    __virtio64 max_size;
+	/* See VIRTIO_CRYPTO_OP_* above */
+	uint32_t  status;
+
+	/*
+	 * Maximum number of data queue
+	 */
+	uint32_t  max_dataqueues;
+
+	/*
+	 * Specifies the services mask which the device support,
+	 * see VIRTIO_CRYPTO_SERVICE_* above
+	 */
+	uint32_t crypto_services;
+
+	/* Detailed algorithms mask */
+	uint32_t cipher_algo_l;
+	uint32_t cipher_algo_h;
+	uint32_t hash_algo;
+	uint32_t mac_algo_l;
+	uint32_t mac_algo_h;
+	uint32_t aead_algo;
+	/* Maximum length of cipher key */
+	uint32_t max_cipher_key_len;
+	/* Maximum length of authenticated key */
+	uint32_t max_auth_key_len;
+	uint32_t reserve;
+	/* Maximum size of each crypto request's content */
+	uint64_t max_size;
 };
 
 struct virtio_crypto_inhdr {
-    /* See VIRTIO_CRYPTO_* above */
-    uint8_t status;
+	/* See VIRTIO_CRYPTO_* above */
+	uint8_t status;
 };
-
-#endif /* _LINUX_VIRTIO_CRYPTO_H */
+#endif
-- 
MST
