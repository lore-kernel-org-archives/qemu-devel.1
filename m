Received: from eggs.gnu.org ([2001:4830:134:3::10]:39707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gFFfZ-000551-Bx
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gFFfT-0004zD-4x
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:41:40 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:24199)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gFFfM-0004nL-V2
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:41:31 -0400
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Wed, 24 Oct 2018 17:40:50 +0800
Message-Id: <20181024094051.4470-3-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181024094051.4470-1-maozhongyi@cmss.chinamobile.com>
References: <20181024094051.4470-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH v2 2/3] qemu-iotests: remove unused variable
 here
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

run
git grep '\$here' tests/qemu-iotests

has 0 hits, which means we are setting a variable that
no use, so execute the following cmd to remove all of
the 'here=...' lines as dead code.

sed -i '/here=/d' $(git grep -l 'here=' tests/qemu-iotests)

Cc: kwolf@redhat.com
Cc: mreitz@redhat.com
Cc: eblake@redhat.com

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
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
 169 files changed, 169 deletions(-)

diff --git a/tests/qemu-iotests/001 b/tests/qemu-iotests/001
index 42a57e4e86..55dcbb71d9 100755
--- a/tests/qemu-iotests/001
+++ b/tests/qemu-iotests/001
@@ -24,7 +24,6 @@ owner=hch@lst.de
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/002 b/tests/qemu-iotests/002
index 70799f8a9a..74572b4711 100755
--- a/tests/qemu-iotests/002
+++ b/tests/qemu-iotests/002
@@ -24,7 +24,6 @@ owner=hch@lst.de
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/003 b/tests/qemu-iotests/003
index d5396e54a5..bf2595559b 100755
--- a/tests/qemu-iotests/003
+++ b/tests/qemu-iotests/003
@@ -24,7 +24,6 @@ owner=hch@lst.de
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/004 b/tests/qemu-iotests/004
index 9552cd31ea..841b15dfac 100755
--- a/tests/qemu-iotests/004
+++ b/tests/qemu-iotests/004
@@ -24,7 +24,6 @@ owner=hch@lst.de
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
index 1cf3d67b74..8aa4283a4d 100755
--- a/tests/qemu-iotests/005
+++ b/tests/qemu-iotests/005
@@ -27,7 +27,6 @@ owner=hch@lst.de
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/007 b/tests/qemu-iotests/007
index e4ebcdea54..b983022a7f 100755
--- a/tests/qemu-iotests/007
+++ b/tests/qemu-iotests/007
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/008 b/tests/qemu-iotests/008
index 62d9524045..8dfa10bcb8 100755
--- a/tests/qemu-iotests/008
+++ b/tests/qemu-iotests/008
@@ -24,7 +24,6 @@ owner=hch@lst.de
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/009 b/tests/qemu-iotests/009
index fbcfe5cd17..73ae09db69 100755
--- a/tests/qemu-iotests/009
+++ b/tests/qemu-iotests/009
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/010 b/tests/qemu-iotests/010
index 285e7bf960..751aca9813 100755
--- a/tests/qemu-iotests/010
+++ b/tests/qemu-iotests/010
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/011 b/tests/qemu-iotests/011
index 4da1670083..35909564a9 100755
--- a/tests/qemu-iotests/011
+++ b/tests/qemu-iotests/011
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/012 b/tests/qemu-iotests/012
index a35bbd58e1..de9a5fb4d5 100755
--- a/tests/qemu-iotests/012
+++ b/tests/qemu-iotests/012
@@ -26,7 +26,6 @@ owner=hch@lst.de
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/013 b/tests/qemu-iotests/013
index 3a9668cad0..5e1efcee28 100755
--- a/tests/qemu-iotests/013
+++ b/tests/qemu-iotests/013
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/014 b/tests/qemu-iotests/014
index 1404d14eff..9ade571a95 100755
--- a/tests/qemu-iotests/014
+++ b/tests/qemu-iotests/014
@@ -26,7 +26,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/015 b/tests/qemu-iotests/015
index fd43f80503..21f7d42c84 100755
--- a/tests/qemu-iotests/015
+++ b/tests/qemu-iotests/015
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/017 b/tests/qemu-iotests/017
index a0de5ed878..1ac6f74502 100755
--- a/tests/qemu-iotests/017
+++ b/tests/qemu-iotests/017
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/018 b/tests/qemu-iotests/018
index fab2fc1803..bba30a1be2 100755
--- a/tests/qemu-iotests/018
+++ b/tests/qemu-iotests/018
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/019 b/tests/qemu-iotests/019
index 5697d109b6..8f911a79c1 100755
--- a/tests/qemu-iotests/019
+++ b/tests/qemu-iotests/019
@@ -26,7 +26,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index 7b066d19a3..6b972d082f 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/021 b/tests/qemu-iotests/021
index e568f38c69..c15ebf9eb8 100755
--- a/tests/qemu-iotests/021
+++ b/tests/qemu-iotests/021
@@ -24,7 +24,6 @@ owner=hch@lst.de
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/022 b/tests/qemu-iotests/022
index a438a8862d..44765c7b7a 100755
--- a/tests/qemu-iotests/022
+++ b/tests/qemu-iotests/022
@@ -26,7 +26,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/023 b/tests/qemu-iotests/023
index 23b16a4d9b..c8e1b9a761 100755
--- a/tests/qemu-iotests/023
+++ b/tests/qemu-iotests/023
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index a91200cd59..428b5c815d 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/025 b/tests/qemu-iotests/025
index 17f7d17673..fcd4d97c17 100755
--- a/tests/qemu-iotests/025
+++ b/tests/qemu-iotests/025
@@ -24,7 +24,6 @@ owner=stefanha@linux.vnet.ibm.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index 84d3bd509f..31276d9027 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/027 b/tests/qemu-iotests/027
index 33539cc769..2c46ae1457 100755
--- a/tests/qemu-iotests/027
+++ b/tests/qemu-iotests/027
@@ -24,7 +24,6 @@ owner=stefanha@linux.vnet.ibm.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index ad87aa0dae..a2a7c93bcd 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -27,7 +27,6 @@ owner=stefanha@linux.vnet.ibm.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/029 b/tests/qemu-iotests/029
index fc430c78de..cf0fe0f6a6 100755
--- a/tests/qemu-iotests/029
+++ b/tests/qemu-iotests/029
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/031 b/tests/qemu-iotests/031
index ab599add77..ac0dfaed7d 100755
--- a/tests/qemu-iotests/031
+++ b/tests/qemu-iotests/031
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/032 b/tests/qemu-iotests/032
index ce1dbaf086..3e86bb0111 100755
--- a/tests/qemu-iotests/032
+++ b/tests/qemu-iotests/032
@@ -26,7 +26,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/033 b/tests/qemu-iotests/033
index 9492f17e5f..46b91388ef 100755
--- a/tests/qemu-iotests/033
+++ b/tests/qemu-iotests/033
@@ -24,7 +24,6 @@ owner=pbonzini@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/034 b/tests/qemu-iotests/034
index f4ebad8edb..62812cd53c 100755
--- a/tests/qemu-iotests/034
+++ b/tests/qemu-iotests/034
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/035 b/tests/qemu-iotests/035
index 522e5e8245..a5716caf32 100755
--- a/tests/qemu-iotests/035
+++ b/tests/qemu-iotests/035
@@ -25,7 +25,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
index ecb556ef26..4e76602a93 100755
--- a/tests/qemu-iotests/036
+++ b/tests/qemu-iotests/036
@@ -27,7 +27,6 @@ owner=stefanha@linux.vnet.ibm.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/037 b/tests/qemu-iotests/037
index 95a7e7731b..2e43b19ed0 100755
--- a/tests/qemu-iotests/037
+++ b/tests/qemu-iotests/037
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/038 b/tests/qemu-iotests/038
index 338123d5f2..4e03976023 100755
--- a/tests/qemu-iotests/038
+++ b/tests/qemu-iotests/038
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index caf245def0..b3c344cb27 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -27,7 +27,6 @@ owner=stefanha@linux.vnet.ibm.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/042 b/tests/qemu-iotests/042
index e5ce618766..beaa339000 100755
--- a/tests/qemu-iotests/042
+++ b/tests/qemu-iotests/042
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/043 b/tests/qemu-iotests/043
index 8bbb72695f..fc9005b28f 100755
--- a/tests/qemu-iotests/043
+++ b/tests/qemu-iotests/043
@@ -24,7 +24,6 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index 79de8064ec..01c0de62d8 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/047 b/tests/qemu-iotests/047
index 07e391d7ea..c168373cf0 100755
--- a/tests/qemu-iotests/047
+++ b/tests/qemu-iotests/047
@@ -25,7 +25,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/049 b/tests/qemu-iotests/049
index a456d097d4..4d0ad5cd50 100755
--- a/tests/qemu-iotests/049
+++ b/tests/qemu-iotests/049
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/050 b/tests/qemu-iotests/050
index 294dffb88c..963a0db97f 100755
--- a/tests/qemu-iotests/050
+++ b/tests/qemu-iotests/050
@@ -24,7 +24,6 @@ owner=pbonzini@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 69adc791df..a676da8273 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/052 b/tests/qemu-iotests/052
index aefff4bff5..b992adf4ff 100755
--- a/tests/qemu-iotests/052
+++ b/tests/qemu-iotests/052
@@ -24,7 +24,6 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/053 b/tests/qemu-iotests/053
index f04b88bbc1..afa109c950 100755
--- a/tests/qemu-iotests/053
+++ b/tests/qemu-iotests/053
@@ -24,7 +24,6 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/054 b/tests/qemu-iotests/054
index 4e6361f0d9..cf88a7c76e 100755
--- a/tests/qemu-iotests/054
+++ b/tests/qemu-iotests/054
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/058 b/tests/qemu-iotests/058
index 1ba0cbee25..0d741a7cac 100755
--- a/tests/qemu-iotests/058
+++ b/tests/qemu-iotests/058
@@ -26,7 +26,6 @@ owner=xiawenc@linux.vnet.ibm.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 nbd_unix_socket=$TEST_DIR/test_qemu_nbd_socket
diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index 2bfdb941f6..54d5567acc 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -24,7 +24,6 @@ owner=famz@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 74ad371885..af0588ae9a 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index 92c1889333..1a50163419 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/062 b/tests/qemu-iotests/062
index 6d1638711c..985fbef41e 100755
--- a/tests/qemu-iotests/062
+++ b/tests/qemu-iotests/062
@@ -25,7 +25,6 @@ owner=mreitz@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/063 b/tests/qemu-iotests/063
index 6daf389a3d..041fb5c1ac 100755
--- a/tests/qemu-iotests/063
+++ b/tests/qemu-iotests/063
@@ -25,7 +25,6 @@ owner=alex@alex.org.uk
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/064 b/tests/qemu-iotests/064
index 22d5678e3d..f55ff37ca7 100755
--- a/tests/qemu-iotests/064
+++ b/tests/qemu-iotests/064
@@ -24,7 +24,6 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/066 b/tests/qemu-iotests/066
index 8638217736..26c043711b 100755
--- a/tests/qemu-iotests/066
+++ b/tests/qemu-iotests/066
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/067 b/tests/qemu-iotests/067
index 62dc3e820d..f8d584f487 100755
--- a/tests/qemu-iotests/067
+++ b/tests/qemu-iotests/067
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
index e7fca6a494..f0583d52ae 100755
--- a/tests/qemu-iotests/068
+++ b/tests/qemu-iotests/068
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/069 b/tests/qemu-iotests/069
index 96e55ef216..fdee121f43 100755
--- a/tests/qemu-iotests/069
+++ b/tests/qemu-iotests/069
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/070 b/tests/qemu-iotests/070
index 6fbb95a086..78e0390f5f 100755
--- a/tests/qemu-iotests/070
+++ b/tests/qemu-iotests/070
@@ -25,7 +25,6 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 48b495513f..6448e9e75b 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/072 b/tests/qemu-iotests/072
index aa027c7d29..08ef29f5b4 100755
--- a/tests/qemu-iotests/072
+++ b/tests/qemu-iotests/072
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/073 b/tests/qemu-iotests/073
index c572d9afcc..5e7f76cb7f 100755
--- a/tests/qemu-iotests/073
+++ b/tests/qemu-iotests/073
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/075 b/tests/qemu-iotests/075
index df5f88a43c..45b8901ef0 100755
--- a/tests/qemu-iotests/075
+++ b/tests/qemu-iotests/075
@@ -24,7 +24,6 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/076 b/tests/qemu-iotests/076
index 35bce0b210..3b5ab3fd08 100755
--- a/tests/qemu-iotests/076
+++ b/tests/qemu-iotests/076
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/077 b/tests/qemu-iotests/077
index 8e6a9a598f..a40f319d37 100755
--- a/tests/qemu-iotests/077
+++ b/tests/qemu-iotests/077
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/078 b/tests/qemu-iotests/078
index 86b0e95897..68d0ea8802 100755
--- a/tests/qemu-iotests/078
+++ b/tests/qemu-iotests/078
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
index da0e441d54..fca2f77d37 100755
--- a/tests/qemu-iotests/079
+++ b/tests/qemu-iotests/079
@@ -24,7 +24,6 @@ owner=hutao@cn.fujitsu.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index 14f3d7f275..cec2376f59 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/081 b/tests/qemu-iotests/081
index b30a7c4331..c5d4616630 100755
--- a/tests/qemu-iotests/081
+++ b/tests/qemu-iotests/081
@@ -24,7 +24,6 @@ owner=benoit@irqsave.net
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index e8008f2044..14f6631071 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/083 b/tests/qemu-iotests/083
index a42a2e1819..982adecf02 100755
--- a/tests/qemu-iotests/083
+++ b/tests/qemu-iotests/083
@@ -24,7 +24,6 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/084 b/tests/qemu-iotests/084
index 559c8ed1ea..e131fa9642 100755
--- a/tests/qemu-iotests/084
+++ b/tests/qemu-iotests/084
@@ -25,7 +25,6 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index 0786b28503..2ef84077b8 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -29,7 +29,6 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 snapshot_virt0="snapshot-v0.qcow2"
diff --git a/tests/qemu-iotests/086 b/tests/qemu-iotests/086
index 442e63afc4..971de7dc35 100755
--- a/tests/qemu-iotests/086
+++ b/tests/qemu-iotests/086
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index 4303e0e62b..109cdf5ea4 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/088 b/tests/qemu-iotests/088
index e55b67cd69..c5e9ab42c7 100755
--- a/tests/qemu-iotests/088
+++ b/tests/qemu-iotests/088
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index aa1ba4a98e..3165d79e2a 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/090 b/tests/qemu-iotests/090
index 7380503d57..1450993e15 100755
--- a/tests/qemu-iotests/090
+++ b/tests/qemu-iotests/090
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index 2e66ed31b9..2f2f98ee64 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -26,7 +26,6 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1    # failure is the default!
 
 MIG_FIFO="${TEST_DIR}/migrate"
