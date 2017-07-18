Received: from eggs.gnu.org ([2001:4830:134:3::10]:48612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dXKwJ-0000TJ-6A
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dXKwF-0005Z1-WC
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:20:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dXKwF-0005YB-MC
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:20:51 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6I5JLss090316
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 01:20:49 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bs1svyr39-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 01:20:49 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 18 Jul 2017 01:20:48 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 18 Jul 2017 00:20:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1500355216-23603-1-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/8] qemu-ga patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The following changes since commit ca4e667dbf431d4a2a5a619cde79d30dd2ac3e=
b2:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20170717-pull-req=
uest' into staging (2017-07-17 17:54:17 +0100)

are available in the git repository at:

  git://github.com/mdroth/qemu.git tags/qga-pull-2017-07-17-tag

for you to fetch changes up to 48f66332e435ed35c23f3c6ec40b2f1af521758f:

  test-qga: add test for guest-get-osinfo (2017-07-17 19:27:45 -0500)

----------------------------------------------------------------
qemu-ga patch queue
* new command: qemu-get-osinfo
* build fix for OpenBSD
* better error-reporting for failure on keyfile dump
* remove redundant initialization of qa_state global
* include libpcre in w32 package
* w32 localization fixes for service installation/registration

----------------------------------------------------------------
Daniel Rempel (1):
      qga-win: fix installation on localized windows

Marc-Andr=C3=A9 Lureau (1):
      qga: report error on keyfile dump error

Peng Hao (1):
      qga-win32: remove a redundancy code

Thomas Lamprecht (1):
      qemu-ga: add missing libpcre to MSI build

Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (4):
      qemu-ga: check if utmpx.h is available on the system
      qemu-ga: add guest-get-osinfo command
      test-qga: pass environemnt to qemu-ga
      test-qga: add test for guest-get-osinfo

 configure                      |  19 +++++
 qga/commands-posix.c           | 158 +++++++++++++++++++++++++++++++++-
 qga/commands-win32.c           | 188 +++++++++++++++++++++++++++++++++++=
++++++
 qga/installer/qemu-ga.wxs      |   4 +
 qga/main.c                     |   9 +-
 qga/qapi-schema.json           |  65 ++++++++++++++
 qga/vss-win32/install.cpp      |  35 +++++++-
 tests/data/test-qga-os-release |   7 ++
 tests/test-qga.c               |  64 +++++++++++++-
 9 files changed, 540 insertions(+), 9 deletions(-)
 create mode 100644 tests/data/test-qga-os-release
