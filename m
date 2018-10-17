Received: from eggs.gnu.org ([2001:4830:134:3::10]:47353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gCiNZ-0002Mh-Ar
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gCiNU-00054F-0w
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:44:37 -0400
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Wed, 17 Oct 2018 17:44:04 +0800
Message-Id: <20181017094406.4844-2-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181017094406.4844-1-maozhongyi@cmss.chinamobile.com>
References: <20181017094406.4844-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH 1/3] qemu-iotests: Modern shellscripting (use
 $() instead of ``)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

Various shell files contain a mix between obsolete ``
and modern $(); It would be nice to convert to using $()
everywhere.

`pwd` and `basename $0` are in 231 files under directory
tests/qemu-iotests, so replaced it with the following:

sed -i 's/`pwd`/$(pwd)/g' $(git grep -l "\`pwd\`")
sed -i 's/`basename $0`/$(basename $0)/g' $(git grep -l "basename \$0")

A small amount of the rest is manually modified.

Cc: kwolf@redhat.com
Cc: mreitz@redhat.com
Cc: qemu-block@nongnu.org

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
---
 tests/qemu-iotests/001            |  4 +-
 tests/qemu-iotests/002            |  4 +-
 tests/qemu-iotests/003            |  4 +-
 tests/qemu-iotests/004            |  4 +-
 tests/qemu-iotests/005            |  4 +-
 tests/qemu-iotests/007            |  6 +--
 tests/qemu-iotests/008            |  4 +-
 tests/qemu-iotests/009            |  4 +-
 tests/qemu-iotests/010            |  4 +-
 tests/qemu-iotests/011            |  6 +--
 tests/qemu-iotests/012            |  4 +-
 tests/qemu-iotests/013            |  4 +-
 tests/qemu-iotests/014            |  6 +--
 tests/qemu-iotests/015            |  4 +-
 tests/qemu-iotests/017            |  4 +-
 tests/qemu-iotests/018            |  4 +-
 tests/qemu-iotests/019            |  4 +-
 tests/qemu-iotests/020            |  4 +-
 tests/qemu-iotests/021            |  4 +-
 tests/qemu-iotests/022            |  4 +-
 tests/qemu-iotests/023            |  4 +-
 tests/qemu-iotests/024            |  4 +-
 tests/qemu-iotests/025            |  4 +-
 tests/qemu-iotests/026            |  4 +-
 tests/qemu-iotests/027            |  4 +-
 tests/qemu-iotests/028            |  4 +-
 tests/qemu-iotests/029            |  4 +-
 tests/qemu-iotests/031            |  4 +-
 tests/qemu-iotests/032            |  4 +-
 tests/qemu-iotests/033            |  4 +-
 tests/qemu-iotests/034            |  4 +-
 tests/qemu-iotests/035            |  4 +-
 tests/qemu-iotests/036            |  4 +-
 tests/qemu-iotests/037            |  4 +-
 tests/qemu-iotests/038            |  4 +-
 tests/qemu-iotests/039            |  4 +-
 tests/qemu-iotests/042            |  4 +-
 tests/qemu-iotests/043            |  4 +-
 tests/qemu-iotests/046            |  4 +-
 tests/qemu-iotests/047            |  4 +-
 tests/qemu-iotests/048            |  2 +-
 tests/qemu-iotests/049            |  4 +-
 tests/qemu-iotests/050            |  4 +-
 tests/qemu-iotests/051            |  4 +-
 tests/qemu-iotests/052            |  4 +-
 tests/qemu-iotests/053            |  4 +-
 tests/qemu-iotests/054            |  4 +-
 tests/qemu-iotests/058            |  4 +-
 tests/qemu-iotests/059            |  4 +-
 tests/qemu-iotests/061            |  4 +-
 tests/qemu-iotests/062            |  4 +-
 tests/qemu-iotests/063            |  4 +-
 tests/qemu-iotests/064            |  4 +-
 tests/qemu-iotests/067            |  4 +-
 tests/qemu-iotests/070            |  4 +-
 tests/qemu-iotests/073            |  4 +-
 tests/qemu-iotests/074            |  2 +-
 tests/qemu-iotests/075            |  4 +-
 tests/qemu-iotests/076            |  4 +-
 tests/qemu-iotests/077            |  4 +-
 tests/qemu-iotests/078            |  4 +-
 tests/qemu-iotests/079            |  4 +-
 tests/qemu-iotests/080            |  4 +-
 tests/qemu-iotests/081            |  4 +-
 tests/qemu-iotests/082            |  4 +-
 tests/qemu-iotests/083            |  4 +-
 tests/qemu-iotests/084            |  4 +-
 tests/qemu-iotests/085            |  4 +-
 tests/qemu-iotests/086            |  4 +-
 tests/qemu-iotests/087            |  4 +-
 tests/qemu-iotests/088            |  4 +-
 tests/qemu-iotests/091            |  4 +-
 tests/qemu-iotests/092            |  4 +-
 tests/qemu-iotests/095            |  4 +-
 tests/qemu-iotests/101            |  4 +-
 tests/qemu-iotests/104            |  4 +-
 tests/qemu-iotests/105            |  4 +-
 tests/qemu-iotests/116            |  4 +-
 tests/qemu-iotests/128            |  4 +-
 tests/qemu-iotests/131            |  4 +-
 tests/qemu-iotests/133            |  4 +-
 tests/qemu-iotests/134            |  4 +-
 tests/qemu-iotests/135            |  4 +-
 tests/qemu-iotests/142            |  4 +-
 tests/qemu-iotests/144            |  4 +-
 tests/qemu-iotests/145            |  4 +-
 tests/qemu-iotests/146            |  4 +-
 tests/qemu-iotests/154            |  4 +-
 tests/qemu-iotests/158            |  4 +-
 tests/qemu-iotests/171            |  4 +-
 tests/qemu-iotests/172            |  4 +-
 tests/qemu-iotests/173            |  4 +-
 tests/qemu-iotests/174            |  4 +-
 tests/qemu-iotests/175            |  4 +-
 tests/qemu-iotests/177            |  4 +-
 tests/qemu-iotests/178            |  4 +-
 tests/qemu-iotests/181            |  4 +-
 tests/qemu-iotests/183            |  4 +-
 tests/qemu-iotests/184            |  4 +-
 tests/qemu-iotests/185            |  4 +-
 tests/qemu-iotests/186            |  4 +-
 tests/qemu-iotests/187            |  4 +-
 tests/qemu-iotests/188            |  4 +-
 tests/qemu-iotests/189            |  4 +-
 tests/qemu-iotests/190            |  4 +-
 tests/qemu-iotests/191            |  4 +-
 tests/qemu-iotests/192            |  4 +-
 tests/qemu-iotests/195            |  4 +-
 tests/qemu-iotests/198            |  4 +-
 tests/qemu-iotests/200            |  4 +-
 tests/qemu-iotests/201            |  2 +-
 tests/qemu-iotests/204            |  4 +-
 tests/qemu-iotests/226            |  4 +-
 tests/qemu-iotests/231            |  4 +-
 tests/qemu-iotests/check          | 62 +++++++++++++++----------------
 tests/qemu-iotests/common.config  |  6 +--
 tests/qemu-iotests/common.pattern |  4 +-
 tests/qemu-iotests/common.rc      |  2 +-
 118 files changed, 265 insertions(+), 265 deletions(-)

