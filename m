Received: from eggs.gnu.org ([2001:4830:134:3::10]:39692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ehca2-0001SX-HA
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:44:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ehcZx-00031N-Kd
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:44:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50040
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ehcZx-00030g-DG
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:44:37 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w12EhB7P071681
	for <qemu-devel@nongnu.org>; Fri, 2 Feb 2018 09:44:35 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fvqy65vtu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 09:44:34 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 2 Feb 2018 07:44:34 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri,  2 Feb 2018 09:44:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <1517582668-10923-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/4] tpm: A fix and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com

The following patches fix the resetting of the CRB interface and wrap
calls to st{w,l}_be_p in tpm_cmd_set_XYZ functions. We also clean up
a one-liner in the TIS.

   Stefan

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
