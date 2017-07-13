Received: from eggs.gnu.org ([2001:4830:134:3::10]:59167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVeA4-00005w-12
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVeA3-0001Oh-2b
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:28:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dVeA2-0001OE-Sn
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:28:07 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Jul 2017 15:27:56 +0200
Message-Id: <1499952476-3454-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1499952476-3454-1-git-send-email-armbru@redhat.com>
References: <1499952476-3454-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 9/9] Convert error_report*_err() to
 warn_report*_err()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

From: Alistair Francis <alistair.francis@xilinx.com>

Convert all uses of error_report*_err("Warning:"... to use
warn_report*_err() instead. This helps standardise on a single
method of printing warnings to the user.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <d8e088757186955f40f04ec4f4be7f640d3c8660.1499866456.git.alis=
tair.francis@xilinx.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/qdev-properties.c | 2 +-
 hw/i386/pc.c              | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index f5983c8..3d0bba2 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1169,7 +1169,7 @@ static void qdev_prop_set_globals_for_type(DeviceSt=
ate *dev,
                 error_propagate(prop->errp, err);
             } else {
                 assert(prop->user_provided);
-                error_reportf_err(err, "Warning: ");
+                warn_report_err(err);
             }
         }
     }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 465e91c..bf541ca 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1320,8 +1320,7 @@ void pc_acpi_init(const char *default_dsdt)
=20
         acpi_table_add_builtin(opts, &err);
         if (err) {
-            error_reportf_err(err, "WARNING: failed to load %s: ",
-                              filename);
+            warn_reportf_err(err, "failed to load %s: ", filename);
         }
         g_free(filename);
     }
--=20
2.7.5
