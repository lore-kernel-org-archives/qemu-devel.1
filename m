Received: from eggs.gnu.org ([2001:4830:134:3::10]:36226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAN-0007Q8-Rm
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAJ-0007Na-UE
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39926
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e5FAJ-0007NL-ON
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:31 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9JHxUJZ069702
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:28 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dpyrdb9bx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:28 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 19 Oct 2017 14:03:27 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 14:02:43 -0400
In-Reply-To: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1508436175-1596-10-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 09/21] tpm: remove init() class method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, marcandre.lureau@gmail.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

No backend use it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 backends/tpm.c               | 4 +---
 include/sysemu/tpm_backend.h | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index ca3a78e..dc750d4 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -47,13 +47,11 @@ enum TpmType tpm_backend_get_type(TPMBackend *s)
 int tpm_backend_init(TPMBackend *s, TPMState *state,
                      TPMRecvDataCB *datacb)
 {
-    TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
-
     s->tpm_state =3D state;
     s->recv_data_callback =3D datacb;
     s->had_startup_error =3D false;
=20
-    return k->init ? k->init(s) : 0;
+    return 0;
 }
=20
 int tpm_backend_startup_tpm(TPMBackend *s)
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index a4288df..b08f985 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -66,8 +66,6 @@ struct TPMBackendClass {
=20
     TPMBackend *(*create)(QemuOpts *opts, const char *id);
=20
-    /* initialize the backend */
-    int (*init)(TPMBackend *t);
     /* start up the TPM on the backend */
     int (*startup_tpm)(TPMBackend *t);
=20
--=20
2.5.5
