Received: from eggs.gnu.org ([2001:4830:134:3::10]:43348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFFpu-0004eR-IC
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFFpq-00064W-NQ
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:52:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gFFpq-00062I-ED
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:52:18 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 24 Oct 2018 10:52:02 +0100
Message-Id: <1540374728-27579-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/6] qtest,
 Makefiles and shell script improvements
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

the following changes since commit 13399aad4fa87b2878c49d02a5d3bafa6c966b=
a3:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-10-22=
' into staging (2018-10-23 17:20:23 +0100)

are available in the git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2018-10-24

for you to fetch changes up to 86583a07c4a7d55b04db5942a70d176f5299144a:

  configure: Provide option to explicitly disable AVX2 (2018-10-24 07:39:=
10 +0100)

----------------------------------------------------------------
- Disable migration-test with TCG on s390x (since there are known problem=
s)
- Small Makefile improvements
- More modern shell scripting changes (use $() instead of ``)
- Add a configure option to disable AVX2
----------------------------------------------------------------

Liam Merwick (1):
      configure: Provide option to explicitly disable AVX2

Mao Zhongyi (2):
      debian-bootstrap.pre: Modern shell scripting (use $() instead of ``=
)
      po/Makefile: Modern shell scripting (use $() instead of ``)

Thomas Huth (3):
      tests/migration-test: Disable s390x test when running with TCG
      hw/core: Move null-machine into the common-obj list
      configs: Add a CONFIG_SMC37C669 switch for the "smc37c669-superio" =
device

 configure                                     | 11 +++++++++--
 default-configs/alpha-softmmu.mak             |  1 +
 hw/core/Makefile.objs                         |  3 +--
 hw/core/null-machine.c                        |  2 +-
 hw/isa/Makefile.objs                          |  3 ++-
 po/Makefile                                   |  2 +-
 tests/docker/dockerfiles/debian-bootstrap.pre |  4 ++--
 tests/migration-test.c                        | 16 ++++++++++++++++
 8 files changed, 33 insertions(+), 9 deletions(-)
