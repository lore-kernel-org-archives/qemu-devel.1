Received: from eggs.gnu.org ([2001:4830:134:3::10]:52113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eycXS-0002nL-Pp
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eycXQ-0008N0-57
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:08:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43466
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eycXP-0008Mn-US
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:08:16 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2LC7oRG046663
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 08:08:15 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gun4kwjsw-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 08:08:05 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 21 Mar 2018 08:07:56 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 21 Mar 2018 08:07:47 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <1521634071-16519-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v1 0/4] Merge tpm 2018/03/21
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

This series of patches fixes the initialization and setting of a few
flags of the TPM CRB interface.

The following changes since commit f1a63fcfcd92c88be8942b5ae71aef9749a4f135:

  Update version for v2.12.0-rc0 release (2018-03-20 19:04:22 +0000)

are available in the git repository at:

  git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-03-21-1

for you to fetch changes up to ffbf24bdb223914d5805fef15bfe9c4489868fad:

  tpm: CRB: query backend for TPM established flag (2018-03-21 08:01:03 -0400)

----------------------------------------------------------------
Stefan Berger (4):
      tpm: CRB: Set tpmRegValidSts flag to '1' in device reset
      tpm: CRB: set registers to 0 by default
      tpm: CRB: reset locAssigned upon relinquishing locality
      tpm: CRB: query backend for TPM established flag

 hw/tpm/tpm_crb.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

-- 
2.5.5
