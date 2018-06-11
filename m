Received: from eggs.gnu.org ([2001:4830:134:3::10]:60621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQqL-0001qA-7j
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQqK-0000HE-DA
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSQqK-0000Gw-6b
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:00 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Jun 2018 14:42:37 -0300
Message-Id: <20180611174243.31070-8-ehabkost@redhat.com>
In-Reply-To: <20180611174243.31070-1-ehabkost@redhat.com>
References: <20180611174243.31070-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 07/13] python: futurize -f
 lib2to3.fixes.fix_tuple_params
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

Remove implicit tuple parameter unpacking.

This is necessary for Python 3 compatibility.

Done using:

  $ py=$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';) | \
    sort -u | grep -v README.sh4)
  $ futurize -w -f lib2to3.fixes.fix_tuple_params $py

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180608122952.2009-8-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/analyse-locks-simpletrace.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/analyse-locks-simpletrace.py b/scripts/analyse-locks-simpletrace.py
index 352bc9c22d..30090bdfff 100755
--- a/scripts/analyse-locks-simpletrace.py
+++ b/scripts/analyse-locks-simpletrace.py
@@ -78,7 +78,7 @@ if __name__ == '__main__':
 
     # Now dump the individual lock stats
     for key, val in sorted(analyser.mutex_records.iteritems(),
-                           key=lambda (k,v): v["locks"]):
+                           key=lambda k_v: k_v[1]["locks"]):
         print ("Lock: %#x locks: %d, locked: %d, unlocked: %d" %
                (key, val["locks"], val["locked"], val["unlocked"]))
 
-- 
2.18.0.rc1.1.g3f1ff2140
