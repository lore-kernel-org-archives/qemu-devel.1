Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81504C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56B18214DA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B18214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46967 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHDsZ-0000S5-Fx
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 16:43:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHDnx-0001J3-39
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHDnv-0002dn-Ls
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:38:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHDnv-0002c4-Dy
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:38:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 556B53076C60
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:38:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 004A460BEC
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:38:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 6945D1132BB6; Thu, 18 Apr 2019 22:38:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 22:38:32 +0200
Message-Id: <20190418203840.10528-2-armbru@redhat.com>
In-Reply-To: <20190418203840.10528-1-armbru@redhat.com>
References: <20190418203840.10528-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Thu, 18 Apr 2019 20:38:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL for-4.1 1/9] Clean up includes
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418203832.i1Ajh7rYqsBfSzH533o9U57eHIwJ6l8TQjwAtQsaXXk@z>

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
Message-Id: <20190313162812.8885-1-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 contrib/elf2dmp/main.c   | 3 +--
 contrib/elf2dmp/pdb.c    | 3 +--
 hw/display/ati.c         | 1 +
 hw/display/ati_2d.c      | 1 +
 hw/display/ati_dbg.c     | 1 +
 hw/display/ati_int.h     | 1 -
 include/hw/cpu/cluster.h | 1 -
 tests/fp/platform.h      | 1 -
 tests/libqos/qgraph.h    | 4 ----
 tests/qos-test.c         | 2 +-
 10 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 1bfeb89ba7..9a2dbc2902 100644
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
index 64af20f584..a5bd40c99d 100644
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
index db409be3c9..75716dd944 100644
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
index bc98ba6eeb..f31b3c27c7 100644
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
index 1e6c32624e..b045f81d06 100644
--- a/hw/display/ati_dbg.c
+++ b/hw/display/ati_dbg.c
@@ -1,3 +1,4 @@
+#include "qemu/osdep.h"
 #include "ati_int.h"
 
 #ifdef DEBUG_ATI
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index a6f3e20e63..2f426064cf 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -9,7 +9,6 @@
 #ifndef ATI_INT_H
 #define ATI_INT_H
 
-#include "qemu/osdep.h"
 #include "hw/pci/pci.h"
 #include "vga_int.h"
 
diff --git a/include/hw/cpu/cluster.h b/include/hw/cpu/cluster.h
index 549c2d31d4..01c1e50cd2 100644
--- a/include/hw/cpu/cluster.h
+++ b/include/hw/cpu/cluster.h
@@ -20,7 +20,6 @@
 #ifndef HW_CPU_CLUSTER_H
 #define HW_CPU_CLUSTER_H
 
-#include "qemu/osdep.h"
 #include "hw/qdev.h"
 
 /*
diff --git a/tests/fp/platform.h b/tests/fp/platform.h
index c20ba70baa..f8c423dde3 100644
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
index ef0c73837a..e799095b30 100644
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
 
diff --git a/tests/qos-test.c b/tests/qos-test.c
index 6b1145eccc..ae2fb5de1c 100644
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
2.17.2


