Received: from eggs.gnu.org ([209.51.188.92]:54628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2IN0-0001ku-Qi
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:29:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2IMz-0008BV-W8
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:29:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2IMz-0008A4-PI
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:29:13 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  8 Mar 2019 17:29:03 +0100
Message-Id: <20190308162906.10491-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] travis-ci: Test installing Sphinx
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Fam Zheng <fam@euphon.net>

Hi,

This series improve the Travis CI to test installing the Sphinx
generated documentation in in-tree and out-of-tree builds.

It is based on Peter's "Fix various issues with Sphinx build
machinery" series:
https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02625.html

Regards,

Phil.

Based-on: <20190308135744.6480-1-peter.maydell@linaro.org>

Philippe Mathieu-Daud=C3=A9 (3):
  .travis.yml: Reduce the out-of-tree target list
  .travis.yml: Test the documentation installation process
  .travis.yml: Test installing Sphinx documentation in out-of-tree build

 .travis.yml | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

--=20
2.20.1