diff --git a/tests/qemu-iotests/092 b/tests/qemu-iotests/092
index be71add468..8e318f10b9 100755
--- a/tests/qemu-iotests/092
+++ b/tests/qemu-iotests/092
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/094 b/tests/qemu-iotests/094
index 9aa01e3627..7adc9b9138 100755
--- a/tests/qemu-iotests/094
+++ b/tests/qemu-iotests/094
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/095 b/tests/qemu-iotests/095
index 3ce960502c..9fc47f6b87 100755
--- a/tests/qemu-iotests/095
+++ b/tests/qemu-iotests/095
@@ -27,7 +27,6 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/097 b/tests/qemu-iotests/097
index e22670c8d0..7234b16053 100755
--- a/tests/qemu-iotests/097
+++ b/tests/qemu-iotests/097
@@ -25,7 +25,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/098 b/tests/qemu-iotests/098
index b002e969b3..c7977da99a 100755
--- a/tests/qemu-iotests/098
+++ b/tests/qemu-iotests/098
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/099 b/tests/qemu-iotests/099
index caaf58eee5..4a6275d4bc 100755
--- a/tests/qemu-iotests/099
+++ b/tests/qemu-iotests/099
@@ -25,7 +25,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/101 b/tests/qemu-iotests/101
index 6022eb31fc..3001ba3c0a 100755
--- a/tests/qemu-iotests/101
+++ b/tests/qemu-iotests/101
@@ -24,7 +24,6 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
index 04b3f28445..29a6a940e2 100755
--- a/tests/qemu-iotests/102
+++ b/tests/qemu-iotests/102
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=$PWD
 status=1    # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
