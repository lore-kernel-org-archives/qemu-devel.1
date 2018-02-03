Received: from eggs.gnu.org ([2001:4830:134:3::10]:59815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ehyVy-00077t-FS
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 09:10:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ehyVt-0003uG-Jx
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 09:09:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48648
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ehyVt-0003tt-DY
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 09:09:53 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w13E8q9r051171
	for <qemu-devel@nongnu.org>; Sat, 3 Feb 2018 09:09:52 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fw6w8m9ee-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 09:09:52 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 3 Feb 2018 09:09:52 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat,  3 Feb 2018 09:09:37 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <1517666981-9339-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL 0/4] Merge tpm 2018/02/03
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com, peter.maydell@linaro.org

The following patches do some cleanups and fix the resetting of the TPM
CRB device and add my tpm-next git tree reference to MAINTAINERS.

The following changes since commit e486b528229ed4ed5dfdac790c8152bfb2a265c9:

  Merge remote-tracking branch 'remotes/elmarco/tags/dump-pull-request' into staging (2018-02-02 10:57:50 +0000)

are available in the git repository at:

  git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-02-03-1

for you to fetch changes up to 3bd9e16149de3965a9880a20826a28b7b94bd4a7:

  tpm: tis: move one-line function into caller (2018-02-03 09:01:56 -0500)

----------------------------------------------------------------
Merge tpm 2018/02/03 v1

----------------------------------------------------------------
Stefan Berger (4):
      tpm: Split off tpm_crb_reset function
      tpm: wrap stX_be_p in tpm_cmd_set_XYZ functions
      MAINTAINERS: add pointer to tpm-next repository
      tpm: tis: move one-line function into caller

 MAINTAINERS       |  1 +
 hw/tpm/tpm_crb.c  | 48 ++++++++++++++++++++++++++++--------------------
 hw/tpm/tpm_tis.c  |  7 +------
 hw/tpm/tpm_util.c |  6 +++---
 hw/tpm/tpm_util.h | 15 +++++++++++++++
 5 files changed, 48 insertions(+), 29 deletions(-)

-- 
2.5.5
