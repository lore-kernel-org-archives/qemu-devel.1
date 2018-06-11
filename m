Received: from eggs.gnu.org ([2001:4830:134:3::10]:60676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQqP-0001v5-M9
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQqO-0000JE-N1
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSQqO-0000Iy-HO
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:04 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Jun 2018 14:42:39 -0300
Message-Id: <20180611174243.31070-10-ehabkost@redhat.com>
In-Reply-To: <20180611174243.31070-1-ehabkost@redhat.com>
References: <20180611174243.31070-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 09/13] python: futurize -f
 lib2to3.fixes.fix_except
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

Convert "except X, T" to "except X as T".

This is necessary for Python 3 compatibility.

Done using:

  $ py=$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';) | \
    sort -u | grep -v README.sh4)
  $ futurize -w -f lib2to3.fixes.fix_except $py

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180608122952.2009-10-ehabkost@redhat.com>
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
