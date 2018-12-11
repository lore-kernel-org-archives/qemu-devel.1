Received: from eggs.gnu.org ([2001:4830:134:3::10]:40738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gWp5X-0006FH-90
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gWp5T-0003ic-Fb
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:57:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1gWp5T-0003hd-56
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:57:03 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBBKsG0U130032
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 15:57:01 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pakvb29h6-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 15:57:00 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 11 Dec 2018 20:56:59 -0000
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 11 Dec 2018 15:56:52 -0500
In-Reply-To: <20181211205654.3550341-1-stefanb@linux.vnet.ibm.com>
References: <20181211205654.3550341-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20181211205654.3550341-2-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 1/3] tpm: Remove unused locty parameter from
 tpm_tis_abort()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>

Remove the unused locty parameter from tpm_tis_abort() function.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/tpm/tpm_tis.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index d9322692ee..176d424ed9 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -233,7 +233,7 @@ static void tpm_tis_new_active_locality(TPMState *s, =
uint8_t new_active_locty)
 }
=20
 /* abort -- this function switches the locality */
-static void tpm_tis_abort(TPMState *s, uint8_t locty)
+static void tpm_tis_abort(TPMState *s)
 {
     s->rw_offset =3D 0;
=20
@@ -281,7 +281,7 @@ static void tpm_tis_prep_abort(TPMState *s, uint8_t l=
octy, uint8_t newlocty)
         }
     }
=20
-    tpm_tis_abort(s, locty);
+    tpm_tis_abort(s);
 }
=20
 /*
@@ -311,7 +311,7 @@ static void tpm_tis_request_completed(TPMIf *ti, int =
ret)
     }
=20
     if (TPM_TIS_IS_VALID_LOCTY(s->next_locty)) {
-        tpm_tis_abort(s, locty);
+        tpm_tis_abort(s);
     }
=20
     tpm_tis_raise_irq(s, locty,
--=20
2.17.1
