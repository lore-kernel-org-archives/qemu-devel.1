Received: from eggs.gnu.org ([2001:4830:134:3::10]:39790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gFFfc-00056C-PA
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gFFfY-00052X-DK
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:41:44 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:55547)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gFFfW-0004mU-JM
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:41:40 -0400
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Wed, 24 Oct 2018 17:40:49 +0800
Message-Id: <20181024094051.4470-2-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181024094051.4470-1-maozhongyi@cmss.chinamobile.com>
References: <20181024094051.4470-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH v2 1/3] qemu-iotests: convert `pwd` and $(pwd)
 to $PWD
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

POSIX requires $PWD to be reliable, and we expect all
shells used by qemu scripts to be relatively close to
POSIX.  Thus, it is smarter to avoid forking the pwd
executable for something that is already available in
the environment.

So replac it with the following:

sed -i 's/`pwd`/$PWD/g' $(git grep -l "\`pwd\`")
sed -i 's/$(pwd)/$PWD/g' $(git grep  -l "\$(pwd)")

The remaining small parts are manually modified.

Cc: kwolf@redhat.com 
Cc: mreitz@redhat.com
Cc: eblake@redhat.com

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
---
 configure                        | 2 +-
 tests/check-block.sh             | 6 +++---
 tests/qemu-iotests/001           | 2 +-
 tests/qemu-iotests/002           | 2 +-
 tests/qemu-iotests/003           | 2 +-
 tests/qemu-iotests/004           | 2 +-
 tests/qemu-iotests/005           | 2 +-
 tests/qemu-iotests/007           | 2 +-
 tests/qemu-iotests/008           | 2 +-
 tests/qemu-iotests/009           | 2 +-
 tests/qemu-iotests/010           | 2 +-
 tests/qemu-iotests/011           | 2 +-
 tests/qemu-iotests/012           | 2 +-
 tests/qemu-iotests/013           | 2 +-
 tests/qemu-iotests/014           | 2 +-
 tests/qemu-iotests/015           | 2 +-
 tests/qemu-iotests/017           | 2 +-
 tests/qemu-iotests/018           | 2 +-
 tests/qemu-iotests/019           | 2 +-
 tests/qemu-iotests/020           | 2 +-
 tests/qemu-iotests/021           | 2 +-
 tests/qemu-iotests/022           | 2 +-
 tests/qemu-iotests/023           | 2 +-
 tests/qemu-iotests/024           | 2 +-
 tests/qemu-iotests/025           | 2 +-
 tests/qemu-iotests/026           | 2 +-
 tests/qemu-iotests/027           | 2 +-
 tests/qemu-iotests/028           | 2 +-
 tests/qemu-iotests/029           | 2 +-
 tests/qemu-iotests/031           | 2 +-
 tests/qemu-iotests/032           | 2 +-
 tests/qemu-iotests/033           | 2 +-
 tests/qemu-iotests/034           | 2 +-
 tests/qemu-iotests/035           | 2 +-
 tests/qemu-iotests/036           | 2 +-
 tests/qemu-iotests/037           | 2 +-
 tests/qemu-iotests/038           | 2 +-
 tests/qemu-iotests/039           | 2 +-
 tests/qemu-iotests/042           | 2 +-
 tests/qemu-iotests/043           | 2 +-
 tests/qemu-iotests/046           | 2 +-
 tests/qemu-iotests/047           | 2 +-
 tests/qemu-iotests/049           | 2 +-
 tests/qemu-iotests/050           | 2 +-
 tests/qemu-iotests/051           | 2 +-
 tests/qemu-iotests/052           | 2 +-
 tests/qemu-iotests/053           | 2 +-
 tests/qemu-iotests/054           | 2 +-
 tests/qemu-iotests/058           | 2 +-
 tests/qemu-iotests/059           | 2 +-
 tests/qemu-iotests/061           | 2 +-
 tests/qemu-iotests/062           | 2 +-
 tests/qemu-iotests/063           | 2 +-
 tests/qemu-iotests/064           | 2 +-
 tests/qemu-iotests/067           | 2 +-
 tests/qemu-iotests/070           | 2 +-
 tests/qemu-iotests/073           | 2 +-
 tests/qemu-iotests/075           | 2 +-
 tests/qemu-iotests/076           | 2 +-
 tests/qemu-iotests/077           | 2 +-
 tests/qemu-iotests/078           | 2 +-
 tests/qemu-iotests/079           | 2 +-
 tests/qemu-iotests/080           | 2 +-
 tests/qemu-iotests/081           | 2 +-
 tests/qemu-iotests/082           | 2 +-
 tests/qemu-iotests/083           | 2 +-
 tests/qemu-iotests/084           | 2 +-
 tests/qemu-iotests/085           | 2 +-
 tests/qemu-iotests/086           | 2 +-
 tests/qemu-iotests/087           | 2 +-
 tests/qemu-iotests/088           | 2 +-
 tests/qemu-iotests/091           | 2 +-
 tests/qemu-iotests/092           | 2 +-
 tests/qemu-iotests/095           | 2 +-
 tests/qemu-iotests/101           | 2 +-
 tests/qemu-iotests/104           | 2 +-
 tests/qemu-iotests/105           | 2 +-
 tests/qemu-iotests/116           | 2 +-
 tests/qemu-iotests/128           | 2 +-
 tests/qemu-iotests/131           | 2 +-
 tests/qemu-iotests/133           | 2 +-
 tests/qemu-iotests/134           | 2 +-
 tests/qemu-iotests/135           | 2 +-
 tests/qemu-iotests/142           | 2 +-
 tests/qemu-iotests/144           | 2 +-
 tests/qemu-iotests/145           | 2 +-
 tests/qemu-iotests/146           | 2 +-
 tests/qemu-iotests/154           | 2 +-
 tests/qemu-iotests/158           | 2 +-
 tests/qemu-iotests/171           | 2 +-
 tests/qemu-iotests/172           | 2 +-
 tests/qemu-iotests/173           | 2 +-
 tests/qemu-iotests/174           | 2 +-
 tests/qemu-iotests/175           | 2 +-
 tests/qemu-iotests/177           | 2 +-
 tests/qemu-iotests/178           | 2 +-
 tests/qemu-iotests/181           | 2 +-
 tests/qemu-iotests/183           | 2 +-
 tests/qemu-iotests/184           | 2 +-
 tests/qemu-iotests/185           | 2 +-
 tests/qemu-iotests/186           | 2 +-
 tests/qemu-iotests/187           | 2 +-
 tests/qemu-iotests/188           | 2 +-
 tests/qemu-iotests/189           | 2 +-
 tests/qemu-iotests/190           | 2 +-
 tests/qemu-iotests/191           | 2 +-
 tests/qemu-iotests/192           | 2 +-
 tests/qemu-iotests/195           | 2 +-
 tests/qemu-iotests/198           | 2 +-
 tests/qemu-iotests/200           | 2 +-
 tests/qemu-iotests/204           | 2 +-
 tests/qemu-iotests/226           | 2 +-
 tests/qemu-iotests/231           | 2 +-
 tests/qemu-iotests/check         | 2 +-
 tests/qemu-iotests/common.config | 2 +-
 tests/qemu-iotests/common.rc     | 2 +-
 116 files changed, 118 insertions(+), 118 deletions(-)

