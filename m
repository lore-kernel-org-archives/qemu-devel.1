Received: from eggs.gnu.org ([209.51.188.92]:46518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkE6w-0004q5-ML
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:17:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkE6v-0003lW-T4
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:17:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gkE6v-0003ko-Mu
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:17:57 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 17 Jan 2019 18:17:39 -0200
Message-Id: <20190117201743.20470-6-ehabkost@redhat.com>
In-Reply-To: <20190117201743.20470-1-ehabkost@redhat.com>
References: <20190117201743.20470-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/9] Travis CI: make specified Python versions
 usable on jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>

From: Cleber Rosa <crosa@redhat.com>

For the two Python jobs, which seem to have the goal of making sure
QEMU builds successfully on the 3.0-3.6 spectrum of Python 3 versions,
the specified version is only applicable if a Python virtual
environment is used.  To do that, it's necessary to define the
(primary?) language of the job to be Python.

Also, Travis doesn't have a 3.0 Python installation available for the
chosen distro, 3.4 being the lower version available.

Reference: https://docs.travis-ci.com/user/languages/python/#specifying-p=
ython-versions
Signed-off-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20181109150710.31085-4-crosa@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
[ehabkost: Now 3.4 is the lowest Python version available]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

fixup! Travis CI: make specified Python versions usable on jobs

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 .travis.yml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 93fd0164a0..87d9fa971c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -175,12 +175,14 @@ matrix:
     # Python builds
     - env:
         - CONFIG=3D"--target-list=3Dx86_64-softmmu"
+      language: python
       python:
-        - "3.0"
+        - "3.4"
=20
=20
     - env:
         - CONFIG=3D"--target-list=3Dx86_64-softmmu"
+      language: python
       python:
         - "3.6"
=20
--=20
2.18.0.rc1.1.g3f1ff2140
