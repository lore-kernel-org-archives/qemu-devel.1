Received: from eggs.gnu.org ([2001:4830:134:3::10]:34342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2Ohd-0003be-2c
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 17:38:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2OhY-0003l7-63
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 17:38:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45934
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e2OhX-0003ko-WB
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 17:38:04 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9BLYY7w046516
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 17:37:55 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dhty0h09j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 17:37:55 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 11 Oct 2017 17:37:54 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 11 Oct 2017 17:37:27 -0400
Message-Id: <1507757851-12580-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 0/4] tpm: Extend TPM with state migration
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

This set of patches implements support for migrating the state of the
external 'swtpm' TPM emulator. I have primarily tested this with TPM 1.2
so far.

This series of patches builds on top of the recent pull request

   Stefan

Stefan Berger (4):
  tpm: print buffers received from TPM when debugging
  tpm: Introduce condition to notify waiters of completed command
  tpm: Introduce condition in TPM backend for notification
  tpm: extend TPM emulator and TIS with state migration support

 backends/tpm.c               |  25 ++++
 hw/tpm/tpm_emulator.c        | 313 +++++++++++++++++++++++++++++++++++++++++--
 hw/tpm/tpm_int.h             |   3 +
 hw/tpm/tpm_tis.c             | 154 ++++++++++++++++++++-
 hw/tpm/tpm_tis.h             |   2 +
 hw/tpm/tpm_util.c            |   7 +
 hw/tpm/tpm_util.h            |   2 +
 include/sysemu/tpm_backend.h |  22 +++
 8 files changed, 517 insertions(+), 11 deletions(-)

-- 
2.5.5
