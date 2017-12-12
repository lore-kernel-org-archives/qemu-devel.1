Received: from eggs.gnu.org ([2001:4830:134:3::10]:47179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eOlUg-0000KK-E0
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:25:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eOlUe-0003AN-Es
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:25:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eOlUe-00039U-8F
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:25:12 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 12 Dec 2017 14:24:58 +0000
Message-Id: <20171212142500.3909-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v6 0/2] Convert apple related code to
 keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Peter Maydell ]" <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Programmingkid <programmingkidx@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>

This is a followup to

  v1: https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02047.html
  v2: https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02471.html
  v3: https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02517.html
  v4: https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02708.html
  v5: https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg02950.html

This series contains only the apple related patches, the cocoa frontend
and adb backend device.

I decided to separate them, as I'm fairly sure the keycodemapdb data for
these has some problems in it. There is contradictory information on the
right mappings to use for certain keys. Looking at darwin source code
in fact I think that the low level hardware scancode -> keycode mappings
on OS-X might even change based on user config options at the OS level,
and I'm not sure how to deal with that yet.

So I need todo more investigation before I consider these two patches
ready for merge. They're just posted to allow any feedback to be gathered


Daniel P. Berrange (2):
  hw: convert the adb device to keycodemapdb
  ui: convert cocoa frontend to keycodemapdb

 Makefile                    |   2 +
 hw/input/adb.c              | 124 +-------------------------------------
 include/hw/input/adb-keys.h | 141 --------------------------------------------
 include/ui/input.h          |   5 ++
 ui/cocoa.m                  | 129 +---------------------------------------
 ui/input-keymap.c           |   2 +
 6 files changed, 13 insertions(+), 390 deletions(-)
 delete mode 100644 include/hw/input/adb-keys.h

-- 
2.14.3