diff --git a/configure b/configure
index e39f63d01d..3a4f6e1ff0 100755
--- a/configure
+++ b/configure
@@ -868,7 +868,7 @@ Linux)
   vhost_crypto="yes"
   vhost_scsi="yes"
   vhost_vsock="yes"
-  QEMU_INCLUDES="-I\$(SRC_PATH)/linux-headers -I$(pwd)/linux-headers $QEMU_INCLUDES"
+  QEMU_INCLUDES="-I\$(SRC_PATH)/linux-headers -I$PWD/linux-headers $QEMU_INCLUDES"
   supported_os="yes"
 ;;
 esac
diff --git a/tests/check-block.sh b/tests/check-block.sh
index c3de3789c4..f3d12fd602 100755
--- a/tests/check-block.sh
+++ b/tests/check-block.sh
@@ -5,9 +5,9 @@ if [ "$#" -ne 0 ]; then
     FORMAT_LIST="$@"
 fi
 
-export QEMU_PROG="$(pwd)/x86_64-softmmu/qemu-system-x86_64"
-export QEMU_IMG_PROG="$(pwd)/qemu-img"
-export QEMU_IO_PROG="$(pwd)/qemu-io"
+export QEMU_PROG="$PWD/x86_64-softmmu/qemu-system-x86_64"
+export QEMU_IMG_PROG="$PWD/qemu-img"
+export QEMU_IO_PROG="$PWD/qemu-io"
 
 if [ ! -x $QEMU_PROG ]; then
     echo "'make check-block' requires qemu-system-x86_64"
