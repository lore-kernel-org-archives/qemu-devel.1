Received: from eggs.gnu.org ([2001:4830:134:3::10]:54960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ctnl3-0006Y8-1r
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 00:01:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ctnl0-00082N-0q
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 00:01:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34486
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ctnkz-00081J-Qx
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 00:01:49 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2V40363063745
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 00:01:48 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29h4d1bxsx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 00:01:48 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 30 Mar 2017 22:01:47 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 30 Mar 2017 23:01:07 -0500
Message-Id: <1490932869-31217-1-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL for-2.9 0/2] qemu-ga patch queue for 2.9
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

The following changes since commit df9046363220e57d45818312759b954c033c58ab:

  Update version for v2.9.0-rc2 release (2017-03-28 19:11:16 +0100)

are available in the git repository at:

  git://github.com/mdroth/qemu.git tags/qga-pull-2017-03-30-tag

for you to fetch changes up to 4eaf72029446ba693c63429475ce46348f65bf01:

  qga: Make qemu-ga compile statically for Windows (2017-03-30 21:47:25 -0500)

----------------------------------------------------------------
qemu-ga patch queue for 2.9

* fix make check failure of guest-get-fsinfo when nested virtual block
  device partitions are mounted in the test environment
* fix static compilation for mingw builds

----------------------------------------------------------------
Michael Roth (1):
      qga: don't fail if mount doesn't have slave devices

Sameeh Jubran (1):
      qga: Make qemu-ga compile statically for Windows

 configure            | 7 +++++++
 qga/commands-posix.c | 4 +++-
 2 files changed, 10 insertions(+), 1 deletion(-)
