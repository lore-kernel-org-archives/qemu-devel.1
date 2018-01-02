Received: from eggs.gnu.org ([2001:4830:134:3::10]:49132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eWND9-0007Gr-4C
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 09:06:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eWND4-0008BZ-TS
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 09:06:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eWND4-0008AN-No
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 09:06:30 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  2 Jan 2018 15:06:23 +0100
Message-Id: <20180102140625.14477-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Dump patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The following changes since commit 281f327487c9c9b1599f93c589a408bbf4a651=
b8:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.12-pull-re=
quest' into staging (2017-12-22 00:11:36 +0000)

are available in the Git repository at:

  https://github.com/elmarco/qemu.git tags/dump-pull-request

for you to fetch changes up to c3b1642b9b6b3ba4314d6be3be509d396372cfd5:

  dump-guest-memory.py: fix "You can't do that without a process to debug=
" (2018-01-02 14:49:54 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (2):
  dump: fix note_name_equal()
  dump-guest-memory.py: fix "You can't do that without a process to
    debug"

 scripts/dump-guest-memory.py | 3 +--
 dump.c                       | 7 +------
 hw/misc/vmcoreinfo.c         | 3 +++
 3 files changed, 5 insertions(+), 8 deletions(-)

--=20
2.15.1.355.g36791d7216
