Received: from eggs.gnu.org ([2001:4830:134:3::10]:36348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAS-0007Rr-85
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAM-0007Qx-A7
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e5FAM-0007Qa-2M
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:34 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9JHxSva116356
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:29 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dpx2mj0q5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:29 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 19 Oct 2017 14:03:27 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 14:02:37 -0400
In-Reply-To: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1508436175-1596-4-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 03/21] tpm: make tpm_get_backend_driver()
 static
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

No need to export the function.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 include/sysemu/tpm_backend.h | 1 -
 tpm.c                        | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 2c798a1..c6e5637 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -215,7 +215,6 @@ TPMInfo *tpm_backend_query_tpm(TPMBackend *s);
=20
 TPMBackend *qemu_find_tpm(const char *id);
=20
-const TPMDriverOps *tpm_get_backend_driver(const char *type);
 void tpm_register_model(enum TpmModel model);
 void tpm_register_driver(const TPMDriverOps *tdo);
=20
diff --git a/tpm.c b/tpm.c
index 3122227..bc7d747 100644
--- a/tpm.c
+++ b/tpm.c
@@ -31,7 +31,7 @@ void tpm_register_model(enum TpmModel model)
     tpm_models[model] =3D true;
 }
=20
-const TPMDriverOps *tpm_get_backend_driver(const char *type)
+static const TPMDriverOps *tpm_get_backend_driver(const char *type)
 {
     int i =3D qapi_enum_parse(&TpmType_lookup, type, -1, NULL);
=20
--=20
2.5.5
