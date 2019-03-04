Received: from eggs.gnu.org ([209.51.188.92]:46125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCw-0002Iv-55
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCr-0004dx-R3
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:55 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:38343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sCo-0004Wm-1t
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:50 -0500
Received: by mail-wm1-x335.google.com with SMTP id a188so121729wmf.3
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:49 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:19:53 +0100
Message-Id: <1551723614-1823-34-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 33/54] ppc: Express dependencies of the 'prep'
 and '40p' machines with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, Yang Zhong <yang.zhong@intel.com>, =?UTF-8?q?Herv=C3=83=C2=A9=20Poussineau?= <hpoussin@reactos.org>

From: Thomas Huth <thuth@redhat.com>

Select the required devices in hw/ppc/Kconfig instead, so that
ppc-softmmu.mak only contains the user-selectable PREP switch.
Plug-in devices like NE2000_ISA are pulled in automatically by the
Kconfig build system now.

Cc: HervÃ© Poussineau <hpoussin@reactos.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/ppc-softmmu.mak |  8 --------
 hw/ppc/Kconfig                  | 10 ++++++++++
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 9ad307a..066cec9 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -55,11 +55,3 @@ CONFIG_MAC_NEWWORLD=y
 
 # For PReP
 CONFIG_PREP=y
-CONFIG_PREP_PCI=y
-CONFIG_RS6000_MC=y
-CONFIG_I82374=y
-CONFIG_I82378=y
-CONFIG_PCKBD=y
-CONFIG_NE2000_ISA=y
-CONFIG_PC87312=y
-CONFIG_CS4231A=y
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 30e3e81..24e4ed9 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -39,6 +39,16 @@ config SAM460EX
 
 config PREP
     bool
+    imply PCI_DEVICES
+    imply TEST_DEVICES
+    select CS4231A
+    select PREP_PCI
+    select I82374
+    select I82378
+    select LSI_SCSI_PCI
+    select M48T59
+    select PC87312
+    select RS6000_MC
 
 config RS6000_MC
     bool
-- 
1.8.3.1
