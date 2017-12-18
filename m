Received: from eggs.gnu.org ([2001:4830:134:3::10]:34472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQsHP-0004XS-Om
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:04:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQsHM-0001LD-0C
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:04:15 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Dec 2017 21:04:00 +1100
Message-Id: <20171218100404.4427-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv2 0/4] Improvements to pxe-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: thuth@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

This series makes several cleanups and enhancements to tests/pxe-test.
In particular it improves its handling of different machine types.

Changes since v1:
  * Simplified handling of device model options, at the expense of
    further changes to the test names
  * Assorted minor changes based on review
  
David Gibson (4):
  tests/pxe-test: Remove unnecessary special case test functions
  tests/pxe-test: Use table of testcases rather than open-coding
  tests/pxe-test: Test net booting over IPv6 in some cases
  tests/pxe-test: Add some extra tests

 tests/pxe-test.c | 100 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 75 insertions(+), 25 deletions(-)

-- 
2.14.3
