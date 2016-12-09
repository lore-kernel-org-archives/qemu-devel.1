Received: from eggs.gnu.org ([2001:4830:134:3::10]:48327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK9e-00044H-1t
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:19:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK9d-0003oj-6A
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:19:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cFK9c-0003oV-W6
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:19:57 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  9 Dec 2016 13:17:50 +0100
Message-Id: <1481285870-3396-21-git-send-email-thuth@redhat.com>
In-Reply-To: <1481285870-3396-1-git-send-email-thuth@redhat.com>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 20/20] Makefile.target: Targets now have to
 reside in the target/ folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Jia Liu <proljc@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, James Hogan <james.hogan@imgtec.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>

Now that all target CPU folders have been moved to target/, we
do not need to support the old naming scheme of target-xxx
anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Makefile.target | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index 90b25ae..1da789c 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -7,11 +7,7 @@ include config-target.mak
 include config-devices.mak
 include $(SRC_PATH)/rules.mak
 
-ifneq ($(wildcard $(SRC_PATH)/target/$(TARGET_BASE_ARCH)),)
 TARGET_FOLDER=target/$(TARGET_BASE_ARCH)
-else
-TARGET_FOLDER=target-$(TARGET_BASE_ARCH)
-endif
 
 $(call set-vpath, $(SRC_PATH):$(BUILD_DIR))
 ifdef CONFIG_LINUX
-- 
1.8.3.1
