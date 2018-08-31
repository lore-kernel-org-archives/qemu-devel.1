Received: from eggs.gnu.org ([2001:4830:134:3::10]:39315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fvf3l-0000r7-OF
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fvexP-0007Fo-OF
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:39:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51980 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fvexP-0007FZ-IX
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:39:07 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 31 Aug 2018 10:38:49 +0200
Message-Id: <1535704738-8986-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] Removal of deprecated options and
 improvements for qtests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

 Hi Peter!

The following changes since commit 19b599f7664b2ebfd0f405fb79c14dd2415574=
52:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-08-27=
-v2' into staging (2018-08-27 16:44:20 +0100)

are available in the git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2018-08-31

for you to fetch changes up to ae6bf766048ecaeef90b85c4fb2b4db2aa0c094c:

  tests: add a qmp success-response test (2018-08-31 09:53:10 +0200)

----------------------------------------------------------------
Removal of deprecated options and improvements for the qtests
----------------------------------------------------------------

Eric Blake (1):
      tests/libqos: Utilize newer glib spawn check

Marc-Andr=C3=A9 Lureau (4):
      tests: add qmp_assert_error_class()
      tests: add qmp/object-add-without-props test
      tests: add qmp/qom-set-without-value test
      tests: add a qmp success-response test

Thomas Huth (4):
      Remove the deprecated -balloon option
      Remove the deprecated -nodefconfig option
      Remove the deprecated options -startdate, -localtime and -rtc-td-ha=
ck
      net: Remove the deprecated -tftp, -bootp, -redir and -smb options

 docs/interop/live-block-operations.rst  |   4 +-
 docs/virtio-balloon-stats.txt           |   6 +-
 include/net/net.h                       |   3 -
 include/net/slirp.h                     |   4 -
 net/slirp.c                             | 132 +++++++-------------------=
------
 os-posix.c                              |   8 --
 qemu-deprecated.texi                    |  56 --------------
 qemu-options.hx                         |  36 +--------
 tests/drive_del-test.c                  |   5 +-
 tests/libqos/libqos.c                   |  12 +--
 tests/libqtest.c                        |  11 +++
 tests/libqtest.h                        |   9 +++
 tests/qapi-schema/qapi-schema-test.json |   2 +
 tests/qapi-schema/qapi-schema-test.out  |   2 +
 tests/qmp-cmd-test.c                    |  18 +++++
 tests/qmp-test.c                        |  87 +++++++++------------
 tests/test-qga.c                        |   9 +--
 tests/test-qmp-cmds.c                   |  17 ++++
 vl.c                                    | 132 ++++++--------------------=
------
 19 files changed, 158 insertions(+), 395 deletions(-)
