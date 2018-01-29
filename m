Received: from eggs.gnu.org ([2001:4830:134:3::10]:34981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1egHs0-0004Za-2K
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 17:25:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1egHrw-0005tH-Tw
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 17:25:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1egHrw-0005se-Kr
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 17:25:40 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0TMPMmx036457
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 17:25:38 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ftbbvj7mv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 17:25:38 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 29 Jan 2018 17:25:37 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 29 Jan 2018 17:25:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1517264719-18288-1-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 0/6] Merge tpm 2018/01/26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com, peter.maydell@linaro.org

The patches in this pull request fix a bug in the initialization of
a variable, adapt the cancel path used by the passthrough device to the
sysfs path of more recent versions of the Linux kernel, and do some other
cleanups preparing for support of migration. Finally, we add the CRB
interface emulation, which is used with a TPM 2.

The following changes since commit 0d1442912b3d6591a57ee45fbf28bc91e58d9e=
76:

  Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' i=
nto staging (2018-01-29 14:29:17 +0000)

are available in the git repository at:

  git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-01-26-2

for you to fetch changes up to 4ab6cb4c62273bb46102e5ae1d6af691b47cbcd8:

  tpm: add CRB device (2018-01-29 14:22:50 -0500)

----------------------------------------------------------------
Merge tpm 2018/01/26 v2

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (5):
      tpm: fix alignment issues
      tpm: lookup cancel path under tpm device class
      tpm: replace GThreadPool with AIO threadpool
      tpm: report backend request error
      tpm: add CRB device

Stefan Berger (1):
      tpm: Set the flags of the CMD_INIT command to 0

 backends/tpm.c                     |  59 +++++++++--------
 default-configs/i386-softmmu.mak   |   1 +
 default-configs/x86_64-softmmu.mak |   1 +
 hw/i386/acpi-build.c               |  34 +++++++---
 hw/tpm/Makefile.objs               |   1 +
 hw/tpm/tpm_crb.c                   | 303 +++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/tpm/tpm_emulator.c              |  39 +++++-------
 hw/tpm/tpm_passthrough.c           |  71 +++++++++++----------
 hw/tpm/tpm_tis.c                   |   3 +-
 hw/tpm/tpm_util.c                  |  75 ++++++++++------------
 hw/tpm/tpm_util.h                  |  17 ++++-
 include/hw/acpi/tpm.h              |  51 +++++++++++++++
 include/sysemu/tpm.h               |   5 +-
 include/sysemu/tpm_backend.h       |  15 ++++-
 qapi/tpm.json                      |   5 +-
 tests/Makefile.include             |   2 +
 tests/tpm-crb-test.c               | 275 +++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++
 17 files changed, 818 insertions(+), 139 deletions(-)
 create mode 100644 hw/tpm/tpm_crb.c
 create mode 100644 tests/tpm-crb-test.c

--=20
2.5.5
