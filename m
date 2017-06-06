Received: from eggs.gnu.org ([2001:4830:134:3::10]:42397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIFz5-0006o2-Ip
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIFyx-0004dZ-Ae
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:01:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dIFyx-0004cX-11
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:01:19 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Jun 2017 17:01:15 +0200
Message-Id: <20170606150115.17264-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] docs: create config/,
 devel/ and spin/ subdirectories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, berrange@redhat.com

Developer documentation should be its own manual.  As a start, move all
developer-oriented files to a separate directory.

Also move non-text files to their own directories: docs/config/ for
QEMU -readconfig input, and docs/spin/ for formal models to be used
with the SPIN model checker.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/{ => config}/ich9-ehci-uhci.cfg       | 0
 docs/{ => config}/mach-virt-graphical.cfg  | 0
 docs/{ => config}/mach-virt-serial.cfg     | 0
 docs/{ => config}/q35-emulated.cfg         | 0
 docs/{ => config}/q35-virtio-graphical.cfg | 0
 docs/{ => config}/q35-virtio-serial.cfg    | 0
 docs/{ => devel}/atomics.txt               | 0
 docs/{ => devel}/bitmaps.md                | 0
 docs/{ => devel}/blkdebug.txt              | 0
 docs/{ => devel}/blkverify.txt             | 0
 docs/{ => devel}/build-system.txt          | 0
 docs/{ => devel}/lockcnt.txt               | 0
 docs/{ => devel}/memory.txt                | 0
 docs/{ => devel}/migration.txt             | 0
 docs/{ => devel}/multi-thread-tcg.txt      | 0
 docs/{ => devel}/multiple-iothreads.txt    | 0
 docs/{ => devel}/qapi-code-gen.txt         | 0
 docs/{ => devel}/rcu.txt                   | 0
 docs/{ => devel}/tracing.txt               | 0
 docs/{ => devel}/virtio-migration.txt      | 0
 docs/{ => devel}/writing-qmp-commands.txt  | 0
 docs/{ => spin}/aio_notify.promela         | 0
 docs/{ => spin}/aio_notify_accept.promela  | 0
 docs/{ => spin}/aio_notify_bug.promela     | 0
 docs/{ => spin}/tcg-exclusive.promela      | 0
 docs/{ => spin}/win32-qemu-event.promela   | 0
 26 files changed, 0 insertions(+), 0 deletions(-)
 rename docs/{ => config}/ich9-ehci-uhci.cfg (100%)
 rename docs/{ => config}/mach-virt-graphical.cfg (100%)
 rename docs/{ => config}/mach-virt-serial.cfg (100%)
 rename docs/{ => config}/q35-emulated.cfg (100%)
 rename docs/{ => config}/q35-virtio-graphical.cfg (100%)
 rename docs/{ => config}/q35-virtio-serial.cfg (100%)
 rename docs/{ => devel}/atomics.txt (100%)
 rename docs/{ => devel}/bitmaps.md (100%)
 rename docs/{ => devel}/blkdebug.txt (100%)
 rename docs/{ => devel}/blkverify.txt (100%)
 rename docs/{ => devel}/build-system.txt (100%)
 rename docs/{ => devel}/lockcnt.txt (100%)
 rename docs/{ => devel}/memory.txt (100%)
 rename docs/{ => devel}/migration.txt (100%)
 rename docs/{ => devel}/multi-thread-tcg.txt (100%)
 rename docs/{ => devel}/multiple-iothreads.txt (100%)
 rename docs/{ => devel}/qapi-code-gen.txt (100%)
 rename docs/{ => devel}/rcu.txt (100%)
 rename docs/{ => devel}/tracing.txt (100%)
 rename docs/{ => devel}/virtio-migration.txt (100%)
 rename docs/{ => devel}/writing-qmp-commands.txt (100%)
 rename docs/{ => spin}/aio_notify.promela (100%)
 rename docs/{ => spin}/aio_notify_accept.promela (100%)
 rename docs/{ => spin}/aio_notify_bug.promela (100%)
 rename docs/{ => spin}/tcg-exclusive.promela (100%)
 rename docs/{ => spin}/win32-qemu-event.promela (100%)

