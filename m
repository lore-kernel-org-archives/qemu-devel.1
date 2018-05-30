Received: from eggs.gnu.org ([2001:4830:134:3::10]:55080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fO6tL-0004vP-G7
	for qemu-devel@nongnu.org; Wed, 30 May 2018 15:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fO6tI-0003vr-7O
	for qemu-devel@nongnu.org; Wed, 30 May 2018 15:36:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fO6tH-0003vG-V2
	for qemu-devel@nongnu.org; Wed, 30 May 2018 15:36:12 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4UJYKK3057089
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 15:36:10 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ja0r2mpjx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 15:36:09 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 30 May 2018 13:36:09 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 15:35:44 -0400
Message-Id: <20180530193548.3846786-1-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/4] Refactor code and implement another TPM
 TIS test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

This series of patches refactors the tpm-crb-swtpm-test.c in the
first two patches and moves functions into tpm-util.c and tpm-tests.c
for reuse. Patch 3 passes "tpm-crb" to the functions that create the
QEMU command line. Patch 4 is more or less a copy of tpm-crb-swtpm-test.c
adapted for the TIS interface.

   Stefan

Stefan Berger (4):
  test: Move reusable code from tpm-crb-swtpm-test.c to tpm-util.c
  test: Move common TPM test functions to tpm-tests.c
  test: Pass TPM interface model to functions creating command line
  test: Add swtpm migration test for the TPM TIS interface

 tests/Makefile.include     |   5 +-
 tests/tpm-crb-swtpm-test.c | 189 +--------------------------------------------
 tests/tpm-tests.c          | 127 ++++++++++++++++++++++++++++++
 tests/tpm-tests.h          |  26 +++++++
 tests/tpm-tis-swtpm-test.c |  66 ++++++++++++++++
 tests/tpm-util.c           | 138 +++++++++++++++++++++++++++++++++
 tests/tpm-util.h           |  14 ++++
 7 files changed, 379 insertions(+), 186 deletions(-)
 create mode 100644 tests/tpm-tests.c
 create mode 100644 tests/tpm-tests.h
 create mode 100644 tests/tpm-tis-swtpm-test.c

-- 
2.14.3
