Received: from eggs.gnu.org ([209.51.188.92]:57680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwC-0002Fl-K9
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwA-0002R6-Ao
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:11 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnwA-0002QG-2x
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:10 -0500
Received: by mail-wr1-x444.google.com with SMTP id q15so771004wro.12
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:58:09 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:14 +0100
Message-Id: <1549562254-41157-32-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 31/51] ppc: Express dependencies of the 'prep'
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
Cc: thuth@redhat.com, philmd@redhat.com, =?UTF-8?q?Herv=C3=83=C2=A9=20Poussineau?= <hpoussin@reactos.org>

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
index be6440e..9cebf0f 100644
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
