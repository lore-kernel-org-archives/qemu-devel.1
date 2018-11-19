Received: from eggs.gnu.org ([2001:4830:134:3::10]:51524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnl9-0000Q8-CG
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:55:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnl3-0002ew-Cg
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:54:55 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 19 Nov 2018 11:54:16 -0600
Message-Id: <20181119175427.2298497-2-eblake@redhat.com>
In-Reply-To: <20181119175427.2298497-1-eblake@redhat.com>
References: <20181119175427.2298497-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 01/12] qemu-iotests: remove unused variable
 'here'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, "open list:Block layer core" <qemu-block@nongnu.org>

From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Running
git grep '\$here' tests/qemu-iotests

has 0 hits, which means we are setting a variable that has
no use.  It appears that commit e8f8624d removed the last
use.  So execute the following cmd to remove all of
the 'here=...' lines as dead code.

sed -i '/^here=/d' $(git grep -l '^here=' tests/qemu-iotests)

Cc: kwolf@redhat.com
Cc: mreitz@redhat.com
Cc: eblake@redhat.com
Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Message-Id: <20181024094051.4470-3-maozhongyi@cmss.chinamobile.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: touch up commit message, reorder series, rebase to master]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/001 | 1 -
 tests/qemu-iotests/002 | 1 -
 tests/qemu-iotests/003 | 1 -
 tests/qemu-iotests/004 | 1 -
 tests/qemu-iotests/005 | 1 -
 tests/qemu-iotests/007 | 1 -
 tests/qemu-iotests/008 | 1 -
 tests/qemu-iotests/009 | 1 -
 tests/qemu-iotests/010 | 1 -
 tests/qemu-iotests/011 | 1 -
 tests/qemu-iotests/012 | 1 -
 tests/qemu-iotests/013 | 1 -
 tests/qemu-iotests/014 | 1 -
 tests/qemu-iotests/015 | 1 -
 tests/qemu-iotests/017 | 1 -
 tests/qemu-iotests/018 | 1 -
 tests/qemu-iotests/019 | 1 -
 tests/qemu-iotests/020 | 1 -
 tests/qemu-iotests/021 | 1 -
 tests/qemu-iotests/022 | 1 -
 tests/qemu-iotests/023 | 1 -
 tests/qemu-iotests/024 | 1 -
 tests/qemu-iotests/025 | 1 -
 tests/qemu-iotests/026 | 1 -
 tests/qemu-iotests/027 | 1 -
 tests/qemu-iotests/028 | 1 -
 tests/qemu-iotests/029 | 1 -
 tests/qemu-iotests/031 | 1 -
 tests/qemu-iotests/032 | 1 -
 tests/qemu-iotests/033 | 1 -
 tests/qemu-iotests/034 | 1 -
 tests/qemu-iotests/035 | 1 -
 tests/qemu-iotests/036 | 1 -
 tests/qemu-iotests/037 | 1 -
 tests/qemu-iotests/038 | 1 -
 tests/qemu-iotests/039 | 1 -
 tests/qemu-iotests/042 | 1 -
 tests/qemu-iotests/043 | 1 -
 tests/qemu-iotests/046 | 1 -
 tests/qemu-iotests/047 | 1 -
 tests/qemu-iotests/049 | 1 -
 tests/qemu-iotests/050 | 1 -
 tests/qemu-iotests/051 | 1 -
 tests/qemu-iotests/052 | 1 -
 tests/qemu-iotests/053 | 1 -
 tests/qemu-iotests/054 | 1 -
 tests/qemu-iotests/058 | 1 -
 tests/qemu-iotests/059 | 1 -
 tests/qemu-iotests/060 | 1 -
 tests/qemu-iotests/061 | 1 -
 tests/qemu-iotests/062 | 1 -
 tests/qemu-iotests/063 | 1 -
 tests/qemu-iotests/064 | 1 -
 tests/qemu-iotests/066 | 1 -
 tests/qemu-iotests/067 | 1 -
 tests/qemu-iotests/068 | 1 -
 tests/qemu-iotests/069 | 1 -
 tests/qemu-iotests/070 | 1 -
 tests/qemu-iotests/071 | 1 -
 tests/qemu-iotests/072 | 1 -
 tests/qemu-iotests/073 | 1 -
 tests/qemu-iotests/075 | 1 -
 tests/qemu-iotests/076 | 1 -
 tests/qemu-iotests/077 | 1 -
 tests/qemu-iotests/078 | 1 -
 tests/qemu-iotests/079 | 1 -
 tests/qemu-iotests/080 | 1 -
 tests/qemu-iotests/081 | 1 -
 tests/qemu-iotests/082 | 1 -
 tests/qemu-iotests/083 | 1 -
 tests/qemu-iotests/084 | 1 -
 tests/qemu-iotests/085 | 1 -
 tests/qemu-iotests/086 | 1 -
 tests/qemu-iotests/087 | 1 -
 tests/qemu-iotests/088 | 1 -
 tests/qemu-iotests/089 | 1 -
 tests/qemu-iotests/090 | 1 -
 tests/qemu-iotests/091 | 1 -
 tests/qemu-iotests/092 | 1 -
 tests/qemu-iotests/094 | 1 -
 tests/qemu-iotests/095 | 1 -
 tests/qemu-iotests/097 | 1 -
 tests/qemu-iotests/098 | 1 -
 tests/qemu-iotests/099 | 1 -
 tests/qemu-iotests/101 | 1 -
 tests/qemu-iotests/102 | 1 -
 tests/qemu-iotests/103 | 1 -
 tests/qemu-iotests/104 | 1 -
 tests/qemu-iotests/105 | 1 -
 tests/qemu-iotests/106 | 1 -
 tests/qemu-iotests/107 | 1 -
 tests/qemu-iotests/108 | 1 -
 tests/qemu-iotests/109 | 1 -
 tests/qemu-iotests/110 | 1 -
 tests/qemu-iotests/111 | 1 -
 tests/qemu-iotests/112 | 1 -
 tests/qemu-iotests/113 | 1 -
 tests/qemu-iotests/114 | 1 -
 tests/qemu-iotests/115 | 1 -
 tests/qemu-iotests/116 | 1 -
 tests/qemu-iotests/117 | 1 -
 tests/qemu-iotests/119 | 1 -
 tests/qemu-iotests/120 | 1 -
 tests/qemu-iotests/121 | 1 -
 tests/qemu-iotests/122 | 1 -
 tests/qemu-iotests/123 | 1 -
 tests/qemu-iotests/125 | 1 -
 tests/qemu-iotests/126 | 1 -
 tests/qemu-iotests/127 | 1 -
 tests/qemu-iotests/128 | 1 -
 tests/qemu-iotests/130 | 1 -
 tests/qemu-iotests/131 | 1 -
 tests/qemu-iotests/133 | 1 -
 tests/qemu-iotests/134 | 1 -
 tests/qemu-iotests/135 | 1 -
 tests/qemu-iotests/137 | 1 -
 tests/qemu-iotests/138 | 1 -
 tests/qemu-iotests/140 | 1 -
 tests/qemu-iotests/141 | 1 -
 tests/qemu-iotests/142 | 1 -
 tests/qemu-iotests/143 | 1 -
 tests/qemu-iotests/144 | 1 -
 tests/qemu-iotests/145 | 1 -
 tests/qemu-iotests/146 | 1 -
 tests/qemu-iotests/150 | 1 -
 tests/qemu-iotests/153 | 1 -
 tests/qemu-iotests/154 | 1 -
 tests/qemu-iotests/156 | 1 -
 tests/qemu-iotests/157 | 1 -
 tests/qemu-iotests/158 | 1 -
 tests/qemu-iotests/159 | 1 -
 tests/qemu-iotests/160 | 1 -
 tests/qemu-iotests/162 | 1 -
 tests/qemu-iotests/170 | 1 -
 tests/qemu-iotests/171 | 1 -
 tests/qemu-iotests/172 | 1 -
 tests/qemu-iotests/173 | 1 -
 tests/qemu-iotests/174 | 1 -
 tests/qemu-iotests/175 | 1 -
 tests/qemu-iotests/176 | 1 -
 tests/qemu-iotests/177 | 1 -
 tests/qemu-iotests/178 | 1 -
 tests/qemu-iotests/179 | 1 -
 tests/qemu-iotests/181 | 1 -
 tests/qemu-iotests/182 | 1 -
 tests/qemu-iotests/183 | 1 -
 tests/qemu-iotests/184 | 1 -
 tests/qemu-iotests/185 | 1 -
 tests/qemu-iotests/186 | 1 -
 tests/qemu-iotests/187 | 1 -
 tests/qemu-iotests/188 | 1 -
 tests/qemu-iotests/189 | 1 -
 tests/qemu-iotests/190 | 1 -
 tests/qemu-iotests/191 | 1 -
 tests/qemu-iotests/192 | 1 -
 tests/qemu-iotests/195 | 1 -
 tests/qemu-iotests/197 | 1 -
 tests/qemu-iotests/198 | 1 -
 tests/qemu-iotests/200 | 1 -
 tests/qemu-iotests/204 | 1 -
 tests/qemu-iotests/214 | 1 -
 tests/qemu-iotests/215 | 1 -
 tests/qemu-iotests/221 | 1 -
 tests/qemu-iotests/223 | 1 -
 tests/qemu-iotests/225 | 1 -
 tests/qemu-iotests/226 | 1 -
 tests/qemu-iotests/227 | 1 -
 tests/qemu-iotests/229 | 1 -
 tests/qemu-iotests/231 | 1 -
 tests/qemu-iotests/232 | 1 -
 170 files changed, 170 deletions(-)

