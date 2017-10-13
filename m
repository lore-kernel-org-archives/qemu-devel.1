Received: from eggs.gnu.org ([2001:4830:134:3::10]:50569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2yP9-0007Ln-QJ
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2yP5-0002rX-QL
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:45:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51446
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e2yP5-0002qj-BK
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:45:23 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9DBiiRw041532
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 07:45:20 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2djuk0cxnp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 07:45:19 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 13 Oct 2017 07:45:19 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 13 Oct 2017 07:44:49 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <1507895100-26457-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v3 00/11] Merge tpm 2017/10/04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, amarnath.valluri@intel.com, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

The following changes since commit f90ea7ba7c5ae7010ee0ce062207ae42530f57d6:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20171012' into staging (2017-10-12 17:06:50 +0100)

are available in the git repository at:

  git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2017-10-04-3

for you to fetch changes up to 8dc67017220109fd5bc9d2bffa73674595f62e08:

  specs: Describe the TPM support in QEMU (2017-10-13 07:34:33 -0400)

----------------------------------------------------------------
Merge tpm 2017/10/04 v3

----------------------------------------------------------------
Amarnath Valluri (9):
      tpm-backend: Remove unneeded member variable from backend class
      tpm-backend: Move thread handling inside TPMBackend
      tpm-backend: Initialize and free data members in it's own methods
      tpm-backend: Made few interface methods optional
      tpm-backend: Add new API to read backend TpmInfo
      tpm-backend: Move realloc_buffer() implementation to tpm-tis model
      tpm-passthrough: move reusable code to utils
      tpm: Added support for TPM emulator
      tpm: Move tpm_cleanup() to right place

Stefan Berger (2):
      tpm: Use EMSGSIZE instead of EBADMSG to compile on OpenBSD
      specs: Describe the TPM support in QEMU

 backends/tpm.c                   | 115 ++++++++------
 configure                        |  13 +-
 docs/specs/tpm.txt               | 123 +++++++++++++++
 hmp.c                            |   5 +
 hw/tpm/Makefile.objs             |   1 +
 hw/tpm/tpm_emulator.c            | 587 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/tpm/tpm_ioctl.h               | 246 ++++++++++++++++++++++++++++++
 hw/tpm/tpm_passthrough.c         | 242 +++++++-----------------------
 hw/tpm/tpm_tis.c                 |  14 +-
 hw/tpm/tpm_util.c                |  35 ++++-
 hw/tpm/tpm_util.h                |   4 +
 include/sysemu/tpm_backend.h     |  80 +++++-----
 include/sysemu/tpm_backend_int.h |  41 -----
 qapi/tpm.json                    |  21 ++-
 qemu-options.hx                  |  22 ++-
 tpm.c                            |  37 +----
 vl.c                             |   1 +
 17 files changed, 1216 insertions(+), 371 deletions(-)
 create mode 100644 docs/specs/tpm.txt
 create mode 100644 hw/tpm/tpm_emulator.c
 create mode 100644 hw/tpm/tpm_ioctl.h
 delete mode 100644 include/sysemu/tpm_backend_int.h


-- 
2.5.5
