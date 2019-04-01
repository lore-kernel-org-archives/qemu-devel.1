Received: from eggs.gnu.org ([209.51.188.92]:46828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hAxgQ-00066p-34
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hAxgO-0006xH-TI
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:13:05 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Mon,  1 Apr 2019 16:12:21 +0200
Message-Id: <20190401141222.30034-5-lvivier@redhat.com>
In-Reply-To: <20190401141222.30034-1-lvivier@redhat.com>
References: <20190401141222.30034-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 4/5] build: chardev is only needed for
 softmmu targets
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

Move the dependency from SUBDIR_RULES to SOFTMMU_SUBDIR_RULES

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 Makefile      | 3 ++-
 Makefile.objs | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 10ae5e31fc0a..d2de0b6e56cc 100644
--- a/Makefile
+++ b/Makefile
@@ -440,6 +440,7 @@ SOFTMMU_SUBDIR_RULES=3D$(filter %-softmmu,$(SUBDIR_RU=
LES))
=20
 $(SOFTMMU_SUBDIR_RULES): $(authz-obj-y)
 $(SOFTMMU_SUBDIR_RULES): $(block-obj-y)
+$(SOFTMMU_SUBDIR_RULES): $(chardev-obj-y)
 $(SOFTMMU_SUBDIR_RULES): $(crypto-obj-y)
 $(SOFTMMU_SUBDIR_RULES): $(io-obj-y)
 $(SOFTMMU_SUBDIR_RULES): config-all-devices.mak
@@ -475,7 +476,7 @@ subdir-capstone: .git-submodule-status
 subdir-slirp: .git-submodule-status
 	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp BUILD_DIR=3D"$(BUILD_=
DIR)/slirp" CC=3D"$(CC)" AR=3D"$(AR)" LD=3D"$(LD)" RANLIB=3D"$(RANLIB)" C=
FLAGS=3D"$(QEMU_CFLAGS)")
=20
-$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) \
+$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) \
 	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
=20
 ROMSUBDIR_RULES=3D$(patsubst %,romsubdir-%, $(ROMS))
diff --git a/Makefile.objs b/Makefile.objs
index dda5bbc9101f..43c9e4503297 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -129,9 +129,9 @@ trace-events-subdirs +=3D accel/kvm
 trace-events-subdirs +=3D accel/tcg
 trace-events-subdirs +=3D authz
 trace-events-subdirs +=3D block
-trace-events-subdirs +=3D chardev
 trace-events-subdirs +=3D crypto
 ifeq ($(CONFIG_SOFTMMU),y)
+trace-events-subdirs +=3D chardev
 trace-events-subdirs +=3D audio
 trace-events-subdirs +=3D hw/9pfs
 trace-events-subdirs +=3D hw/acpi
--=20
2.20.1
