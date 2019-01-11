Received: from eggs.gnu.org ([209.51.188.92]:49880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gi1Uw-0007jd-Qq
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:25:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gi1Uw-0007HR-55
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:25:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53153)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gi1Uv-0007G1-VD
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:25:38 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 11 Jan 2019 16:25:31 -0200
Message-Id: <20190111182533.31593-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Work around test-qht-par + gprof issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Emilio G. Cota" <cota@braap.org>

The following changes since commit e53f7796fbe71a5c7c24ffebf04b4aa9a759da=
36:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-r=
equest' into staging (2019-01-11 13:35:48 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to ce2eefd7c21697fee87a0686353de881081d22c6:

  tests: Disable qht-bench parallel test when using gprof (2019-01-11 16:=
21:45 -0200)

----------------------------------------------------------------
Work around test-qht-par + gprof issues

Travis CI jobs are failing because of test-qht-par when gprof is
enabled.  Temporarily disable test-qht-par if gprof is enabled,
until we fix the bug.

----------------------------------------------------------------

Queue for Machine Core patches


Philippe Mathieu-Daud=C3=A9 (2):
  configure: Let the TARGET_GPROF var use the regular 'y' for Yes
  tests: Disable qht-bench parallel test when using gprof

 configure              | 3 ++-
 tests/Makefile.include | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

--=20
2.18.0.rc1.1.g3f1ff2140
