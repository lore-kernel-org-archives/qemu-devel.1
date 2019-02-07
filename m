Received: from eggs.gnu.org ([209.51.188.92]:54981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grpT2-0002LH-EP
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:36:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grpT1-0007UW-Nw
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:36:12 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu,  7 Feb 2019 14:36:02 -0500
Message-Id: <20190207193605.25676-2-crosa@redhat.com>
In-Reply-To: <20190207193605.25676-1-crosa@redhat.com>
References: <20190207193605.25676-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/4] configure: remove handling of "wav" audio
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>

This looks like a leftover that was never implemented.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 configure | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/configure b/configure
index fbd0825488..ff55e2273e 100755
--- a/configure
+++ b/configure
@@ -3350,10 +3350,6 @@ for drv in $audio_drv_list; do
       oss_libs=3D"$oss_lib"
     ;;
=20
-    wav)
-    # XXX: Probes for CoreAudio, DirectSound
-    ;;
-
     *)
     echo "$audio_possible_drivers" | grep -q "\<$drv\>" || {
         error_exit "Unknown driver '$drv' selected" \
--=20
2.20.1
