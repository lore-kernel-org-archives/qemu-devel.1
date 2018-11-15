Received: from eggs.gnu.org ([2001:4830:134:3::10]:54498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gNILM-0000xY-BM
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:10:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gNILI-000717-D9
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:10:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1gNILH-0006zp-SA
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:10:00 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAFE3coS026673
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 09:09:56 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ns8v9chjn-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 09:09:56 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 15 Nov 2018 14:09:55 -0000
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 15 Nov 2018 09:09:47 -0500
Message-Id: <20181115140949.3481699-1-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v1 0/2] Merge tpm 2018/11/15 v1
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

The 2 patches in this series fix some minor issues.

   Stefan

The following changes since commit cb968d275c145467c8b385a3618a207ec111eab1:

  Update version for v3.1.0-rc1 release (2018-11-13 18:16:14 +0000)

are available in the Git repository at:

  git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-11-15-1

for you to fetch changes up to 5e58b58c478bd00c807bd7814ccab148d49cc901:

  tests: tpm: Use g_test_message rather than fprintf (2018-11-14 16:12:24 -0500)

----------------------------------------------------------------
Prasad J Pandit (1):
      tpm: use loop iterator to set sts data field

Stefan Berger (1):
      tests: tpm: Use g_test_message rather than fprintf

 hw/tpm/tpm_tis.c  | 2 +-
 tests/tpm-tests.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

2.17.1