diff --git a/tests/qemu-iotests/001 b/tests/qemu-iotests/001
index ffd14e2ce96..55dcbb71d99 100755
--- a/tests/qemu-iotests/001
+++ b/tests/qemu-iotests/001
@@ -24,7 +24,6 @@ owner=hch@lst.de
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/002 b/tests/qemu-iotests/002
index d4f8e91b917..74572b47118 100755
--- a/tests/qemu-iotests/002
+++ b/tests/qemu-iotests/002
@@ -24,7 +24,6 @@ owner=hch@lst.de
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/003 b/tests/qemu-iotests/003
index 19889b9fcdb..bf2595559bc 100755
--- a/tests/qemu-iotests/003
+++ b/tests/qemu-iotests/003
@@ -24,7 +24,6 @@ owner=hch@lst.de
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/004 b/tests/qemu-iotests/004
index 6f2aa3d9a25..841b15dfaca 100755
--- a/tests/qemu-iotests/004
+++ b/tests/qemu-iotests/004
@@ -24,7 +24,6 @@ owner=hch@lst.de
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
index 444737751ff..8aa4283a4d5 100755
--- a/tests/qemu-iotests/005
+++ b/tests/qemu-iotests/005
@@ -27,7 +27,6 @@ owner=hch@lst.de
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/007 b/tests/qemu-iotests/007
index fa543eeb7db..b983022a7f3 100755
--- a/tests/qemu-iotests/007
+++ b/tests/qemu-iotests/007
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/008 b/tests/qemu-iotests/008
index 8e89d74fe9b..8dfa10bcb89 100755
--- a/tests/qemu-iotests/008
+++ b/tests/qemu-iotests/008
@@ -24,7 +24,6 @@ owner=hch@lst.de
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/009 b/tests/qemu-iotests/009
index 16e4475ca4b..73ae09db696 100755
--- a/tests/qemu-iotests/009
+++ b/tests/qemu-iotests/009
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/010 b/tests/qemu-iotests/010
index 151dac238d5..751aca9813c 100755
--- a/tests/qemu-iotests/010
+++ b/tests/qemu-iotests/010
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/011 b/tests/qemu-iotests/011
index f8d044ec857..35909564a91 100755
--- a/tests/qemu-iotests/011
+++ b/tests/qemu-iotests/011
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/012 b/tests/qemu-iotests/012
index 01a770d59c5..de9a5fb4d51 100755
--- a/tests/qemu-iotests/012
+++ b/tests/qemu-iotests/012
@@ -26,7 +26,6 @@ owner=hch@lst.de
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/013 b/tests/qemu-iotests/013
index d013f87da99..5e1efcee289 100755
--- a/tests/qemu-iotests/013
+++ b/tests/qemu-iotests/013
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/014 b/tests/qemu-iotests/014
index 2ea79e8c8b7..9ade571a950 100755
--- a/tests/qemu-iotests/014
+++ b/tests/qemu-iotests/014
@@ -26,7 +26,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/015 b/tests/qemu-iotests/015
index aaf9c3f4150..21f7d42c84f 100755
--- a/tests/qemu-iotests/015
+++ b/tests/qemu-iotests/015
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/017 b/tests/qemu-iotests/017
index 4f9302db42e..1ac6f745025 100755
--- a/tests/qemu-iotests/017
+++ b/tests/qemu-iotests/017
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/018 b/tests/qemu-iotests/018
index 1d39d35c479..bba30a1be2c 100755
--- a/tests/qemu-iotests/018
+++ b/tests/qemu-iotests/018
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/019 b/tests/qemu-iotests/019
index 24a789a25c0..8f911a79c1a 100755
--- a/tests/qemu-iotests/019
+++ b/tests/qemu-iotests/019
@@ -26,7 +26,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index eac5080f83c..6b972d082fe 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/021 b/tests/qemu-iotests/021
index 11e8ed7187f..c15ebf9eb8c 100755
--- a/tests/qemu-iotests/021
+++ b/tests/qemu-iotests/021
@@ -24,7 +24,6 @@ owner=hch@lst.de
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/022 b/tests/qemu-iotests/022
index 2452a9f86a0..44765c7b7a1 100755
--- a/tests/qemu-iotests/022
+++ b/tests/qemu-iotests/022
@@ -26,7 +26,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/023 b/tests/qemu-iotests/023
index 497ae1ed17c..c8e1b9a761b 100755
--- a/tests/qemu-iotests/023
+++ b/tests/qemu-iotests/023
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index 4071ed60935..428b5c815d0 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/025 b/tests/qemu-iotests/025
index 70dd5f10aa2..fcd4d97c17d 100755
--- a/tests/qemu-iotests/025
+++ b/tests/qemu-iotests/025
@@ -24,7 +24,6 @@ owner=stefanha@linux.vnet.ibm.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index 582d254195f..31276d9027a 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/027 b/tests/qemu-iotests/027
index 08593da7757..2c46ae1457a 100755
--- a/tests/qemu-iotests/027
+++ b/tests/qemu-iotests/027
@@ -24,7 +24,6 @@ owner=stefanha@linux.vnet.ibm.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index 97a88692512..a2a7c93bcdb 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -27,7 +27,6 @@ owner=stefanha@linux.vnet.ibm.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/029 b/tests/qemu-iotests/029
index 5cff6875bfc..cf0fe0f6a64 100755
--- a/tests/qemu-iotests/029
+++ b/tests/qemu-iotests/029
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/031 b/tests/qemu-iotests/031
index 1e08abc5ed1..ac0dfaed7dd 100755
--- a/tests/qemu-iotests/031
+++ b/tests/qemu-iotests/031
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/032 b/tests/qemu-iotests/032
index 24bcb52fc2d..3e86bb01119 100755
--- a/tests/qemu-iotests/032
+++ b/tests/qemu-iotests/032
@@ -26,7 +26,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/033 b/tests/qemu-iotests/033
index ee8a1338bbd..46b91388efa 100755
--- a/tests/qemu-iotests/033
+++ b/tests/qemu-iotests/033
@@ -24,7 +24,6 @@ owner=pbonzini@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/034 b/tests/qemu-iotests/034
index 1b28bdae638..62812cd53cb 100755
--- a/tests/qemu-iotests/034
+++ b/tests/qemu-iotests/034
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/035 b/tests/qemu-iotests/035
index efc38e4d49d..a5716caf327 100755
--- a/tests/qemu-iotests/035
+++ b/tests/qemu-iotests/035
@@ -25,7 +25,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
index ce638d60762..4e76602a930 100755
--- a/tests/qemu-iotests/036
+++ b/tests/qemu-iotests/036
@@ -27,7 +27,6 @@ owner=stefanha@linux.vnet.ibm.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/037 b/tests/qemu-iotests/037
index c476b823d2b..2e43b19ed04 100755
--- a/tests/qemu-iotests/037
+++ b/tests/qemu-iotests/037
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/038 b/tests/qemu-iotests/038
index d99a1501d7a..4e03976023d 100755
--- a/tests/qemu-iotests/038
+++ b/tests/qemu-iotests/038
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index 1f48339692d..b3c344cb27c 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -27,7 +27,6 @@ owner=stefanha@linux.vnet.ibm.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/042 b/tests/qemu-iotests/042
index a53e7cb7578..beaa3390005 100755
--- a/tests/qemu-iotests/042
+++ b/tests/qemu-iotests/042
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/043 b/tests/qemu-iotests/043
index 1c6c22d92a8..fc9005b28fe 100755
--- a/tests/qemu-iotests/043
+++ b/tests/qemu-iotests/043
@@ -24,7 +24,6 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index f2ebecf24c7..01c0de62d82 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/047 b/tests/qemu-iotests/047
index 1b8f3d4a64e..c168373cf0f 100755
--- a/tests/qemu-iotests/047
+++ b/tests/qemu-iotests/047
@@ -25,7 +25,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/049 b/tests/qemu-iotests/049
index df35b6d21e6..4d0ad5cd50c 100755
--- a/tests/qemu-iotests/049
+++ b/tests/qemu-iotests/049
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/050 b/tests/qemu-iotests/050
index 03b4a5d6208..963a0db97f7 100755
--- a/tests/qemu-iotests/050
+++ b/tests/qemu-iotests/050
@@ -24,7 +24,6 @@ owner=pbonzini@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 25d3b2d4785..a676da82734 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/052 b/tests/qemu-iotests/052
index 842eaced3b6..b992adf4ffd 100755
--- a/tests/qemu-iotests/052
+++ b/tests/qemu-iotests/052
@@ -24,7 +24,6 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/053 b/tests/qemu-iotests/053
index 2a04f5f5516..afa109c950a 100755
--- a/tests/qemu-iotests/053
+++ b/tests/qemu-iotests/053
@@ -24,7 +24,6 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/054 b/tests/qemu-iotests/054
index bf47ef9fac3..cf88a7c76e5 100755
--- a/tests/qemu-iotests/054
+++ b/tests/qemu-iotests/054
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/058 b/tests/qemu-iotests/058
index 5eb8784669e..0d741a7cac2 100755
--- a/tests/qemu-iotests/058
+++ b/tests/qemu-iotests/058
@@ -26,7 +26,6 @@ owner=xiawenc@linux.vnet.ibm.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 nbd_unix_socket=$TEST_DIR/test_qemu_nbd_socket
diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index 530bbbe6ce4..54d5567accf 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -24,7 +24,6 @@ owner=famz@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 74ad371885d..af0588ae9a9 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index 911b6f28946..1a501634193 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/062 b/tests/qemu-iotests/062
index 051fb9f4100..985fbef41ea 100755
--- a/tests/qemu-iotests/062
+++ b/tests/qemu-iotests/062
@@ -25,7 +25,6 @@ owner=mreitz@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/063 b/tests/qemu-iotests/063
index adc037c1f55..041fb5c1ac7 100755
--- a/tests/qemu-iotests/063
+++ b/tests/qemu-iotests/063
@@ -25,7 +25,6 @@ owner=alex@alex.org.uk
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/064 b/tests/qemu-iotests/064
index 5792fbbc928..f55ff37ca73 100755
--- a/tests/qemu-iotests/064
+++ b/tests/qemu-iotests/064
@@ -24,7 +24,6 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/066 b/tests/qemu-iotests/066
index 86382177364..26c043711b9 100755
--- a/tests/qemu-iotests/066
+++ b/tests/qemu-iotests/066
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/067 b/tests/qemu-iotests/067
index fe259f61654..f8d584f4873 100755
--- a/tests/qemu-iotests/067
+++ b/tests/qemu-iotests/067
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
index e7fca6a4949..f0583d52ae3 100755
--- a/tests/qemu-iotests/068
+++ b/tests/qemu-iotests/068
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/069 b/tests/qemu-iotests/069
index 96e55ef2160..fdee121f43a 100755
--- a/tests/qemu-iotests/069
+++ b/tests/qemu-iotests/069
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/070 b/tests/qemu-iotests/070
index 8d08d74ff93..78e0390f5f3 100755
--- a/tests/qemu-iotests/070
+++ b/tests/qemu-iotests/070
@@ -25,7 +25,6 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 48b495513f6..6448e9e75bc 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/072 b/tests/qemu-iotests/072
index aa027c7d293..08ef29f5b44 100755
--- a/tests/qemu-iotests/072
+++ b/tests/qemu-iotests/072
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/073 b/tests/qemu-iotests/073
index 40f85b18b97..5e7f76cb7f7 100755
--- a/tests/qemu-iotests/073
+++ b/tests/qemu-iotests/073
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/075 b/tests/qemu-iotests/075
index caa30d47434..45b8901ef01 100755
--- a/tests/qemu-iotests/075
+++ b/tests/qemu-iotests/075
@@ -24,7 +24,6 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/076 b/tests/qemu-iotests/076
index ef9e6a4ff32..3b5ab3fd08a 100755
--- a/tests/qemu-iotests/076
+++ b/tests/qemu-iotests/076
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/077 b/tests/qemu-iotests/077
index b3c6fb13704..a40f319d371 100755
--- a/tests/qemu-iotests/077
+++ b/tests/qemu-iotests/077
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/078 b/tests/qemu-iotests/078
index a106c26f6b5..68d0ea88020 100755
--- a/tests/qemu-iotests/078
+++ b/tests/qemu-iotests/078
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
index b2e3f7426ac..fca2f77d379 100755
--- a/tests/qemu-iotests/079
+++ b/tests/qemu-iotests/079
@@ -24,7 +24,6 @@ owner=hutao@cn.fujitsu.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index f0eb42f3909..cec2376f599 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/081 b/tests/qemu-iotests/081
index 9f1dece2711..ccb6becaef0 100755
--- a/tests/qemu-iotests/081
+++ b/tests/qemu-iotests/081
@@ -24,7 +24,6 @@ owner=benoit@irqsave.net
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index 3e605d52d1a..14f6631071d 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/083 b/tests/qemu-iotests/083
index 9f92317b0ac..89f67db70fc 100755
--- a/tests/qemu-iotests/083
+++ b/tests/qemu-iotests/083
@@ -24,7 +24,6 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/084 b/tests/qemu-iotests/084
index 04f2aa9d7d1..e131fa96424 100755
--- a/tests/qemu-iotests/084
+++ b/tests/qemu-iotests/084
@@ -25,7 +25,6 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index 5c7668cf9ba..2ef84077b8f 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -29,7 +29,6 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 snapshot_virt0="snapshot-v0.qcow2"
diff --git a/tests/qemu-iotests/086 b/tests/qemu-iotests/086
index 84e38350719..971de7dc355 100755
--- a/tests/qemu-iotests/086
+++ b/tests/qemu-iotests/086
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index 2561a14456e..109cdf5ea43 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/088 b/tests/qemu-iotests/088
index b8076f216b0..c5e9ab42c75 100755
--- a/tests/qemu-iotests/088
+++ b/tests/qemu-iotests/088
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index aa1ba4a98e7..3165d79e2ac 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/090 b/tests/qemu-iotests/090
index 7380503d57c..1450993e15e 100755
--- a/tests/qemu-iotests/090
+++ b/tests/qemu-iotests/090
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index 10ac4a8d73b..2f2f98ee64d 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -26,7 +26,6 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1    # failure is the default!

 MIG_FIFO="${TEST_DIR}/migrate"
