Received: from eggs.gnu.org ([2001:4830:134:3::10]:58024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKlUp-0001P4-UQ
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:41:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKlOX-0002nP-Te
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:34:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gKlOX-0002mY-MS
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:34:53 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D53BA308402C
	for <qemu-devel@nongnu.org>; Thu,  8 Nov 2018 14:34:52 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu,  8 Nov 2018 15:34:22 +0100
Message-Id: <20181108143422.15955-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] scripts: Remove unused python imports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Reported-by: LGTM code review
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 scripts/analyse-locks-simpletrace.py         | 1 -
 scripts/analyze-migration.py                 | 1 -
 scripts/device-crash-test                    | 1 -
 scripts/simpletrace.py                       | 1 -
 scripts/tracetool.py                         | 2 --
 scripts/tracetool/format/simpletrace_stap.py | 2 +-
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
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index e93a7c0c84..f459d582be 100755
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
--=20
2.17.2
