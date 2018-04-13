Received: from eggs.gnu.org ([2001:4830:134:3::10]:43511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f71pu-0002uJ-9G
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 12:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f71pq-0000pk-7O
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 12:46:06 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Apr 2018 18:45:45 +0200
Message-Id: <20180413164545.18409-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] acpi: fix a comment about aml_call0()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/acpi/aml-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 3fa557cea1..1e43cd736d 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -627,7 +627,7 @@ Aml *aml_notify(Aml *arg1, Aml *arg2)
     return var;
 }
=20
-/* helper to call method with 1 argument */
+/* helper to call method without argument */
 Aml *aml_call0(const char *method)
 {
     Aml *var =3D aml_alloc();
--=20
2.17.0.rc1.36.gcedb63ea2f
