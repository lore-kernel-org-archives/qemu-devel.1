Received: from eggs.gnu.org ([2001:4830:134:3::10]:42868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cFHT5-0007mp-Cw
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 04:27:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cFHT1-0008PR-E5
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 04:27:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cFHT1-0008OV-4p
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 04:27:47 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB99PISD091193
	for <qemu-devel@nongnu.org>; Fri, 9 Dec 2016 04:27:44 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 277rtm31yp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 04:27:44 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 9 Dec 2016 02:27:43 -0700
From: Greg Kurz <groug@kaod.org>
Date: Fri, 09 Dec 2016 10:27:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148127558476.2633.13433882390740185948.stgit@bahia>
Subject: [Qemu-devel] [PATCH 0/8] tests: add 9P functional tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This series brings the ability to test 9P operations. It provides basic tests
of version, attach and walk, which are essential operations in a 9P session.
It also provide two security-oriented tests of the walk operation (for issues
that got fixed in QEMU 2.7).

I could run this on ppc64, ppc64le and i386 hosts. It also passes travis-ci
checks. I plan to push this to 2.9.

---

Greg Kurz (8):
      tests: virtio-9p: rename PCI configuration test
      tests: virtio-9p: code refactoring
      9pfs: fix P9_NOTAG and P9_NOFID macros
      tests: virtio-9p: add version operation test
      tests: virtio-9p: add attach operation test
      tests: virtio-9p: add walk operation test
      tests: virtio-9p: no slash in path elements during walk
      tests: virtio-9p: ".." cannot be used to walk out of the shared directory


 hw/9pfs/9p.h           |    4 
 tests/virtio-9p-test.c |  478 +++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 429 insertions(+), 53 deletions(-)

--
Greg
