Received: from eggs.gnu.org ([2001:4830:134:3::10]:33846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWACD-0003ub-73
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWACC-0000Gi-3I
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:45:01 -0400
Received: from mail-qk0-x233.google.com ([2607:f8b0:400d:c09::233]:36984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWACB-0000GT-VH
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:45:00 -0400
Received: by mail-qk0-x233.google.com with SMTP id j12-v6so2852527qkk.4
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 17:44:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Jun 2018 21:44:35 -0300
Message-Id: <20180622004435.10291-7-f4bug@amsat.org>
In-Reply-To: <20180622004435.10291-1-f4bug@amsat.org>
References: <20180622004435.10291-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 6/6] travis: Add Avocado tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
https://travis-ci.org/philmd/qemu/jobs/395266626

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
---
 .travis.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index fabfe9ec34..7b224add2d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -153,3 +153,11 @@ matrix:
         - TEST_CMD=""
       before_script:
         - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || { cat config.log && exit 1; }
+    # Avocado tests
+    - env: CONFIG="--target-list=x86_64-softmmu,mips-softmmu --enable-trace-backends=nop --disable-tools --disable-docs"
+           TEST_CMD="avocado run tests/acceptance"
+      python:
+        - "3.6"
+      before_script:
+        - pip install --user avocado-framework
+        - ./configure ${CONFIG} || { cat config.log && exit 1; }
-- 
2.18.0.rc2
