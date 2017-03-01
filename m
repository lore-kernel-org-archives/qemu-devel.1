Received: from eggs.gnu.org ([2001:4830:134:3::10]:49831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cj2mC-0003xc-Mk
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 06:50:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cj2mB-0007BB-Tz
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 06:50:36 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  1 Mar 2017 11:50:23 +0000
Message-Id: <20170301115026.22621-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/3] throttle: improve command-line
 parameter documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Nini Gu <ngu@redhat.com>, qemu-block@nongnu.org, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>

v3:
 * Added Patch 2 to fix invalid test parameters
 * Switched to nicer max < avg check [Berto]
v2:
 * Fixed s/bps/iops/ copy-paste error in Patch 1 [Berto]
 * Rephrased warning about guest hangs and errors [Berto]
 * Added Patch 2 to hide the internal .max value from the monitor

Patch 1 fleshes out the documentation for I/O throttling command-line
parameters.

Patch 2 hides an internal value that was being exposed to users via the
monitor and caused confusion.

I ended up not adding QMP-style throttling.* names to the command-line
documentation because the names are very long and unlikely to be used.  I
couldn't see a nice way of adding them while still keeping the documentation
readable.

Stefan Hajnoczi (3):
  qemu-options: explain disk I/O throttling options
  throttle: do not use invalid config in test
  throttle: make throttle_config(throttle_get_config()) symmetric

 tests/test-throttle.c |  8 ++++----
 util/throttle.c       | 14 ++++++++++++++
 qemu-options.hx       | 24 ++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 4 deletions(-)

-- 
2.9.3
