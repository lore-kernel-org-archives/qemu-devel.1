Received: from eggs.gnu.org ([2001:4830:134:3::10]:38497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7tJB-0003G1-Mf
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7tJ6-0003QE-OX
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:19:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56932
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e7tJ6-0003PM-Jp
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:19:32 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9R1JKbk113122
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 21:19:29 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dus554ff5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 21:19:29 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 26 Oct 2017 21:19:28 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 26 Oct 2017 20:18:45 -0500
Message-Id: <20171027011849.29195-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL 0/4] qemu-ga patch queue
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

The following changes since commit ae49fbbcd8e4e9d8bf7131add34773f579e1aff7:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20171025' into staging (2017-10-25 16:38:57 +0100)

are available in the git repository at:

  git://github.com/mdroth/qemu.git tags/qga-pull-2017-10-26-tag

for you to fetch changes up to 8cedc80555e5a395a4fda7130b0115015e775c48:

  qga-win: fix error-handling in getNameByStringSID() (2017-10-26 20:01:32 -0500)

----------------------------------------------------------------
qemu-ga patch queue for 2.11

* support for network interface stats
* w32: improvements for guest-set-time
* w32: fix a hang with guest-fsfreeze-freeze when timeout occurs
  during heavy I/O
* w32: fix faulty error-handling in VSS/fsfreeze COM registration

----------------------------------------------------------------
Bishara AbuHattoum (1):
      qga-win: Updating guest_set_time action

Chen Hanxiao (1):
      qga-win: don't hang if vss hold writes timeout

Michael Roth (1):
      qga-win: fix error-handling in getNameByStringSID()

ZhiPeng Lu (1):
      qga: add network stats to guest-network-get-interfaces

 configure                   |  2 +-
 qga/commands-posix.c        | 74 +++++++++++++++++++++++++++++++++++++-
 qga/commands-win32.c        | 86 ++++++++++++++++++++++++++++++++++++++++++++-
 qga/qapi-schema.json        | 38 +++++++++++++++++++-
 qga/vss-win32/install.cpp   | 13 ++++---
 qga/vss-win32/requester.cpp | 12 +++++++
 6 files changed, 217 insertions(+), 8 deletions(-)
