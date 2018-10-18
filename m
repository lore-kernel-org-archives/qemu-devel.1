Received: from eggs.gnu.org ([2001:4830:134:3::10]:35071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gDCvY-0006gV-J6
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gDCvV-0005yK-9S
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:21:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1gDCvU-0005tK-Vn
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:21:41 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9IIFE71128067
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 14:21:39 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2n6wu243p0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 14:21:39 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 18 Oct 2018 12:21:38 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 18 Oct 2018 14:21:29 -0400
Message-Id: <20181018182130.799406-1-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/2] docs: tpm: Mention implemented TPM CRB
 interface emulation and specs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, marcandre.lureau@gmail.com
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>

Add a few sentences about the implemented emulation of the TPM CRB
interface and its specification.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 docs/specs/tpm.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
index 0e9bbebe1d..1af82bba86 100644
--- a/docs/specs/tpm.txt
+++ b/docs/specs/tpm.txt
@@ -20,6 +20,21 @@ QEMU files related to TPM TIS interface:
  - hw/tpm/tpm_tis.h
 
 
+QEMU also implements a TPM CRB interface following the Trusted Computing
+Group's specification "TCG PC Client Platform TPM Profile (PTP)
+Specification", Family "2.0", Level 00 Revision 01.03 v22, May 22, 2017.
+This specification, or a later version of it, can be accessed from the
+following URL:
+
+https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/
+
+The CRB interface makes a memory mapped IO region in the area 0xfed40000 -
+0xfed40fff (1 locality) available to the guest operating system.
+
+QEMU files related to TPM CRB interface:
+ - hw/tpm/tpm_crb.c
+
+
 = ACPI Interface =
 
 The TPM device is defined with ACPI ID "PNP0C31". QEMU builds a SSDT and passes
-- 
2.17.1
