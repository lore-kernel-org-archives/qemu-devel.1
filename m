Received: from eggs.gnu.org ([2001:4830:134:3::10]:60334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ckneZ-0002ho-7C
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:06:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ckneV-0006Sp-Hg
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:05:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42337
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ckneV-0006RV-AM
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:05:55 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2683rxd049472
	for <qemu-devel@nongnu.org>; Mon, 6 Mar 2017 03:05:54 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 290bymbhqg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 03:05:54 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 6 Mar 2017 01:05:53 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  6 Mar 2017 02:03:39 -0600
Message-Id: <1488787422-30487-1-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL for-2.9 0/3] qemu-ga patch queue for 2.9
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

The following changes since commit 17783ac828adc694d986698d2d7014aedfeb48c6:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.9-20170303' into staging (2017-03-04 16:31:14 +0000)

are available in the git repository at:

  git://github.com/mdroth/qemu.git tags/qga-pull-2017-03-06-tag

for you to fetch changes up to ec72c0e271f2b13953079a4f4dadb49ac5910b54:

  tests: check path to avoid a failing qga/get-vcpus test (2017-03-06 00:54:19 -0600)

----------------------------------------------------------------
qemu-ga patch queue for 2.9

* fix fsfreeze for filesystems mounted in multiple locations
* fix test failure when running in a chroot
* support for socket-based activation

----------------------------------------------------------------
Bruce Rogers (1):
      tests: check path to avoid a failing qga/get-vcpus test

Peter Lieven (1):
      qga: ignore EBUSY when freezing a filesystem

Stefan Hajnoczi (1):
      qga: add systemd socket activation support

 qga/channel-posix.c  | 68 ++++++++++++++++++++++++++---------------------
 qga/channel-win32.c  |  2 +-
 qga/channel.h        |  3 ++-
 qga/commands-posix.c |  5 +++-
 qga/main.c           | 74 ++++++++++++++++++++++++++++++++++++++++++++++++----
 tests/test-qga.c     |  4 ++-
 6 files changed, 117 insertions(+), 39 deletions(-)