diff --git a/tests/qemu-iotests/092 b/tests/qemu-iotests/092
index 5bbdd071d8b..8e318f10b93 100755
--- a/tests/qemu-iotests/092
+++ b/tests/qemu-iotests/092
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/094 b/tests/qemu-iotests/094
index 9aa01e3627c..7adc9b91382 100755
--- a/tests/qemu-iotests/094
+++ b/tests/qemu-iotests/094
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/095 b/tests/qemu-iotests/095
index 72ecc22e1b7..9fc47f6b877 100755
--- a/tests/qemu-iotests/095
+++ b/tests/qemu-iotests/095
@@ -27,7 +27,6 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/097 b/tests/qemu-iotests/097
index e22670c8d06..7234b16053f 100755
--- a/tests/qemu-iotests/097
+++ b/tests/qemu-iotests/097
@@ -25,7 +25,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/098 b/tests/qemu-iotests/098
index b002e969b32..c7977da99ac 100755
--- a/tests/qemu-iotests/098
+++ b/tests/qemu-iotests/098
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/099 b/tests/qemu-iotests/099
index caaf58eee54..4a6275d4bca 100755
--- a/tests/qemu-iotests/099
+++ b/tests/qemu-iotests/099
@@ -25,7 +25,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/101 b/tests/qemu-iotests/101
index ea53f8b8d38..3001ba3c0ad 100755
--- a/tests/qemu-iotests/101
+++ b/tests/qemu-iotests/101
@@ -24,7 +24,6 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
index 04b3f284456..29a6a940e2a 100755
--- a/tests/qemu-iotests/102
+++ b/tests/qemu-iotests/102
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq=$(basename $0)
 echo "QA output created by $seq"

