Received: from eggs.gnu.org ([209.51.188.92]:38108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gn7Am-0006A3-6Z
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:29:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gn78X-0005YA-PU
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:27:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gn78X-0005Xw-Jd
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:27:33 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 25 Jan 2019 20:27:16 +0100
Message-Id: <20190125192719.15339-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] OpenBSD fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>, Kamil Rytarowski <kamil@netbsd.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <fam@euphon.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Li Qiang <liq3ea@163.com>, Paolo Bonzini <pbonzini@redhat.com>

Fixes I encountered while trying to run QEMU test suite on OpenBSD.
More to come, but please review.

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (3):
  configure: Disable W^X on OpenBSD
  XXX oslib-posix: Ignore fcntl("/dev/null", F_SETFL, O_NONBLOCK)
    failure
  WIP tests/vm: Run tests on OpenBSD

 configure          | 11 +++++++++++
 tests/vm/openbsd   |  4 +---
 util/oslib-posix.c |  2 ++
 3 files changed, 14 insertions(+), 3 deletions(-)

--=20
2.20.1