diff --git a/tests/qemu-iotests/001 b/tests/qemu-iotests/001
index ffd14e2ce9..42a57e4e86 100755
--- a/tests/qemu-iotests/001
+++ b/tests/qemu-iotests/001
@@ -24,7 +24,7 @@ owner=hch@lst.de
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/002 b/tests/qemu-iotests/002
index d4f8e91b91..70799f8a9a 100755
--- a/tests/qemu-iotests/002
+++ b/tests/qemu-iotests/002
@@ -24,7 +24,7 @@ owner=hch@lst.de
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/003 b/tests/qemu-iotests/003
index 19889b9fcd..d5396e54a5 100755
--- a/tests/qemu-iotests/003
+++ b/tests/qemu-iotests/003
@@ -24,7 +24,7 @@ owner=hch@lst.de
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/004 b/tests/qemu-iotests/004
index 6f2aa3d9a2..9552cd31ea 100755
--- a/tests/qemu-iotests/004
+++ b/tests/qemu-iotests/004
@@ -24,7 +24,7 @@ owner=hch@lst.de
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
index 444737751f..1cf3d67b74 100755
--- a/tests/qemu-iotests/005
+++ b/tests/qemu-iotests/005
@@ -27,7 +27,7 @@ owner=hch@lst.de
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/007 b/tests/qemu-iotests/007
index fa543eeb7d..e4ebcdea54 100755
--- a/tests/qemu-iotests/007
+++ b/tests/qemu-iotests/007
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/008 b/tests/qemu-iotests/008
index 8e89d74fe9..62d9524045 100755
--- a/tests/qemu-iotests/008
+++ b/tests/qemu-iotests/008
@@ -24,7 +24,7 @@ owner=hch@lst.de
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/009 b/tests/qemu-iotests/009
index 16e4475ca4..fbcfe5cd17 100755
--- a/tests/qemu-iotests/009
+++ b/tests/qemu-iotests/009
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/010 b/tests/qemu-iotests/010
index 151dac238d..285e7bf960 100755
--- a/tests/qemu-iotests/010
+++ b/tests/qemu-iotests/010
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/011 b/tests/qemu-iotests/011
index f8d044ec85..4da1670083 100755
--- a/tests/qemu-iotests/011
+++ b/tests/qemu-iotests/011
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/012 b/tests/qemu-iotests/012
index 01a770d59c..a35bbd58e1 100755
--- a/tests/qemu-iotests/012
+++ b/tests/qemu-iotests/012
@@ -26,7 +26,7 @@ owner=hch@lst.de
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/013 b/tests/qemu-iotests/013
index d013f87da9..3a9668cad0 100755
--- a/tests/qemu-iotests/013
+++ b/tests/qemu-iotests/013
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/014 b/tests/qemu-iotests/014
index 2ea79e8c8b..1404d14eff 100755
--- a/tests/qemu-iotests/014
+++ b/tests/qemu-iotests/014
@@ -26,7 +26,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/015 b/tests/qemu-iotests/015
index aaf9c3f415..fd43f80503 100755
--- a/tests/qemu-iotests/015
+++ b/tests/qemu-iotests/015
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/017 b/tests/qemu-iotests/017
index 4f9302db42..a0de5ed878 100755
--- a/tests/qemu-iotests/017
+++ b/tests/qemu-iotests/017
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/018 b/tests/qemu-iotests/018
index 1d39d35c47..fab2fc1803 100755
--- a/tests/qemu-iotests/018
+++ b/tests/qemu-iotests/018
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/019 b/tests/qemu-iotests/019
index 24a789a25c..5697d109b6 100755
--- a/tests/qemu-iotests/019
+++ b/tests/qemu-iotests/019
@@ -26,7 +26,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index eac5080f83..7b066d19a3 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/021 b/tests/qemu-iotests/021
index 11e8ed7187..e568f38c69 100755
--- a/tests/qemu-iotests/021
+++ b/tests/qemu-iotests/021
@@ -24,7 +24,7 @@ owner=hch@lst.de
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/022 b/tests/qemu-iotests/022
index 2452a9f86a..a438a8862d 100755
--- a/tests/qemu-iotests/022
+++ b/tests/qemu-iotests/022
@@ -26,7 +26,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/023 b/tests/qemu-iotests/023
index 497ae1ed17..23b16a4d9b 100755
--- a/tests/qemu-iotests/023
+++ b/tests/qemu-iotests/023
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index 4071ed6093..a91200cd59 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/025 b/tests/qemu-iotests/025
index 70dd5f10aa..17f7d17673 100755
--- a/tests/qemu-iotests/025
+++ b/tests/qemu-iotests/025
@@ -24,7 +24,7 @@ owner=stefanha@linux.vnet.ibm.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index 582d254195..84d3bd509f 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/027 b/tests/qemu-iotests/027
index 08593da775..33539cc769 100755
--- a/tests/qemu-iotests/027
+++ b/tests/qemu-iotests/027
@@ -24,7 +24,7 @@ owner=stefanha@linux.vnet.ibm.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index 97a8869251..ad87aa0dae 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -27,7 +27,7 @@ owner=stefanha@linux.vnet.ibm.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/029 b/tests/qemu-iotests/029
index 5cff6875bf..fc430c78de 100755
--- a/tests/qemu-iotests/029
+++ b/tests/qemu-iotests/029
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/031 b/tests/qemu-iotests/031
index 1e08abc5ed..ab599add77 100755
--- a/tests/qemu-iotests/031
+++ b/tests/qemu-iotests/031
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/032 b/tests/qemu-iotests/032
index 24bcb52fc2..ce1dbaf086 100755
--- a/tests/qemu-iotests/032
+++ b/tests/qemu-iotests/032
@@ -26,7 +26,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/033 b/tests/qemu-iotests/033
index ee8a1338bb..9492f17e5f 100755
--- a/tests/qemu-iotests/033
+++ b/tests/qemu-iotests/033
@@ -24,7 +24,7 @@ owner=pbonzini@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/034 b/tests/qemu-iotests/034
index 1b28bdae63..f4ebad8edb 100755
--- a/tests/qemu-iotests/034
+++ b/tests/qemu-iotests/034
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/035 b/tests/qemu-iotests/035
index efc38e4d49..522e5e8245 100755
--- a/tests/qemu-iotests/035
+++ b/tests/qemu-iotests/035
@@ -25,7 +25,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
index ce638d6076..ecb556ef26 100755
--- a/tests/qemu-iotests/036
+++ b/tests/qemu-iotests/036
@@ -27,7 +27,7 @@ owner=stefanha@linux.vnet.ibm.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/037 b/tests/qemu-iotests/037
index c476b823d2..95a7e7731b 100755
--- a/tests/qemu-iotests/037
+++ b/tests/qemu-iotests/037
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/038 b/tests/qemu-iotests/038
index d99a1501d7..338123d5f2 100755
--- a/tests/qemu-iotests/038
+++ b/tests/qemu-iotests/038
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index 1f48339692..caf245def0 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -27,7 +27,7 @@ owner=stefanha@linux.vnet.ibm.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/042 b/tests/qemu-iotests/042
index a53e7cb757..e5ce618766 100755
--- a/tests/qemu-iotests/042
+++ b/tests/qemu-iotests/042
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/043 b/tests/qemu-iotests/043
index 1c6c22d92a..8bbb72695f 100755
--- a/tests/qemu-iotests/043
+++ b/tests/qemu-iotests/043
@@ -24,7 +24,7 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index f2ebecf24c..79de8064ec 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/047 b/tests/qemu-iotests/047
index 1b8f3d4a64..07e391d7ea 100755
--- a/tests/qemu-iotests/047
+++ b/tests/qemu-iotests/047
@@ -25,7 +25,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/049 b/tests/qemu-iotests/049
index df35b6d21e..a456d097d4 100755
--- a/tests/qemu-iotests/049
+++ b/tests/qemu-iotests/049
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/050 b/tests/qemu-iotests/050
index 03b4a5d620..294dffb88c 100755
--- a/tests/qemu-iotests/050
+++ b/tests/qemu-iotests/050
@@ -24,7 +24,7 @@ owner=pbonzini@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 25d3b2d478..69adc791df 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/052 b/tests/qemu-iotests/052
index 842eaced3b..aefff4bff5 100755
--- a/tests/qemu-iotests/052
+++ b/tests/qemu-iotests/052
@@ -24,7 +24,7 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/053 b/tests/qemu-iotests/053
index 2a04f5f551..f04b88bbc1 100755
--- a/tests/qemu-iotests/053
+++ b/tests/qemu-iotests/053
@@ -24,7 +24,7 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/054 b/tests/qemu-iotests/054
index bf47ef9fac..4e6361f0d9 100755
--- a/tests/qemu-iotests/054
+++ b/tests/qemu-iotests/054
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/058 b/tests/qemu-iotests/058
index 5eb8784669..1ba0cbee25 100755
--- a/tests/qemu-iotests/058
+++ b/tests/qemu-iotests/058
@@ -26,7 +26,7 @@ owner=xiawenc@linux.vnet.ibm.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 nbd_unix_socket=$TEST_DIR/test_qemu_nbd_socket
diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index 530bbbe6ce..2bfdb941f6 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -24,7 +24,7 @@ owner=famz@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index 911b6f2894..92c1889333 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -24,7 +24,7 @@ owner=mreitz@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/062 b/tests/qemu-iotests/062
index 051fb9f410..6d1638711c 100755
--- a/tests/qemu-iotests/062
+++ b/tests/qemu-iotests/062
@@ -25,7 +25,7 @@ owner=mreitz@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/063 b/tests/qemu-iotests/063
index adc037c1f5..6daf389a3d 100755
--- a/tests/qemu-iotests/063
+++ b/tests/qemu-iotests/063
@@ -25,7 +25,7 @@ owner=alex@alex.org.uk
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/064 b/tests/qemu-iotests/064
index 5792fbbc92..22d5678e3d 100755
--- a/tests/qemu-iotests/064
+++ b/tests/qemu-iotests/064
@@ -24,7 +24,7 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/067 b/tests/qemu-iotests/067
index fe259f6165..62dc3e820d 100755
--- a/tests/qemu-iotests/067
+++ b/tests/qemu-iotests/067
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/070 b/tests/qemu-iotests/070
index 8d08d74ff9..6fbb95a086 100755
--- a/tests/qemu-iotests/070
+++ b/tests/qemu-iotests/070
@@ -25,7 +25,7 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/073 b/tests/qemu-iotests/073
index 40f85b18b9..c572d9afcc 100755
--- a/tests/qemu-iotests/073
+++ b/tests/qemu-iotests/073
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/075 b/tests/qemu-iotests/075
index caa30d4743..df5f88a43c 100755
--- a/tests/qemu-iotests/075
+++ b/tests/qemu-iotests/075
@@ -24,7 +24,7 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/076 b/tests/qemu-iotests/076
index ef9e6a4ff3..35bce0b210 100755
--- a/tests/qemu-iotests/076
+++ b/tests/qemu-iotests/076
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/077 b/tests/qemu-iotests/077
index b3c6fb1370..8e6a9a598f 100755
--- a/tests/qemu-iotests/077
+++ b/tests/qemu-iotests/077
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/078 b/tests/qemu-iotests/078
index a106c26f6b..86b0e95897 100755
--- a/tests/qemu-iotests/078
+++ b/tests/qemu-iotests/078
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
index b2e3f7426a..da0e441d54 100755
--- a/tests/qemu-iotests/079
+++ b/tests/qemu-iotests/079
@@ -24,7 +24,7 @@ owner=hutao@cn.fujitsu.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index f0eb42f390..14f3d7f275 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/081 b/tests/qemu-iotests/081
index da3fb0984b..b30a7c4331 100755
--- a/tests/qemu-iotests/081
+++ b/tests/qemu-iotests/081
@@ -24,7 +24,7 @@ owner=benoit@irqsave.net
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index 3e605d52d1..e8008f2044 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/083 b/tests/qemu-iotests/083
index 3c1adbf0fb..a42a2e1819 100755
--- a/tests/qemu-iotests/083
+++ b/tests/qemu-iotests/083
@@ -24,7 +24,7 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/084 b/tests/qemu-iotests/084
index 04f2aa9d7d..559c8ed1ea 100755
--- a/tests/qemu-iotests/084
+++ b/tests/qemu-iotests/084
@@ -25,7 +25,7 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index 5c7668cf9b..0786b28503 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -29,7 +29,7 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 snapshot_virt0="snapshot-v0.qcow2"
diff --git a/tests/qemu-iotests/086 b/tests/qemu-iotests/086
index 84e3835071..442e63afc4 100755
--- a/tests/qemu-iotests/086
+++ b/tests/qemu-iotests/086
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index 2561a14456..4303e0e62b 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/088 b/tests/qemu-iotests/088
index b8076f216b..e55b67cd69 100755
--- a/tests/qemu-iotests/088
+++ b/tests/qemu-iotests/088
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index 10ac4a8d73..2e66ed31b9 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -26,7 +26,7 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1    # failure is the default!
 
 MIG_FIFO="${TEST_DIR}/migrate"
