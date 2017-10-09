Received: from eggs.gnu.org ([2001:4830:134:3::10]:55055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gzd-0006Mc-3f
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gza-0005IP-1w
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gzZ-0005I1-S1
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:45 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:56:04 +0200
Message-Id: <20171009225623.29232-24-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 23/42] tpm-tis: no longer expose TPMState
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

Now that there is an interface instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/tpm.h | 2 --
 hw/tpm/tpm_tis.c     | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index c8afa179e5..62b073beeb 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -14,8 +14,6 @@
=20
 #include "qemu/option.h"
=20
-typedef struct TPMState TPMState;
-
 int tpm_config_parse(QemuOptsList *opts_list, const char *optarg);
 int tpm_init(void);
 void tpm_cleanup(void);
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index c24be57136..b3757bfbda 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -72,7 +72,7 @@ typedef struct TPMLocality {
     TPMSizedBuffer r_buffer;
 } TPMLocality;
=20
-struct TPMState {
+typedef struct TPMState {
     ISADevice busdev;
     MemoryRegion mmio;
=20
@@ -95,7 +95,7 @@ struct TPMState {
     char *backend;
     TPMBackend *be_driver;
     TPMVersion be_tpm_version;
-};
+} TPMState;
=20
 #define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
=20
--=20
2.14.1.146.gd35faa819
