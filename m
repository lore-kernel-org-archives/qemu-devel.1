Received: from eggs.gnu.org ([2001:4830:134:3::10]:39082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmJK-0006LG-31
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:39:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmJJ-0004Hz-8G
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:39:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eBmJJ-0004Hl-2S
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:39:49 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  6 Nov 2017 19:39:01 +0100
Message-Id: <20171106183925.16747-5-marcandre.lureau@redhat.com>
In-Reply-To: <20171106183925.16747-1-marcandre.lureau@redhat.com>
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 04/28] tpm-tis: no longer expose TPMState
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
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 include/sysemu/tpm.h | 2 --
 hw/tpm/tpm_tis.c     | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index fb1719e5e4..7a1713a81e 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -15,8 +15,6 @@
 #include "qom/object.h"
 #include "qapi-types.h"
=20
-typedef struct TPMState TPMState;
-
 int tpm_config_parse(QemuOptsList *opts_list, const char *optarg);
 int tpm_init(void);
 void tpm_cleanup(void);
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 34ceec91c3..4a8a2ffc79 100644
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
@@ -94,7 +94,7 @@ struct TPMState {
     char *backend;
     TPMBackend *be_driver;
     TPMVersion be_tpm_version;
-};
+} TPMState;
=20
 #define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
=20
--=20
2.15.0.rc0.40.gaefcc5f6f
