Received: from eggs.gnu.org ([2001:4830:134:3::10]:49653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQwC0-0000tp-Iq
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQwBx-0008Dy-Fx
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:47:12 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  7 Jun 2018 11:46:43 -0300
Message-Id: <20180607144645.10187-3-f4bug@amsat.org>
In-Reply-To: <20180607144645.10187-1-f4bug@amsat.org>
References: <20180607144645.10187-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/4] hw/ppc/spapr_drc: Replace
 error_setg(&error_abort) by abort()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Use abort() instead of error_setg(&error_abort),
as suggested by the "qapi/error.h" documentation:

    Please don't error_setg(&error_fatal, ...), use error_report() and
    exit(), because that's more obvious.
    Likewise, don't error_setg(&error_abort, ...), use assert().

Use abort() instead of the suggested assert() because the assertion is
already verified by the switch case.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ppc/spapr_drc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 8a045d6b93..b934b9c9ed 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -366,7 +366,7 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
             break;
         }
         default:
-            error_setg(&error_abort, "device FDT in unexpected state: %d", tag);
+            abort(); /* device FDT in unexpected state */
         }
         fdt_offset = fdt_offset_next;
     } while (fdt_depth != 0);
-- 
2.17.1