-here=$PWD
 status=1    # failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
index 2841318492d..66f8167f028 100755
--- a/tests/qemu-iotests/103
+++ b/tests/qemu-iotests/103
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq=$(basename $0)
 echo "QA output created by $seq"

-here=$PWD
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/104 b/tests/qemu-iotests/104
index 726d4670527..34bb0d23baf 100755
--- a/tests/qemu-iotests/104
+++ b/tests/qemu-iotests/104
@@ -24,7 +24,6 @@ owner=hutao@cn.fujitsu.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 trap "exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/105 b/tests/qemu-iotests/105
index 3db4ce3cf3e..943bda2f4f2 100755
--- a/tests/qemu-iotests/105
+++ b/tests/qemu-iotests/105
@@ -24,7 +24,6 @@ owner=famz@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
index 5e51f88a783..4129fee6bc9 100755
--- a/tests/qemu-iotests/106
+++ b/tests/qemu-iotests/106
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq=$(basename $0)
 echo "QA output created by $seq"

-here=$PWD
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/107 b/tests/qemu-iotests/107
index d7222dc1c91..5d70ad20079 100755
--- a/tests/qemu-iotests/107
+++ b/tests/qemu-iotests/107
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
index 2355d98c1d3..58e8ad7636e 100755
--- a/tests/qemu-iotests/108
+++ b/tests/qemu-iotests/108
@@ -25,7 +25,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
index acbd0791365..90bdae459b8 100755
--- a/tests/qemu-iotests/109
+++ b/tests/qemu-iotests/109
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index 9de7369f3ae..b64b3b215a1 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/111 b/tests/qemu-iotests/111
index a1c152d0c10..e15e66ac5d7 100755
--- a/tests/qemu-iotests/111
+++ b/tests/qemu-iotests/111
@@ -25,7 +25,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/112 b/tests/qemu-iotests/112
index 28eb9aae93d..fba2965322d 100755
--- a/tests/qemu-iotests/112
+++ b/tests/qemu-iotests/112
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/113 b/tests/qemu-iotests/113
index 4e098109050..d8d78c46dcb 100755
--- a/tests/qemu-iotests/113
+++ b/tests/qemu-iotests/113
@@ -25,7 +25,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/114 b/tests/qemu-iotests/114
index 5b7dc5496c8..e17fb514cb5 100755
--- a/tests/qemu-iotests/114
+++ b/tests/qemu-iotests/114
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/115 b/tests/qemu-iotests/115
index 665c2ead41b..0581e03c266 100755
--- a/tests/qemu-iotests/115
+++ b/tests/qemu-iotests/115
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/116 b/tests/qemu-iotests/116
index df0172fed3a..f8a27b9c02b 100755
--- a/tests/qemu-iotests/116
+++ b/tests/qemu-iotests/116
@@ -27,7 +27,6 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/117 b/tests/qemu-iotests/117
index 6c834611824..e533e230a3e 100755
--- a/tests/qemu-iotests/117
+++ b/tests/qemu-iotests/117
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/119 b/tests/qemu-iotests/119
index 4f34fb4343a..32810d52c9a 100755
--- a/tests/qemu-iotests/119
+++ b/tests/qemu-iotests/119
@@ -25,7 +25,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/120 b/tests/qemu-iotests/120
index f40b97d0999..76afdf449bf 100755
--- a/tests/qemu-iotests/120
+++ b/tests/qemu-iotests/120
@@ -25,7 +25,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/121 b/tests/qemu-iotests/121
index 6d6f55a5dcf..d2885c700f5 100755
--- a/tests/qemu-iotests/121
+++ b/tests/qemu-iotests/121
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index d8c8ad722dc..eab3399dd65 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/123 b/tests/qemu-iotests/123
index b18e3fca9a4..168b985c8b5 100755
--- a/tests/qemu-iotests/123
+++ b/tests/qemu-iotests/123
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
index c20c71570c4..778c8749334 100755
--- a/tests/qemu-iotests/125
+++ b/tests/qemu-iotests/125
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq=$(basename $0)
 echo "QA output created by $seq"

