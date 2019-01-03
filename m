Received: from eggs.gnu.org ([208.118.235.92]:40302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gf402-0001hA-II
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:29:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gf3zz-0008E1-UO
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:29:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gf3zz-0008Bs-Om
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:29:27 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu,  3 Jan 2019 15:29:17 +0100
Message-Id: <20190103142919.30090-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] buildsys: Disable qht-bench parallel test
 when using gprof
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G . Cota" <cota@braap.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Disable test-qht-par when using gprof, as this break Travis CI.

See: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01638.html

Philippe Mathieu-Daud=C3=A9 (2):
  configure: Let the TARGET_GPROF var use the regular 'y' for Yes
  tests: Disable qht-bench parallel test when using gprof

 configure              | 2 +-
 tests/Makefile.include | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

--=20
2.17.2