diff --git a/tests/qemu-iotests/001 b/tests/qemu-iotests/001
index ffd14e2ce9..3fcea0e6d2 100755
--- a/tests/qemu-iotests/001
+++ b/tests/qemu-iotests/001
@@ -21,10 +21,10 @@
 # creator
 owner=hch@lst.de
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/002 b/tests/qemu-iotests/002
index d4f8e91b91..42976b8ad5 100755
--- a/tests/qemu-iotests/002
+++ b/tests/qemu-iotests/002
@@ -21,10 +21,10 @@
 # creator
 owner=hch@lst.de
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/003 b/tests/qemu-iotests/003
index 19889b9fcd..104c3a286a 100755
--- a/tests/qemu-iotests/003
+++ b/tests/qemu-iotests/003
@@ -21,10 +21,10 @@
 # creator
 owner=hch@lst.de
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/004 b/tests/qemu-iotests/004
index 6f2aa3d9a2..2c8942d4fc 100755
--- a/tests/qemu-iotests/004
+++ b/tests/qemu-iotests/004
@@ -21,10 +21,10 @@
 # creator
 owner=hch@lst.de
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
index 444737751f..2d26736e03 100755
--- a/tests/qemu-iotests/005
+++ b/tests/qemu-iotests/005
@@ -24,10 +24,10 @@
 # creator
 owner=hch@lst.de
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/007 b/tests/qemu-iotests/007
index fa543eeb7d..94343eba41 100755
--- a/tests/qemu-iotests/007
+++ b/tests/qemu-iotests/007
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
@@ -50,7 +50,7 @@ echo
 echo "creating image"
 _make_test_img 1M
 
-for i in `seq 1 10`; do
+for i in $(seq 1 10); do
     echo "savevm $i"
     $QEMU -nographic -hda "$TEST_IMG" -serial none -monitor stdio >/dev/null 2>&1 <<EOF
 savevm test-$i
diff --git a/tests/qemu-iotests/008 b/tests/qemu-iotests/008
index 8e89d74fe9..8f348389d2 100755
--- a/tests/qemu-iotests/008
+++ b/tests/qemu-iotests/008
@@ -21,10 +21,10 @@
 # creator
 owner=hch@lst.de
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/009 b/tests/qemu-iotests/009
index 16e4475ca4..4c169f2993 100755
--- a/tests/qemu-iotests/009
+++ b/tests/qemu-iotests/009
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/010 b/tests/qemu-iotests/010
index 151dac238d..437b7d74e6 100755
--- a/tests/qemu-iotests/010
+++ b/tests/qemu-iotests/010
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/011 b/tests/qemu-iotests/011
index f8d044ec85..1ecad4c359 100755
--- a/tests/qemu-iotests/011
+++ b/tests/qemu-iotests/011
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
@@ -51,7 +51,7 @@ _make_test_img $size
 
 echo
 echo "overlapping I/O"
-for i in `seq 1 10`; do
+for i in $(seq 1 10); do
     let mb=1024*1024
     let off1=$i*$mb
     let off2=$off1+512
