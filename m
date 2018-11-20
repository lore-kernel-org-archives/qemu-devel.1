Received: from eggs.gnu.org ([2001:4830:134:3::10]:46651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gP3eY-00066x-9m
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:53:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gP3eT-000874-Cg
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:53:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gP3eT-000851-5m
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:53:05 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 20 Nov 2018 11:52:20 +0100
Message-Id: <1542711143-1946-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] qtest patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>

 Hi Peter,

the following changes since commit d304cf014bf9feec3dcd7ee65c75a7f52206ec=
df:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
81119' into staging (2018-11-19 15:58:17 +0000)

are available in the git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2018-11-20

for you to fetch changes up to ced09f9b07e425690d3bfe524cf93c4dbf4b26bc:

  qtest: log QEMU command line (2018-11-20 10:49:12 +0100)

----------------------------------------------------------------
- One additional simple qmp-test
- A fix for ide-test
- Add logging of QEMU parameters in libqtest
----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (1):
      tests: add qmp/missing-any-arg test

Paolo Bonzini (1):
      qtest: log QEMU command line

Thomas Huth (1):
      tests/ide: Free pcibus when finishing a test

 tests/ide-test.c |  4 ++++
 tests/libqtest.c | 26 +++++++++++++++-----------
 tests/qmp-test.c | 14 ++++++++++++++
 3 files changed, 33 insertions(+), 11 deletions(-)

Marc-Andr=C3=A9 Lureau (1):
  tests: add qmp/missing-any-arg test

Paolo Bonzini (1):
  qtest: log QEMU command line

Thomas Huth (1):
  tests/ide: Free pcibus when finishing a test

 tests/ide-test.c |  4 ++++
 tests/libqtest.c | 26 +++++++++++++++-----------
 tests/qmp-test.c | 14 ++++++++++++++
 3 files changed, 33 insertions(+), 11 deletions(-)

--=20
1.8.3.1