index 2841318492..66f8167f02 100755
--- a/tests/qemu-iotests/103
+++ b/tests/qemu-iotests/103
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/104 b/tests/qemu-iotests/104
index b790c89528..34bb0d23ba 100755
--- a/tests/qemu-iotests/104
+++ b/tests/qemu-iotests/104
@@ -24,7 +24,6 @@ owner=hutao@cn.fujitsu.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 trap "exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/105 b/tests/qemu-iotests/105
index 3c125bf163..943bda2f4f 100755
--- a/tests/qemu-iotests/105
+++ b/tests/qemu-iotests/105
@@ -24,7 +24,6 @@ owner=famz@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
index 5e51f88a78..4129fee6bc 100755
--- a/tests/qemu-iotests/106
+++ b/tests/qemu-iotests/106
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/107 b/tests/qemu-iotests/107
index d7222dc1c9..5d70ad2007 100755
--- a/tests/qemu-iotests/107
+++ b/tests/qemu-iotests/107
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
index 2355d98c1d..58e8ad7636 100755
--- a/tests/qemu-iotests/108
+++ b/tests/qemu-iotests/108
@@ -25,7 +25,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
index acbd079136..90bdae459b 100755
--- a/tests/qemu-iotests/109
+++ b/tests/qemu-iotests/109
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index 9de7369f3a..b64b3b215a 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/111 b/tests/qemu-iotests/111
index a1c152d0c1..e15e66ac5d 100755
--- a/tests/qemu-iotests/111
+++ b/tests/qemu-iotests/111
@@ -25,7 +25,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/112 b/tests/qemu-iotests/112
index 28eb9aae93..fba2965322 100755
--- a/tests/qemu-iotests/112
+++ b/tests/qemu-iotests/112
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/113 b/tests/qemu-iotests/113
index 4e09810905..d8d78c46dc 100755
--- a/tests/qemu-iotests/113
+++ b/tests/qemu-iotests/113
@@ -25,7 +25,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/114 b/tests/qemu-iotests/114
index 5b7dc5496c..e17fb514cb 100755
--- a/tests/qemu-iotests/114
+++ b/tests/qemu-iotests/114
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/115 b/tests/qemu-iotests/115
index 665c2ead41..0581e03c26 100755
--- a/tests/qemu-iotests/115
+++ b/tests/qemu-iotests/115
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/116 b/tests/qemu-iotests/116
index bb75a33e78..f8a27b9c02 100755
--- a/tests/qemu-iotests/116
+++ b/tests/qemu-iotests/116
@@ -27,7 +27,6 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/117 b/tests/qemu-iotests/117
index 6c83461182..e533e230a3 100755
--- a/tests/qemu-iotests/117
+++ b/tests/qemu-iotests/117
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/119 b/tests/qemu-iotests/119
index 4f34fb4343..32810d52c9 100755
--- a/tests/qemu-iotests/119
+++ b/tests/qemu-iotests/119
@@ -25,7 +25,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/120 b/tests/qemu-iotests/120
index f40b97d099..76afdf449b 100755
--- a/tests/qemu-iotests/120
+++ b/tests/qemu-iotests/120
@@ -25,7 +25,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/121 b/tests/qemu-iotests/121
index 6d6f55a5dc..d2885c700f 100755
--- a/tests/qemu-iotests/121
+++ b/tests/qemu-iotests/121
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index d8c8ad722d..eab3399dd6 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/123 b/tests/qemu-iotests/123
index b18e3fca9a..168b985c8b 100755
--- a/tests/qemu-iotests/123
+++ b/tests/qemu-iotests/123
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
index c20c71570c..778c874933 100755
--- a/tests/qemu-iotests/125
+++ b/tests/qemu-iotests/125
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
index a2d4d6c73d..91148383ad 100755
--- a/tests/qemu-iotests/126
+++ b/tests/qemu-iotests/126
@@ -25,7 +25,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/127 b/tests/qemu-iotests/127
index 9e0d7d3be8..c9139ed5e6 100755
--- a/tests/qemu-iotests/127
+++ b/tests/qemu-iotests/127
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=$PWD
 status=1    # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/128 b/tests/qemu-iotests/128
