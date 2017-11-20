Received: from eggs.gnu.org ([2001:4830:134:3::10]:42307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eGty1-0006WW-Bi
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:51:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eGtxy-00062z-98
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:51:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46393
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eGtxy-00060X-35
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:50:58 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAKLnnp7046659
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 16:50:53 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ec5ue4019-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 16:50:53 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Nov 2017 14:50:52 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Nov 2017 15:50:33 -0600
Message-Id: <20171120215034.22212-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL for-2.11 0/1] qemu-ga patch queue for 2.11
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

The following changes since commit b2996bb405e2806725a341c72d80be9e77ed8b82:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.11-20171120' into staging (2017-11-20 18:00:16 +0000)

are available in the git repository at:

  git://github.com/mdroth/qemu.git tags/qga-pull-2017-11-20-tag

for you to fetch changes up to df83eabd5245828cbca32060aa191d8b03bc5d50:

  qga: replace GetIfEntry with GetIfEntry2 for interface stats (2017-11-20 14:45:31 -0600)

----------------------------------------------------------------
qemu-ga patch queue for 2.11

* fix potential overflow in network interface stats reporting

----------------------------------------------------------------
ZhiPeng Lu (1):
      qga: replace GetIfEntry with GetIfEntry2 for interface stats

 qga/commands-win32.c | 54 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 16 deletions(-)
