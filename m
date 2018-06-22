Received: from eggs.gnu.org ([2001:4830:134:3::10]:33763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWAC1-0003mQ-Bf
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWABw-0000Cd-G2
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:44:49 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:45429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWABw-0000Bp-Af
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:44:44 -0400
Received: by mail-qt0-x243.google.com with SMTP id i18-v6so4587014qtp.12
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 17:44:44 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Jun 2018 21:44:29 -0300
Message-Id: <20180622004435.10291-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/6] Avocado: start multi-arch tests,
 add a Travis job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Hi,

Another neanderthal approach to add multi-arch acceptance tests using
Avocado.

Since Cleber Rosa work got merged [0], I can restart my previous attempt [1]
at using Avocado in QEMU.
Cleber Rosa rewrote my previous v1 [1], in good python, now this v2 pushes
a bit further:
- we can now run other archs
- Avocado is integrated into Travis CI

I'm not sure Travis is the best CI available for those tests, but it runs
quite fast:

      ...
      LINK    x86_64-softmmu/qemu-system-x86_64
    JOB ID     : a3a56af3c02d193e862ce660aae1d9c72926dcb6
    JOB LOG    : /home/travis/avocado/job-results/job-2018-06-21T23.49-a3a56af/job.log
     (1/7) tests/acceptance/boot_linux_console.py:BootLinuxConsoleX86_64.test:  PASS (3.89 s)
     (2/7) tests/acceptance/boot_linux_console.py:BootLinuxConsoleMips.test:  PASS (1.83 s)
     (3/7) tests/acceptance/version.py:Version.test_qmp_human_info_version:  PASS (0.05 s)
     (4/7) tests/acceptance/vnc.py:Vnc.test_no_vnc:  PASS (0.04 s)
     (5/7) tests/acceptance/vnc.py:Vnc.test_no_vnc_change_password:  PASS (0.04 s)
     (6/7) tests/acceptance/vnc.py:Vnc.test_vnc_change_password_requires_a_password:  PASS (0.05 s)
     (7/7) tests/acceptance/vnc.py:Vnc.test_vnc_change_password:  PASS (0.05 s)
    RESULTS    : PASS 7 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
    JOB TIME   : 6.21 s

    Done. Your build exited with 0.

    Job ran for 5 min 34 sec

I couldn't add the Alpha tests because all the vmlinux kernels I found
online are gzipped, so I'm waiting some upstream Avocado merges before.

Cleber: I hope you can help me pythonizing this series :p

Regards,

Phil.

[0]: http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg04531.html
[1]: http://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg03076.html

Philippe Mathieu-Daudé (6):
  avocado: Add a Test.arch property
  tests/acceptance: Rename the x86-64 specific BootLinuxConsole test
  tests/acceptance: Improve the Avocado tags
  tests/acceptance: Add a BootLinuxConsoleMips test
  tests/acceptance: Add a kludge to not use the default console
  travis: Add Avocado tests

 .travis.yml                               |  8 +++++
 scripts/qemu.py                           |  6 ++--
 tests/acceptance/avocado_qemu/__init__.py | 17 ++++++---
 tests/acceptance/boot_linux_console.py    | 44 +++++++++++++++++++++--
 4 files changed, 67 insertions(+), 8 deletions(-)

-- 
2.18.0.rc2
