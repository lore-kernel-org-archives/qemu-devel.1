Received: from eggs.gnu.org ([2001:4830:134:3::10]:60597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d3cH6-0001Bt-7o
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d3cH3-0003kz-3l
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:47:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1d3cH2-0003kv-RW
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:47:29 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3R5hk9C040591
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 01:47:27 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a3ah3rfut-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 01:47:27 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 27 Apr 2017 01:47:26 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 27 Apr 2017 00:46:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1493271996-23607-1-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 0/8] qemu-ga patch queue
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

The following changes since commit 81b2d5ceb0cfb4cdc2163492e3169ed714b0cd=
a9:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20170426' into =
staging (2017-04-26 20:50:49 +0100)

are available in the git repository at:

  git://github.com/mdroth/qemu.git tags/qga-pull-2017-04-25-v2-tag

for you to fetch changes up to 53c58e64d0a27c59d763778faa2b5a522c544719:

  qga: Add `guest-get-timezone` command (2017-04-27 00:40:25 -0500)

----------------------------------------------------------------
qemu-ga patch queue

* new commands: guest-get-timezone, guest-get-users, guest-get-host-name
* fix hang on w32 when stopping qemu-ga service while fs frozen
* fix missing setting of can-offline in guest-get-vcpus
* make qemu-ga VSS w32 service on-demand rather than on-startup
* fix unecessary errors to EventLog on w32
* improvements to fsfreeze documentation

v2:
 * document 'zone' field of guest-get-timezone as informational-only
   (Daniel, Eric)
 * fix build error for glib < 2.32 (Peter)

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
 include/glib-compat.h       |   6 +++
 qga/commands-posix.c        |  60 +++++++++++++++++++++++++
 qga/commands-win32.c        | 105 ++++++++++++++++++++++++++++++++++++++=
+++++-
 qga/commands.c              |  49 +++++++++++++++++++++
 qga/main.c                  |  23 ++++++++++
 qga/qapi-schema.json        |  88 ++++++++++++++++++++++++++++++++++++-
 qga/vss-win32.h             |   1 +
 qga/vss-win32/install.cpp   |  28 +++++++++++-
 qga/vss-win32/install.h     |  20 +++++++++
 qga/vss-win32/provider.cpp  |   1 -
 qga/vss-win32/requester.cpp |   2 +
 qga/vss-win32/vss-common.h  |  11 +----
 qga/vss-win32/vss-handles.h |  14 ++++++
 14 files changed, 393 insertions(+), 17 deletions(-)
 create mode 100644 qga/vss-win32/install.h
 create mode 100644 qga/vss-win32/vss-handles.h
