Received: from eggs.gnu.org ([209.51.188.92]:46687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hAxg1-0005eA-0Z
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hAxg0-0006qv-2C
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:12:40 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Mon,  1 Apr 2019 16:12:17 +0200
Message-Id: <20190401141222.30034-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/5] build: cleanup in Makefile.objs
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

This cleanup removes hardware objects from the list of files to be
built for linux-user only targets.

It also builds traces files only when the related file is built.

Tested with all combinations of --{disable,enable}-{system,user,tools}

v3:
  - don't move hw/display to CONFIG_BLOCK section
v2:
  - add CONFIG_TOOLS and CONFIG_BLOCK
  - replace GENERATED_FILES by generated-files-y
    and use generated-files-${CONFIG_TRACE_UST} and
    generated-files-${CONFIG_SOFTMMU}
  - move chardev-obj-y from SUBDIR_RULES to SOFTMMU_SUBDIR_RULES
  - use $(CONFIG_BLOCK) in tests/Makefile.include
  - disable qemu-ga with linux-user only

Laurent Vivier (5):
  trace: only include trace-event-subdirs when they are needed
  build: replace GENERATED_FILES by generated-files-y
  configure: qemu-ga is only needed with softmmu targets
  build: chardev is only needed for softmmu targets
  build: don't build hardware objects with linux-user

 Makefile                   |  43 +++++++-------
 Makefile.objs              |  22 ++++---
 Makefile.target            |   6 +-
 configure                  |   4 +-
 target/s390x/Makefile.objs |   2 +-
 tests/Makefile.include     | 116 ++++++++++++++++++-------------------
 6 files changed, 102 insertions(+), 91 deletions(-)

--=20
2.20.1
