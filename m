Received: from eggs.gnu.org ([2001:4830:134:3::10]:45927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRGYQ-0008Py-5v
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRGYP-0005SE-H4
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:31:42 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  8 Jun 2018 09:29:51 -0300
Message-Id: <20180608122952.2009-10-ehabkost@redhat.com>
In-Reply-To: <20180608122952.2009-1-ehabkost@redhat.com>
References: <20180608122952.2009-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/10] python: futurize -f
 lib2to3.fixes.fix_except
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Juan Quintela <quintela@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Convert "except X, T" to "except X as T".

This is necessary for Python 3 compatibility.

Done using:

  $ py=$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';) | \
    sort -u | grep -v README.sh4)
  $ futurize -w -f lib2to3.fixes.fix_except $py

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/simpletrace.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index 2658b5cc7c..d4a50a1e2b 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -45,7 +45,7 @@ def get_record(edict, idtoname, rechdr, fobj):
         rec = (name, rechdr[1], rechdr[3])
         try:
             event = edict[name]
-        except KeyError, e:
+        except KeyError as e:
             import sys
             sys.stderr.write('%s event is logged but is not declared ' \
                              'in the trace events file, try using ' \
-- 
2.18.0.rc1.1.g3f1ff2140
