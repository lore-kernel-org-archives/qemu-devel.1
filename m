Received: from eggs.gnu.org ([208.118.235.92]:35002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ehOE4-0003ww-Dv
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 18:29:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ehOCl-0001sI-E3
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 18:24:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35020
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ehOCl-0001qY-0Z
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 18:23:43 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w11NJ9es065480
	for <qemu-devel@nongnu.org>; Thu, 1 Feb 2018 18:23:42 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fv77mnc11-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 18:23:41 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 1 Feb 2018 18:23:41 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu,  1 Feb 2018 18:23:34 -0500
Message-Id: <1517527416-31328-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/2] tpm: A fix and a cleanup
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

The following two patches fix the resetting of the CRB interface
and wrap calls to st{w,l}_be_p in tpm_cmd_set_XYZ functions.

   Stefan

Stefan Berger (2):
  tpm: Split off tpm_crb_reset function
  tpm: wrap stX_be_p in tpm_cmd_set_XYZ functions

 hw/tpm/tpm_crb.c  |  6 ++++++
 hw/tpm/tpm_util.c |  6 +++---
 hw/tpm/tpm_util.h | 15 +++++++++++++++
 3 files changed, 24 insertions(+), 3 deletions(-)

-- 
2.5.5
