Received: from eggs.gnu.org ([2001:4830:134:3::10]:40734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ebSvb-0007yi-G9
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:13:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ebSvV-00036H-Vj
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:13:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ebSvV-000332-Pj
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:13:25 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jan 2018 16:11:49 +0100
Message-Id: <20180116151152.4040-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] Sanitizers configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, stefanha@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

This is a few reworked patches from "[PATCH v3 00/18] Various
build-sys and sanitizer related fixes" series.

It enables sanitizers by default with --enable-debug. But sanitizers
can be also enabled/disabled independently with a configure option.

If ASAN is detected but coroutine annotations are not available, then
a simple message is printed during configure.

Marc-Andr=C3=A9 Lureau (3):
  exynos4210: workaround UBSAN compilation error
  build-sys: add --enable-sanitizers
  ucontext: annotate coroutine stack for ASAN

 include/qemu/compiler.h      |  4 +++
 hw/display/exynos4210_fimd.c |  2 +-
 util/coroutine-ucontext.c    | 48 ++++++++++++++++++++++++++++++++
 .travis.yml                  |  3 +-
 configure                    | 65 ++++++++++++++++++++++++++++++++++++++=
++++++
 5 files changed, 120 insertions(+), 2 deletions(-)

--=20
2.16.0.rc1.1.gef27df75a1
