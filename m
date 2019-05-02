Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9659C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 19:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E98220645
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 19:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E98220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57371 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMGxg-0005AE-NO
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 15:01:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMGvk-0003jW-1J
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMGvh-00034P-Ve
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:59:39 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:54335)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMGvg-00033d-0R; Thu, 02 May 2019 14:59:37 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MQ5f4-1h97kp1GwC-00M0HN; Thu, 02 May 2019 20:58:51 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 20:58:26 +0200
Message-Id: <20190502185835.15185-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502185835.15185-1-laurent@vivier.eu>
References: <20190502185835.15185-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xVhJC29hi64K8Mo9KwgOZ8dLwMyyjb7cCfI8WpjTj+J/1NYL+Qm
	Voo0cOPqv1EUxVYbM/VRS/Bs7RZpK3EZ/gMsUB9Xs9FPXlvA3pRs6HIds7fO3wjVeuqGDTP
	Omc5HWKWoTNY1g/NWXMbPA5arCrFvmZTB+nPplx+kdp6xiOKd7NqRMNL5XYEUBAFzHHM3d9
	gQ0hK8lqpVG4jHiVusFXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oSm8HSqA+gY=:XwAhgy9L85c3CyL1iSZyyX
	jELqtg/xXpnnrP7tz/BHAUkvE8vAW9qMQW2v1pR0mBRwh1stHyIDKGSGEmIkRgeD6wwitjVBm
	dG0A4asqc4Be4g50w7cZhnBXlTFVXLfY5IbTCbpDT71fCquvcYRFCF9wz2/19AB4vQL9qCIJ7
	+M2qX6VELbnfO3OgaJ4hMd2z1YJXJ8F4lrQmP/NWUolETkIMEN8Axav1SaW+L/xbnAMcslN/k
	SKPP3m6o1Zo1XC8qYFFH03lknOQouvxzRC1TpGq2DMy3jU9gsRfriXpTqXFVpJBodsjui2+aB
	xfotr5NB9Y9Rcm29m78XyqDqHOWLCKFjUI/81ClbJa2M1qxo1DUYixdvLyE03J0kzr4HBWS99
	weAkaD3yYhxJ7IBjGi6K20doj1OjBq85Fa8d6g5oV1hIvK6EOXRwbixH12LHgg3B+1p3Bqhgb
	Tau0Em0K26WqaMIBIQsSY4JvUKMIPU5TK9jhL+DH9y6OMd0qfAajYi2Lx2ODObEClbyXHqRlW
	Qs82h7We6fASG4AxxR8QfW0CoRPNHmEUmd5Zma7nUZwy6jX010wz872KOhF7TggtWYGzX+CTJ
	x1Vlj9AbEykJDPky2FX0fRU9g/lfxb4Yg2EAdYRFU/YYN7TihCwwwxH7g/kr2aDkvXA+/etk7
	2EQrc3roOKCej5/qlQKbhC3eHOliLMUo3IrMCmkR+zaE2npgw8+HB+wniP9oYLd8mvlSxk+R6
	i2hjXVCCZdO/9aAR7HBqshv0lp0zY42mYXdbmA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL 04/13] Clean up includes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, qemu-trivial@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Fabien Chouteau <chouteau@adacore.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>,
	Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
	Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502185826.X9HvErsrkoJ5a1fpjOV_F_ALr13T9qqbpfDdrlmUvQA@z>

From: Markus Armbruster <armbru@redhat.com>

Clean up includes so that osdep.h is included first and headers
which it implies are not included manually.

