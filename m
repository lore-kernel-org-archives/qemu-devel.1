Received: from eggs.gnu.org ([2001:4830:134:3::10]:55151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cOM2o-0005bW-Hj
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 05:10:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cOM2k-0007it-NS
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 05:10:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cOM2k-0007id-Hb
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 05:10:10 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue,  3 Jan 2017 18:10:03 +0800
Message-Id: <1483438205-31110-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [kvm-unit-tests PATCH v2 0/2] run_tests: support
 concurrent test execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>, peterx@redhat.com, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>

v2:
- patch 1: do per-test logging in all cases
- patch 2: throw away task.bash, instead, take Radim's suggestion to
  use jobs

run_tests.sh is getting slower. Maybe it's time to let it run faster.
An obvious issue is that, we were running the tests sequentially in
the past.

This series provides another new "-j" parameter. "-j 8" means we run
the tests on 8 task queues. That'll fasten the script a lot. A very
quick test of mine shows 3x speed boost with 8 task queues.

Please review, thanks.

Peter Xu (2):
  run_tests: put logs into per-test file
  run_tests: allow run tests in parallel

 Makefile               |  4 ++--
 run_tests.sh           | 26 ++++++++++++++++++--------
 scripts/functions.bash | 24 ++++++++++++++++++++++--
 scripts/global.bash    | 13 +++++++++++++
 4 files changed, 55 insertions(+), 12 deletions(-)
 create mode 100644 scripts/global.bash

--=20
2.7.4
