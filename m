Received: from eggs.gnu.org ([2001:4830:134:3::10]:33803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eEj8e-00024f-G3
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 16:53:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eEj8b-00010J-4d
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 16:53:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47544
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eEj8I-0000ll-Up
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 16:52:56 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAELnjAM030644
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 16:52:35 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e86fseeb4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 16:52:35 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 14 Nov 2017 16:52:34 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 14 Nov 2017 16:52:26 -0500
Message-Id: <1510696349-5151-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 for-2.11 0/3] tpm: a few fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@gmail.com, qemu-devel@nongnu.org, amarnath.valluri@intel.com
Cc: Stefan Berger <"Stefan Bergerstefanb"@linux.vnet.ibm.com>

From: Stefan Berger <Stefan Berger stefanb@linux.vnet.ibm.com>

The following patches fix a performance issue (patch 1) and an
error path issue (patches 2 and 3) for 2.11.

   Stefan

Stefan Berger (3):
  tpm_emulator: Add a caching layer for the TPM Established flag
  tpm_tis: Return TPM_VERSION_UNSPEC in case of BE failure
  tpm_tis: Return 0 for every register in case of failure mode

 hw/tpm/tpm_emulator.c | 17 ++++++++++++++---
 hw/tpm/tpm_tis.c      |  6 +++++-
 2 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.5.5