index 5a6dde0c03..925f5c7e98 100755
--- a/tests/qemu-iotests/128
+++ b/tests/qemu-iotests/128
@@ -24,7 +24,6 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 devname="eiodev$$"
diff --git a/tests/qemu-iotests/130 b/tests/qemu-iotests/130
index 2c4b94da1b..f2f2706b28 100755
--- a/tests/qemu-iotests/130
+++ b/tests/qemu-iotests/130
@@ -26,7 +26,6 @@ owner=kwolf@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/131 b/tests/qemu-iotests/131
index 47da00e3aa..58c25f7abe 100755
--- a/tests/qemu-iotests/131
+++ b/tests/qemu-iotests/131
@@ -24,7 +24,6 @@ owner=den@openvz.org
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
index 9bca244c90..a9a47a3c36 100755
--- a/tests/qemu-iotests/133
+++ b/tests/qemu-iotests/133
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index 934c6c534a..cacabcd28b 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -24,7 +24,6 @@ owner=berrange@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/135 b/tests/qemu-iotests/135
index b12246fee9..a18a0c7230 100755
--- a/tests/qemu-iotests/135
+++ b/tests/qemu-iotests/135
@@ -24,7 +24,6 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
index 19e8597306..09cd4450ca 100755
--- a/tests/qemu-iotests/137
+++ b/tests/qemu-iotests/137
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
index 21650d8197..eccbcae3a6 100755
--- a/tests/qemu-iotests/138
+++ b/tests/qemu-iotests/138
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
index a8fc95145c..d4623b5a5d 100755
--- a/tests/qemu-iotests/140
+++ b/tests/qemu-iotests/140
@@ -28,7 +28,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
index 4246d387a1..e2408c7988 100755
--- a/tests/qemu-iotests/141
+++ b/tests/qemu-iotests/141
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/142 b/tests/qemu-iotests/142
index 0ac1402f55..c7c360d11b 100755
--- a/tests/qemu-iotests/142
+++ b/tests/qemu-iotests/142
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/143 b/tests/qemu-iotests/143
index 5ff1944507..d6302cc06d 100755
--- a/tests/qemu-iotests/143
+++ b/tests/qemu-iotests/143
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/144 b/tests/qemu-iotests/144
index 15909fe7bd..118c099994 100755
--- a/tests/qemu-iotests/144
+++ b/tests/qemu-iotests/144
@@ -26,7 +26,6 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 TMP_SNAP1=${TEST_DIR}/tmp.qcow2
diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
index f8f4849490..6ce8a46f92 100755
--- a/tests/qemu-iotests/145
+++ b/tests/qemu-iotests/145
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/146 b/tests/qemu-iotests/146
index c8e99a344a..3f61351ffe 100755
--- a/tests/qemu-iotests/146
+++ b/tests/qemu-iotests/146
@@ -24,7 +24,6 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1    # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/150 b/tests/qemu-iotests/150
index ee8f6375f6..955b877efa 100755
--- a/tests/qemu-iotests/150
+++ b/tests/qemu-iotests/150
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index 0daeb1b005..00092b84b9 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -24,7 +24,6 @@ owner=famz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 tmp=/tmp/$$
 status=1	# failure is the default!
 
