Received: from eggs.gnu.org ([2001:4830:134:3::10]:36538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1egEFC-0003yr-JA
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:33:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1egEF7-0004Yy-Id
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:33:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1egEF7-0004YU-Dj
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:33:21 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 29 Jan 2018 19:33:02 +0100
Message-Id: <20180129183307.19689-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/5] tpm: CRB device and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This series fixes alignment issues, cleans up a bit the TPM IO thread
handling, allows to report backend error to hw/frontend, and
implements the CRB device.

It is a resend of '[PATCH v2 0/5] tpm: CRB device and cleanups', '[PATCH
v3] tpm: add CRB device', and '[PATCH] tpm: fix alignment issues'
combined on top of master to ease maintainer work.

Marc-Andr=C3=A9 Lureau (5):
  tpm: fix alignment issues
  tpm: lookup cancel path under tpm device class
  tpm: replace GThreadPool with AIO threadpool
  tpm: report backend request error
  tpm: add CRB device

 qapi/tpm.json                      |   5 +-
 hw/tpm/tpm_util.h                  |  17 ++-
 include/hw/acpi/tpm.h              |  51 +++++++
 include/sysemu/tpm.h               |   5 +-
 include/sysemu/tpm_backend.h       |  15 +-
 backends/tpm.c                     |  59 ++++----
 hw/i386/acpi-build.c               |  34 ++++-
 hw/tpm/tpm_crb.c                   | 303 +++++++++++++++++++++++++++++++=
++++++
 hw/tpm/tpm_emulator.c              |  35 ++---
 hw/tpm/tpm_passthrough.c           |  71 +++++----
 hw/tpm/tpm_tis.c                   |   3 +-
 hw/tpm/tpm_util.c                  |  75 +++++----
 tests/tpm-crb-test.c               | 275 +++++++++++++++++++++++++++++++=
++
 default-configs/i386-softmmu.mak   |   1 +
 default-configs/x86_64-softmmu.mak |   1 +
 hw/tpm/Makefile.objs               |   1 +
 tests/Makefile.include             |   2 +
 17 files changed, 815 insertions(+), 138 deletions(-)
 create mode 100644 hw/tpm/tpm_crb.c
 create mode 100644 tests/tpm-crb-test.c

--=20
2.16.0.rc1.1.gef27df75a1
