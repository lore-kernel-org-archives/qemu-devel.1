Received: from eggs.gnu.org ([2001:4830:134:3::10]:46915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTuAD-0007yC-7o
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTuAC-0007Jj-9b
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:13:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fTuAC-0007J6-3G
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:13:36 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 15 Jun 2018 16:13:23 -0300
Message-Id: <20180615191327.11480-4-ehabkost@redhat.com>
In-Reply-To: <20180615191327.11480-1-ehabkost@redhat.com>
References: <20180615191327.11480-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/7] scripts/qemu.py: allow adding to the list
 of extra arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

From: Cleber Rosa <crosa@redhat.com>

Tests will often need to add extra arguments to QEMU command
line arguments.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20180530184156.15634-3-crosa@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 08a3e9af5a..7cd8193df8 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -359,3 +359,9 @@ class QEMUMachine(object):
         of the qemu process.
         '''
         return self._iolog
+
+    def add_args(self, *args):
+        '''
+        Adds to the list of extra arguments to be given to the QEMU bina=
ry
+        '''
+        self._args.extend(args)
--=20
2.18.0.rc1.1.g3f1ff2140