diff --git a/tests/qemu-iotests/154 b/tests/qemu-iotests/154
index cb68dbee00..4a4abf0589 100755
--- a/tests/qemu-iotests/154
+++ b/tests/qemu-iotests/154
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index 0a9a09802e..f97f96f666 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -32,7 +32,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/157 b/tests/qemu-iotests/157
index 2bf02be465..c3231b787a 100755
--- a/tests/qemu-iotests/157
+++ b/tests/qemu-iotests/157
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index 168f331197..d277ddcc94 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -24,7 +24,6 @@ owner=berrange@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/159 b/tests/qemu-iotests/159
index 9b0e1ecc90..e74b2739de 100755
--- a/tests/qemu-iotests/159
+++ b/tests/qemu-iotests/159
@@ -23,7 +23,6 @@ owner=fullmanet@gmail.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1
 
 _cleanup()
diff --git a/tests/qemu-iotests/160 b/tests/qemu-iotests/160
index 5c910e5bfc..92fff45d10 100755
--- a/tests/qemu-iotests/160
+++ b/tests/qemu-iotests/160
@@ -23,7 +23,6 @@ owner=fullmanet@gmail.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1
 
 _cleanup()
diff --git a/tests/qemu-iotests/162 b/tests/qemu-iotests/162
index 477a806360..ef02d844a2 100755
--- a/tests/qemu-iotests/162
+++ b/tests/qemu-iotests/162
@@ -25,7 +25,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/170 b/tests/qemu-iotests/170
index b79359fc4e..861eabf5cc 100755
--- a/tests/qemu-iotests/170
+++ b/tests/qemu-iotests/170
@@ -23,7 +23,6 @@ owner=fullmanet@gmail.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1
 
 _cleanup()
