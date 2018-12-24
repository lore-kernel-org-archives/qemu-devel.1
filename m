Received: from eggs.gnu.org ([208.118.235.92]:58609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gbSU1-0002lw-0I
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 10:49:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gbSTv-0003w4-5Y
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 10:49:32 -0500
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Date: Mon, 24 Dec 2018 10:49:22 -0500
Message-Id: <20181224154922.3338-1-wainersm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] hw/core: fix whitespace in a sentence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 hw/core/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 4439ea663f..a0beeeb2a9 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -591,7 +591,7 @@ static void machine_class_init(ObjectClass *oc, void =
*data)
     object_class_property_add_bool(oc, "dump-guest-core",
         machine_get_dump_guest_core, machine_set_dump_guest_core, &error=
_abort);
     object_class_property_set_description(oc, "dump-guest-core",
-        "Include guest memory in  a core dump", &error_abort);
+        "Include guest memory in a core dump", &error_abort);
=20
     object_class_property_add_bool(oc, "mem-merge",
         machine_get_mem_merge, machine_set_mem_merge, &error_abort);
--=20
2.19.2
