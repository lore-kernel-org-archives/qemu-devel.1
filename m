Received: from eggs.gnu.org ([2001:4830:134:3::10]:58706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dIfN1-0006nC-92
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dIfN0-0004Bq-6f
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:07:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dIfN0-0004Bg-0z
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:07:50 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  7 Jun 2017 19:07:34 +0100
Message-Id: <20170607180736.11011-4-stefanha@redhat.com>
In-Reply-To: <20170607180736.11011-1-stefanha@redhat.com>
References: <20170607180736.11011-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 3/5] .gdbinit: load QEMU sub-commands
 when gdb starts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The scripts/qemu-gdb.py file is not easily discoverable.  Add a .gdbinit
file so GDB either loads qemu-gdb.py automatically or prints a message
informing the user how to enable them (some systems disable ./.gdbinit
loading for security reasons).

Symlink .gdbinit and the scripts directory in order to make out-of-tree
builds work.  The scripts directory is used to find the qemu-gdb.py file
specified by a relative path in .gdbinit.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Eric Blake <eblake@redhat.com>
Message-id: 20170517124042.1430-1-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 configure | 1 +
 .gdbinit  | 8 ++++++++
 2 files changed, 9 insertions(+)
 create mode 100644 .gdbinit

diff --git a/configure b/configure
index 13e040d..2203b98 100755
--- a/configure
+++ b/configure
@@ -6376,6 +6376,7 @@ FILES=3D"$FILES pc-bios/spapr-rtas/Makefile"
 FILES=3D"$FILES pc-bios/s390-ccw/Makefile"
 FILES=3D"$FILES roms/seabios/Makefile roms/vgabios/Makefile"
 FILES=3D"$FILES pc-bios/qemu-icon.bmp"
+FILES=3D"$FILES .gdbinit scripts" # scripts needed by relative path in .=
gdbinit
 for bios_file in \
     $source_path/pc-bios/*.bin \
     $source_path/pc-bios/*.lid \
diff --git a/.gdbinit b/.gdbinit
new file mode 100644
index 0000000..9d322fc
--- /dev/null
+++ b/.gdbinit
@@ -0,0 +1,8 @@
+# GDB may have ./.gdbinit loading disabled by default.  In that case you=
 can
+# follow the instructions it prints.  They boil down to adding the follo=
wing to
+# your home directory's ~/.gdbinit file:
+#
+#   add-auto-load-safe-path /path/to/qemu/.gdbinit
+
+# Load QEMU-specific sub-commands and settings
+source scripts/qemu-gdb.py
--=20
2.9.4
