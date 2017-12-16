Received: from eggs.gnu.org ([2001:4830:134:3::10]:45885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTd-0005x3-Je
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTZ-0008N6-MW
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54560
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQGTZ-0008Ma-HR
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:17 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBGHdV3e110188
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:15 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2evwa8qst2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:14 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 16 Dec 2017 10:42:14 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 16 Dec 2017 12:41:28 -0500
In-Reply-To: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513446109-9013-12-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 11/32] tpm-passthrough: pass TPMPassthruState
 to handle_device_opts
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

It doesn't need TPMBackend. Also reorder arguments for consistency.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_passthrough.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 048edb1..9326cbf 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -239,9 +239,9 @@ static int tpm_passthrough_open_sysfs_cancel(TPMPasst=
hruState *tpm_pt)
     return fd;
 }
=20
-static int tpm_passthrough_handle_device_opts(QemuOpts *opts, TPMBackend=
 *tb)
+static int
+tpm_passthrough_handle_device_opts(TPMPassthruState *tpm_pt, QemuOpts *o=
pts)
 {
-    TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
     const char *value;
=20
     value =3D qemu_opt_get(opts, "cancel-path");
@@ -292,7 +292,7 @@ static TPMBackend *tpm_passthrough_create(QemuOpts *o=
pts, const char *id)
=20
     tb->id =3D g_strdup(id);
=20
-    if (tpm_passthrough_handle_device_opts(opts, tb)) {
+    if (tpm_passthrough_handle_device_opts(tpm_pt, opts)) {
         goto err_exit;
     }
=20
--=20
2.5.5