diff --git a/tests/qemu-iotests/012 b/tests/qemu-iotests/012
index 01a770d59c..b708bb2f4d 100755
--- a/tests/qemu-iotests/012
+++ b/tests/qemu-iotests/012
@@ -23,10 +23,10 @@
 # creator
 owner=hch@lst.de
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/013 b/tests/qemu-iotests/013
index d013f87da9..aea104a2a6 100755
--- a/tests/qemu-iotests/013
+++ b/tests/qemu-iotests/013
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/014 b/tests/qemu-iotests/014
index 2ea79e8c8b..c03fbb0239 100755
--- a/tests/qemu-iotests/014
+++ b/tests/qemu-iotests/014
@@ -23,10 +23,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
@@ -59,7 +59,7 @@ for offset in $TEST_OFFSETS; do
 done
 
 # With snapshots
-for i in `seq 1 3`; do
+for i in $(seq 1 3); do
     $QEMU_IMG snapshot -c test$i "$TEST_IMG"
     for offset in $TEST_OFFSETS; do
         echo With snapshot test$i, offset $offset
diff --git a/tests/qemu-iotests/015 b/tests/qemu-iotests/015
index aaf9c3f415..7ff28b333f 100755
--- a/tests/qemu-iotests/015
+++ b/tests/qemu-iotests/015
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/017 b/tests/qemu-iotests/017
index 4f9302db42..a485590a60 100755
--- a/tests/qemu-iotests/017
+++ b/tests/qemu-iotests/017
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/018 b/tests/qemu-iotests/018
index 1d39d35c47..0ee5e93b39 100755
--- a/tests/qemu-iotests/018
+++ b/tests/qemu-iotests/018
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/019 b/tests/qemu-iotests/019
index 24a789a25c..b104dec9d6 100755
--- a/tests/qemu-iotests/019
+++ b/tests/qemu-iotests/019
@@ -23,10 +23,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index eac5080f83..5477968e72 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/021 b/tests/qemu-iotests/021
index 11e8ed7187..90c52b9c1e 100755
--- a/tests/qemu-iotests/021
+++ b/tests/qemu-iotests/021
@@ -21,10 +21,10 @@
 # creator
 owner=hch@lst.de
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/022 b/tests/qemu-iotests/022
index 2452a9f86a..f0e04cd58d 100755
--- a/tests/qemu-iotests/022
+++ b/tests/qemu-iotests/022
@@ -23,10 +23,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/023 b/tests/qemu-iotests/023
index 497ae1ed17..2e278c0e2d 100755
--- a/tests/qemu-iotests/023
+++ b/tests/qemu-iotests/023
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index 4071ed6093..78191d698e 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/025 b/tests/qemu-iotests/025
index 70dd5f10aa..86ed7292db 100755
--- a/tests/qemu-iotests/025
+++ b/tests/qemu-iotests/025
@@ -21,10 +21,10 @@
 # creator
 owner=stefanha@linux.vnet.ibm.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index 582d254195..aded2edf69 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/027 b/tests/qemu-iotests/027
index 08593da775..cd797433c5 100755
--- a/tests/qemu-iotests/027
+++ b/tests/qemu-iotests/027
@@ -21,10 +21,10 @@
 # creator
 owner=stefanha@linux.vnet.ibm.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index 97a8869251..fdeadd2f41 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -24,10 +24,10 @@
 # creator
 owner=stefanha@linux.vnet.ibm.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/029 b/tests/qemu-iotests/029
index 5cff6875bf..a9e6a80aaa 100755
--- a/tests/qemu-iotests/029
+++ b/tests/qemu-iotests/029
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/031 b/tests/qemu-iotests/031
index 1e08abc5ed..e36960456b 100755
--- a/tests/qemu-iotests/031
+++ b/tests/qemu-iotests/031
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/032 b/tests/qemu-iotests/032
index 24bcb52fc2..0a1ba06591 100755
--- a/tests/qemu-iotests/032
+++ b/tests/qemu-iotests/032
@@ -23,10 +23,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/033 b/tests/qemu-iotests/033
index ee8a1338bb..61b9d0c25d 100755
--- a/tests/qemu-iotests/033
+++ b/tests/qemu-iotests/033
@@ -21,10 +21,10 @@
 # creator
 owner=pbonzini@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/034 b/tests/qemu-iotests/034
index 1b28bdae63..8becaa8b50 100755
--- a/tests/qemu-iotests/034
+++ b/tests/qemu-iotests/034
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/035 b/tests/qemu-iotests/035
index efc38e4d49..830a7bb9d2 100755
--- a/tests/qemu-iotests/035
+++ b/tests/qemu-iotests/035
@@ -22,10 +22,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
index ce638d6076..8d4438f0dc 100755
--- a/tests/qemu-iotests/036
+++ b/tests/qemu-iotests/036
@@ -24,10 +24,10 @@
 # creator
 owner=stefanha@linux.vnet.ibm.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/037 b/tests/qemu-iotests/037
index c476b823d2..17bb252e27 100755
--- a/tests/qemu-iotests/037
+++ b/tests/qemu-iotests/037
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/038 b/tests/qemu-iotests/038
index d99a1501d7..29ca8f049b 100755
--- a/tests/qemu-iotests/038
+++ b/tests/qemu-iotests/038
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index 1f48339692..cdab2078bb 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -24,10 +24,10 @@
 # creator
 owner=stefanha@linux.vnet.ibm.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/042 b/tests/qemu-iotests/042
