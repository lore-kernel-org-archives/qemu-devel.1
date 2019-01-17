Received: from eggs.gnu.org ([209.51.188.92]:42707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gkCqe-00059L-Do
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:57:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gkCqc-0005sQ-VX
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:57:03 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 17 Jan 2019 13:56:14 -0500
Message-Id: <20190117185628.21862-5-crosa@redhat.com>
In-Reply-To: <20190117185628.21862-1-crosa@redhat.com>
References: <20190117185628.21862-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/18] Acceptance tests: fix doc reference to
 avocado_qemu directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

The "this directory" reference is misleading and confusing, it's a
leftover from when this text was proposed in a README file inside
the "tests/acceptance/avocado_qemu" directory.

When that text was moved to the top level docs directory, the
reference was not updated.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 docs/devel/testing.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 18e2c0868a..44c9b3ae74 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -590,8 +590,9 @@ Alternatively, follow the instructions on this link:
 Overview
 --------
=20
-This directory provides the ``avocado_qemu`` Python module, containing
-the ``avocado_qemu.Test`` class.  Here's a simple usage example:
+The ``tests/acceptance/avocado_qemu`` directory provides the
+``avocado_qemu`` Python module, containing the ``avocado_qemu.Test``
+class.  Here's a simple usage example:
=20
 .. code::
=20
--=20
2.20.1
