Received: from eggs.gnu.org ([2001:4830:134:3::10]:45029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gL8k7-0002EP-Ha
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:30:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gL8k6-0007xa-K7
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:30:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gL8k4-0007vo-LN
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:30:42 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri,  9 Nov 2018 10:30:01 -0500
Message-Id: <20181109153002.597-2-crosa@redhat.com>
In-Reply-To: <20181109153002.597-1-crosa@redhat.com>
References: <20181109153002.597-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 1/2] tests/test-qht-par: test gets stuck
 intermittently on OSX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, programmingkidx@gmail.com, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Cleber Rosa <crosa@redhat.com>

To be fully honest, this may not be a OSX (alone) condition, but may
be a situation that only happens with OSX on Travis-CI, were resources
are quite limited.

I have personal experience with tests that exercise parallelism or
depend on timing to fail on Travis.  Because I'm not 100% certain that
this is a situation that only happens with OSX on Travis-CI, and
because I'm not certain that we should be skipping tests because
they're running on Travis-CI, let's disable them on OSX as a whole.

A small note: this type of change makes me believe that there should
be a list of testing related caveats or TODO list tracked on the
documentation.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/Makefile.include | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 074eece558..c821b01467 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -87,7 +87,10 @@ check-unit-y +=3D tests/test-rcu-simpleq$(EXESUF)
 check-unit-y +=3D tests/test-rcu-tailq$(EXESUF)
 check-unit-y +=3D tests/test-qdist$(EXESUF)
 check-unit-y +=3D tests/test-qht$(EXESUF)
+# test-qht-par gets stuck quite often on OSX
+ifneq ($(CONFIG_DARWIN),y)
 check-unit-y +=3D tests/test-qht-par$(EXESUF)
+endif
 check-unit-y +=3D tests/test-bitops$(EXESUF)
 check-unit-y +=3D tests/test-bitcnt$(EXESUF)
 check-unit-y +=3D tests/test-qdev-global-props$(EXESUF)
--=20
2.19.1
