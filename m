Received: from eggs.gnu.org ([2001:4830:134:3::10]:55410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtsd-00046o-7u
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:13:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtsZ-0002ep-53
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:13:51 -0400
Received: from mail-qt0-x22e.google.com ([2607:f8b0:400d:c0d::22e]:34499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtsZ-0002eg-0u
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:13:47 -0400
Received: by mail-qt0-x22e.google.com with SMTP id c10so69213335qtd.1
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 09:13:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 16 Jun 2017 13:13:23 -0300
Message-Id: <20170616161334.7492-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/11] travis: try to reduce failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

These patches try to improve our Travis CI usage (quite a few failures the last
days). This series include Peter's "Automate coverity scan uploads via Travis"
patches (https://www.mail-archive.com/qemu-devel@nongnu.org/msg457443.html).

Patch 1 is a no-op as of today, but if eventually Shippable improve their
hardware the builds will profit of it directly.

Patch 2 allow to check how many time is spent building the codebase versus
running the tests.

Patch 4/5 speed up a bit Travis building many test objects in parallel (using
all available cores) previous to run the tests sequentially (as before) so the
tests output don't get mixed.

Patch 6 use 'travis_retry' feature to avoid aborting a job on network failure
retrying 3 times (default).

Then are Peter patches improving Coverity.

Regards,

Phil.

Peter Maydell (3):
  travis: install more library dependencies
  scripts/run-coverity-scan: Script to run Coverity Scan build
  travis: Add config to do a Coverity Scan upload

Philippe Mathieu-Daudé (8):
  travis: build using all available cpus
  travis: split building/testing to have finer elapsed time
  travis: use yes/no variable to enable/disable tests
  tests: add rule to compile many objects used by tests
  travis: build tests objects in parallel, then run tests sequentially
  travis: retry if llvm.org timeouts
  travis: install more library dependencies
  MAINTAINERS: self-appoint me as reviewer in build/test automation

 .travis.yml               |  82 ++++++++++++++++++----
 MAINTAINERS               |   1 +
 scripts/run-coverity-scan | 170 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include    |   8 ++-
 4 files changed, 244 insertions(+), 17 deletions(-)
 create mode 100755 scripts/run-coverity-scan

-- 
2.11.0
