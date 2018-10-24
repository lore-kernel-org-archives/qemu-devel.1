Received: from eggs.gnu.org ([2001:4830:134:3::10]:36221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gFOcb-0002Ic-Os
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 15:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gFOcW-0001cP-Oh
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 15:15:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55893
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1gFOcW-0001bZ-If
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 15:15:08 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9OJEiTM019729
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 15:15:07 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2naxh6gsb4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 15:15:07 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 24 Oct 2018 13:15:06 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 24 Oct 2018 15:14:58 -0400
Message-Id: <20181024191458.1277823-1-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] tpm: Zero-init structure to avoid
 uninitialized variables in valgrind log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>

Zero-init the ptm_loc structure so that we don't have fields that
are not initialised.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_emulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 10bc20dbec..968f06ae3b 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -158,7 +158,7 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
 static int tpm_emulator_set_locality(TPMEmulator *tpm_emu, uint8_t locty_number,
                                      Error **errp)
 {
-    ptm_loc loc;
+    ptm_loc loc = { 0 };
 
     if (tpm_emu->cur_locty_number == locty_number) {
         return 0;
-- 
2.17.1