diff --git a/docs/ich9-ehci-uhci.cfg b/docs/config/ich9-ehci-uhci.cfg
similarity index 100%
rename from docs/ich9-ehci-uhci.cfg
rename to docs/config/ich9-ehci-uhci.cfg
diff --git a/docs/mach-virt-graphical.cfg b/docs/config/mach-virt-graphical.cfg
similarity index 100%
rename from docs/mach-virt-graphical.cfg
rename to docs/config/mach-virt-graphical.cfg
diff --git a/docs/mach-virt-serial.cfg b/docs/config/mach-virt-serial.cfg
similarity index 100%
rename from docs/mach-virt-serial.cfg
rename to docs/config/mach-virt-serial.cfg
diff --git a/docs/q35-emulated.cfg b/docs/config/q35-emulated.cfg
similarity index 100%
rename from docs/q35-emulated.cfg
rename to docs/config/q35-emulated.cfg
diff --git a/docs/q35-virtio-graphical.cfg b/docs/config/q35-virtio-graphical.cfg
similarity index 100%
rename from docs/q35-virtio-graphical.cfg
rename to docs/config/q35-virtio-graphical.cfg
diff --git a/docs/q35-virtio-serial.cfg b/docs/config/q35-virtio-serial.cfg
similarity index 100%
rename from docs/q35-virtio-serial.cfg
rename to docs/config/q35-virtio-serial.cfg
diff --git a/docs/atomics.txt b/docs/devel/atomics.txt
similarity index 100%
rename from docs/atomics.txt
rename to docs/devel/atomics.txt
diff --git a/docs/bitmaps.md b/docs/devel/bitmaps.md
similarity index 100%
rename from docs/bitmaps.md
rename to docs/devel/bitmaps.md
diff --git a/docs/blkdebug.txt b/docs/devel/blkdebug.txt
similarity index 100%
rename from docs/blkdebug.txt
rename to docs/devel/blkdebug.txt
diff --git a/docs/blkverify.txt b/docs/devel/blkverify.txt
similarity index 100%
rename from docs/blkverify.txt
rename to docs/devel/blkverify.txt
diff --git a/docs/build-system.txt b/docs/devel/build-system.txt
similarity index 100%
rename from docs/build-system.txt
rename to docs/devel/build-system.txt
diff --git a/docs/lockcnt.txt b/docs/devel/lockcnt.txt
similarity index 100%
rename from docs/lockcnt.txt
rename to docs/devel/lockcnt.txt
diff --git a/docs/memory.txt b/docs/devel/memory.txt
similarity index 100%
rename from docs/memory.txt
rename to docs/devel/memory.txt
diff --git a/docs/migration.txt b/docs/devel/migration.txt
similarity index 100%
rename from docs/migration.txt
rename to docs/devel/migration.txt
diff --git a/docs/multi-thread-tcg.txt b/docs/devel/multi-thread-tcg.txt
similarity index 100%
rename from docs/multi-thread-tcg.txt
rename to docs/devel/multi-thread-tcg.txt
diff --git a/docs/multiple-iothreads.txt b/docs/devel/multiple-iothreads.txt
similarity index 100%
rename from docs/multiple-iothreads.txt
rename to docs/devel/multiple-iothreads.txt
diff --git a/docs/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
similarity index 100%
rename from docs/qapi-code-gen.txt
rename to docs/devel/qapi-code-gen.txt
diff --git a/docs/rcu.txt b/docs/devel/rcu.txt
similarity index 100%
rename from docs/rcu.txt
rename to docs/devel/rcu.txt
diff --git a/docs/tracing.txt b/docs/devel/tracing.txt
similarity index 100%
rename from docs/tracing.txt
rename to docs/devel/tracing.txt
diff --git a/docs/virtio-migration.txt b/docs/devel/virtio-migration.txt
similarity index 100%
rename from docs/virtio-migration.txt
rename to docs/devel/virtio-migration.txt
diff --git a/docs/writing-qmp-commands.txt b/docs/devel/writing-qmp-commands.txt
similarity index 100%
rename from docs/writing-qmp-commands.txt
rename to docs/devel/writing-qmp-commands.txt
diff --git a/docs/aio_notify.promela b/docs/spin/aio_notify.promela
similarity index 100%
rename from docs/aio_notify.promela
rename to docs/spin/aio_notify.promela
diff --git a/docs/aio_notify_accept.promela b/docs/spin/aio_notify_accept.promela
similarity index 100%
rename from docs/aio_notify_accept.promela
rename to docs/spin/aio_notify_accept.promela
diff --git a/docs/aio_notify_bug.promela b/docs/spin/aio_notify_bug.promela
similarity index 100%
rename from docs/aio_notify_bug.promela
rename to docs/spin/aio_notify_bug.promela
diff --git a/docs/tcg-exclusive.promela b/docs/spin/tcg-exclusive.promela
similarity index 100%
rename from docs/tcg-exclusive.promela
rename to docs/spin/tcg-exclusive.promela
diff --git a/docs/win32-qemu-event.promela b/docs/spin/win32-qemu-event.promela
similarity index 100%
rename from docs/win32-qemu-event.promela
rename to docs/spin/win32-qemu-event.promela
-- 
2.13.0
