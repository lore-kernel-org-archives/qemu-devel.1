Received: from eggs.gnu.org ([2001:4830:134:3::10]:57564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ef94G-0002JK-5J
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ef94D-0003MI-32
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:49:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58326
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ef94C-0003M6-TS
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:49:37 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0QInHZC037104
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 13:49:35 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fr5cw3316-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 13:49:34 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 26 Jan 2018 11:49:34 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 26 Jan 2018 13:49:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1516992568-3139-1-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Merge tpm 2018/01/26
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

   Stefan

The following changes since commit 0f79bfe38a2cf0f43c7ea4959da7f8ebd7858f=
3d:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-2.12-=
pull-request' into staging (2018-01-25 09:53:53 +0000)

are available in the git repository at:

  git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-01-26-1

for you to fetch changes up to b510b21e072a0a9218f37051c885e95824d06bea:

  tpm: add CRB device (2018-01-26 10:12:02 -0500)

----------------------------------------------------------------
Merge tpm 2018/01/26 v1

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (4):
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
 hw/tpm/tpm_emulator.c              |  25 +++-----
 hw/tpm/tpm_passthrough.c           |  65 +++++++++++--------
 hw/tpm/tpm_tis.c                   |   3 +-
 include/hw/acpi/tpm.h              |  51 +++++++++++++++
 include/sysemu/tpm.h               |   5 +-
 include/sysemu/tpm_backend.h       |  15 ++++-
 qapi/tpm.json                      |   5 +-
 tests/Makefile.include             |   2 +
 tests/tpm-crb-test.c               | 275 +++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++
 15 files changed, 760 insertions(+), 85 deletions(-)
 create mode 100644 hw/tpm/tpm_crb.c
 create mode 100644 tests/tpm-crb-test.c

--=20
2.5.5
