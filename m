Received: from eggs.gnu.org ([2001:4830:134:3::10]:47021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g85Kp-0005vl-8l
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g85Km-0006Bf-5W
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:14:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1g85Kl-0006BD-VZ
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:14:36 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Thu,  4 Oct 2018 11:14:23 -0400
Message-Id: <20181004151429.7232-2-crosa@redhat.com>
In-Reply-To: <20181004151429.7232-1-crosa@redhat.com>
References: <20181004151429.7232-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 1/7] Acceptance Tests: improve docstring on
 pick_default_qemu_bin()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Caio Carrara <ccarrara@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <pmathieu@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

Making it clear what is returned by this utility function.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
index 1e54fd5932..d8d5b48dac 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -27,6 +27,10 @@ def pick_default_qemu_bin():
     """
     Picks the path of a QEMU binary, starting either in the current working
     directory or in the source tree root directory.
+
+    :returns: the path to the default QEMU binary or None if one could not
+              be found
+    :rtype: str or None
     """
     arch = os.uname()[4]
     qemu_bin_relative_path = os.path.join("%s-softmmu" % arch,
-- 
2.17.1
