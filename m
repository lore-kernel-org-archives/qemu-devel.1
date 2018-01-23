Received: from eggs.gnu.org ([2001:4830:134:3::10]:38621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <izik@veertu.com>) id 1edxoi-0008PQ-IE
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 07:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <izik@veertu.com>) id 1edxoe-0003nU-NL
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 07:36:44 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:40148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <izik@veertu.com>) id 1edxoe-0003n4-Gu
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 07:36:40 -0500
Received: by mail-wm0-x241.google.com with SMTP id v123so1567019wmd.5
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 04:36:40 -0800 (PST)
From: Izik Eidus <izik@veertu.com>
Date: Tue, 23 Jan 2018 14:36:38 +0200
Message-Id: <20180123123639.35255-2-izik@veertu.com>
In-Reply-To: <20180123123639.35255-1-izik@veertu.com>
References: <20180123123639.35255-1-izik@veertu.com>
Subject: [Qemu-devel] [PATCH 1/2] Add missing hvdos public domain
 attribution:
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Izik Eidus <izik@veertu.com>

hvf.c and vmx.h contain code from hvdos.c that is released as public domain:

from hvdos github: https://github.com/mist64/hvdos

"License

See LICENSE.txt (2-clause-BSD).

In order to simplify use of this code as a template, you can consider any parts from "hvdos.c" and "interface.h" as being in the public domain."

Signed-off-by: Izik Eidus <izik@veertu.com>
---
 target/i386/hvf/hvf.c | 3 +++
 target/i386/hvf/vmx.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 010866ed22..ab4820c3f5 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -17,6 +17,9 @@
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * This file contain code under public domain from the hvdos project:
+ * https://github.com/mist64/hvdos
  */
 #include "qemu/osdep.h"
 #include "qemu-common.h"
diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 9dfcd2f2eb..162a7d51ae 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -17,6 +17,9 @@
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * This file contain code under public domain from the hvdos project:
+ * https://github.com/mist64/hvdos
  */
 
 #ifndef VMX_H
-- 
2.13.6 (Apple Git-96)
