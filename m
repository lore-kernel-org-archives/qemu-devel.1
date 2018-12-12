Received: from eggs.gnu.org ([2001:4830:134:3::10]:58548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gX0ad-00087F-LJ
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:14:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gX0aa-00043y-Fb
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:13:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gX0aa-00043T-8q
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:13:56 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 12 Dec 2018 10:13:44 +0100
Message-Id: <1544606032-16924-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/8] Set minimum compiler versions to GCC 4.8
 and Clang 3.4
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

the following changes since commit bb9bf94b3e8926553290bc9a7cb84315af4220=
86:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-r=
equest' into staging (2018-12-11 19:18:58 +0000)

are available in the git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2018-12-12

for you to fetch changes up to 2b4c1125ac3db2734222ff43c25388a16aca4a99:

  i2c: Move typedef of bitbang_i2c_interface to i2c.h (2018-12-12 10:01:1=
3 +0100)

----------------------------------------------------------------
Explicitly check for minimum compiler versions.
Remove obsolete code for old compilers that is now not required anymore.
Fix a duplicated typedef for Clang 3.4.
----------------------------------------------------------------

BALATON Zoltan (1):
      i2c: Move typedef of bitbang_i2c_interface to i2c.h

Thomas Huth (7):
      configure: Add a test for the minimum compiler version
      configure: Remove obsolete check for Clang < 3.2
      configure: Remove old -fno-gcse workaround for GCC 4.6.x and 4.7.[0=
12]
      tcg/tcg.h: Remove GCC check for tcg_debug_assert() macro
      audio/alsaaudio: Remove compiler check around pragma
      includes: Replace QEMU_GNUC_PREREQ with "__has_builtin || !defined(=
__clang__)"
      Remove QEMU_ARTIFICIAL macro

 Makefile.target             |  3 ---
 audio/alsaaudio.c           |  2 --
 configure                   | 47 +++++++++++++++++++++++++--------------=
------
 hw/i2c/bitbang_i2c.h        |  2 --
 include/hw/i2c/i2c.h        |  2 ++
 include/hw/i2c/ppc4xx_i2c.h |  3 ---
 include/qemu/compiler.h     |  8 +-------
 include/qemu/host-utils.h   |  4 ++--
 scripts/checkpatch.pl       |  1 -
 scripts/cocci-macro-file.h  |  1 -
 tcg/tcg.h                   |  4 +---
 11 files changed, 32 insertions(+), 45 deletions(-)
