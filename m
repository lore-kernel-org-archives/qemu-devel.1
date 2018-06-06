Received: from eggs.gnu.org ([2001:4830:134:3::10]:49026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fQeZY-000884-Su
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:58:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fQeZV-000279-Rj
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:58:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48662
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fQeZV-00026L-Kt
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:58:17 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w56JoTwI069315
	for <qemu-devel@nongnu.org>; Wed, 6 Jun 2018 15:58:16 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jejeaaq69-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 15:58:15 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 6 Jun 2018 13:58:15 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed,  6 Jun 2018 15:58:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20180606195805.185833-1-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v1 0/4] Merge tpm 2018/06/06
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>

This series of patches refactors existing TPM test code and adds another
TPM TIS test case testing TPM migration.

    Stefan

The following changes since commit c1c2a435905ae76b159c573b0c0d6f095b45ebc6:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-docker-updates-050618-1' into staging (2018-06-05 17:06:23 +0100)

are available in the Git repository at:

  git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-06-06-1

for you to fetch changes up to 70663851ed4242435676c0bc288efbc1bc4ccf87:

  test: Add swtpm migration test for the TPM TIS interface (2018-06-06 15:44:12 -0400)

----------------------------------------------------------------
Merge tpm 2018/06/06 v1

----------------------------------------------------------------
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
2.14.4
