Received: from eggs.gnu.org ([2001:4830:134:3::10]:48864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1erUMh-0006lg-Qq
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:59:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1erUMe-0002bU-Pc
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:59:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48740
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1erUMe-0002ae-Jh
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:59:40 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w21JxMkV077967
	for <qemu-devel@nongnu.org>; Thu, 1 Mar 2018 14:59:39 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2geqw30kx1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 14:59:39 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 1 Mar 2018 12:59:38 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu,  1 Mar 2018 14:59:31 -0500
Message-Id: <1519934373-3629-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 0/2] tpm: Extend TPM with state migration
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
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

This series of patches implements support for migrating the state of the
external 'swtpm' TPM emulator as well as that of the TIS interface. 

For testing of TPM 2 (migration) please use the following git repos and
branches:

libtpms: 
   - repo: https://github.com/stefanberger/libtpms
   - branch: tpm2-preview.rev146.v2

swtpm:
   - repo: https://github.com/stefanberger/swtpm
   - branch: tpm2-preview.rev146.v2

Regards,
  Stefan

Changes:
 v3->v4:
   - dropped the size limit enforcement on blobs received from the swtpm
   - the .post_load migration function requires errno's to be returned.
     -> some of the functions have been converted to return a better errno

Stefan Berger (2):
  tpm: extend TPM emulator with state migration support
  tpm: extend TPM TIS with state migration support

 hw/tpm/tpm_emulator.c | 312 ++++++++++++++++++++++++++++++++++++++++++++++++--
 hw/tpm/tpm_tis.c      |  54 ++++++++-
 2 files changed, 355 insertions(+), 11 deletions(-)

-- 
2.5.5