diff --git a/tests/qemu-iotests/171 b/tests/qemu-iotests/171
index 910f18fd59..5b46069fde 100755
--- a/tests/qemu-iotests/171
+++ b/tests/qemu-iotests/171
@@ -25,7 +25,6 @@ owner=tgolembi@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
index 203554b30a..c5ee33ee81 100755
--- a/tests/qemu-iotests/172
+++ b/tests/qemu-iotests/172
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/173 b/tests/qemu-iotests/173
index f657becd80..1fe8c5d738 100755
--- a/tests/qemu-iotests/173
+++ b/tests/qemu-iotests/173
@@ -24,7 +24,6 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1    # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/174 b/tests/qemu-iotests/174
index bc8d6df3f6..d8bb05c4e2 100755
--- a/tests/qemu-iotests/174
+++ b/tests/qemu-iotests/174
@@ -24,7 +24,6 @@ owner=nirsof@gmail.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index e3c904695d..ebbeb6e74c 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -24,7 +24,6 @@ owner=nirsof@gmail.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/176 b/tests/qemu-iotests/176
index 32baa116dd..c091d0bd1e 100755
--- a/tests/qemu-iotests/176
+++ b/tests/qemu-iotests/176
@@ -29,7 +29,6 @@ owner=mreitz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/177 b/tests/qemu-iotests/177
index dfd5723c8b..7bf8e1daf3 100755
--- a/tests/qemu-iotests/177
+++ b/tests/qemu-iotests/177
@@ -24,7 +24,6 @@ owner=eblake@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
index 5d25a50d03..3f4b4a4564 100755
--- a/tests/qemu-iotests/178
+++ b/tests/qemu-iotests/178
@@ -24,7 +24,6 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1    # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/179 b/tests/qemu-iotests/179
index 115944a753..3040631636 100755
--- a/tests/qemu-iotests/179
+++ b/tests/qemu-iotests/179
@@ -24,7 +24,6 @@ owner=eblake@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index c05318096a..0c44108dac 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 MIG_SOCKET="${TEST_DIR}/migrate"
diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
index 4b31592fb8..9e0944d49a 100755
--- a/tests/qemu-iotests/182
+++ b/tests/qemu-iotests/182
@@ -24,7 +24,6 @@ owner=famz@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 tmp=/tmp/$$
 status=1	# failure is the default!
 
diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index b28701302b..ebb5e304ac 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1 # failure is the default!
 
 MIG_SOCKET="${TEST_DIR}/migrate"
diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
index a36a2e3270..2f3259d558 100755
--- a/tests/qemu-iotests/184
+++ b/tests/qemu-iotests/184
@@ -24,7 +24,6 @@ owner="Manos Pitsidianakis"
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 trap "exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index 80dca40465..d8f1505cd8 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1 # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index ab71a30c14..29681bf45c 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/187 b/tests/qemu-iotests/187
index 6affdc253c..1feddca508 100755
--- a/tests/qemu-iotests/187
+++ b/tests/qemu-iotests/187
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/188 b/tests/qemu-iotests/188
index d946b9699d..af40e496ee 100755
--- a/tests/qemu-iotests/188
+++ b/tests/qemu-iotests/188
@@ -24,7 +24,6 @@ owner=berrange@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/189 b/tests/qemu-iotests/189
index e98001fd99..222bec133b 100755
--- a/tests/qemu-iotests/189
+++ b/tests/qemu-iotests/189
@@ -24,7 +24,6 @@ owner=berrange@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/190 b/tests/qemu-iotests/190
index fce04e2f3f..95ba06d8f4 100755
--- a/tests/qemu-iotests/190
+++ b/tests/qemu-iotests/190
@@ -24,7 +24,6 @@ owner=eblake@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1    # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index 7de80df778..198272ea3b 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1 # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
index ee8fd2d841..415c706db5 100755
--- a/tests/qemu-iotests/192
+++ b/tests/qemu-iotests/192
@@ -25,7 +25,6 @@ owner=famz@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/195 b/tests/qemu-iotests/195
index 7784b1f363..f56f255715 100755
--- a/tests/qemu-iotests/195
+++ b/tests/qemu-iotests/195
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1 # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index 0369aa5cff..8170f5d4ab 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -24,7 +24,6 @@ owner=eblake@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1 # failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
index c23bd16ea7..4d961f4f3a 100755
--- a/tests/qemu-iotests/198
+++ b/tests/qemu-iotests/198
@@ -24,7 +24,6 @@ owner=berrange@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
index 4f5d5b3b23..b9ebd5a8c7 100755
--- a/tests/qemu-iotests/200
+++ b/tests/qemu-iotests/200
@@ -26,7 +26,6 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1    # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/204 b/tests/qemu-iotests/204
index 0ec550a691..57f3afe1d7 100755
--- a/tests/qemu-iotests/204
+++ b/tests/qemu-iotests/204
@@ -24,7 +24,6 @@ owner=eblake@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/214 b/tests/qemu-iotests/214
index c46ca2a6dd..7a2d5391bb 100755
--- a/tests/qemu-iotests/214
+++ b/tests/qemu-iotests/214
@@ -22,7 +22,6 @@
 seq=$(basename "$0")
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/215 b/tests/qemu-iotests/215
index 2e616ed659..230fd2551a 100755
--- a/tests/qemu-iotests/215
+++ b/tests/qemu-iotests/215
@@ -21,7 +21,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1 # failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/221 b/tests/qemu-iotests/221
index 41c4e4bdf8..06f48f1f23 100755
--- a/tests/qemu-iotests/221
+++ b/tests/qemu-iotests/221
@@ -21,7 +21,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1 # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index 8b1859c2dd..58a3f3ff40 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -21,7 +21,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1 # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/225 b/tests/qemu-iotests/225
index f2ee715685..e42ee94ff0 100755
--- a/tests/qemu-iotests/225
+++ b/tests/qemu-iotests/225
@@ -24,7 +24,6 @@ owner=mreitz@redhat.com
 seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/226 b/tests/qemu-iotests/226
index c396edb6ab..aec413b23c 100755
--- a/tests/qemu-iotests/226
+++ b/tests/qemu-iotests/226
@@ -25,7 +25,6 @@ owner=jsnow@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1    # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/227 b/tests/qemu-iotests/227
index 9a5f7f9f14..43f2323ff2 100755
--- a/tests/qemu-iotests/227
+++ b/tests/qemu-iotests/227
@@ -24,7 +24,6 @@ owner=kwolf@redhat.com
 seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/229 b/tests/qemu-iotests/229
index ff851ec431..86602437ff 100755
--- a/tests/qemu-iotests/229
+++ b/tests/qemu-iotests/229
@@ -25,7 +25,6 @@ owner=jcody@redhat.com
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/231 b/tests/qemu-iotests/231
index e044cea9b5..e9f8aaacd3 100755
--- a/tests/qemu-iotests/231
+++ b/tests/qemu-iotests/231
@@ -26,7 +26,6 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
-- 
2.17.1