-here=$PWD
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
index a2d4d6c73dc..91148383ad7 100755
--- a/tests/qemu-iotests/126
+++ b/tests/qemu-iotests/126
@@ -25,7 +25,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/127 b/tests/qemu-iotests/127
index 9e0d7d3be8b..c9139ed5e6c 100755
--- a/tests/qemu-iotests/127
+++ b/tests/qemu-iotests/127
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq=$(basename $0)
 echo "QA output created by $seq"

-here=$PWD
 status=1    # failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/128 b/tests/qemu-iotests/128
index 0976a18133f..925f5c7e98a 100755
--- a/tests/qemu-iotests/128
+++ b/tests/qemu-iotests/128
@@ -24,7 +24,6 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 devname="eiodev$$"
diff --git a/tests/qemu-iotests/130 b/tests/qemu-iotests/130
index 2c4b94da1bf..f2f2706b285 100755
--- a/tests/qemu-iotests/130
+++ b/tests/qemu-iotests/130
@@ -26,7 +26,6 @@ owner=kwolf@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/131 b/tests/qemu-iotests/131
index 94a9ae76af6..58c25f7abe5 100755
--- a/tests/qemu-iotests/131
+++ b/tests/qemu-iotests/131
@@ -24,7 +24,6 @@ owner=den@openvz.org
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
index af6b3e1dd4c..a9a47a3c36c 100755
--- a/tests/qemu-iotests/133
+++ b/tests/qemu-iotests/133
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index 99144151b82..cacabcd28b1 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -24,7 +24,6 @@ owner=berrange@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/135 b/tests/qemu-iotests/135
index ce608312f6d..a18a0c72309 100755
--- a/tests/qemu-iotests/135
+++ b/tests/qemu-iotests/135
@@ -24,7 +24,6 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
index 19e8597306a..09cd4450ca5 100755
--- a/tests/qemu-iotests/137
+++ b/tests/qemu-iotests/137
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
index 21650d8197f..eccbcae3a66 100755
--- a/tests/qemu-iotests/138
+++ b/tests/qemu-iotests/138
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
index a8fc95145c4..d4623b5a5d5 100755
--- a/tests/qemu-iotests/140
+++ b/tests/qemu-iotests/140
@@ -28,7 +28,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
index 4246d387a1b..e2408c79888 100755
--- a/tests/qemu-iotests/141
+++ b/tests/qemu-iotests/141
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/142 b/tests/qemu-iotests/142
index 1639c839853..c7c360d11b5 100755
--- a/tests/qemu-iotests/142
+++ b/tests/qemu-iotests/142
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/143 b/tests/qemu-iotests/143
index 5ff19445078..d6302cc06d8 100755
--- a/tests/qemu-iotests/143
+++ b/tests/qemu-iotests/143
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/144 b/tests/qemu-iotests/144
index 4b915718cd1..118c0999949 100755
--- a/tests/qemu-iotests/144
+++ b/tests/qemu-iotests/144
@@ -26,7 +26,6 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 TMP_SNAP1=${TEST_DIR}/tmp.qcow2
diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
index c371b3c46a0..6ce8a46f92a 100755
--- a/tests/qemu-iotests/145
+++ b/tests/qemu-iotests/145
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/146 b/tests/qemu-iotests/146
index 043711be680..3f61351ffe4 100755
--- a/tests/qemu-iotests/146
+++ b/tests/qemu-iotests/146
@@ -24,7 +24,6 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1    # failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/150 b/tests/qemu-iotests/150
index ee8f6375f69..955b877efa1 100755
--- a/tests/qemu-iotests/150
+++ b/tests/qemu-iotests/150
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index 0daeb1b0058..00092b84b9f 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -24,7 +24,6 @@ owner=famz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 tmp=/tmp/$$
 status=1	# failure is the default!

