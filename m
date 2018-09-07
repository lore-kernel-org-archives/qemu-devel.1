Received: from eggs.gnu.org ([2001:4830:134:3::10]:44462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fyNdP-0008QU-No
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 16:45:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fyNdF-0000Cy-45
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 16:45:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fyNdE-00007p-Mi
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 16:45:32 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w87KiLuX071344
	for <qemu-devel@nongnu.org>; Fri, 7 Sep 2018 16:45:31 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2mbv0mj8sx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 16:45:30 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 7 Sep 2018 16:45:29 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri,  7 Sep 2018 16:45:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20180907204524.2275697-1-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v1 0/1] Merge tpm 2018/09/07 v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

This patch fixes a TPM test failure in QEMU's test suite.

   Stefan

The following changes since commit 19b599f7664b2ebfd0f405fb79c14dd241557452:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-08-27-v2' into staging (2018-08-27 16:44:20 +0100)

are available in the Git repository at:

  git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-09-07-1

for you to fetch changes up to 2271b75fa9019a9ba10d38ea2cf53a2032b1d8fd:

  tests: Fix signalling race condition in TPM tests (2018-09-07 16:37:47 -0400)

----------------------------------------------------------------
Stefan Berger (1):
      tests: Fix signalling race condition in TPM tests

 tests/tpm-crb-test.c |  1 +
 tests/tpm-emu.c      | 11 ++++++++++-
 tests/tpm-emu.h      |  1 +
 tests/tpm-tis-test.c |  1 +
 4 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.14.4
