Received: from eggs.gnu.org ([2001:4830:134:3::10]:54033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBLe1-0006Ru-CQ
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 11:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBLdy-0004Mt-6H
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 11:15:57 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBLdx-0004MB-Tp
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 11:15:54 -0400
Received: by mail-wm1-x344.google.com with SMTP id r63-v6so14875074wma.4
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 08:15:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Oct 2018 17:15:39 +0200
Message-Id: <20181013151545.3731-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/6] Avocado: more multi-arch tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, Magnus Damm <magnus.damm@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>

Hi,

Another neanderthal approach to add multi-arch acceptance tests using Avocado.

I couldn't figure how to use the R2D serial, the kernel boots using the sm501
display correctly, but I'm too console-oriented to write UI tests...

Magnus or Zoltan, any hint on this?

Thanks

Phil.

Since v2 (http://lists.gnu.org/archive/html/qemu-devel/2018-06/msg06370.html):
- use Debian packaged kernels, add link to the sources and a comment
  about how to rebuild these images (Alex)
- use self.arch from Cleber's series
- add mips64el kernel console test
- add sh4 test using the tracing framework

Since v1 (http://lists.gnu.org/archive/html/qemu-devel/2018-04/msg03076.html):
- we can now run other archs (Cleber)

Based-on: 20181009232607.15521-1-crosa@redhat.com
"Acceptance Tests: basic architecture support" from Cleber Rosa
https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01821.html

Philippe Mathieu-Daudé (6):
  tests/acceptance: Rename the generic BootLinuxConsole test as
    test_x86_64_pc
  tests/acceptance: Add a kludge to not use the default console
  tests/acceptance: Add test_mips_4kc_malta in BootLinuxConsole
  tests/acceptance: Add test_mipsel_5kc_malta in BootLinuxConsole
  tests/acceptance: Add test_sh4_r2d in BootLinuxConsole
  tests/acceptance: Add test_sh4_r2d in BootLinuxTracing

 scripts/qemu.py                        |   6 +-
 tests/acceptance/boot_linux_console.py | 206 ++++++++++++++++++++++++-
 2 files changed, 208 insertions(+), 4 deletions(-)

-- 
2.19.1
