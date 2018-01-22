Received: from eggs.gnu.org ([2001:4830:134:3::10]:46230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1edjj4-0004XI-OJ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 16:33:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1edjiz-00081r-Qy
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 16:33:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1edjiz-00081E-Im
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 16:33:53 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0MLXpLx099631
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 16:33:51 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fnpghbh58-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 16:33:51 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 22 Jan 2018 14:33:42 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 22 Jan 2018 16:33:38 -0500
Message-Id: <1516656818-31834-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] tpm: Set the flags of the CMD_INIT command to 0
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

The flags of the CMD_INIT control channel command were not
initialized properly. Fix this and set to 0.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_emulator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 35c78de..532d3e3 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -320,7 +320,9 @@ static int tpm_emulator_set_buffer_size(TPMBackend *tb,
 static int tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersize)
 {
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
-    ptm_init init;
+    ptm_init init = {
+        .u.req.init_flags = 0,
+    };
     ptm_res res;
 
     if (buffersize != 0 &&
-- 
2.5.5
