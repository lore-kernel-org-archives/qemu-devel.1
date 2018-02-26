Received: from eggs.gnu.org ([2001:4830:134:3::10]:46368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1eqMLu-0007K9-FA
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:14:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1eqMLq-0004ed-LY
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:14:14 -0500
Received: from mail-sn1nam02on0130.outbound.protection.outlook.com
	([104.47.36.130]:17056
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1eqMLq-0004eC-FW
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:14:10 -0500
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Mon, 26 Feb 2018 09:13:33 -0800
Message-Id: <1519665216-1078-6-git-send-email-juterry@microsoft.com>
In-Reply-To: <1519665216-1078-1-git-send-email-juterry@microsoft.com>
References: <1519665216-1078-1-git-send-email-juterry@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 5/8] Fix WHPX typo in 'mmio'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, "Justin Terry (VM)" <juterry@microsoft.com>

Renames the usage of 'memio' to 'mmio' in the emulator callbacks.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
---
 target/i386/whpx-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 74a8f4d599..7e58d5f68c 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -527,7 +527,7 @@ static HRESULT CALLBACK whpx_emu_ioport_callback(
     return S_OK;
 }
 
-static HRESULT CALLBACK whpx_emu_memio_callback(
+static HRESULT CALLBACK whpx_emu_mmio_callback(
     void *ctx,
     WHV_EMULATOR_MEMORY_ACCESS_INFO *ma)
 {
@@ -610,7 +610,7 @@ static HRESULT CALLBACK whpx_emu_translate_callback(
 static const WHV_EMULATOR_CALLBACKS whpx_emu_callbacks = {
     .Size = sizeof(WHV_EMULATOR_CALLBACKS),
     .WHvEmulatorIoPortCallback = whpx_emu_ioport_callback,
-    .WHvEmulatorMemoryCallback = whpx_emu_memio_callback,
+    .WHvEmulatorMemoryCallback = whpx_emu_mmio_callback,
     .WHvEmulatorGetVirtualProcessorRegisters = whpx_emu_getreg_callback,
     .WHvEmulatorSetVirtualProcessorRegisters = whpx_emu_setreg_callback,
     .WHvEmulatorTranslateGvaPage = whpx_emu_translate_callback,
-- 
2.13.6
