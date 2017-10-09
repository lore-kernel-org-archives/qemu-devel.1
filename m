Received: from eggs.gnu.org ([2001:4830:134:3::10]:54487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gyk-0005XR-5n
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gyi-0004t4-VQ
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gyi-0004sb-PI
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:52 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:55:48 +0200
Message-Id: <20171009225623.29232-8-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/42] tpm: move TPMSizedBuffer to tpm_tis.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, stefanb@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Close to where it's being used.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_tis.h             | 5 +++++
 include/sysemu/tpm_backend.h | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
index a1df41fa21..31e612a7f4 100644
--- a/hw/tpm/tpm_tis.h
+++ b/hw/tpm/tpm_tis.h
@@ -37,6 +37,11 @@ typedef enum {
     TPM_TIS_STATE_RECEPTION,
 } TPMTISState;
=20
+typedef struct TPMSizedBuffer {
+    uint32_t size;
+    uint8_t  *buffer;
+} TPMSizedBuffer;
+
 /* locality data  -- all fields are persisted */
 typedef struct TPMLocality {
     TPMTISState state;
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index adb6a68076..63093551a1 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -66,11 +66,6 @@ struct TPMBackendClass {
     void (*handle_request)(TPMBackend *s, TPMBackendCmd cmd);
 };
=20
-typedef struct TPMSizedBuffer {
-    uint32_t size;
-    uint8_t  *buffer;
-} TPMSizedBuffer;
-
 struct TPMDriverOps {
     enum TpmType type;
     const QemuOptDesc *opts;
--=20
2.14.1.146.gd35faa819
