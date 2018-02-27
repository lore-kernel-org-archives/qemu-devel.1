Received: from eggs.gnu.org ([2001:4830:134:3::10]:45781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eqfuX-0005Lv-1N
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eqfuT-0002Tb-0y
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:07:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53256
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eqfuS-0002TP-RW
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:07:12 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1RE5Ehe144258
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 09:07:12 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gd8sp82cf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 09:07:11 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 27 Feb 2018 09:07:10 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 27 Feb 2018 09:07:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <1519740425-11270-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v2 0/2] Merge tpm 2018/02/21 v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

This patch series adds a test case for the TPM TIS interface.

   Stefan

Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180220-pull-request' into staging (2018-02-20 14:05:00 +0000)

are available in the git repository at:

  git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-02-21-2

for you to fetch changes up to adb0e917e6ee93631e40265ca145bc31cd3b6c9a:

  tests: add test for TPM TIS device (2018-02-21 07:24:50 -0500)

----------------------------------------------------------------
Merge tpm 2018/02/21 v2

----------------------------------------------------------------
Stefan Berger (2):
      tests: Move common TPM test code into tpm-emu.c
      tests: add test for TPM TIS device

 MAINTAINERS            |   1 +
 hw/tpm/tpm_tis.c       | 101 -----------------
 include/hw/acpi/tpm.h  | 105 ++++++++++++++++++
 tests/Makefile.include |   4 +-
 tests/tpm-crb-test.c   | 174 +----------------------------
 tests/tpm-emu.c        | 174 +++++++++++++++++++++++++++++
 tests/tpm-emu.h        |  38 +++++++
 tests/tpm-tis-test.c   | 486 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 810 insertions(+), 273 deletions(-)
 create mode 100644 tests/tpm-emu.c
 create mode 100644 tests/tpm-emu.h
 create mode 100644 tests/tpm-tis-test.c

-- 
2.5.5
