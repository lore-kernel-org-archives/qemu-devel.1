Received: from eggs.gnu.org ([2001:4830:134:3::10]:34561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1epDJx-000451-6c
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:23:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1epDJu-0007Sw-2z
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:23:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56772 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1epDJt-0007Rp-Ta
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:23:26 -0500
From: marcandre.lureau@redhat.com
Date: Fri, 23 Feb 2018 14:23:05 +0100
Message-Id: <20180223132311.26555-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180223132311.26555-1-marcandre.lureau@redhat.com>
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/7] SecurityPkg/Tcg2Pei: drop
 Tcg2PhysicalPresenceLib dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: edk2-devel@lists.01.org
Cc: pjones@redhat.com, jiewen.yao@intel.com, stefanb@linux.vnet.ibm.com, lersek@redhat.com, qemu-devel@nongnu.org, javierm@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Apparently, unnecessary. Avoids extra build dependency and churn.

CC: Laszlo Ersek <lersek@redhat.com>
CC: Stefan Berger <stefanb@linux.vnet.ibm.com>
Contributed-under: TianoCore Contribution Agreement 1.0
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.c   | 2 --
 SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf | 1 -
 2 files changed, 3 deletions(-)

diff --git a/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.c b/SecurityPkg/Tcg/Tcg2Pei/=
Tcg2Pei.c
index a7ae3354b5..3758fc6a41 100644
--- a/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.c
+++ b/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.c
@@ -18,7 +18,6 @@ WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITH=
ER EXPRESS OR IMPLIED.
 #include <IndustryStandard/UefiTcgPlatform.h>
 #include <Ppi/FirmwareVolumeInfo.h>
 #include <Ppi/FirmwareVolumeInfo2.h>
-#include <Ppi/LockPhysicalPresence.h>
 #include <Ppi/TpmInitialized.h>
 #include <Ppi/FirmwareVolume.h>
 #include <Ppi/EndOfPeiPhase.h>
@@ -44,7 +43,6 @@ WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITH=
ER EXPRESS OR IMPLIED.
 #include <Library/MemoryAllocationLib.h>
 #include <Library/ReportStatusCodeLib.h>
 #include <Library/ResetSystemLib.h>
-#include <Library/Tcg2PhysicalPresenceLib.h>
=20
 #define PERF_ID_TCG2_PEI  0x3080
=20
diff --git a/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf b/SecurityPkg/Tcg/Tcg2Pe=
i/Tcg2Pei.inf
index f7b85444d9..bc910c3baf 100644
--- a/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf
+++ b/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf
@@ -58,7 +58,6 @@
   PerformanceLib
   MemoryAllocationLib
   ReportStatusCodeLib
-  Tcg2PhysicalPresenceLib
   ResetSystemLib
=20
 [Guids]
--=20
2.16.1.73.g5832b7e9f2
