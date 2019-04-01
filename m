Received: from eggs.gnu.org ([209.51.188.92]:46721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hAxg3-0005jG-Q3
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hAxg2-0006rb-HP
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:12:43 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Mon,  1 Apr 2019 16:12:18 +0200
Message-Id: <20190401141222.30034-2-lvivier@redhat.com>
In-Reply-To: <20190401141222.30034-1-lvivier@redhat.com>
References: <20190401141222.30034-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/5] trace: only include trace-event-subdirs
 when they are needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Laurent Vivier <lvivier@redhat.com>

Some directories are built only for softmmu targets,
and the related trace-event-subdirs must do the same

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile.objs | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index cf065de5ed44..dda5bbc9101f 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -127,11 +127,12 @@ rdmacm-mux-obj-y =3D contrib/rdmacm-mux/
 trace-events-subdirs =3D
 trace-events-subdirs +=3D accel/kvm
 trace-events-subdirs +=3D accel/tcg
-trace-events-subdirs +=3D audio
 trace-events-subdirs +=3D authz
 trace-events-subdirs +=3D block
 trace-events-subdirs +=3D chardev
 trace-events-subdirs +=3D crypto
+ifeq ($(CONFIG_SOFTMMU),y)
+trace-events-subdirs +=3D audio
 trace-events-subdirs +=3D hw/9pfs
 trace-events-subdirs +=3D hw/acpi
 trace-events-subdirs +=3D hw/alpha
@@ -140,7 +141,6 @@ trace-events-subdirs +=3D hw/audio
 trace-events-subdirs +=3D hw/block
 trace-events-subdirs +=3D hw/block/dataplane
 trace-events-subdirs +=3D hw/char
-trace-events-subdirs +=3D hw/display
 trace-events-subdirs +=3D hw/dma
 trace-events-subdirs +=3D hw/hppa
 trace-events-subdirs +=3D hw/i2c
@@ -173,11 +173,14 @@ trace-events-subdirs +=3D hw/virtio
 trace-events-subdirs +=3D hw/watchdog
 trace-events-subdirs +=3D hw/xen
 trace-events-subdirs +=3D hw/gpio
+trace-events-subdirs +=3D migration
+trace-events-subdirs +=3D net
+trace-events-subdirs +=3D ui
+endif
+trace-events-subdirs +=3D hw/display
 trace-events-subdirs +=3D io
 trace-events-subdirs +=3D linux-user
-trace-events-subdirs +=3D migration
 trace-events-subdirs +=3D nbd
-trace-events-subdirs +=3D net
 trace-events-subdirs +=3D qapi
 trace-events-subdirs +=3D qom
 trace-events-subdirs +=3D scsi
@@ -189,7 +192,6 @@ trace-events-subdirs +=3D target/ppc
 trace-events-subdirs +=3D target/riscv
 trace-events-subdirs +=3D target/s390x
 trace-events-subdirs +=3D target/sparc
-trace-events-subdirs +=3D ui
 trace-events-subdirs +=3D util
=20
 trace-events-files =3D $(SRC_PATH)/trace-events $(trace-events-subdirs:%=
=3D$(SRC_PATH)/%/trace-events)
--=20
2.20.1
