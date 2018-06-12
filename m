Received: from eggs.gnu.org ([2001:4830:134:3::10]:58632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3g-0002cZ-Pd
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3d-0001fR-5S
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:36 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:44:34 +1000
Message-Id: <20180612064503.14282-5-david@gibson.dropbear.id.au>
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/33] hw/ppc/spapr_drc: Replace
 error_setg(&error_abort) by error_report() + abort()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, David Gibson <david@gibson.dropbear.id.au>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Use error_report() + abort() instead of error_setg(&error_abort),
as suggested by the "qapi/error.h" documentation:

    Please don't error_setg(&error_fatal, ...), use error_report() and
    exit(), because that's more obvious.
    Likewise, don't error_setg(&error_abort, ...), use assert().

Use abort() instead of the suggested assert() because the error message
already got displayed.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 8a045d6b93..2edb7d1e9c 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -366,7 +366,8 @@ static void prop_get_fdt(Object *obj, Visitor *v, con=
st char *name,
             break;
         }
         default:
-            error_setg(&error_abort, "device FDT in unexpected state: %d=
", tag);
+            error_report("device FDT in unexpected state: %d", tag);
+            abort();
         }
         fdt_offset =3D fdt_offset_next;
     } while (fdt_depth !=3D 0);
--=20
2.17.1