index a53e7cb757..3f2309a69e 100755
--- a/tests/qemu-iotests/042
+++ b/tests/qemu-iotests/042
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/043 b/tests/qemu-iotests/043
index 1c6c22d92a..204a710b55 100755
--- a/tests/qemu-iotests/043
+++ b/tests/qemu-iotests/043
@@ -21,10 +21,10 @@
 # creator
 owner=stefanha@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index f2ebecf24c..a9de7f6603 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/047 b/tests/qemu-iotests/047
index 1b8f3d4a64..5599faf006 100755
--- a/tests/qemu-iotests/047
+++ b/tests/qemu-iotests/047
@@ -22,10 +22,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/048 b/tests/qemu-iotests/048
index 9ed04a068d..5830f41ca7 100755
--- a/tests/qemu-iotests/048
+++ b/tests/qemu-iotests/048
@@ -22,7 +22,7 @@
 # creator
 owner=mrezanin@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
 status=1        # failure is the default!
diff --git a/tests/qemu-iotests/049 b/tests/qemu-iotests/049
index df35b6d21e..7797a166da 100755
--- a/tests/qemu-iotests/049
+++ b/tests/qemu-iotests/049
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/050 b/tests/qemu-iotests/050
index 03b4a5d620..80197fe4aa 100755
--- a/tests/qemu-iotests/050
+++ b/tests/qemu-iotests/050
@@ -21,10 +21,10 @@
 # creator
 owner=pbonzini@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 25d3b2d478..a58f612363 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/052 b/tests/qemu-iotests/052
index 842eaced3b..afc4d0d314 100755
--- a/tests/qemu-iotests/052
+++ b/tests/qemu-iotests/052
@@ -21,10 +21,10 @@
 # creator
 owner=stefanha@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/053 b/tests/qemu-iotests/053
index 2a04f5f551..3786d822a0 100755
--- a/tests/qemu-iotests/053
+++ b/tests/qemu-iotests/053
@@ -21,10 +21,10 @@
 # creator
 owner=stefanha@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/054 b/tests/qemu-iotests/054
index bf47ef9fac..b97dff2cd4 100755
--- a/tests/qemu-iotests/054
+++ b/tests/qemu-iotests/054
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/058 b/tests/qemu-iotests/058
index 5eb8784669..7ac1629191 100755
--- a/tests/qemu-iotests/058
+++ b/tests/qemu-iotests/058
@@ -23,10 +23,10 @@
 # creator
 owner=xiawenc@linux.vnet.ibm.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 nbd_unix_socket=$TEST_DIR/test_qemu_nbd_socket
diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index 530bbbe6ce..8d5901b5e7 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -21,10 +21,10 @@
 # creator
 owner=famz@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index 911b6f2894..30a5efbedb 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -21,10 +21,10 @@
 # creator
 owner=mreitz@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/062 b/tests/qemu-iotests/062
index 051fb9f410..7517be97e4 100755
--- a/tests/qemu-iotests/062
+++ b/tests/qemu-iotests/062
@@ -22,10 +22,10 @@
 # creator
 owner=mreitz@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/063 b/tests/qemu-iotests/063
index adc037c1f5..5aee1271dd 100755
--- a/tests/qemu-iotests/063
+++ b/tests/qemu-iotests/063
@@ -22,10 +22,10 @@
 # creator
 owner=alex@alex.org.uk
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/064 b/tests/qemu-iotests/064
index 5792fbbc92..e2057641c8 100755
--- a/tests/qemu-iotests/064
+++ b/tests/qemu-iotests/064
@@ -21,10 +21,10 @@
 # creator
 owner=jcody@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/067 b/tests/qemu-iotests/067
index fe259f6165..4c27777653 100755
--- a/tests/qemu-iotests/067
+++ b/tests/qemu-iotests/067
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/070 b/tests/qemu-iotests/070
index 8d08d74ff9..43c68a58f0 100755
--- a/tests/qemu-iotests/070
+++ b/tests/qemu-iotests/070
@@ -22,10 +22,10 @@
 # creator
 owner=jcody@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/073 b/tests/qemu-iotests/073
index 40f85b18b9..44740815bc 100755
--- a/tests/qemu-iotests/073
+++ b/tests/qemu-iotests/073
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/074 b/tests/qemu-iotests/074
index b17866bd34..31b4dc522e 100755
--- a/tests/qemu-iotests/074
+++ b/tests/qemu-iotests/074
@@ -22,7 +22,7 @@
 # creator
 owner=famz@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
 status=1        # failure is the default!
diff --git a/tests/qemu-iotests/075 b/tests/qemu-iotests/075
index caa30d4743..db921a347c 100755
--- a/tests/qemu-iotests/075
+++ b/tests/qemu-iotests/075
@@ -21,10 +21,10 @@
 # creator
 owner=stefanha@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/076 b/tests/qemu-iotests/076
