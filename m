Received: from eggs.gnu.org ([2001:4830:134:3::10]:43731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eR9mV-0006G8-OB
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 23:45:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eR9mT-0000cC-Ot
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 23:45:31 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Dec 2017 15:45:18 +1100
Message-Id: <20171219044522.10850-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv3 0/4] Improvements to pxe-test
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

Please apply.

Changes since v2:
  * At thuth's suggestion add bootindex=1 on all test cases, removing
    the need for per-case device options.
Changes since v1:
  * Simplified handling of device model options, at the expense of
    further changes to the test names
  * Assorted minor changes based on review

David Gibson (4):
  tests/pxe-test: Remove unnecessary special case test functions
  tests/pxe-test: Use table of testcases rather than open-coding
  tests/pxe-test: Test net booting over IPv6 in some cases
  tests/pxe-test: Add some extra tests

 tests/pxe-test.c | 99 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 74 insertions(+), 25 deletions(-)

-- 
2.14.3
