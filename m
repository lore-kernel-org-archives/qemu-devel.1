Received: from eggs.gnu.org ([2001:4830:134:3::10]:44620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSC-0004M7-Dg
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSB-0004xK-Dy
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:24 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:39207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimSB-0004wo-6H
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:23 -0500
Received: by mail-wr0-x244.google.com with SMTP id f6so29195560wra.6
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:23 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:28 +0100
Message-Id: <1517858941-5538-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 14/47] Add missing hvdos public domain
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
Cc: Izik Eidus <izik@veertu.com>

From: Izik Eidus <izik@veertu.com>

hvf.c and vmx.h contain code from hvdos.c that is released as public domain:

from hvdos github: https://github.com/mist64/hvdos

"License

See LICENSE.txt (2-clause-BSD).

In order to simplify use of this code as a template, you can consider any parts from "hvdos.c" and "interface.h" as being in the public domain."

Signed-off-by: Izik Eidus <izik@veertu.com>
Message-Id: <20180123123639.35255-2-izik@veertu.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf.c | 3 +++
 target/i386/hvf/vmx.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 010866e..ab4820c 100644
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
index 9dfcd2f..162a7d5 100644
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
1.8.3.1
