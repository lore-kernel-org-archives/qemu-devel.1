Received: from eggs.gnu.org ([209.51.188.92]:60035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKNER-0003UA-R1
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 09:19:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKNER-0001kQ-1v
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 09:19:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKNEQ-0001iV-Pj
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 09:19:06 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sat, 27 Apr 2019 15:18:57 +0200
Message-Id: <20190427131857.11600-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] hw/tpm: Only build tpm_ppi.o if any of
 TPM_TIS/TPM_CRB is built
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The TPM Physical Presence Interface routines are only used
by the CRB/TIS interfaces. Do not compile this file if any
of them is built.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Marc-Andr=C3=A9:
  You might want to add yourself as reviewer/maintainer of TPM ;)
---
 hw/tpm/Makefile.objs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
index 700c8786228..de0b85d02ae 100644
--- a/hw/tpm/Makefile.objs
+++ b/hw/tpm/Makefile.objs
@@ -1,5 +1,5 @@
-common-obj-y +=3D tpm_util.o
-obj-y +=3D tpm_ppi.o
+common-obj-$(CONFIG_TPM) +=3D tpm_util.o
+obj-$(call lor,$(CONFIG_TPM_TIS),$(CONFIG_TPM_CRB)) +=3D tpm_ppi.o
 common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis.o
 common-obj-$(CONFIG_TPM_CRB) +=3D tpm_crb.o
 common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o
--=20
2.20.1
