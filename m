Received: from eggs.gnu.org ([209.51.188.92]:32947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gwcgs-0005lF-A6
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 19:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gwcgq-0000vd-F4
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 19:58:18 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Wed, 20 Feb 2019 19:57:36 -0500
Message-Id: <20190221005753.27955-4-crosa@redhat.com>
In-Reply-To: <20190221005753.27955-1-crosa@redhat.com>
References: <20190221005753.27955-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 03/20] Acceptance tests: improve docstring
 on pick_default_qemu_bin()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Caio Carrara <ccarrara@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>, Cornelia Huck <cohuck@redhat.com>

Making it clear what is returned by this utility function.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Caio Carrara <ccarrara@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
index 1e54fd5932..d8d5b48dac 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -27,6 +27,10 @@ def pick_default_qemu_bin():
     """
     Picks the path of a QEMU binary, starting either in the current work=
ing
     directory or in the source tree root directory.
+
+    :returns: the path to the default QEMU binary or None if one could n=
ot
+              be found
+    :rtype: str or None
     """
     arch =3D os.uname()[4]
     qemu_bin_relative_path =3D os.path.join("%s-softmmu" % arch,
--=20
2.20.1