index ef9e6a4ff3..f8fe58af0e 100755
--- a/tests/qemu-iotests/076
+++ b/tests/qemu-iotests/076
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/077 b/tests/qemu-iotests/077
index b3c6fb1370..57ccb05c33 100755
--- a/tests/qemu-iotests/077
+++ b/tests/qemu-iotests/077
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/078 b/tests/qemu-iotests/078
index a106c26f6b..32c14e0ca7 100755
--- a/tests/qemu-iotests/078
+++ b/tests/qemu-iotests/078
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
index b2e3f7426a..668a912d77 100755
--- a/tests/qemu-iotests/079
+++ b/tests/qemu-iotests/079
@@ -21,10 +21,10 @@
 # creator
 owner=hutao@cn.fujitsu.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index f0eb42f390..d251af9371 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/081 b/tests/qemu-iotests/081
index da3fb0984b..b31c6ff5a0 100755
--- a/tests/qemu-iotests/081
+++ b/tests/qemu-iotests/081
@@ -21,10 +21,10 @@
 # creator
 owner=benoit@irqsave.net
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index 3e605d52d1..f46ce169b5 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/083 b/tests/qemu-iotests/083
index 3c1adbf0fb..a3bbe263d2 100755
--- a/tests/qemu-iotests/083
+++ b/tests/qemu-iotests/083
@@ -21,10 +21,10 @@
 # creator
 owner=stefanha@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/084 b/tests/qemu-iotests/084
index 04f2aa9d7d..82be8650dc 100755
--- a/tests/qemu-iotests/084
+++ b/tests/qemu-iotests/084
@@ -22,10 +22,10 @@
 # creator
 owner=jcody@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index 5c7668cf9b..fb1f950512 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -26,10 +26,10 @@
 # creator
 owner=jcody@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 snapshot_virt0="snapshot-v0.qcow2"
diff --git a/tests/qemu-iotests/086 b/tests/qemu-iotests/086
index 84e3835071..b9faefe20a 100755
--- a/tests/qemu-iotests/086
+++ b/tests/qemu-iotests/086
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index 2561a14456..9edef9d1c2 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/088 b/tests/qemu-iotests/088
index b8076f216b..448717d22a 100755
--- a/tests/qemu-iotests/088
+++ b/tests/qemu-iotests/088
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index 10ac4a8d73..6e95c761c1 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -23,10 +23,10 @@
 # creator
 owner=jcody@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1    # failure is the default!
 
 MIG_FIFO="${TEST_DIR}/migrate"
diff --git a/tests/qemu-iotests/092 b/tests/qemu-iotests/092
index 5bbdd071d8..ac8e79268b 100755
--- a/tests/qemu-iotests/092
+++ b/tests/qemu-iotests/092
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/095 b/tests/qemu-iotests/095
index 72ecc22e1b..bd6485fc09 100755
--- a/tests/qemu-iotests/095
+++ b/tests/qemu-iotests/095
@@ -24,10 +24,10 @@
 # creator
 owner=jcody@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/101 b/tests/qemu-iotests/101
index ea53f8b8d3..2d2fd9209d 100755
--- a/tests/qemu-iotests/101
+++ b/tests/qemu-iotests/101
@@ -21,10 +21,10 @@
 # creator
 owner=stefanha@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/104 b/tests/qemu-iotests/104
index 726d467052..ebe2c218da 100755
--- a/tests/qemu-iotests/104
+++ b/tests/qemu-iotests/104
@@ -21,10 +21,10 @@
 # creator
 owner=hutao@cn.fujitsu.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 trap "exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/105 b/tests/qemu-iotests/105
index 3db4ce3cf3..59dad1d972 100755
--- a/tests/qemu-iotests/105
+++ b/tests/qemu-iotests/105
@@ -21,10 +21,10 @@
 # creator
 owner=famz@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/116 b/tests/qemu-iotests/116
index df0172fed3..bda3fa8db4 100755
--- a/tests/qemu-iotests/116
+++ b/tests/qemu-iotests/116
@@ -24,10 +24,10 @@
 # creator
 owner=stefanha@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/128 b/tests/qemu-iotests/128
index 0976a18133..1f33ea5a3c 100755
--- a/tests/qemu-iotests/128
+++ b/tests/qemu-iotests/128
@@ -21,10 +21,10 @@
 # creator
 owner=stefanha@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 devname="eiodev$$"
diff --git a/tests/qemu-iotests/131 b/tests/qemu-iotests/131
index 94a9ae76af..e72ba62c3b 100755
--- a/tests/qemu-iotests/131
+++ b/tests/qemu-iotests/131
@@ -21,10 +21,10 @@
 # creator
 owner=den@openvz.org
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
index af6b3e1dd4..a23cc2ee51 100755
--- a/tests/qemu-iotests/133
+++ b/tests/qemu-iotests/133
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index 99144151b8..0e0f13cab4 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -21,10 +21,10 @@
 # creator
 owner=berrange@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/135 b/tests/qemu-iotests/135
index ce608312f6..be0306a55d 100755
--- a/tests/qemu-iotests/135
+++ b/tests/qemu-iotests/135
@@ -21,10 +21,10 @@
 # creator
 owner=jcody@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/142 b/tests/qemu-iotests/142
index 1639c83985..e61d2bc66b 100755
--- a/tests/qemu-iotests/142
+++ b/tests/qemu-iotests/142
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/144 b/tests/qemu-iotests/144
index 4b915718cd..60da5a9030 100755
--- a/tests/qemu-iotests/144
+++ b/tests/qemu-iotests/144
@@ -23,10 +23,10 @@
 # creator
 owner=jcody@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 TMP_SNAP1=${TEST_DIR}/tmp.qcow2
diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
index c371b3c46a..8da70edfc5 100755
--- a/tests/qemu-iotests/145
+++ b/tests/qemu-iotests/145
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/146 b/tests/qemu-iotests/146
index 043711be68..1d6aed3824 100755
--- a/tests/qemu-iotests/146
+++ b/tests/qemu-iotests/146
@@ -21,10 +21,10 @@
 # creator
 owner=jcody@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1    # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/154 b/tests/qemu-iotests/154
index fde03b0dc8..0fe6ea2b8d 100755
--- a/tests/qemu-iotests/154
+++ b/tests/qemu-iotests/154
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index 24ac600a4a..3e99201dc7 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -21,10 +21,10 @@
 # creator
 owner=berrange@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/171 b/tests/qemu-iotests/171
index bcfaaf1be2..b4bc4cb546 100755
--- a/tests/qemu-iotests/171
+++ b/tests/qemu-iotests/171
@@ -22,10 +22,10 @@
 # creator
 owner=tgolembi@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
index 02c5f79bab..f36e9b92ab 100755
--- a/tests/qemu-iotests/172
+++ b/tests/qemu-iotests/172
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/173 b/tests/qemu-iotests/173
index bdaa092979..05e6870cc7 100755
--- a/tests/qemu-iotests/173
+++ b/tests/qemu-iotests/173
@@ -21,10 +21,10 @@
 # creator
 owner=jcody@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1    # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/174 b/tests/qemu-iotests/174
index 552879db32..8e21a2ed33 100755
--- a/tests/qemu-iotests/174
+++ b/tests/qemu-iotests/174
@@ -21,10 +21,10 @@
 # creator
 owner=nirsof@gmail.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index ca56e827cd..a7a9a97b91 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -21,10 +21,10 @@
 # creator
 owner=nirsof@gmail.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/177 b/tests/qemu-iotests/177
index 396986da89..934bbda624 100755
--- a/tests/qemu-iotests/177
+++ b/tests/qemu-iotests/177
@@ -21,10 +21,10 @@
 # creator
 owner=eblake@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
index 6af52c653a..bde1295c5f 100755
--- a/tests/qemu-iotests/178
+++ b/tests/qemu-iotests/178
@@ -21,10 +21,10 @@
 # creator
 owner=stefanha@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1    # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index e02979378d..02193034a9 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 MIG_SOCKET="${TEST_DIR}/migrate"
diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index c49e1ad6ef..5d5faae278 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1 # failure is the default!
 
 MIG_SOCKET="${TEST_DIR}/migrate"
diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
index 2b68284d58..e6e35c9467 100755
--- a/tests/qemu-iotests/184
+++ b/tests/qemu-iotests/184
@@ -21,10 +21,10 @@
 # creator
 owner="Manos Pitsidianakis"
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 trap "exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index 7dcfdeac60..8fde877dd0 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1 # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index 0aa4395a57..f2c882b96a 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/187 b/tests/qemu-iotests/187
index 7bb783363c..cc78669965 100755
--- a/tests/qemu-iotests/187
+++ b/tests/qemu-iotests/187
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/188 b/tests/qemu-iotests/188
index 83ed03e33e..c2e3004688 100755
--- a/tests/qemu-iotests/188
+++ b/tests/qemu-iotests/188
@@ -21,10 +21,10 @@
 # creator
 owner=berrange@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/189 b/tests/qemu-iotests/189
index e695475722..09277e69b6 100755
--- a/tests/qemu-iotests/189
+++ b/tests/qemu-iotests/189
@@ -21,10 +21,10 @@
 # creator
 owner=berrange@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/190 b/tests/qemu-iotests/190
index 8f808fef5d..98f1fb8840 100755
--- a/tests/qemu-iotests/190
+++ b/tests/qemu-iotests/190
@@ -21,10 +21,10 @@
 # creator
 owner=eblake@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1    # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index d6860e72f7..d6a40c9d63 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1 # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
index 595f0d786a..0acdabc7e6 100755
--- a/tests/qemu-iotests/192
+++ b/tests/qemu-iotests/192
@@ -22,10 +22,10 @@
 # creator
 owner=famz@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/195 b/tests/qemu-iotests/195
index e7a403ded2..b4d6fbe5de 100755
--- a/tests/qemu-iotests/195
+++ b/tests/qemu-iotests/195
@@ -21,10 +21,10 @@
 # creator
 owner=kwolf@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1 # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
index 54eaaf5153..c0e5c02340 100755
--- a/tests/qemu-iotests/198
+++ b/tests/qemu-iotests/198
@@ -21,10 +21,10 @@
 # creator
 owner=berrange@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
index ddbdedc476..acf0fa3eaf 100755
--- a/tests/qemu-iotests/200
+++ b/tests/qemu-iotests/200
@@ -23,10 +23,10 @@
 # creator
 owner=jcody@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1    # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/201 b/tests/qemu-iotests/201
index c1a1e00077..c418ff4024 100755
--- a/tests/qemu-iotests/201
+++ b/tests/qemu-iotests/201
@@ -19,7 +19,7 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
 status=1	# failure is the default!
