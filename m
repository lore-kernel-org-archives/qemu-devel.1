Received: from eggs.gnu.org ([2001:4830:134:3::10]:39670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7z1-0001w0-WF
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7yy-0000SP-RE
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:40:43 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7yy-0000S4-Ko
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:40:40 -0400
Received: by mail-wr1-x441.google.com with SMTP id x12-v6so15099034wru.8
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 17:40:40 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Oct 2018 02:40:25 +0200
Message-Id: <20181013004034.6968-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/8] tests/vm: Improvements when KVM is not
 available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Hi Fam,

Few patches I added while testing the VM tests without KVM access.
I doubt many people want to suffer using TCG for VM testing, but
it was handy to debug/support aarch64 VM tests.

Also this could be a useful TCG stress test...?

Since v2: https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg04084.html
- use default args.jobs (Fam)
- move kvm_available() to scripts/QEMU so it can be used by Avocado
- do not use -smp 1
- add a BaseVM::arch property to help cross vm testing

Since v1: http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg03411.html
- rebased on master
- added get_default_jobs (Fam)
- dropped 'When using TCG, wait longer for a VM to start'

Regards,

Phil.

Philippe Mathieu-Daudé (8):
  tests/vm: Extract the kvm_available() handy function
  tests/vm: Do not abuse parallelism when KVM is not available
  tests/vm: Do not use the -smp option with a single cpu
  tests/vm: Display remaining seconds to wait for a VM to start
  tests/vm: Add a BaseVM::arch property
  tests/vm: Let kvm_available() work in cross environments
  tests/vm: Do not use -enable-kvm if HOST != TARGET architecture
  tests/vm: Do not abuse parallelism when HOST != TARGET architecture

 scripts/qemu.py      |  6 ++++++
 tests/vm/basevm.py   | 30 +++++++++++++++++++++---------
 tests/vm/centos      |  1 +
 tests/vm/freebsd     |  1 +
 tests/vm/netbsd      |  1 +
 tests/vm/openbsd     |  1 +
 tests/vm/ubuntu.i386 |  1 +
 7 files changed, 32 insertions(+), 9 deletions(-)

-- 
2.19.1
