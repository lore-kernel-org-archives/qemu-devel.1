Received: from eggs.gnu.org ([2001:4830:134:3::10]:48351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVr-0005aC-5o
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVm-0006e3-3c
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:14 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:55691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVl-0006d3-TE
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:10 -0500
Received: by mail-wm0-x241.google.com with SMTP id q83so22819823wme.5
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:20:09 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:25 +0100
Message-Id: <1520342370-123606-30-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 29/34] Fix WHPX typo in 'mmio'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Justin Terry (VM)" <juterry@microsoft.com>

From: "Justin Terry (VM) via Qemu-devel" <qemu-devel@nongnu.org>

Renames the usage of 'memio' to 'mmio' in the emulator callbacks.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
Message-Id: <1519665216-1078-6-git-send-email-juterry@microsoft.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Justin Terry (VM) via Qemu-devel <qemu-devel@nongnu.org>
---
 target/i386/whpx-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 74a8f4d..7e58d5f 100644
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
1.8.3.1
