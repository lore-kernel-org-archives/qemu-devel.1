Received: from eggs.gnu.org ([2001:4830:134:3::10]:46696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eyOFl-0008KW-TY
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 16:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eyOFh-000225-Gx
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 16:53:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eyOFh-00021X-8o
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 16:53:01 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2KKqveZ033951
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 16:52:57 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gu8jutr2a-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 16:52:56 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 20 Mar 2018 14:52:55 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 20 Mar 2018 16:52:47 -0400
Message-Id: <1521579171-26213-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/4] tpm: Fix initialization of a few flags
 of CRB interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

Fix the initialization of a few flags of the CRB interface. I tested the changes
with UEFI and it works fine. SeaBIOS needs to have the latest patches applied.

   Stefan

Stefan Berger (4):
  tpm: CRB: Set tpmRegValidSts flag to '1' in device reset
  tpm: CRB: set registers to 0 by default
  tpm: CRB: reset locAssigned upon relinquishing locality
  tpm: CRB: query backend for TPM established flag

 hw/tpm/tpm_crb.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

-- 
2.5.5
