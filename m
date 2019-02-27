Received: from eggs.gnu.org ([209.51.188.92]:46982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gz6YD-0005bn-2d
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 16:15:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gz6YB-0001C2-5z
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 16:15:36 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 27 Feb 2019 22:15:23 +0100
Message-Id: <20190227211525.2470-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFCv2 0/2] tests/tcg: Vector instruction tests
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

Before I go ahead and implement more tests, let's clarify if this is the
way to go first.

RFC -> RFCv2:
- Dropped "tests/tcg: Allow targets to set the optimization level"
-- Handle it directly from the Makefile
- Add a test for VECTOR GATHER ELEMENT
- Rework signal handling to work with more than one signal occurrence. Also
  simplify setting the signal handlers a bit.

David Hildenbrand (2):
  tests/tcg: target/s390x: Test VECTOR GATHER ELEMENT
  tests/tcg: target/s390x: Test VECTOR LOAD GR FROM VR ELEMENT

 tests/tcg/s390x/Makefile.target     |  7 +++
 tests/tcg/s390x/helper.h            | 28 +++++++++++
 tests/tcg/s390x/signal-helper.inc.c | 46 ++++++++++++++++++
 tests/tcg/s390x/vge.c               | 75 +++++++++++++++++++++++++++++
 tests/tcg/s390x/vlgv.c              | 37 ++++++++++++++
 5 files changed, 193 insertions(+)
 create mode 100644 tests/tcg/s390x/helper.h
 create mode 100644 tests/tcg/s390x/signal-helper.inc.c
 create mode 100644 tests/tcg/s390x/vge.c
 create mode 100644 tests/tcg/s390x/vlgv.c

-- 
2.17.2
