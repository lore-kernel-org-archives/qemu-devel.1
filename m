Received: from eggs.gnu.org ([2001:4830:134:3::10]:46869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUdva-0006uV-7g
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:37:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUdvX-0002Ny-4R
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:37:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gUdvW-0002Nb-V5
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:37:47 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  6 Dec 2018 00:37:30 +0400
Message-Id: <20181205203737.9011-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 v4 0/7] monitor: misc fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,

Here is a small series of fixes for the monitor, mostly related to
threading issues.

v4:
 - added "colo: check chardev can switch context"
 - replaced an assert_not_reached() with a better assert
 - commit message updates & rb tags

v3:
 - replaced an error_report() with an assert()
 - simplify a mon->use_io_thread condition, removing needless QMP check
 - modify/add some code comments
 - update commit messages

v2 bis:
 - update comments/commit messages
 - add Peter r-b

v2: after Peter review
 - patch 2: fix resuming with oob=3Doff
 - patch 4: keep MUX case explicit, improve commit message

Marc-Andr=C3=A9 Lureau (7):
  monitor: inline ambiguous helper functions
  monitor: accept chardev input from iothread
  char: add a QEMU_CHAR_FEATURE_GCONTEXT flag
  monitor: check if chardev can switch gcontext for OOB
  colo: check chardev can switch context
  monitor: prevent inserting new monitors after cleanup
  monitor: avoid potential dead-lock when cleaning up

 include/chardev/char.h |  3 ++
 chardev/char.c         | 11 +++++++
 monitor.c              | 71 ++++++++++++++++++++++++++----------------
 net/colo-compare.c     |  6 ++++
 4 files changed, 65 insertions(+), 26 deletions(-)

--=20
2.20.0.rc1
