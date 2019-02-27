Received: from eggs.gnu.org ([209.51.188.92]:38681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyxP5-0000bD-Cc
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:29:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyxAH-0006HO-87
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:14:18 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 27 Feb 2019 12:14:09 +0100
Message-Id: <20190227111411.22890-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 0/2] tests/tcg: Vector instruction tests
 for target/s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, David Hildenbrand <david@redhat.com>

As I currently work on vector instruction support for s390x/tcg, for now
I wrote my tests for kvm-unit-tests, but tests/tcg seems to be a better fit.
The only tricky part is testing interrupt handling, but that also seems to
be possible using some signal hackery.

This is only one test to discuss if the approach make sense. These patches
only work when applied on top of:
    https://github.com/davidhildenbrand/qemu/tree/vx

David Hildenbrand (2):
  tests/tcg: Allow targets to set the optimization level
  tests/tcg: target/s390: Add test for VECTOR LOAD GR FROM VR ELEMENT

 tests/tcg/Makefile                  |  4 +--
 tests/tcg/s390x/Makefile.target     |  3 ++-
 tests/tcg/s390x/helper.h            | 28 +++++++++++++++++++++
 tests/tcg/s390x/signal_helper.inc.c | 39 +++++++++++++++++++++++++++++
 tests/tcg/s390x/vlgv.c              | 37 +++++++++++++++++++++++++++
 5 files changed, 108 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/s390x/helper.h
 create mode 100644 tests/tcg/s390x/signal_helper.inc.c
 create mode 100644 tests/tcg/s390x/vlgv.c

-- 
2.17.2
