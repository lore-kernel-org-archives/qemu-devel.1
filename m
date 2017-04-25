Received: from eggs.gnu.org ([2001:4830:134:3::10]:45183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d39W2-0003EE-UF
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 19:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d39Vz-0004R2-QE
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 19:05:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46585
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1d39Vz-0004Qv-KN
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 19:04:59 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3PN454Z140530
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 19:04:58 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a2ebtjx6p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 19:04:58 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 25 Apr 2017 19:04:58 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 25 Apr 2017 18:04:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1493161481-29595-1-git-send-email-mdroth@linux.vnet.ibm.com>
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

The following changes since commit fe491fa85c4634453b340b18046aae2eaf8147=
db:

  Merge remote-tracking branch 'remotes/agraf/tags/signed-s390-for-upstre=
am' into staging (2017-04-25 14:48:55 +0100)

are available in the git repository at:

  git://github.com/mdroth/qemu.git tags/qga-pull-2017-04-25-tag

for you to fetch changes up to b3734da00e4285521f8eb2c958ab08b981f7a298:

  qga: Add `guest-get-timezone` command (2017-04-25 15:49:24 -0500)

----------------------------------------------------------------
qemu-ga patch queue

* new commands: guest-get-timezone, guest-get-users, guest-get-host-name
* fix hang on w32 when stopping qemu-ga service while fs frozen
* fix missing setting of can-offline in guest-get-vcpus
* make qemu-ga VSS w32 service on-demand rather than on-startup
* fix unecessary errors to EventLog on w32
* improvements to fsfreeze documentation

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (1):
      qga: improve fsfreeze documentations

Sameeh Jubran (4):
      qemu-ga: Make QGA VSS provider service run only when needed
      qga-win: Enable 'can-offline' field in 'guest-get-vcpus' reply
      qga-win: Fix a bug where qemu-ga service is stuck during stop opera=
tion
      qga-win: Fix Event Viewer errors caused by qemu-ga

Vinzenz Feenstra (3):
      qga: Add 'guest-get-host-name' command
      qga: Add 'guest-get-users' command
      qga: Add `guest-get-timezone` command

 configure                   |   2 +-
 include/glib-compat.h       |   5 +++
 qga/commands-posix.c        |  60 +++++++++++++++++++++++++
 qga/commands-win32.c        | 105 ++++++++++++++++++++++++++++++++++++++=
+++++-
 qga/commands.c              |  49 +++++++++++++++++++++
 qga/main.c                  |  23 ++++++++++
 qga/qapi-schema.json        |  87 +++++++++++++++++++++++++++++++++++-
 qga/vss-win32.h             |   1 +
 qga/vss-win32/install.cpp   |  28 +++++++++++-
 qga/vss-win32/install.h     |  20 +++++++++
 qga/vss-win32/provider.cpp  |   1 -
 qga/vss-win32/requester.cpp |   2 +
 qga/vss-win32/vss-common.h  |  11 +----
 qga/vss-win32/vss-handles.h |  14 ++++++
 14 files changed, 391 insertions(+), 17 deletions(-)
 create mode 100644 qga/vss-win32/install.h
 create mode 100644 qga/vss-win32/vss-handles.h