diff --git a/tests/qemu-iotests/154 b/tests/qemu-iotests/154
index fde03b0dc8c..4a4abf05890 100755
--- a/tests/qemu-iotests/154
+++ b/tests/qemu-iotests/154
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index 0a9a09802e1..f97f96f6668 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -32,7 +32,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/157 b/tests/qemu-iotests/157
index 2bf02be465c..c3231b787a1 100755
--- a/tests/qemu-iotests/157
+++ b/tests/qemu-iotests/157
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index 24ac600a4a4..d277ddcc943 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -24,7 +24,6 @@ owner=berrange@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/159 b/tests/qemu-iotests/159
index 9b0e1ecc90d..e74b2739dea 100755
--- a/tests/qemu-iotests/159
+++ b/tests/qemu-iotests/159
@@ -23,7 +23,6 @@ owner=fullmanet@gmail.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1

 _cleanup()
diff --git a/tests/qemu-iotests/160 b/tests/qemu-iotests/160
index 5c910e5bfc1..92fff45d104 100755
--- a/tests/qemu-iotests/160
+++ b/tests/qemu-iotests/160
@@ -23,7 +23,6 @@ owner=fullmanet@gmail.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1

 _cleanup()
diff --git a/tests/qemu-iotests/162 b/tests/qemu-iotests/162
index 477a8063604..ef02d844a20 100755
--- a/tests/qemu-iotests/162
+++ b/tests/qemu-iotests/162
@@ -25,7 +25,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/170 b/tests/qemu-iotests/170
index b79359fc4e4..861eabf5cc0 100755
--- a/tests/qemu-iotests/170
+++ b/tests/qemu-iotests/170
@@ -23,7 +23,6 @@ owner=fullmanet@gmail.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1

 _cleanup()
