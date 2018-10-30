Received: from eggs.gnu.org ([2001:4830:134:3::10]:40117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gHcXQ-0002lp-Uf
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 18:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gHcXL-0002KL-3a
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 18:31:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1gHbsO-0006NW-Sn
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:48:41 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9ULi0FJ033548
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 17:48:36 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nexue1mmy-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 17:48:35 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 30 Oct 2018 21:48:35 -0000
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 30 Oct 2018 17:47:38 -0400
In-Reply-To: <20181030214740.2294043-1-stefanb@linux.vnet.ibm.com>
References: <20181030214740.2294043-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20181030214740.2294043-4-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 3/5] docs: tpm: Mention implemented TPM CRB
 interface emulation and specs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>

From: Stefan Berger <stefanb@linux.ibm.com>

Add a few sentences about the implemented emulation of the TPM CRB
interface and its specification.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 docs/specs/tpm.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
index 0e9bbebe1d..1af82bba86 100644
--- a/docs/specs/tpm.txt
+++ b/docs/specs/tpm.txt
@@ -20,6 +20,21 @@ QEMU files related to TPM TIS interface:
  - hw/tpm/tpm_tis.h
=20
=20
+QEMU also implements a TPM CRB interface following the Trusted Computing
+Group's specification "TCG PC Client Platform TPM Profile (PTP)
+Specification", Family "2.0", Level 00 Revision 01.03 v22, May 22, 2017.
+This specification, or a later version of it, can be accessed from the
+following URL:
+
+https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profil=
e-ptp-specification/
+
+The CRB interface makes a memory mapped IO region in the area 0xfed40000=
 -
+0xfed40fff (1 locality) available to the guest operating system.
+
+QEMU files related to TPM CRB interface:
+ - hw/tpm/tpm_crb.c
+
+
 =3D ACPI Interface =3D
=20
 The TPM device is defined with ACPI ID "PNP0C31". QEMU builds a SSDT and=
 passes
--=20
2.17.1
