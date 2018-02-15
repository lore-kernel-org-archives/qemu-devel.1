Received: from eggs.gnu.org ([2001:4830:134:3::10]:57033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1emKFO-0003xU-RJ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:10:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1emKFK-0006PM-RM
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:10:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1emKFK-0006OX-Gs
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:10:46 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1FE7hwI036729
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 09:10:45 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g55sfevt6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 09:10:44 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 15 Feb 2018 07:10:44 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 15 Feb 2018 09:10:33 -0500
Message-Id: <1518703835-10361-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/2] Add tests for the TPM TIS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com

This series of patches adds tests for the TPM TIS.

   Stefan

v1->v2:
 - moved common TPM test code into tpm-emu.c
 - clearified a few comments in tpm-tis-test.c, no code changes

Stefan Berger (2):
  tests: Move common TPM test code into tpm-emu.c
  tests: add test for TPM TIS device

 MAINTAINERS            |   1 +
 hw/tpm/tpm_tis.c       | 101 ----------
 include/hw/acpi/tpm.h  | 105 +++++++++++
 tests/Makefile.include |   4 +-
 tests/tpm-crb-test.c   | 174 +-----------------
 tests/tpm-emu.c        | 175 ++++++++++++++++++
 tests/tpm-emu.h        |  38 ++++
 tests/tpm-tis-test.c   | 486 +++++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 811 insertions(+), 273 deletions(-)
 create mode 100644 tests/tpm-emu.c
 create mode 100644 tests/tpm-emu.h
 create mode 100644 tests/tpm-tis-test.c

-- 
2.5.5
