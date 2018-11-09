Received: from eggs.gnu.org ([2001:4830:134:3::10]:36919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gL8Ng-0006oP-E9
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:07:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gL8NZ-0006f4-0C
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:07:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33997)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gL8NY-0006Zh-PF
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:07:24 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri,  9 Nov 2018 10:07:06 -0500
Message-Id: <20181109150710.31085-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] Record Python version and misc test/CI
 fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Caio Carrara <ccarrara@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Cleber Rosa <crosa@redhat.com>

A recent experience with Travis-CI[1] showed that some tests were not
running with the intended Python version.  Let's add the Python
version the configure output, which serves as a general debugging
aid that the intended Python version was used[2][3].

Additionally, the recently introduced "check-venv" target, used by the
"check-acceptance" target, verifies if the configured Python interpreter
is Python 3, and does so on the Makefile itself.  Since the Python versio=
n
is being captured on configure, let's avoid rerunning Python on every
make invocation.

Finally, a small cosmetic fix to the "make check-help" output.

[1] https://travis-ci.org/clebergnu/qemu/jobs/452033247#L983
[2] https://travis-ci.org/clebergnu/qemu/jobs/452663112#L960
[3] https://travis-ci.org/clebergnu/qemu/jobs/452663113#L956

Cleber Rosa (4):
  configure: keep track of Python version
  check-venv: use recorded Python version
  Travis CI: make specified Python versions usable on jobs
  check-help: visual and content improvements

 .travis.yml            |  4 +++-
 configure              |  6 +++++-
 tests/Makefile.include | 11 ++++++-----
 3 files changed, 14 insertions(+), 7 deletions(-)

--=20
2.19.1
