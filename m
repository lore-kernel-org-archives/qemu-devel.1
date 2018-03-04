Received: from eggs.gnu.org ([2001:4830:134:3::10]:33303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1esbcX-00022f-Rm
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 16:56:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1esbcT-0004ku-0o
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 16:56:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36596
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1esbcS-0004ki-RF
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 16:56:36 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w24Ls6gt034466
	for <qemu-devel@nongnu.org>; Sun, 4 Mar 2018 16:56:35 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gg9vf5ngq-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 04 Mar 2018 16:56:34 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sun, 4 Mar 2018 14:56:33 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sun,  4 Mar 2018 16:56:22 -0500
Message-Id: <1520200587-14681-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/5] Convert the TPM code to use tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, dgilbert@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

This series of patches converts the TPM code to use tracing rather
than the #define DEBUG_XYZ type of debugging.

Regards,
   Stefan

Stefan Berger (5):
  tpm: convert tpm_crb.c to use trace-events
  tpm: convert tpm_passthrough.c to use trace-events
  tpm: convert tpm_util.c to use trace-events
  tpm: convert tpm_emulator.c to use trace-events
  tpm: convert tpm_tis.c to use trace-events

 Makefile.objs            |  1 +
 hw/tpm/tpm_crb.c         | 17 +++------
 hw/tpm/tpm_emulator.c    | 45 +++++++++++-----------
 hw/tpm/tpm_passthrough.c | 13 ++-----
 hw/tpm/tpm_tis.c         | 98 ++++++++++++++++++++++--------------------------
 hw/tpm/tpm_util.c        | 29 ++++++--------
 hw/tpm/trace-events      | 46 +++++++++++++++++++++++
 7 files changed, 135 insertions(+), 114 deletions(-)
 create mode 100644 hw/tpm/trace-events

-- 
2.5.5
