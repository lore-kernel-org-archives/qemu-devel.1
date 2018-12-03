Received: from eggs.gnu.org ([2001:4830:134:3::10]:55342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gTrbF-0003OL-94
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gTrbB-0002vz-UF
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:01:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54036
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1gTrbB-0002qW-7G
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:01:33 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB3Gv2ij146286
	for <qemu-devel@nongnu.org>; Mon, 3 Dec 2018 12:01:23 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p583f9jue-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 12:01:22 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 3 Dec 2018 17:01:09 -0000
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon,  3 Dec 2018 12:01:03 -0500
Message-Id: <20181203170105.2367492-1-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/2] Cleanup and locality range check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ppandit@redhat.com, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

This series of patches removes an unnecessary parameter from tpm_tis_abort()
and adds a locality range check to tpm_tis_prep_abort().

   Stefan


Stefan Berger (2):
  tpm: Remove unused locty parameter from tpm_tis_abort()
  tpm: Make sure new locality passed to tpm_tis_prep_abort() is valid

 hw/tpm/tpm_tis.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.17.1
