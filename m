Received: from eggs.gnu.org ([2001:4830:134:3::10]:60482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fLst7-0008Bw-BJ
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fLst2-0004CN-32
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:14:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fLst1-0004B8-R0
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:14:44 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4OGE6nX115387
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 12:14:42 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j5x43rt0c-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 12:14:42 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 24 May 2018 10:14:41 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 24 May 2018 12:14:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20180524161435.3012991-1-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v2 0/4] Merge tpm 2018/05/23
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

This series of patches adds TPM emulator state migration support and a
test case for testing (local) migration.

   Stefan

The following changes since commit 4f50c1673a89b07f376ce5c42d22d79a79cd466d:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-05-22 09:43:58 +0100)

are available in the Git repository at:

  git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-05-23-1

for you to fetch changes up to 319bb20d1e88ea2e13baeb158a4989eceeee5e86:

  test: Add test cases that use the external swtpm with CRB interface (2018-05-23 20:35:25 -0400)

----------------------------------------------------------------
Merge tpm 2018/05/23 v1

----------------------------------------------------------------
Stefan Berger (4):
      tpm: extend TPM emulator with state migration support
      tpm: extend TPM TIS with state migration support
      docs: tpm: add VM save/restore example and troubleshooting guide
      test: Add test cases that use the external swtpm with CRB interface

 docs/specs/tpm.txt         | 106 +++++++++++++++++++++
 hw/tpm/tpm_emulator.c      | 323 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 hw/tpm/tpm_tis.c           |  52 +++++++++-
 hw/tpm/trace-events        |   9 +-
 tests/Makefile.include     |   3 +
 tests/tpm-crb-swtpm-test.c | 247 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/tpm-util.c           | 186 ++++++++++++++++++++++++++++++++++++
 tests/tpm-util.h           |  36 +++++++
 8 files changed, 948 insertions(+), 14 deletions(-)
 create mode 100644 tests/tpm-crb-swtpm-test.c
 create mode 100644 tests/tpm-util.c
 create mode 100644 tests/tpm-util.h

-- 
2.14.3
