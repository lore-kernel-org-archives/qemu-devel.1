Received: from eggs.gnu.org ([2001:4830:134:3::10]:45657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gPAkU-00083C-5J
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:27:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gPAkJ-0001fG-2G
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:27:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1gPAkG-0001Xx-NX
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:27:34 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAKINhnp054128
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 13:27:29 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nvnwc4uv1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 13:27:29 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 20 Nov 2018 18:27:28 -0000
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 20 Nov 2018 13:27:19 -0500
Message-Id: <20181120182721.227114-1-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/2] tpm: Cleanup and locality range check
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
