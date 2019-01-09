Received: from eggs.gnu.org ([209.51.188.92]:47075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghDef-00036I-Qg
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:12:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghDbz-0000HW-Mb
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:09:37 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  9 Jan 2019 14:08:39 +0100
Message-Id: <20190109130844.5172-2-laurent@vivier.eu>
In-Reply-To: <20190109130844.5172-1-laurent@vivier.eu>
References: <20190109130844.5172-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/6] typedefs: (Re-)sort entries alphabetically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Anthony Green <green@moxielogic.com>, John Snow <jsnow@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=83=C2=A9?= <philmd@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Eric Blake <eblake@redhat.com>

Since the last time we sorted things (2988cbeaf), we've had a
few relapses that were inserted out of order.  Also, we had more
entries that were sorted case-insensitively than not, so let's
document that convention and stick to it.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20181115211752.1295571-2-eblake@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/qemu/typedefs.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index d59df20c4d..741935fe36 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -4,7 +4,7 @@
 /* A load of opaque types so that device init declarations don't have to
    pull in all the real definitions.  */
 
-/* Please keep this list in alphabetical order */
+/* Please keep this list in case-insensitive alphabetical order */
 typedef struct AdapterInfo AdapterInfo;
 typedef struct AddressSpace AddressSpace;
 typedef struct AioContext AioContext;
@@ -40,6 +40,7 @@ typedef struct HCIInfo HCIInfo;
 typedef struct HVFX86EmulatorState HVFX86EmulatorState;
 typedef struct I2CBus I2CBus;
 typedef struct I2SCodec I2SCodec;
+typedef struct IOMMUMemoryRegion IOMMUMemoryRegion;
 typedef struct ISABus ISABus;
 typedef struct ISADevice ISADevice;
 typedef struct IsaDma IsaDma;
@@ -49,7 +50,6 @@ typedef struct MachineState MachineState;
 typedef struct MemoryListener MemoryListener;
 typedef struct MemoryMappingList MemoryMappingList;
 typedef struct MemoryRegion MemoryRegion;
-typedef struct IOMMUMemoryRegion IOMMUMemoryRegion;
 typedef struct MemoryRegionCache MemoryRegionCache;
 typedef struct MemoryRegionSection MemoryRegionSection;
 typedef struct MigrationIncomingState MigrationIncomingState;
@@ -84,6 +84,8 @@ typedef struct PostcopyDiscardState PostcopyDiscardState;
 typedef struct Property Property;
 typedef struct PropertyInfo PropertyInfo;
 typedef struct PS2State PS2State;
+typedef struct QBool QBool;
+typedef struct QDict QDict;
 typedef struct QEMUBH QEMUBH;
 typedef struct QemuConsole QemuConsole;
 typedef struct QemuDmaBuf QemuDmaBuf;
@@ -93,12 +95,10 @@ typedef struct QemuMutex QemuMutex;
 typedef struct QemuOpt QemuOpt;
 typedef struct QemuOpts QemuOpts;
 typedef struct QemuOptsList QemuOptsList;
-typedef struct QemuSpin QemuSpin;
 typedef struct QEMUSGList QEMUSGList;
+typedef struct QemuSpin QemuSpin;
 typedef struct QEMUTimer QEMUTimer;
 typedef struct QEMUTimerListGroup QEMUTimerListGroup;
-typedef struct QBool QBool;
-typedef struct QDict QDict;
 typedef struct QJSON QJSON;
 typedef struct QList QList;
 typedef struct QNull QNull;
-- 
2.20.1
