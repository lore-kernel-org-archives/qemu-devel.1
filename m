Received: from eggs.gnu.org ([2001:4830:134:3::10]:41254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1faSIz-0008QG-H0
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1faSIu-0000xb-Hu
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34428
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1faSIu-0000x1-1l
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:40 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w63KnOvw023570
	for <qemu-devel@nongnu.org>; Tue, 3 Jul 2018 16:53:38 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2k0dpcpds0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 16:53:38 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 3 Jul 2018 14:53:37 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  3 Jul 2018 15:52:07 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/14] qga patch queue for soft-freeze
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

Hi Peter,

Sorry for the last-minute pull request. Most of these have been on the li=
st
for a while now waiting to be applied. Please consider pulling these in.

The following changes since commit b07cd3e748b3f27a17c27afeee578dc4eedb8d=
d5:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-3.0-20180703=
' into staging (2018-07-03 14:59:27 +0100)

are available in the git repository at:

  git://github.com/mdroth/qemu.git tags/qga-pull-2018-07-03-tag

for you to fetch changes up to 73e1d8eb9b738cef3dee2da26bb669b1092a4c12:

  qga: removing bios_supports_mode (2018-07-03 15:20:51 -0500)

----------------------------------------------------------------
qemu-ga patch queue for soft-freeze

* add systemd suspend support
* add used/total space stats for guest-get-fsinfo
* fixes for guest-get-fsinfo over PCI bridges
* MSI installer and schema doc fixes
* guard against unbounded allocations in guest-file-read
* add some additional qga test cases

----------------------------------------------------------------
Bishara AbuHattoum (1):
      qga-win: Fixing msi upgrade disallow in WiX file

Chen Hanxiao (3):
      qga: unset frozen state if no mount points are frozen
      qga: add mountpoint usage info to GuestFilesystemInfo
      qga-win: add driver path usage to GuestFilesystemInfo

Daniel Henrique Barboza (6):
      qga: refactoring qmp_guest_suspend_* functions
      qga: bios_supports_mode: decoupling pm-utils and sys logic
      qga: guest_suspend: decoupling pm-utils and sys logic
      qga: removing switch statements, adding run_process_child
      qga: systemd hibernate/suspend/hybrid-sleep support
      qga: removing bios_supports_mode

Marc-Andr=C3=A9 Lureau (1):
      qemu-ga: make get-fsinfo work over pci bridges

Prasad J Pandit (1):
      qga: check bytes count read by guest-file-read

Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (2):
      test-qga: add trivial tests for some commands
      qga/schema: fix documentation for GuestOSInfo

 qga/commands-posix.c      | 362 +++++++++++++++++++++++++++++++---------=
------
 qga/commands-win32.c      |  14 +-
 qga/installer/qemu-ga.wxs |   2 +-
 qga/qapi-schema.json      |  11 +-
 tests/test-qga.c          |  54 +++++++
 5 files changed, 325 insertions(+), 118 deletions(-)
