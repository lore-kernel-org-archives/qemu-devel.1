Received: from eggs.gnu.org ([2001:4830:134:3::10]:39744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9ah4-0007Kd-Pv
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9agz-0006NP-Vi
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:23:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9agz-0006K3-LV
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:23:29 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 20 Apr 2018 15:19:45 -0300
Message-Id: <20180420181951.7252-19-ehabkost@redhat.com>
In-Reply-To: <20180420181951.7252-1-ehabkost@redhat.com>
References: <20180420181951.7252-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 18/24] avocado_qemu: Simplify the installation
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Alistair Francis <alistair23@gmail.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

From: Cleber Rosa <crosa@redhat.com>

Let's just give a single command line that can be reliably executed to
install avocado and the dependencies we're aware for the existing
tests.

The installation approach chosen is the most universal one (pip) and
one that impacts the least the developer's system, being limited to
the user's home directory.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/avocado/README.rst | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/tests/avocado/README.rst b/tests/avocado/README.rst
index 50bc865fc1..e2aa993501 100644
--- a/tests/avocado/README.rst
+++ b/tests/avocado/README.rst
@@ -1,12 +1,23 @@
-This directory is hosting functional tests written using Avocado Testing
-Framework. To install Avocado, follow the instructions from this link::
+========================================
+ QEMU tests using the Avocado Framework
+========================================
+
+This directory hosts functional tests written using Avocado Testing
+Framework.
+
+Installation
+============
+
+To install Avocado and the dependencies needed for these tests, run::
+
+    pip install --user avocado-framework avocado-framework-plugin-varianter-yaml-to-mux aexpect
+
+Alternatively, follow the instructions on this link::
 
     http://avocado-framework.readthedocs.io/en/latest/GetStartedGuide.html#installing-avocado
 
-Tests here are written keeping the minimum amount of dependencies. To
-run the tests, you need the Avocado core package (`python-avocado` on
-Fedora, `avocado-framework` on pip). Extra dependencies should be
-documented in this file.  The current minimum required version is 54.0.
+Overview
+========
 
 In this directory, an ``avocado_qemu`` package is provided, containing
 the ``test`` module, which inherits from ``avocado.Test`` and provides
@@ -77,10 +88,6 @@ file using the Avocado parameters system:
   ``accel`` is ``kvm`` and there are more than one KVM types available.
   Example: ``machine_kvm_type: PR``
 
-To use a parameters file, you have to install the yaml_to_mux plugin
-(`python2-avocado-plugins-varianter-yaml-to-mux` on Fedora,
-`avocado-framework-plugin-varianter-yaml-to-mux` on pip).
-
 Run the test with::
 
     $ avocado run test_my_test.py -m parameters.yaml
@@ -111,3 +118,15 @@ proper variants.
 See ``avocado run --help`` and ``man avocado`` for several other
 options, such as ``--filter-by-tags``, ``--show-job-log``,
 ``--failfast``, etc.
+
+Uninstallation
+==============
+
+If you've followed the installation instructions above, you can easily
+uninstall Avocado.  Start by listing the packages you have installed::
+
+    pip list --user
+
+And remove any package you want with::
+
+    pip uninstall <package_name>
-- 
2.14.3