diff --git a/tests/qemu-iotests/204 b/tests/qemu-iotests/204
index feb69d2ada..14be73bb76 100755
--- a/tests/qemu-iotests/204
+++ b/tests/qemu-iotests/204
@@ -21,10 +21,10 @@
 # creator
 owner=eblake@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/226 b/tests/qemu-iotests/226
index 8ec3e612dd..2a26ad0e38 100755
--- a/tests/qemu-iotests/226
+++ b/tests/qemu-iotests/226
@@ -22,10 +22,10 @@
 # creator
 owner=jsnow@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1    # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/231 b/tests/qemu-iotests/231
index 3e283708b4..7edc0cfee6 100755
--- a/tests/qemu-iotests/231
+++ b/tests/qemu-iotests/231
@@ -23,10 +23,10 @@
 # creator
 owner=jcody@redhat.com
 
-seq=`basename $0`
+seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$(pwd)
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index aa94c6c7ea..8d9eff972a 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -80,17 +80,17 @@ _full_imgfmt_details()
 
 _full_platform_details()
 {
-    os=`uname -s`
-    host=`hostname -s`
-    kernel=`uname -r`
-    platform=`uname -m`
+    os=$(uname -s)
+    host=$(hostname -s)
+    kernel=$(uname -r)
+    platform=$(uname -m)
     echo "$os/$platform $host $kernel"
 }
 
 # $1 = prog to look for
 set_prog_path()
 {
-    p=`command -v $1 2> /dev/null`
+    p=$(command -v $1 2> /dev/null)
     if [ -n "$p" -a -x "$p" ]; then
         type -p "$p"
     else
@@ -99,7 +99,7 @@ set_prog_path()
 }
 
 if [ -z "$TEST_DIR" ]; then
-        TEST_DIR=`pwd`/scratch
+        TEST_DIR=$(pwd)/scratch
 fi
 
 if [ ! -e "$TEST_DIR" ]; then
@@ -147,9 +147,9 @@ do
     if $group
     then
         # arg after -g
-        group_list=`sed -n <"$source_iotests/group" -e 's/$/ /' -e "/^[0-9][0-9][0-9].* $r /"'{
+        group_list=$(sed -n <"$source_iotests/group" -e 's/$/ /' -e "/^[0-9][0-9][0-9].* $r /"'{
 s/ .*//p
-}'`
+}')
         if [ -z "$group_list" ]
         then
             echo "Group \"$r\" is empty or not defined?"
@@ -173,9 +173,9 @@ s/ .*//p
         # arg after -x
         # Populate $tmp.list with all tests
         awk '/^[0-9]{3,}/ {print $1}' "${source_iotests}/group" > $tmp.list 2>/dev/null
-        group_list=`sed -n <"$source_iotests/group" -e 's/$/ /' -e "/^[0-9][0-9][0-9].* $r /"'{
+        group_list=$(sed -n <"$source_iotests/group" -e 's/$/ /' -e "/^[0-9][0-9][0-9].* $r /"'{
 s/ .*//p
-}'`
+}')
         if [ -z "$group_list" ]
         then
             echo "Group \"$r\" is empty or not defined?"
@@ -193,7 +193,7 @@ s/ .*//p
                 rm -f $tmp.sed
             fi
             echo "/^$t\$/d" >>$tmp.sed
-            numsed=`expr $numsed + 1`
+            numsed=$(expr $numsed + 1)
         done
         sed -f $tmp.sed <$tmp.list >$tmp.tmp
         mv $tmp.tmp $tmp.list
@@ -433,12 +433,12 @@ testlist options
             ;;
 
         [0-9]*-[0-9]*)
-            eval `echo $r | sed -e 's/^/start=/' -e 's/-/ end=/'`
+            eval $(echo $r | sed -e 's/^/start=/' -e 's/-/ end=/')
             ;;
 
         [0-9]*-)
-            eval `echo $r | sed -e 's/^/start=/' -e 's/-//'`
-            end=`echo [0-9][0-9][0-9] [0-9][0-9][0-9][0-9] | sed -e 's/\[0-9]//g' -e 's/  *$//' -e 's/.* //'`
+            eval $(echo $r | sed -e 's/^/start=/' -e 's/-//')
+            end=$(echo [0-9][0-9][0-9] [0-9][0-9][0-9][0-9] | sed -e 's/\[0-9]//g' -e 's/  *$//' -e 's/.* //')
             if [ -z "$end" ]
             then
                 echo "No tests in range \"$r\"?"
@@ -455,8 +455,8 @@ testlist options
     esac
 
     # get rid of leading 0s as can be interpreted as octal
-    start=`echo $start | sed 's/^0*//'`
-    end=`echo $end | sed 's/^0*//'`
+    start=$(echo $start | sed 's/^0*//')
+    end=$(echo $end | sed 's/^0*//')
 
     if $xpand
     then
@@ -531,7 +531,7 @@ fi
 # should be sort -n, but this did not work for Linux when this
 # was ported from IRIX
 #
-list=`sort $tmp.list`
+list=$(sort $tmp.list)
 rm -f $tmp.list $tmp.tmp $tmp.sed
 
 if [ -z "$QEMU_PROG" ]
@@ -590,7 +590,7 @@ fi
 export QEMU_NBD_PROG="$(type -p "$QEMU_NBD_PROG")"
 
 if [ -z "$QEMU_VXHS_PROG" ]; then
