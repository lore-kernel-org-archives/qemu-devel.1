Received: from eggs.gnu.org ([2001:4830:134:3::10]:56477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ecXO1-00080d-3h
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:11:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ecXNx-0004aV-71
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:11:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ecXNx-0004a2-0x
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:11:13 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 19 Jan 2018 15:10:59 +0100
Message-Id: <20180119141105.29095-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/5] tpm: CRB device and cleanups
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

Hi,

This series cleans up a bit the TPM IO thread handling, allows to
report backend error to hw/frontend, and implements the CRB device. I
adapted a previously sent patch "tpm: extend TPM CRB with state
migration support" from Stefan, and included an old pending patch
"lookup cancel path" in the series to empty my TPM queue.

Comments welcome

Marc-Andr=C3=A9 Lureau (4):
  tpm: lookup cancel path under tpm device class
  tpm: replace GThreadPool with AIO threadpool
  tpm: report backend request error
  tpm: add CRB device

Stefan Berger (1):
  tpm: extend TPM CRB with state migration support

 qapi/tpm.json                      |   5 +-
 include/hw/acpi/tpm.h              |  72 ++++++++
 include/sysemu/tpm.h               |   5 +-
 include/sysemu/tpm_backend.h       |  15 +-
 backends/tpm.c                     |  59 +++---
 hw/i386/acpi-build.c               |  34 +++-
 hw/tpm/tpm_crb.c                   | 357 +++++++++++++++++++++++++++++++=
++++++
 hw/tpm/tpm_emulator.c              |  21 +--
 hw/tpm/tpm_passthrough.c           |  65 ++++---
 hw/tpm/tpm_tis.c                   |   3 +-
 default-configs/i386-softmmu.mak   |   1 +
 default-configs/x86_64-softmmu.mak |   1 +
 hw/tpm/Makefile.objs               |   1 +
 13 files changed, 555 insertions(+), 84 deletions(-)
 create mode 100644 hw/tpm/tpm_crb.c

--=20
2.16.0.rc1.1.gef27df75a1