diff --git a/tests/qemu-iotests/092 b/tests/qemu-iotests/092
index 5bbdd071d8..be71add468 100755
--- a/tests/qemu-iotests/092
+++ b/tests/qemu-iotests/092
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/095 b/tests/qemu-iotests/095
index 72ecc22e1b..3ce960502c 100755
--- a/tests/qemu-iotests/095
+++ b/tests/qemu-iotests/095
@@ -27,7 +27,7 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/101 b/tests/qemu-iotests/101
index ea53f8b8d3..6022eb31fc 100755
--- a/tests/qemu-iotests/101
+++ b/tests/qemu-iotests/101
@@ -24,7 +24,7 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/104 b/tests/qemu-iotests/104
index 726d467052..b790c89528 100755
--- a/tests/qemu-iotests/104
+++ b/tests/qemu-iotests/104
@@ -24,7 +24,7 @@ owner=hutao@cn.fujitsu.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 trap "exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/105 b/tests/qemu-iotests/105
index 3db4ce3cf3..3c125bf163 100755
--- a/tests/qemu-iotests/105
+++ b/tests/qemu-iotests/105
@@ -24,7 +24,7 @@ owner=famz@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/116 b/tests/qemu-iotests/116
index df0172fed3..bb75a33e78 100755
--- a/tests/qemu-iotests/116
+++ b/tests/qemu-iotests/116
@@ -27,7 +27,7 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/128 b/tests/qemu-iotests/128
index 0976a18133..5a6dde0c03 100755
--- a/tests/qemu-iotests/128
+++ b/tests/qemu-iotests/128
@@ -24,7 +24,7 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 devname="eiodev$$"
diff --git a/tests/qemu-iotests/131 b/tests/qemu-iotests/131
index 94a9ae76af..47da00e3aa 100755
--- a/tests/qemu-iotests/131
+++ b/tests/qemu-iotests/131
@@ -24,7 +24,7 @@ owner=den@openvz.org
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
index af6b3e1dd4..9bca244c90 100755
--- a/tests/qemu-iotests/133
+++ b/tests/qemu-iotests/133
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index 99144151b8..934c6c534a 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -24,7 +24,7 @@ owner=berrange@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/135 b/tests/qemu-iotests/135
index ce608312f6..b12246fee9 100755
--- a/tests/qemu-iotests/135
+++ b/tests/qemu-iotests/135
@@ -24,7 +24,7 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/142 b/tests/qemu-iotests/142
index 1639c83985..0ac1402f55 100755
--- a/tests/qemu-iotests/142
+++ b/tests/qemu-iotests/142
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/144 b/tests/qemu-iotests/144
index 4b915718cd..15909fe7bd 100755
--- a/tests/qemu-iotests/144
+++ b/tests/qemu-iotests/144
@@ -26,7 +26,7 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 TMP_SNAP1=${TEST_DIR}/tmp.qcow2
diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
index c371b3c46a..f8f4849490 100755
--- a/tests/qemu-iotests/145
+++ b/tests/qemu-iotests/145
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/146 b/tests/qemu-iotests/146
index 043711be68..c8e99a344a 100755
--- a/tests/qemu-iotests/146
+++ b/tests/qemu-iotests/146
@@ -24,7 +24,7 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1    # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/154 b/tests/qemu-iotests/154
index fde03b0dc8..cb68dbee00 100755
--- a/tests/qemu-iotests/154
+++ b/tests/qemu-iotests/154
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index 24ac600a4a..168f331197 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -24,7 +24,7 @@ owner=berrange@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/171 b/tests/qemu-iotests/171
index bcfaaf1be2..910f18fd59 100755
--- a/tests/qemu-iotests/171
+++ b/tests/qemu-iotests/171
@@ -25,7 +25,7 @@ owner=tgolembi@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
index 02c5f79bab..203554b30a 100755
--- a/tests/qemu-iotests/172
+++ b/tests/qemu-iotests/172
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/173 b/tests/qemu-iotests/173
index bdaa092979..f657becd80 100755
--- a/tests/qemu-iotests/173
+++ b/tests/qemu-iotests/173
@@ -24,7 +24,7 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1    # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/174 b/tests/qemu-iotests/174
index 552879db32..bc8d6df3f6 100755
--- a/tests/qemu-iotests/174
+++ b/tests/qemu-iotests/174
@@ -24,7 +24,7 @@ owner=nirsof@gmail.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index ca56e827cd..e3c904695d 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -24,7 +24,7 @@ owner=nirsof@gmail.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/177 b/tests/qemu-iotests/177
index 396986da89..dfd5723c8b 100755
--- a/tests/qemu-iotests/177
+++ b/tests/qemu-iotests/177
@@ -24,7 +24,7 @@ owner=eblake@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
index 6af52c653a..5d25a50d03 100755
--- a/tests/qemu-iotests/178
+++ b/tests/qemu-iotests/178
@@ -24,7 +24,7 @@ owner=stefanha@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1    # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index e02979378d..c05318096a 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 MIG_SOCKET="${TEST_DIR}/migrate"
diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index c49e1ad6ef..b28701302b 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1 # failure is the default!
 
 MIG_SOCKET="${TEST_DIR}/migrate"
diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
index 2b68284d58..a36a2e3270 100755
--- a/tests/qemu-iotests/184
+++ b/tests/qemu-iotests/184
@@ -24,7 +24,7 @@ owner="Manos Pitsidianakis"
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 trap "exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index 7dcfdeac60..80dca40465 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1 # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index 0aa4395a57..ab71a30c14 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/187 b/tests/qemu-iotests/187
index 7bb783363c..6affdc253c 100755
--- a/tests/qemu-iotests/187
+++ b/tests/qemu-iotests/187
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/188 b/tests/qemu-iotests/188
index 83ed03e33e..d946b9699d 100755
--- a/tests/qemu-iotests/188
+++ b/tests/qemu-iotests/188
@@ -24,7 +24,7 @@ owner=berrange@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/189 b/tests/qemu-iotests/189
index e695475722..e98001fd99 100755
--- a/tests/qemu-iotests/189
+++ b/tests/qemu-iotests/189
@@ -24,7 +24,7 @@ owner=berrange@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/190 b/tests/qemu-iotests/190
index 8f808fef5d..fce04e2f3f 100755
--- a/tests/qemu-iotests/190
+++ b/tests/qemu-iotests/190
@@ -24,7 +24,7 @@ owner=eblake@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1    # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index d6860e72f7..7de80df778 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1 # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
index 595f0d786a..ee8fd2d841 100755
--- a/tests/qemu-iotests/192
+++ b/tests/qemu-iotests/192
@@ -25,7 +25,7 @@ owner=famz@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/195 b/tests/qemu-iotests/195
index e7a403ded2..7784b1f363 100755
--- a/tests/qemu-iotests/195
+++ b/tests/qemu-iotests/195
@@ -24,7 +24,7 @@ owner=kwolf@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1 # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
index 54eaaf5153..c23bd16ea7 100755
--- a/tests/qemu-iotests/198
+++ b/tests/qemu-iotests/198
@@ -24,7 +24,7 @@ owner=berrange@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
index ddbdedc476..4f5d5b3b23 100755
--- a/tests/qemu-iotests/200
+++ b/tests/qemu-iotests/200
@@ -26,7 +26,7 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1    # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/204 b/tests/qemu-iotests/204
index feb69d2ada..0ec550a691 100755
--- a/tests/qemu-iotests/204
+++ b/tests/qemu-iotests/204
@@ -24,7 +24,7 @@ owner=eblake@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/226 b/tests/qemu-iotests/226
index 8ec3e612dd..c396edb6ab 100755
--- a/tests/qemu-iotests/226
+++ b/tests/qemu-iotests/226
@@ -25,7 +25,7 @@ owner=jsnow@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1    # failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/231 b/tests/qemu-iotests/231
index 3e283708b4..e044cea9b5 100755
--- a/tests/qemu-iotests/231
+++ b/tests/qemu-iotests/231
@@ -26,7 +26,7 @@ owner=jcody@redhat.com
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
+here=$PWD
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index aa94c6c7ea..b37713277d 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -99,7 +99,7 @@ set_prog_path()
 }
 
 if [ -z "$TEST_DIR" ]; then
-        TEST_DIR=`pwd`/scratch
+        TEST_DIR=$PWD/scratch
 fi
 
 if [ ! -e "$TEST_DIR" ]; then
diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common.config
index 102aa6878a..d4721ba92d 100644
--- a/tests/qemu-iotests/common.config
+++ b/tests/qemu-iotests/common.config
@@ -25,7 +25,7 @@ HOSTOS=`uname -s`
 arch=`uname -m`
 [[ "$arch" =~ "ppc64" ]] && qemu_arch=ppc64 || qemu_arch="$arch"
 
-export PWD=`pwd`
+export PWD=$PWD
 
 # make sure we have a standard umask
 umask 022
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 44bee16a5e..5dc3f18ac2 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -160,7 +160,7 @@ fi
 ORIG_TEST_IMG="$TEST_IMG"
 
 if [ -z "$TEST_DIR" ]; then
-        TEST_DIR=`pwd`/scratch
+        TEST_DIR=$PWD/scratch
 fi
 
 QEMU_TEST_DIR="${TEST_DIR}"
-- 
2.17.1
