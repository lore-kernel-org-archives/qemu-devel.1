Received: from eggs.gnu.org ([209.51.188.92]:46469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkE6r-0004mn-19
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:17:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkE6q-0003cE-6W
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:17:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gkE6p-0003aD-TH
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:17:52 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 17 Jan 2019 18:17:36 -0200
Message-Id: <20190117201743.20470-3-ehabkost@redhat.com>
In-Reply-To: <20190117201743.20470-1-ehabkost@redhat.com>
References: <20190117201743.20470-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/9] scripts: Remove unused python imports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reported-by: LGTM code review
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20181108143422.15955-1-philmd@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/analyse-locks-simpletrace.py         | 1 -
 scripts/analyze-migration.py                 | 1 -
 scripts/simpletrace.py                       | 1 -
 scripts/tracetool.py                         | 2 --
 scripts/tracetool/format/simpletrace_stap.py | 2 +-
 scripts/device-crash-test                    | 1 -
 6 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/scripts/analyse-locks-simpletrace.py b/scripts/analyse-locks=
-simpletrace.py
index 30090bdfff..7d9b574300 100755
--- a/scripts/analyse-locks-simpletrace.py
+++ b/scripts/analyse-locks-simpletrace.py
@@ -7,7 +7,6 @@
 #
=20
 from __future__ import print_function
-import os
 import simpletrace
 import argparse
 import numpy as np
diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 5c2010c917..e527eb168e 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -23,7 +23,6 @@ import json
 import os
 import argparse
 import collections
-import pprint
=20
 def mkdir_p(path):
     try:
diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index 4ad34f90cd..45485b864b 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -11,7 +11,6 @@
=20
 from __future__ import print_function
 import struct
-import re
 import inspect
 from tracetool import read_events, Event
 from tracetool.backend.simple import is_string
diff --git a/scripts/tracetool.py b/scripts/tracetool.py
index fe2b0771f2..3beaa66bd8 100755
--- a/scripts/tracetool.py
+++ b/scripts/tracetool.py
@@ -15,8 +15,6 @@ __email__      =3D "stefanha@linux.vnet.ibm.com"
=20
 import sys
 import getopt
-import os.path
-import re
=20
 from tracetool import error_write, out
 import tracetool.backend
diff --git a/scripts/tracetool/format/simpletrace_stap.py b/scripts/trace=
tool/format/simpletrace_stap.py
index e7e44842ca..57b04061cf 100644
--- a/scripts/tracetool/format/simpletrace_stap.py
+++ b/scripts/tracetool/format/simpletrace_stap.py
@@ -14,7 +14,7 @@ __email__      =3D "stefanha@redhat.com"
=20
=20
 from tracetool import out
-from tracetool.backend.dtrace import binary, probeprefix
+from tracetool.backend.dtrace import probeprefix
 from tracetool.backend.simple import is_string
 from tracetool.format.stap import stap_escape
=20
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 549162a547..b32aa93f89 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -26,7 +26,6 @@ check for crashes and unexpected errors.
 from __future__ import print_function
=20
 import sys
-import os
 import glob
 import logging
 import traceback
--=20
2.18.0.rc1.1.g3f1ff2140
