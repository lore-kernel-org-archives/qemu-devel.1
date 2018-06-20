Received: from eggs.gnu.org ([2001:4830:134:3::10]:51407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fVXbh-0005H0-8d
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fVXbd-00029Z-BO
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:32:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57846 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fVXbd-00029I-6Q
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:32:41 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 20 Jun 2018 15:32:16 +0800
Message-Id: <20180620073223.31964-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 0/7] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, peterx@redhat.com, Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

v5:
- more r-bs are collected
- make sure no patch contains extra s-o-bs by doing proper indents for
  diff quotes [Markus]
- misc commit message or comment changes [Markus]

v4:
- collect some r-bs
- remove one extra s-o-b of mine in one patch [Thomas, Markus]
- split the qmp response flush patch into two; apply changes to commit
  message [Markus]
- fix up the doc update patch [Markus]

v3:
- drop patch "tests: iotests: don't compare SHUTDOWN event", replace
  it with "monitor: flush qmp responses when CLOSED" to fix up the
  race. [Eric, Markus]
- tweak the oob revert patch to not break qmp-test [Eric]
- quite a few comment and commit message fix-ups [Eric]
- add more comment in commit message, mention about why MUX can't be
  used for Out-Of-Band [Markus]
- one new patch to comment on chardev CLOSED event [Stefan]
- one new patch to fix iotest breakage on 060 specifically

Tests: make check, iotests

Please review.  Thanks,

Peter Xu (7):
  chardev: comment details for CLOSED event
  monitor: rename *_pop_one to *_pop_any
  monitor: flush qmp responses when CLOSED
  tests: iotests: drop some stderr line
  docs: mention shared state protect for OOB
  monitor: remove "x-oob", turn oob on by default
  Revert "tests: Add parameter to qtest_init_without_qmp_handshake"

 docs/devel/qapi-code-gen.txt | 17 +++++---
 include/chardev/char.h       | 11 +++++-
 include/monitor/monitor.h    |  1 -
 tests/libqtest.h             |  4 +-
 monitor.c                    | 75 +++++++++++++++++++++---------------
 tests/libqtest.c             | 10 ++---
 tests/qmp-test.c             |  6 +--
 vl.c                         |  5 ---
 tests/qemu-iotests/060       | 10 ++++-
 tests/qemu-iotests/060.out   |  1 -
 10 files changed, 83 insertions(+), 57 deletions(-)

--=20
2.17.1
