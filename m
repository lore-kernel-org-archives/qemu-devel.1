Received: from eggs.gnu.org ([2001:4830:134:3::10]:53752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNP1S-0005dn-QZ
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 16:17:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNP1S-00050V-4X
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 16:17:58 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 15 Nov 2018 15:17:51 -0600
Message-Id: <20181115211752.1295571-2-eblake@redhat.com>
In-Reply-To: <20181115211752.1295571-1-eblake@redhat.com>
References: <20181115211752.1295571-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] typedefs: (Re-)sort entries alphabetically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, armbru@redhat.com

Since the last time we sorted things (2988cbeaf), we've had a
few relapses that were inserted out of order.  Also, we had more
entries that were sorted case-insensitively than not, so let's
document that convention and stick to it.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/qemu/typedefs.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 3ec0e13a967..45eab4078eb 100644
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
@@ -82,6 +82,8 @@ typedef struct PostcopyDiscardState PostcopyDiscardState;
 typedef struct Property Property;
 typedef struct PropertyInfo PropertyInfo;
 typedef struct PS2State PS2State;
+typedef struct QBool QBool;
+typedef struct QDict QDict;
 typedef struct QEMUBH QEMUBH;
 typedef struct QemuConsole QemuConsole;
 typedef struct QemuDmaBuf QemuDmaBuf;
@@ -91,12 +93,10 @@ typedef struct QemuMutex QemuMutex;
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
2.17.2
