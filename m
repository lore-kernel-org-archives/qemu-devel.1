Received: from eggs.gnu.org ([209.51.188.92]:49270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDmUz-00041B-9x
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDmUy-0002sa-FI
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:52:57 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  9 Apr 2019 10:52:40 +0200
Message-Id: <20190409085245.31548-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.1 0/5] First batch of
 global_qtest-removement patches for QEMU 4.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lvivier@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, armbru@redhat.com, Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, eblake@redhat.com, Hannes Reinecke <hare@suse.com>

While global_qtest and its wrapper functions work fine for tests that onl=
y
run one instance of QEMU, using the global_qtest variable in our qtests i=
s
very problematic for tests that use multiple test states (e.g. migration
tests). Thus tests that still use global_qtest make it hard to share code
(either by copy-n-pasting or by calling common functions) with tests that
try to track multiple test states, so we should try to completely get rid
of the global_qtest variable and its wrapper function in the long run.

Here's another set of patches that cleans up the usage of global_qtest
in a couple of tests.

Thomas Huth (5):
  tests/tco: Make test independent of global_qtest
  tests/megasas: Make test independent of global_qtest
  tests/qmp-cmd-test: Use qtest_init() instead of qtest_start()
  tests/test-hmp: Use qtest_init() instead of qtest_start()
  tests/ide-test: Make test independent of global_qtest

 tests/ide-test.c     | 284 ++++++++++++++++++++++++-------------------
 tests/megasas-test.c |   2 +-
 tests/qmp-cmd-test.c |  15 ++-
 tests/tco-test.c     |  63 +++++-----
 tests/test-hmp.c     |  19 +--
 5 files changed, 211 insertions(+), 172 deletions(-)

--=20
2.21.0