This commit was created with scripts/clean-includes, with the changes
to the following files manually reverted:

    contrib/libvhost-user/libvhost-user-glib.h
    contrib/libvhost-user/libvhost-user.c
    contrib/libvhost-user/libvhost-user.h
    linux-user/mips64/cpu_loop.c
    linux-user/mips64/signal.c
    linux-user/sparc64/cpu_loop.c
    linux-user/sparc64/signal.c
    linux-user/x86_64/cpu_loop.c
    linux-user/x86_64/signal.c
    slirp/src/*
    target/s390x/gen-features.c
    tests/migration/s390x/a-b-bios.c
    tests/test-rcu-simpleq.c
    tests/test-rcu-tailq.c
    tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.c

We're in the process of spinning out slirp/.  tests/uefi-test-tools/
is guest software.  The remaining reverts are the same as in commit
b7d89466dde.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190313162812.8885-1-armbru@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/display/ati_int.h     | 1 -
 include/hw/cpu/cluster.h | 1 -
 tests/fp/platform.h      | 1 -
 tests/libqos/qgraph.h    | 4 ----
 contrib/elf2dmp/main.c   | 3 +--
 contrib/elf2dmp/pdb.c    | 3 +--
 hw/display/ati.c         | 1 +
 hw/display/ati_2d.c      | 1 +
 hw/display/ati_dbg.c     | 1 +
 tests/qos-test.c         | 2 +-
 10 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index a6f3e20e6319..2f426064cf7d 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -9,7 +9,6 @@
 #ifndef ATI_INT_H
 #define ATI_INT_H
 
-#include "qemu/osdep.h"
 #include "hw/pci/pci.h"
 #include "vga_int.h"
 
diff --git a/include/hw/cpu/cluster.h b/include/hw/cpu/cluster.h
index 549c2d31d438..01c1e50cd221 100644
--- a/include/hw/cpu/cluster.h
+++ b/include/hw/cpu/cluster.h
@@ -20,7 +20,6 @@
 #ifndef HW_CPU_CLUSTER_H
 #define HW_CPU_CLUSTER_H
 
-#include "qemu/osdep.h"
 #include "hw/qdev.h"
 
 /*
diff --git a/tests/fp/platform.h b/tests/fp/platform.h
index c20ba70baa07..f8c423dde3dc 100644
--- a/tests/fp/platform.h
+++ b/tests/fp/platform.h
@@ -29,7 +29,6 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
-#include "config-host.h"
 
 #ifndef HOST_WORDS_BIGENDIAN
 #define LITTLEENDIAN 1
diff --git a/tests/libqos/qgraph.h b/tests/libqos/qgraph.h
index ef0c73837a60..e799095b308a 100644
--- a/tests/libqos/qgraph.h
+++ b/tests/libqos/qgraph.h
@@ -19,11 +19,7 @@
 #ifndef QGRAPH_H
 #define QGRAPH_H
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdbool.h>
 #include <gmodule.h>
-#include <glib.h>
 #include "qemu/module.h"
 #include "malloc.h"
 
diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 1bfeb89ba7bd..9a2dbc290214 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -5,9 +5,8 @@
  *
  */
 
-#include <inttypes.h>
-
 #include "qemu/osdep.h"
+
 #include "err.h"
 #include "addrspace.h"
 #include "pe.h"
diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
index 64af20f5842e..a5bd40c99dca 100644
--- a/contrib/elf2dmp/pdb.c
+++ b/contrib/elf2dmp/pdb.c
@@ -18,9 +18,8 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
  */
 
-#include <inttypes.h>
-
 #include "qemu/osdep.h"
+
 #include "pdb.h"
 #include "err.h"
 
diff --git a/hw/display/ati.c b/hw/display/ati.c
index db409be3c958..75716dd944ec 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -16,6 +16,7 @@
  * No 3D at all yet (maybe after 2D works, but feel free to improve it)
  */
 
+#include "qemu/osdep.h"
 #include "ati_int.h"
 #include "ati_regs.h"
 #include "vga_regs.h"
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index bc98ba6eebf6..f31b3c27c7d8 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -7,6 +7,7 @@
  * This work is licensed under the GNU GPL license version 2 or later.
  */
 
+#include "qemu/osdep.h"
 #include "ati_int.h"
 #include "ati_regs.h"
 #include "qemu/log.h"
diff --git a/hw/display/ati_dbg.c b/hw/display/ati_dbg.c
index 1e6c32624e5a..b045f81d0602 100644
--- a/hw/display/ati_dbg.c
+++ b/hw/display/ati_dbg.c
@@ -1,3 +1,4 @@
+#include "qemu/osdep.h"
 #include "ati_int.h"
 
 #ifdef DEBUG_ATI
diff --git a/tests/qos-test.c b/tests/qos-test.c
index 6b1145ecccff..ae2fb5de1c9b 100644
--- a/tests/qos-test.c
+++ b/tests/qos-test.c
@@ -16,8 +16,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>
  */
 
-#include <getopt.h>
 #include "qemu/osdep.h"
+#include <getopt.h>
 #include "libqtest.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qbool.h"
-- 
2.20.1


