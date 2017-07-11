Received: from eggs.gnu.org ([2001:4830:134:3::10]:53993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dUu0L-0004l2-Mh
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:11:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dUu0I-0006NL-GT
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:11:01 -0400
Received: from mail-bl2nam02on0058.outbound.protection.outlook.com
	([104.47.38.58]:60468
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dUu0I-0006Lf-9N
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:10:58 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 11 Jul 2017 05:07:37 -0700
Message-ID: <e58acdaa087956a792a8e81098b86485291c6d36.1499774331.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1499774331.git.alistair.francis@xilinx.com>
References: <cover.1499774331.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 7/8] Convert error_report*_err() to
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
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, philippe@mathieu-daude.net, berrange@redhat.com, armbru@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

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
---

 hw/core/qdev-properties.c | 2 +-
 hw/i386/pc.c              | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index f5983c83da..3d0bba21a2 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1169,7 +1169,7 @@ static void qdev_prop_set_globals_for_type(DeviceStat=
e *dev,
                 error_propagate(prop->errp, err);
             } else {
                 assert(prop->user_provided);
-                error_reportf_err(err, "Warning: ");
+                warn_report_err(err);
             }
         }
     }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 084ca796c2..4d5bc6e5f3 100644
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
2.11.0