-  export QEMU_VXHS_PROG="`set_prog_path qnio_server`"
+    export QEMU_VXHS_PROG="$(set_prog_path qnio_server)"
 fi
 
 if [ -x "$build_iotests/socket_scm_helper" ]
@@ -616,7 +616,7 @@ _wallclock()
 
 _timestamp()
 {
-    now=`date "+%T"`
+    now=$(date "+%T")
     printf %s " [$now]"
 }
 
@@ -642,9 +642,9 @@ END        { if (NR > 0) {
 
         if [ -f $tmp.expunged ]
         then
-            notrun=`wc -l <$tmp.expunged | sed -e 's/  *//g'`
-            try=`expr $try - $notrun`
-            list=`echo "$list" | sed -f $tmp.expunged`
+            notrun=$(wc -l <$tmp.expunged | sed -e 's/  *//g')
+            try=$(expr $try - $notrun)
+            list=$(echo "$list" | sed -f $tmp.expunged)
         fi
 
         echo "" >>check.log
@@ -682,8 +682,8 @@ trap "_wrapup; exit \$status" 0 1 2 3 15
 
 [ -f $TIMESTAMP_FILE ] || touch $TIMESTAMP_FILE
 
-FULL_IMGFMT_DETAILS=`_full_imgfmt_details`
-FULL_HOST_DETAILS=`_full_platform_details`
+FULL_IMGFMT_DETAILS=$(_full_imgfmt_details)
+FULL_HOST_DETAILS=$(_full_platform_details)
 
 cat <<EOF
 QEMU          -- "$QEMU_PROG" $QEMU_OPTIONS
@@ -729,7 +729,7 @@ do
         # really going to try and run this one
         #
         rm -f $seq.out.bad
-        lasttime=`sed -n -e "/^$seq /s/.* //p" <$TIMESTAMP_FILE`
+        lasttime=$(sed -n -e "/^$seq /s/.* //p" <$TIMESTAMP_FILE)
         if [ "X$lasttime" != X ]; then
                 printf %s " ${lasttime}s ..."
         else
@@ -737,7 +737,7 @@ do
         fi
         rm -f core $seq.notrun
 
-        start=`_wallclock`
+        start=$(_wallclock)
         $timestamp && printf %s "        [$(date "+%T")]"
 
         if [ "$(head -n 1 "$source_iotests/$seq")" == "#!/usr/bin/env python" ]; then
@@ -757,7 +757,7 @@ do
         fi
         sts=$?
         $timestamp && _timestamp
-        stop=`_wallclock`
+        stop=$(_wallclock)
 
         if [ -f core ]
         then
@@ -806,7 +806,7 @@ do
                     then
                         :
                     else
-                        echo "$seq `expr $stop - $start`" >>$tmp.time
+                        echo "$seq $(expr $stop - $start)" >>$tmp.time
                     fi
                 else
                     echo " - output mismatch (see $seq.out.bad)"
@@ -824,14 +824,14 @@ do
     if $err
     then
         bad="$bad $seq"
-        n_bad=`expr $n_bad + 1`
+        n_bad=$(expr $n_bad + 1)
         quick=false
     fi
-    [ -f $seq.notrun ] || try=`expr $try + 1`
+    [ -f $seq.notrun ] || try=$(expr $try + 1)
 
     seq="after_$seq"
 done
 
 interrupt=false
-status=`expr $n_bad`
+status=$(expr $n_bad)
 exit
diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common.config
index 102aa6878a..b4e08bd8ca 100644
--- a/tests/qemu-iotests/common.config
+++ b/tests/qemu-iotests/common.config
@@ -21,11 +21,11 @@ export LANG=C
 
 PATH=".:$PATH"
 
-HOSTOS=`uname -s`
-arch=`uname -m`
+HOSTOS=$(uname -s)
+arch=$(uname -m)
 [[ "$arch" =~ "ppc64" ]] && qemu_arch=ppc64 || qemu_arch="$arch"
 
-export PWD=`pwd`
+export PWD=$(pwd)
 
 # make sure we have a standard umask
 umask 022
diff --git a/tests/qemu-iotests/common.pattern b/tests/qemu-iotests/common.pattern
index 34f4a8dc9b..e30fe6a069 100644
--- a/tests/qemu-iotests/common.pattern
+++ b/tests/qemu-iotests/common.pattern
@@ -22,7 +22,7 @@ function do_is_allocated() {
     local step=$3
     local count=$4
 
-    for i in `seq 1 $count`; do
+    for i in $(seq 1 $count); do
         echo alloc $(( start + (i - 1) * step )) $size
     done
 }
@@ -40,7 +40,7 @@ function do_io() {
     local pattern=$6
 
     echo === IO: pattern $pattern >&2
-    for i in `seq 1 $count`; do
+    for i in $(seq 1 $count); do
         echo $op -P $pattern $(( start + (i - 1) * step )) $size
     done
 }
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 44bee16a5e..41d91be54a 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -160,7 +160,7 @@ fi
 ORIG_TEST_IMG="$TEST_IMG"
 
 if [ -z "$TEST_DIR" ]; then
-        TEST_DIR=`pwd`/scratch
+        TEST_DIR=$(pwd)/scratch
 fi
 
 QEMU_TEST_DIR="${TEST_DIR}"
-- 
2.17.1
