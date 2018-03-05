Received: from eggs.gnu.org ([2001:4830:134:3::10]:41418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esoHi-0003VD-Kk
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:28:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esoHh-0006zx-Dd
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:28:02 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  5 Mar 2018 08:27:13 -0300
Message-Id: <20180305112732.26471-12-f4bug@amsat.org>
In-Reply-To: <20180305112732.26471-1-f4bug@amsat.org>
References: <20180305112732.26471-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 11/30] hw/s390x: use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "open list:S390" <qemu-s390x@nongnu.org>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/sclp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 047d577313..2ffec8f675 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -288,8 +288,8 @@ static void sclp_realize(DeviceState *dev, Error **errp)
 
     ret = s390_set_memory_limit(machine->maxram_size, &hw_limit);
     if (ret == -E2BIG) {
-        error_setg(&err, "host supports a maximum of %" PRIu64 " GB",
-                   hw_limit >> 30);
+        error_setg(&err, "host supports a maximum of %llu GB",
+                   hw_limit / G_BYTE);
     } else if (ret) {
         error_setg(&err, "setting the guest size failed");
     }
-- 
2.16.2
