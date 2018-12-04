Received: from eggs.gnu.org ([2001:4830:134:3::10]:35909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gUCFg-0000sv-Hi
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:04:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gUCFc-0004dp-E6
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:04:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50675
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1gUCFc-0004dL-45
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:04:40 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB4Ex5ra022888
	for <qemu-devel@nongnu.org>; Tue, 4 Dec 2018 10:04:39 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p5utq8c2n-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 10:04:38 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 4 Dec 2018 15:04:34 -0000
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue,  4 Dec 2018 10:04:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20181204150427.2459814-1-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 0/3] Cleanup and locality range check
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
and adds a locality range check to tpm_tis_prep_abort() and
tpm_tis_request_completed().

   Stefan

Stefan Berger (3):
  tpm: Remove unused locty parameter from tpm_tis_abort()
  tpm: Make sure new locality passed to tpm_tis_prep_abort() is valid
  tpm: Make sure the locality received from backend is valid

 hw/tpm/tpm_tis.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.17.1
