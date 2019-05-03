Received: from eggs.gnu.org ([209.51.188.92]:37666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMGn-0003WV-BC
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMGm-0006jB-FS
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:41:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMMGm-0006it-9l
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:41:44 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  2 May 2019 21:41:14 -0300
Message-Id: <20190503004130.8285-4-ehabkost@redhat.com>
In-Reply-To: <20190503004130.8285-1-ehabkost@redhat.com>
References: <20190503004130.8285-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/19] tests/acceptance: fix doc reference to
 avocado_qemu directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>

From: Cleber Rosa <crosa@redhat.com>

The "this directory" reference is misleading and confusing, it's a
leftover from when this text was proposed in a README file inside
the "tests/acceptance/avocado_qemu" directory.

When that text was moved to the top level docs directory, the
reference was not updated.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Caio Carrara <ccarrara@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190312171824.5134-4-crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 docs/devel/testing.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 60f897d915..7c1b199323 100644
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
2.18.0.rc1.1.g3f1ff2140
