Received: from eggs.gnu.org ([2001:4830:134:3::10]:36984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gL8Nw-0007N7-Gc
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:07:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gL8Nt-0007Ai-5S
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:07:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gL8Ng-0006kq-LL
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:07:35 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri,  9 Nov 2018 10:07:09 -0500
Message-Id: <20181109150710.31085-4-crosa@redhat.com>
In-Reply-To: <20181109150710.31085-1-crosa@redhat.com>
References: <20181109150710.31085-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/4] Travis CI: make specified Python versions
 usable on jobs
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

For the two Python jobs, which seem to have the goal of making sure
QEMU builds successfully on the 3.0-3.6 spectrum of Python 3 versions,
the specified version is only applicable if a Python virtual
environment is used.  To do that, it's necessary to define the
(primary?) language of the job to be Python.

Also, Travis doesn't have a 3.0 Python installation available for the
chosen distro, 3.2 being the lower version available.

Reference: https://docs.travis-ci.com/user/languages/python/#specifying-p=
ython-versions
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 .travis.yml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index aa49c7b114..5c18d3e268 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -112,9 +112,11 @@ matrix:
       compiler: clang
     # Python builds
     - env: CONFIG=3D"--target-list=3Dx86_64-softmmu"
+      language: python
       python:
-        - "3.0"
+        - "3.2"
     - env: CONFIG=3D"--target-list=3Dx86_64-softmmu"
+      language: python
       python:
         - "3.6"
     # Acceptance (Functional) tests
--=20
2.19.1
