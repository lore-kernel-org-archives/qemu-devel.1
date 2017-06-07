Received: from eggs.gnu.org ([2001:4830:134:3::10]:58657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dIfMw-0006hd-UX
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:07:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dIfMs-00045p-PX
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:07:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dIfMs-00045Q-JN
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:07:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  7 Jun 2017 19:07:31 +0100
Message-Id: <20170607180736.11011-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 0/5] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit 0db1851becbefe3e50cfc03776fb1f75817376=
af:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.10-pull-re=
quest' into staging (2017-06-07 11:56:00 +0100)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 11cde1c81093a33c46c7a4039bf750bb61551087:

  configure: split c and cxx extra flags (2017-06-07 15:29:46 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Bruno Dominguez (1):
  configure: split c and cxx extra flags

Philippe Mathieu-Daud=C3=A9 (2):
  oslib: strip trailing '\n' from error_setg() string argument
  coccinelle: fix typo in comment

Roman Pen (1):
  coroutine-lock: do not touch coroutine after another one has been
    entered

Stefan Hajnoczi (1):
  .gdbinit: load QEMU sub-commands when gdb starts

 configure                                | 75 ++++++++++++++++++--------=
------
 disas/libvixl/Makefile.objs              |  4 +-
 util/oslib-posix.c                       |  2 +-
 util/qemu-coroutine-lock.c               | 19 +++++++-
 util/qemu-coroutine.c                    |  5 +++
 .gdbinit                                 |  8 ++++
 rules.mak                                |  3 --
 scripts/coccinelle/return_directly.cocci |  2 +-
 8 files changed, 77 insertions(+), 41 deletions(-)
 create mode 100644 .gdbinit

--=20
2.9.4
