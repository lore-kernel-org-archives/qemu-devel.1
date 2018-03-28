Received: from eggs.gnu.org ([2001:4830:134:3::10]:43943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0625704796=stefanb@linux.vnet.ibm.com>)
	id 1f1IAQ-0003Sb-Bh
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0625704796=stefanb@linux.vnet.ibm.com>)
	id 1f1IAL-0000G5-Eb
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:59:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60938
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=0625704796=stefanb@linux.vnet.ibm.com>)
	id 1f1IAL-0000Fm-8d
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:59:29 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2SKwgH8142000
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 16:59:27 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h0efr29dg-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 16:59:27 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 28 Mar 2018 14:59:25 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 28 Mar 2018 16:59:17 -0400
Message-Id: <1522270761-29646-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/4] tpm: More improvements on CRB interface
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

This patch improves yet more flags of the TPM CRB interface and adds
more test to the CRB test case. Ideally we could have this for 2.12.
I tested it with UEFI and it works as before.

   Stefan

Stefan Berger (4):
  tpm: CRB: set the Idle flag by default
  tpm: CRB: Reset Granted flag when relinquishing locality
  tpm: CRB: Enforce locality is requested before processing buffer
  tests: Tests more flags of the CRB interface

 hw/tpm/tpm_crb.c     | 17 +++++++++++-
 tests/tpm-crb-test.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 88 insertions(+), 3 deletions(-)

-- 
2.5.5
