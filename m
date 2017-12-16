Received: from eggs.gnu.org ([2001:4830:134:3::10]:45771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTV-0005q0-JQ
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTR-0008Cz-NB
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57064
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQGTR-0008Ch-Hq
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:09 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBGHdVNx041026
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:05 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ew08mumaq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:05 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 16 Dec 2017 10:42:04 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 16 Dec 2017 12:41:21 -0500
In-Reply-To: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513446109-9013-5-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 04/32] tpm-tis: no longer expose TPMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Now that there is an interface instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c     | 4 ++--
 include/sysemu/tpm.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 9a2360e..4670287 100644
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
diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index fb1719e..7a1713a 100644
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
--=20
2.5.5
