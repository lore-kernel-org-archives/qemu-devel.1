Received: from eggs.gnu.org ([2001:4830:134:3::10]:42487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0627a78234=stefanb@linux.vnet.ibm.com>)
	id 1f1hfK-0006L4-KO
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 20:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0627a78234=stefanb@linux.vnet.ibm.com>)
	id 1f1hfH-0006aY-F7
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 20:13:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=0627a78234=stefanb@linux.vnet.ibm.com>)
	id 1f1hfH-0006Yt-6B
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 20:13:07 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2U09kno027766
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 20:13:05 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h18804p01-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 20:13:04 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 29 Mar 2018 18:13:04 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 29 Mar 2018 20:12:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <1522368777-32742-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v1 0/4] Merge tpm 2018/03/29 v1
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

The following patches fix the handling of some more flags of the TPM CRB
interface and extend the existing TPM CRB test program with tests of more
flags.

    Stefan

The following changes since commit 043289bef4d9c0d277c45695c676a6cc9fca48a0:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180328' into staging (2018-03-28 13:30:10 +0100)

are available in the git repository at:

  git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-03-29-1

for you to fetch changes up to 4d0d1c077e5622da95fd0f6a8e7efb72e0f222b4:

  tests: Tests more flags of the CRB interface (2018-03-29 17:41:03 -0400)

----------------------------------------------------------------
Stefan Berger (4):
      tpm: CRB: set the Idle flag by default
      tpm: CRB: Reset Granted flag when relinquishing locality
      tpm: CRB: Enforce locality is requested before processing buffer
      tests: Tests more flags of the CRB interface

 hw/tpm/tpm_crb.c     | 18 +++++++++++++++++-
 tests/tpm-crb-test.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 89 insertions(+), 3 deletions(-)

-- 
2.5.5
