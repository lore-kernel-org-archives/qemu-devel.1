Received: from eggs.gnu.org ([2001:4830:134:3::10]:53265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCihi-0005eZ-Jd
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCihW-0000pr-2x
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gCihV-0000jE-PK
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:13 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 17 Oct 2018 12:04:52 +0200
Message-Id: <1539770707-7289-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/15] qtest and misc patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

 Hi Peter,

the following changes since commit dddb37495b844270088e68e3bf30b764d48d86=
3f:

  Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-201810=
15.0' into staging (2018-10-15 18:44:04 +0100)

are available in the git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2018-10-17

for you to fetch changes up to 7fc527cdc9cfd139dee1d90e3220a884229a7698:

  configure: remove glib_subprocess check (2018-10-17 09:01:41 +0200)

----------------------------------------------------------------
- Updates for qtest entries in test/Makefile.include
- Simple updates for some shell scripts
- Misc simple patches for files without regular subsystem pull requests
----------------------------------------------------------------

Eric Blake (1):
      tests: Prevent more accidental test disabling

John Arbuckle (1):
      qemu-common.h: update copyright date to 2018

Liu Yuan (1):
      MAINTAINERS: update block/sheepdog maintainers

Mao Zhongyi (3):
      archive-source.sh: Modern shell scripting (use $() instead of ``)
      git-submodule.sh: Modern shell scripting (use $() instead of ``)
      show-fixed-bugs.sh: Modern shell scripting (use $() instead of ``)

Marc-Andr=C3=A9 Lureau (1):
      configure: remove glib_subprocess check

Paolo Bonzini (1):
      tests: remove gcov-files- variables

Philippe Mathieu-Daud=C3=A9 (2):
      gdbstub: Remove unused include
      mailmap: Fix Reimar D=C3=B6ffinger name

Thomas Huth (5):
      target/cris/translate: Get rid of qemu_log_separate()
      qemu/compiler: Wrap __attribute__((flatten)) in a macro
      hw/core/generic-loader: Set a category for the generic-loader devic=
e
      cpu: Provide a proper prototype for target_words_bigendian() in a h=
eader
      hw/core/generic-loader: Compile only once, not for each target

 .mailmap                   |   3 +-
 MAINTAINERS                |   1 -
 configure                  |   6 --
 docs/devel/testing.rst     |   4 +-
 exec.c                     |   5 --
 fpu/softfloat.c            |  39 +++++--------
 gdbstub.c                  |   1 -
 hw/core/Makefile.objs      |   2 +-
 hw/core/generic-loader.c   |   7 +--
 hw/virtio/virtio.c         |   1 -
 include/qemu-common.h      |   2 +-
 include/qemu/compiler.h    |  15 +++++
 include/qom/cpu.h          |  11 ++++
 qom/cpu.c                  |   1 -
 scripts/archive-source.sh  |   4 +-
 scripts/git-submodule.sh   |   4 +-
 scripts/show-fixed-bugs.sh |  10 ++--
 target/cris/translate.c    |   6 +-
 tests/Makefile.include     | 140 ++++-----------------------------------=
------
 19 files changed, 69 insertions(+), 193 deletions(-)
