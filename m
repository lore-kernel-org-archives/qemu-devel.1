Received: from eggs.gnu.org ([209.51.188.92]:54020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=904c6e83a=anthony.perard@citrix.com>)
	id 1ggqZY-00016U-9H
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 07:33:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=904c6e83a=anthony.perard@citrix.com>)
	id 1ggqZX-0008Fa-KW
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 07:33:32 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:24542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=904c6e83a=anthony.perard@citrix.com>)
	id 1ggqZX-00084x-Cq
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 07:33:31 -0500
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Tue, 8 Jan 2019 12:33:11 +0000
Message-ID: <20190108123311.24456-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] qmp-shell: Fix example with objects as values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony.perard@citrix.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>

The example shown that is suppose to let a user passes an object/array as
argument doesn't work. The quotes get removed by shlex.split() and then
both JSON parser complains. Fix the example by adding quotes and add
examples with boolean and array.

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 scripts/qmp/qmp-shell | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 770140772d..9937e3c888 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -33,7 +33,11 @@
 # key=value pairs also support Python or JSON object literal subset notations,
 # without spaces. Dictionaries/objects {} are supported as are arrays [].
 #
-#    example-command arg-name1={'key':'value','obj'={'prop':"value"}}
+#  JSON:
+#    example-command arg-name1='{"key":"value","obj":{"prop":"value"}}'
+#    example-command arg-name1='{"key":"value","obj":[1,true,"three"]}'
+#  free style:
+#    example-command arg-name1="{'key':'value',\"obj\":[1,True,\"three\"]}"
 #
 # Both JSON and Python formatting should work, including both styles of
 # string literal quotes. Both paradigms of literal values should work,
-- 
Anthony PERARD