diff --git a/tests/qemu-iotests/171 b/tests/qemu-iotests/171
index bcfaaf1be25..5b46069fded 100755
--- a/tests/qemu-iotests/171
+++ b/tests/qemu-iotests/171
@@ -25,7 +25,6 @@ owner=tgolembi@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
index 02c5f79bab8..c5ee33ee81b 100755
--- a/tests/qemu-iotests/172
+++ b/tests/qemu-iotests/172
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/173 b/tests/qemu-iotests/173
index bdaa092979e..1fe8c5d7381 100755
--- a/tests/qemu-iotests/173
+++ b/tests/qemu-iotests/173
@@ -24,7 +24,6 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1    # failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/174 b/tests/qemu-iotests/174
index 552879db322..d8bb05c4e21 100755
--- a/tests/qemu-iotests/174
+++ b/tests/qemu-iotests/174
@@ -24,7 +24,6 @@ owner=nirsof@gmail.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index ca56e827cde..ebbeb6e74cd 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -24,7 +24,6 @@ owner=nirsof@gmail.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/176 b/tests/qemu-iotests/176
index 32baa116dd0..c091d0bd1e0 100755
--- a/tests/qemu-iotests/176
+++ b/tests/qemu-iotests/176
@@ -29,7 +29,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/177 b/tests/qemu-iotests/177
index 396986da894..7bf8e1daf39 100755
--- a/tests/qemu-iotests/177
+++ b/tests/qemu-iotests/177
@@ -24,7 +24,6 @@ owner=eblake@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
index 6af52c653a7..3f4b4a45642 100755
--- a/tests/qemu-iotests/178
+++ b/tests/qemu-iotests/178
@@ -24,7 +24,6 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1    # failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/179 b/tests/qemu-iotests/179
index 115944a7532..30406316364 100755
--- a/tests/qemu-iotests/179
+++ b/tests/qemu-iotests/179
@@ -24,7 +24,6 @@ owner=eblake@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index e02979378da..0c44108dac1 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 MIG_SOCKET="${TEST_DIR}/migrate"
diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
index 3b7689c1d5c..9e078c5484d 100755
--- a/tests/qemu-iotests/182
+++ b/tests/qemu-iotests/182
@@ -24,7 +24,6 @@ owner=famz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 tmp=/tmp/$$
 status=1	# failure is the default!

diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index c49e1ad6efb..ebb5e304ac7 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1 # failure is the default!

 MIG_SOCKET="${TEST_DIR}/migrate"
diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
index 2b68284d58f..2f3259d5587 100755
--- a/tests/qemu-iotests/184
+++ b/tests/qemu-iotests/184
@@ -24,7 +24,6 @@ owner="Manos Pitsidianakis"
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 trap "exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index 7dcfdeac605..d8f1505cd83 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1 # failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index 0aa4395a57a..29681bf45c6 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/187 b/tests/qemu-iotests/187
index 7bb783363c3..1feddca5081 100755
--- a/tests/qemu-iotests/187
+++ b/tests/qemu-iotests/187
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/188 b/tests/qemu-iotests/188
index 83ed03e33ee..af40e496eed 100755
--- a/tests/qemu-iotests/188
+++ b/tests/qemu-iotests/188
@@ -24,7 +24,6 @@ owner=berrange@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/189 b/tests/qemu-iotests/189
index e6954757226..222bec133b6 100755
--- a/tests/qemu-iotests/189
+++ b/tests/qemu-iotests/189
@@ -24,7 +24,6 @@ owner=berrange@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/190 b/tests/qemu-iotests/190
index 8f808fef5d9..95ba06d8f48 100755
--- a/tests/qemu-iotests/190
+++ b/tests/qemu-iotests/190
@@ -24,7 +24,6 @@ owner=eblake@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1    # failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index d6860e72f7c..198272ea3b0 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1 # failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
index 595f0d786ab..415c706db54 100755
--- a/tests/qemu-iotests/192
+++ b/tests/qemu-iotests/192
@@ -25,7 +25,6 @@ owner=famz@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/195 b/tests/qemu-iotests/195
index e7a403ded2f..f56f2557153 100755
--- a/tests/qemu-iotests/195
+++ b/tests/qemu-iotests/195
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1 # failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index 0369aa5cff0..8170f5d4ab1 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -24,7 +24,6 @@ owner=eblake@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1 # failure is the default!

 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
index 54eaaf51534..4d961f4f3a5 100755
--- a/tests/qemu-iotests/198
+++ b/tests/qemu-iotests/198
@@ -24,7 +24,6 @@ owner=berrange@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
index ddbdedc476f..b9ebd5a8c77 100755
--- a/tests/qemu-iotests/200
+++ b/tests/qemu-iotests/200
@@ -26,7 +26,6 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1    # failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/204 b/tests/qemu-iotests/204
index feb69d2ada6..57f3afe1d73 100755
--- a/tests/qemu-iotests/204
+++ b/tests/qemu-iotests/204
@@ -24,7 +24,6 @@ owner=eblake@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/214 b/tests/qemu-iotests/214
index c46ca2a6dde..7a2d5391bb7 100755
--- a/tests/qemu-iotests/214
+++ b/tests/qemu-iotests/214
@@ -22,7 +22,6 @@
 seq=$(basename "$0")
 echo "QA output created by $seq"

-here=$PWD
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/215 b/tests/qemu-iotests/215
index 2e616ed659b..230fd2551a5 100755
--- a/tests/qemu-iotests/215
+++ b/tests/qemu-iotests/215
@@ -21,7 +21,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1 # failure is the default!

 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/221 b/tests/qemu-iotests/221
index 41c4e4bdf88..06f48f1f23d 100755
--- a/tests/qemu-iotests/221
+++ b/tests/qemu-iotests/221
@@ -21,7 +21,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1 # failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index 8b1859c2dd3..58a3f3ff408 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -21,7 +21,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1 # failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/225 b/tests/qemu-iotests/225
index f2ee715685f..e42ee94ff01 100755
--- a/tests/qemu-iotests/225
+++ b/tests/qemu-iotests/225
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq=$(basename $0)
 echo "QA output created by $seq"

-here=$PWD
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/226 b/tests/qemu-iotests/226
index 8ec3e612ddb..aec413b23c4 100755
--- a/tests/qemu-iotests/226
+++ b/tests/qemu-iotests/226
@@ -25,7 +25,6 @@ owner=jsnow@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1    # failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/227 b/tests/qemu-iotests/227
index 9a5f7f9f148..43f2323ff2c 100755
--- a/tests/qemu-iotests/227
+++ b/tests/qemu-iotests/227
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=$(basename $0)
 echo "QA output created by $seq"

-here=$PWD
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/229 b/tests/qemu-iotests/229
index ff851ec431f..86602437fff 100755
--- a/tests/qemu-iotests/229
+++ b/tests/qemu-iotests/229
@@ -25,7 +25,6 @@ owner=jcody@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"

-here="$PWD"
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/231 b/tests/qemu-iotests/231
index 3e283708b4c..e9f8aaacd34 100755
--- a/tests/qemu-iotests/231
+++ b/tests/qemu-iotests/231
@@ -26,7 +26,6 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
diff --git a/tests/qemu-iotests/232 b/tests/qemu-iotests/232
index bc2972d1248..b125e54093d 100755
--- a/tests/qemu-iotests/232
+++ b/tests/qemu-iotests/232
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"

-here=`pwd`
 status=1	# failure is the default!

 _cleanup()
-- 
2.17.2
