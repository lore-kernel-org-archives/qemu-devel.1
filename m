Received: from eggs.gnu.org ([2001:4830:134:3::10]:45213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hQ-00010T-T2
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hN-00083Y-QT
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:44:48 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:41:46 -0500
Message-Id: <20180619014319.28272-21-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 020/113] tpm: Set the flags of the CMD_INIT
 command to 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Stefan Berger <stefanb@linux.vnet.ibm.com>

The flags of the CMD_INIT control channel command were not
initialized properly. Fix this and set to 0.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit 302705876492a39f568035ce346e2c9176f5665e)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/tpm/tpm_emulator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index e1a68104d6..ad1f744132 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -260,7 +260,9 @@ static int tpm_emulator_check_caps(TPMEmulator *tpm_emu)
 static int tpm_emulator_startup_tpm(TPMBackend *tb)
 {
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
-    ptm_init init;
+    ptm_init init = {
+        .u.req.init_flags = 0,
+    };
     ptm_res res;
 
     DPRINTF("%s", __func__);
-- 
2.11.0
