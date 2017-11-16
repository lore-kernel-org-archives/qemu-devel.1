Received: from eggs.gnu.org ([2001:4830:134:3::10]:59991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eFO7t-0007op-W6
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:39:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eFO7o-0003v0-22
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:38:58 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 16 Nov 2017 12:38:09 -0500
Message-Id: <20171116173810.16457-10-crosa@redhat.com>
In-Reply-To: <20171116173810.16457-1-crosa@redhat.com>
References: <20171116173810.16457-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 09/10] qemu-iotests: remove unused "here"
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>

Another legacy variable that did not convince me it has any
purpose whatsoever.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
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
 157 files changed, 157 deletions(-)

diff --git a/tests/qemu-iotests/001 b/tests/qemu-iotests/001
index 5830f68ba0..ce671e50e7 100755
--- a/tests/qemu-iotests/001
+++ b/tests/qemu-iotests/001
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/002 b/tests/qemu-iotests/002
index 7dd1774464..8f57a41953 100755
--- a/tests/qemu-iotests/002
+++ b/tests/qemu-iotests/002
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/003 b/tests/qemu-iotests/003
index 13cc8041a3..102ff9cab9 100755
--- a/tests/qemu-iotests/003
+++ b/tests/qemu-iotests/003
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/004 b/tests/qemu-iotests/004
index 710148c2bb..8ddae7fea4 100755
--- a/tests/qemu-iotests/004
+++ b/tests/qemu-iotests/004
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
index d2c6575992..6caf5b0241 100755
--- a/tests/qemu-iotests/005
+++ b/tests/qemu-iotests/005
@@ -26,7 +26,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/007 b/tests/qemu-iotests/007
index 3fe2fe5dad..fc4458e11d 100755
--- a/tests/qemu-iotests/007
+++ b/tests/qemu-iotests/007
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/008 b/tests/qemu-iotests/008
index f021b8ea3a..7b891629db 100755
--- a/tests/qemu-iotests/008
+++ b/tests/qemu-iotests/008
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/009 b/tests/qemu-iotests/009
index 8d56673bc6..6a2498f4ab 100755
--- a/tests/qemu-iotests/009
+++ b/tests/qemu-iotests/009
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/010 b/tests/qemu-iotests/010
index 3f91224795..447914da1a 100755
--- a/tests/qemu-iotests/010
+++ b/tests/qemu-iotests/010
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/011 b/tests/qemu-iotests/011
index 921f43c03d..d758d7a577 100755
--- a/tests/qemu-iotests/011
+++ b/tests/qemu-iotests/011
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/012 b/tests/qemu-iotests/012
index 3121f947f6..a4a7303a9a 100755
--- a/tests/qemu-iotests/012
+++ b/tests/qemu-iotests/012
@@ -25,7 +25,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/013 b/tests/qemu-iotests/013
index 095c2a0cd6..1db4649541 100755
--- a/tests/qemu-iotests/013
+++ b/tests/qemu-iotests/013
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/014 b/tests/qemu-iotests/014
index c28970732b..b679750ba6 100755
--- a/tests/qemu-iotests/014
+++ b/tests/qemu-iotests/014
@@ -25,7 +25,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/015 b/tests/qemu-iotests/015
index a5cda4742c..3ea0e5472d 100755
--- a/tests/qemu-iotests/015
+++ b/tests/qemu-iotests/015
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/017 b/tests/qemu-iotests/017
index 2398fc2bf1..fb4974cd87 100755
--- a/tests/qemu-iotests/017
+++ b/tests/qemu-iotests/017
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/018 b/tests/qemu-iotests/018
index 8d4ccda85e..06139efa64 100755
--- a/tests/qemu-iotests/018
+++ b/tests/qemu-iotests/018
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/019 b/tests/qemu-iotests/019
index b06ef93976..ddf5f7f7f3 100755
--- a/tests/qemu-iotests/019
+++ b/tests/qemu-iotests/019
@@ -25,7 +25,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index b34cfc16e1..d26ef8df86 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/021 b/tests/qemu-iotests/021
index 97e27d6cf3..1b6dfe0fc1 100755
--- a/tests/qemu-iotests/021
+++ b/tests/qemu-iotests/021
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/022 b/tests/qemu-iotests/022
index bc9186c0fa..77a7516be2 100755
--- a/tests/qemu-iotests/022
+++ b/tests/qemu-iotests/022
@@ -25,7 +25,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/023 b/tests/qemu-iotests/023
index 99fda1ff14..eaa73ac866 100755
--- a/tests/qemu-iotests/023
+++ b/tests/qemu-iotests/023
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index b3cabe1fb5..ce661cc5a3 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/025 b/tests/qemu-iotests/025
index a781632b09..93814d5931 100755
--- a/tests/qemu-iotests/025
+++ b/tests/qemu-iotests/025
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index 166c8267f7..7d8c07b240 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/027 b/tests/qemu-iotests/027
index c9416c719f..a7349c178b 100755
--- a/tests/qemu-iotests/027
+++ b/tests/qemu-iotests/027
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index f2991a28aa..85deaf2dad 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -26,7 +26,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/029 b/tests/qemu-iotests/029
index fee694f305..07df4b2959 100755
--- a/tests/qemu-iotests/029
+++ b/tests/qemu-iotests/029
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/031 b/tests/qemu-iotests/031
index da44539b0f..21f8eae2a7 100755
--- a/tests/qemu-iotests/031
+++ b/tests/qemu-iotests/031
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/032 b/tests/qemu-iotests/032
index 15a0ff6298..e4b62e6deb 100755
--- a/tests/qemu-iotests/032
+++ b/tests/qemu-iotests/032
@@ -25,7 +25,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/033 b/tests/qemu-iotests/033
index d4beecc9c0..2eca619837 100755
--- a/tests/qemu-iotests/033
+++ b/tests/qemu-iotests/033
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/034 b/tests/qemu-iotests/034
index c0eb87b40a..90b49c2cde 100755
--- a/tests/qemu-iotests/034
+++ b/tests/qemu-iotests/034
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/035 b/tests/qemu-iotests/035
index 04c4cf0f58..d174ae3c51 100755
--- a/tests/qemu-iotests/035
+++ b/tests/qemu-iotests/035
@@ -24,7 +24,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
index 990b9d82b6..858caa889a 100755
--- a/tests/qemu-iotests/036
+++ b/tests/qemu-iotests/036
@@ -26,7 +26,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/037 b/tests/qemu-iotests/037
index c4d55babe2..ed57e5a2ed 100755
--- a/tests/qemu-iotests/037
+++ b/tests/qemu-iotests/037
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/038 b/tests/qemu-iotests/038
index b35c30fa17..9266fbbb57 100755
--- a/tests/qemu-iotests/038
+++ b/tests/qemu-iotests/038
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index 99a33df803..f57d931b5b 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -26,7 +26,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/042 b/tests/qemu-iotests/042
index 7fafb6a436..24b9c20749 100755
--- a/tests/qemu-iotests/042
+++ b/tests/qemu-iotests/042
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/043 b/tests/qemu-iotests/043
index 0ce07adfd0..fee664cbfd 100755
--- a/tests/qemu-iotests/043
+++ b/tests/qemu-iotests/043
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index c3c16ebd3d..9f7e4df3af 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/047 b/tests/qemu-iotests/047
index ebbb36c349..e8ca27e3c8 100755
--- a/tests/qemu-iotests/047
+++ b/tests/qemu-iotests/047
@@ -24,7 +24,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/049 b/tests/qemu-iotests/049
index 984652cd97..8b235cec7f 100755
--- a/tests/qemu-iotests/049
+++ b/tests/qemu-iotests/049
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/050 b/tests/qemu-iotests/050
index f290c68498..6131cc816a 100755
--- a/tests/qemu-iotests/050
+++ b/tests/qemu-iotests/050
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index b6903d13c4..b5f1b34579 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/052 b/tests/qemu-iotests/052
index 33c3e55713..2c423d7d34 100755
--- a/tests/qemu-iotests/052
+++ b/tests/qemu-iotests/052
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/053 b/tests/qemu-iotests/053
index a84dde31e0..32c75472ae 100755
--- a/tests/qemu-iotests/053
+++ b/tests/qemu-iotests/053
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/054 b/tests/qemu-iotests/054
index 0fc2a8faa6..d3b7f6a727 100755
--- a/tests/qemu-iotests/054
+++ b/tests/qemu-iotests/054
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/058 b/tests/qemu-iotests/058
index 74118b93d3..01a47c6a9e 100755
--- a/tests/qemu-iotests/058
+++ b/tests/qemu-iotests/058
@@ -25,7 +25,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index fe16e9442d..2aa0a9eb83 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 98a946f99c..bcfa33db38 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index 2c6da49646..03d1e5f435 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/062 b/tests/qemu-iotests/062
index 3f97c7d6da..8ef0b9d923 100755
--- a/tests/qemu-iotests/062
+++ b/tests/qemu-iotests/062
@@ -24,7 +24,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/063 b/tests/qemu-iotests/063
index 9b8660e021..aeb247f3a7 100755
--- a/tests/qemu-iotests/063
+++ b/tests/qemu-iotests/063
@@ -24,7 +24,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/064 b/tests/qemu-iotests/064
index 40954b36d7..50214bb2c5 100755
--- a/tests/qemu-iotests/064
+++ b/tests/qemu-iotests/064
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/066 b/tests/qemu-iotests/066
index 556b42bfe6..557a39f357 100755
--- a/tests/qemu-iotests/066
+++ b/tests/qemu-iotests/066
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/067 b/tests/qemu-iotests/067
index b7a6ef2097..4a0f16c5bd 100755
--- a/tests/qemu-iotests/067
+++ b/tests/qemu-iotests/067
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
index 162cd26005..9f9fc4cb48 100755
--- a/tests/qemu-iotests/068
+++ b/tests/qemu-iotests/068
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/069 b/tests/qemu-iotests/069
index 1f3baeea13..df3e2b0ae0 100755
--- a/tests/qemu-iotests/069
+++ b/tests/qemu-iotests/069
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/070 b/tests/qemu-iotests/070
index 684742893c..915c02ecba 100755
--- a/tests/qemu-iotests/070
+++ b/tests/qemu-iotests/070
@@ -24,7 +24,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 7b1fdf7989..865930d7b3 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/072 b/tests/qemu-iotests/072
index 5d4e8becac..43cbeaf526 100755
--- a/tests/qemu-iotests/072
+++ b/tests/qemu-iotests/072
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/073 b/tests/qemu-iotests/073
index f5be7347d1..d9819b6aa5 100755
--- a/tests/qemu-iotests/073
+++ b/tests/qemu-iotests/073
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/075 b/tests/qemu-iotests/075
index b924d7a5f7..5d211b6eb3 100755
--- a/tests/qemu-iotests/075
+++ b/tests/qemu-iotests/075
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/076 b/tests/qemu-iotests/076
index 64b935ad02..ddf3cf0a64 100755
--- a/tests/qemu-iotests/076
+++ b/tests/qemu-iotests/076
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/077 b/tests/qemu-iotests/077
index 897afb688d..375872deed 100755
--- a/tests/qemu-iotests/077
+++ b/tests/qemu-iotests/077
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/078 b/tests/qemu-iotests/078
index 36490ec94c..f9f53772d0 100755
--- a/tests/qemu-iotests/078
+++ b/tests/qemu-iotests/078
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
index d8a2a17e71..35bfab1ad7 100755
--- a/tests/qemu-iotests/079
+++ b/tests/qemu-iotests/079
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index aa7b13776a..67998b6073 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/081 b/tests/qemu-iotests/081
index d840841b0d..9ee474d0a7 100755
--- a/tests/qemu-iotests/081
+++ b/tests/qemu-iotests/081
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index 4f1c03b882..e0f05fe236 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/083 b/tests/qemu-iotests/083
index 39162b36ef..b2d6462526 100755
--- a/tests/qemu-iotests/083
+++ b/tests/qemu-iotests/083
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/084 b/tests/qemu-iotests/084
index 3daf41615b..9b85dda50c 100755
--- a/tests/qemu-iotests/084
+++ b/tests/qemu-iotests/084
@@ -24,7 +24,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index 375a51e07a..adea26a781 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -28,7 +28,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 snapshot_virt0="snapshot-v0.qcow2"
diff --git a/tests/qemu-iotests/086 b/tests/qemu-iotests/086
index 1224e068b7..dda1bc9d07 100755
--- a/tests/qemu-iotests/086
+++ b/tests/qemu-iotests/086
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index fb572dc5b8..1ee9b429c1 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/088 b/tests/qemu-iotests/088
index 75e6ba9908..4bbcf47495 100755
--- a/tests/qemu-iotests/088
+++ b/tests/qemu-iotests/088
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index dad9fcb69f..455e923440 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/090 b/tests/qemu-iotests/090
index 74e14e9f00..959ed64083 100755
--- a/tests/qemu-iotests/090
+++ b/tests/qemu-iotests/090
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index bb32f681bb..d6dd52fe52 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -25,7 +25,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1    # failure is the default!
 
 MIG_FIFO="${TEST_DIR}/migrate"
diff --git a/tests/qemu-iotests/092 b/tests/qemu-iotests/092
index 041d888984..2bf3c69a5f 100755
--- a/tests/qemu-iotests/092
+++ b/tests/qemu-iotests/092
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/094 b/tests/qemu-iotests/094
index 47ff00651f..2869c26bd9 100755
--- a/tests/qemu-iotests/094
+++ b/tests/qemu-iotests/094
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/095 b/tests/qemu-iotests/095
index bc80c019ed..41d24f9e5b 100755
--- a/tests/qemu-iotests/095
+++ b/tests/qemu-iotests/095
@@ -27,7 +27,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/097 b/tests/qemu-iotests/097
index 2a68a08358..8fce38e2ef 100755
--- a/tests/qemu-iotests/097
+++ b/tests/qemu-iotests/097
@@ -24,7 +24,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/098 b/tests/qemu-iotests/098
index afe5b72c87..14164dc83f 100755
--- a/tests/qemu-iotests/098
+++ b/tests/qemu-iotests/098
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/099 b/tests/qemu-iotests/099
index ac94ca7f21..a36fe154da 100755
--- a/tests/qemu-iotests/099
+++ b/tests/qemu-iotests/099
@@ -24,7 +24,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/101 b/tests/qemu-iotests/101
index cc57078727..8520c771af 100755
--- a/tests/qemu-iotests/101
+++ b/tests/qemu-iotests/101
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
index 9acc2772c7..9676ce5529 100755
--- a/tests/qemu-iotests/102
+++ b/tests/qemu-iotests/102
@@ -23,7 +23,6 @@
 seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=$PWD
 status=1    # failure is the default!
 
 # get standard environment, filters and qemu instance handling
diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
index eaab111b5a..dbff3800b7 100755
--- a/tests/qemu-iotests/103
+++ b/tests/qemu-iotests/103
@@ -23,7 +23,6 @@
 seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/104 b/tests/qemu-iotests/104
index 5818b449da..f0a09daf46 100755
--- a/tests/qemu-iotests/104
+++ b/tests/qemu-iotests/104
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 trap "exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/105 b/tests/qemu-iotests/105
index e975f2930e..ef9ad60acf 100755
--- a/tests/qemu-iotests/105
+++ b/tests/qemu-iotests/105
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
index ee81af19da..9aef55962a 100755
--- a/tests/qemu-iotests/106
+++ b/tests/qemu-iotests/106
@@ -23,7 +23,6 @@
 seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 # get standard environment and filters
diff --git a/tests/qemu-iotests/107 b/tests/qemu-iotests/107
index 87e2a22cec..baddfa9d3d 100755
--- a/tests/qemu-iotests/107
+++ b/tests/qemu-iotests/107
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
index 31ea282f20..c5bad010c1 100755
--- a/tests/qemu-iotests/108
+++ b/tests/qemu-iotests/108
@@ -24,7 +24,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
index e011ad86c3..b96be288c0 100755
--- a/tests/qemu-iotests/109
+++ b/tests/qemu-iotests/109
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index e596efddb5..211b7a40eb 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/111 b/tests/qemu-iotests/111
index 37223d93d7..2da9ba57cf 100755
--- a/tests/qemu-iotests/111
+++ b/tests/qemu-iotests/111
@@ -24,7 +24,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/112 b/tests/qemu-iotests/112
index 221892fbd1..72e35b3803 100755
--- a/tests/qemu-iotests/112
+++ b/tests/qemu-iotests/112
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/113 b/tests/qemu-iotests/113
index 9d48020b94..2567ba4596 100755
--- a/tests/qemu-iotests/113
+++ b/tests/qemu-iotests/113
@@ -24,7 +24,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/114 b/tests/qemu-iotests/114
index 44ef79a87f..a1cb2ec2c8 100755
--- a/tests/qemu-iotests/114
+++ b/tests/qemu-iotests/114
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/115 b/tests/qemu-iotests/115
index f2ec8fbd44..54c657a424 100755
--- a/tests/qemu-iotests/115
+++ b/tests/qemu-iotests/115
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/116 b/tests/qemu-iotests/116
index 715a44200f..8d13d2443e 100755
--- a/tests/qemu-iotests/116
+++ b/tests/qemu-iotests/116
@@ -26,7 +26,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/117 b/tests/qemu-iotests/117
index 07aca0eba1..c725b1d710 100755
--- a/tests/qemu-iotests/117
+++ b/tests/qemu-iotests/117
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/119 b/tests/qemu-iotests/119
index dbc7350458..3a0120872c 100755
--- a/tests/qemu-iotests/119
+++ b/tests/qemu-iotests/119
@@ -24,7 +24,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/120 b/tests/qemu-iotests/120
index 3816260951..70efb29a2c 100755
--- a/tests/qemu-iotests/120
+++ b/tests/qemu-iotests/120
@@ -24,7 +24,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/121 b/tests/qemu-iotests/121
index 04b38c9de8..103c5170ca 100755
--- a/tests/qemu-iotests/121
+++ b/tests/qemu-iotests/121
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index ea4ba0f098..27f5cc0977 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/123 b/tests/qemu-iotests/123
index 6701c7ab54..1755300a12 100755
--- a/tests/qemu-iotests/123
+++ b/tests/qemu-iotests/123
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
index 6a0504ba0a..45b0b109e0 100755
--- a/tests/qemu-iotests/125
+++ b/tests/qemu-iotests/125
@@ -23,7 +23,6 @@
 seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=$PWD
 status=1	# failure is the default!
 
 # get standard environment and filters
diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
index 882ace0191..497a8f1d8f 100755
--- a/tests/qemu-iotests/126
+++ b/tests/qemu-iotests/126
@@ -24,7 +24,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/127 b/tests/qemu-iotests/127
index e84f0d80f6..d9366d37b1 100755
--- a/tests/qemu-iotests/127
+++ b/tests/qemu-iotests/127
@@ -23,7 +23,6 @@
 seq=$(basename $0)
 echo "QA output created by $seq"
 
-here=$PWD
 status=1    # failure is the default!
 
 # get standard environment, filters and qemu instance handling
diff --git a/tests/qemu-iotests/128 b/tests/qemu-iotests/128
index 51009f18f6..9529df3dfd 100755
--- a/tests/qemu-iotests/128
+++ b/tests/qemu-iotests/128
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 devname="eiodev$$"
diff --git a/tests/qemu-iotests/130 b/tests/qemu-iotests/130
index ed234c3b6d..f507a7ed7f 100755
--- a/tests/qemu-iotests/130
+++ b/tests/qemu-iotests/130
@@ -25,7 +25,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/131 b/tests/qemu-iotests/131
index 9c12d6c7f9..c809d3f8aa 100755
--- a/tests/qemu-iotests/131
+++ b/tests/qemu-iotests/131
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
index 61adc4374b..0f1dd4e5b3 100755
--- a/tests/qemu-iotests/133
+++ b/tests/qemu-iotests/133
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index c1c45c66d6..57c5fdbab1 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/135 b/tests/qemu-iotests/135
index 5c41718490..86f8aefa2a 100755
--- a/tests/qemu-iotests/135
+++ b/tests/qemu-iotests/135
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
index 1e6c6afcca..93f5c7ebaf 100755
--- a/tests/qemu-iotests/137
+++ b/tests/qemu-iotests/137
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
index cb98fc34b9..c5a0c85e94 100755
--- a/tests/qemu-iotests/138
+++ b/tests/qemu-iotests/138
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
index 63390fd896..55969e80f9 100755
--- a/tests/qemu-iotests/140
+++ b/tests/qemu-iotests/140
@@ -27,7 +27,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
index 996bf16963..db79f457a7 100755
--- a/tests/qemu-iotests/141
+++ b/tests/qemu-iotests/141
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/142 b/tests/qemu-iotests/142
index 6cb73bc6fa..93fd649a14 100755
--- a/tests/qemu-iotests/142
+++ b/tests/qemu-iotests/142
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/143 b/tests/qemu-iotests/143
index 1ae5296607..727c703182 100755
--- a/tests/qemu-iotests/143
+++ b/tests/qemu-iotests/143
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/144 b/tests/qemu-iotests/144
index d6015ce0eb..fc3e044012 100755
--- a/tests/qemu-iotests/144
+++ b/tests/qemu-iotests/144
@@ -25,7 +25,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 TMP_SNAP1=${TEST_DIR}/tmp.qcow2
diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
index c81bbb8a20..3806f0e6be 100755
--- a/tests/qemu-iotests/145
+++ b/tests/qemu-iotests/145
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/146 b/tests/qemu-iotests/146
index 238658d642..5276a31cc3 100755
--- a/tests/qemu-iotests/146
+++ b/tests/qemu-iotests/146
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1    # failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/150 b/tests/qemu-iotests/150
index 6c5d54228b..65c32cf73b 100755
--- a/tests/qemu-iotests/150
+++ b/tests/qemu-iotests/150
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index 54f3ad8c79..2a7bdad8c5 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 tmp=/tmp/$$
 status=1	# failure is the default!
 
diff --git a/tests/qemu-iotests/154 b/tests/qemu-iotests/154
index 7b56d60339..b536c49887 100755
--- a/tests/qemu-iotests/154
+++ b/tests/qemu-iotests/154
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index 618060180c..1fc4eab021 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -31,7 +31,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/157 b/tests/qemu-iotests/157
index c44edd65e7..cdc96e9746 100755
--- a/tests/qemu-iotests/157
+++ b/tests/qemu-iotests/157
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index abf79f3cc2..08db8c95c0 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/159 b/tests/qemu-iotests/159
index 799ff57040..d6fb17da2e 100755
--- a/tests/qemu-iotests/159
+++ b/tests/qemu-iotests/159
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1
 
 . ./common.rc
diff --git a/tests/qemu-iotests/160 b/tests/qemu-iotests/160
index 41ffad5774..4a16bfb0bb 100755
--- a/tests/qemu-iotests/160
+++ b/tests/qemu-iotests/160
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1
 
 . ./common.rc
diff --git a/tests/qemu-iotests/162 b/tests/qemu-iotests/162
index c601c13525..b435024c70 100755
--- a/tests/qemu-iotests/162
+++ b/tests/qemu-iotests/162
@@ -24,7 +24,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 _cleanup()
diff --git a/tests/qemu-iotests/170 b/tests/qemu-iotests/170
index 736c61f8e9..b76473f3b9 100755
--- a/tests/qemu-iotests/170
+++ b/tests/qemu-iotests/170
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1
 
 . ./common.rc
diff --git a/tests/qemu-iotests/171 b/tests/qemu-iotests/171
index 93b119939d..e5c83af2e6 100755
--- a/tests/qemu-iotests/171
+++ b/tests/qemu-iotests/171
@@ -24,7 +24,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
index 56376f0f37..0133691f9b 100755
--- a/tests/qemu-iotests/172
+++ b/tests/qemu-iotests/172
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/173 b/tests/qemu-iotests/173
index f5185a1945..8214b3b999 100755
--- a/tests/qemu-iotests/173
+++ b/tests/qemu-iotests/173
@@ -24,7 +24,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1    # failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/174 b/tests/qemu-iotests/174
index b1527583c7..504efe318b 100755
--- a/tests/qemu-iotests/174
+++ b/tests/qemu-iotests/174
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index b9703dd99c..298cc6465a 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/176 b/tests/qemu-iotests/176
index 9f4a5db86a..273ed2c12f 100755
--- a/tests/qemu-iotests/176
+++ b/tests/qemu-iotests/176
@@ -27,7 +27,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/177 b/tests/qemu-iotests/177
index 2c0c70ec6d..d3216cd5fb 100755
--- a/tests/qemu-iotests/177
+++ b/tests/qemu-iotests/177
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
index 4eba90243d..3dbb15fd77 100755
--- a/tests/qemu-iotests/178
+++ b/tests/qemu-iotests/178
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1    # failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/179 b/tests/qemu-iotests/179
index ccede3bc04..50d1c35380 100755
--- a/tests/qemu-iotests/179
+++ b/tests/qemu-iotests/179
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index cd90eb98c5..e8f19ac868 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 MIG_SOCKET="${TEST_DIR}/migrate"
diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
index f7705b36f7..17396c0816 100755
--- a/tests/qemu-iotests/182
+++ b/tests/qemu-iotests/182
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 tmp=/tmp/$$
 status=1	# failure is the default!
 
diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index ced0df4a76..bb7c5b7093 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1 # failure is the default!
 
 MIG_SOCKET="${TEST_DIR}/migrate"
diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
index c5d0226a67..93f19df963 100755
--- a/tests/qemu-iotests/184
+++ b/tests/qemu-iotests/184
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index 09ebe6b659..2ebca91503 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1 # failure is the default!
 
 MIG_SOCKET="${TEST_DIR}/migrate"
diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index a87a7f81ff..f25548b9bf 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/187 b/tests/qemu-iotests/187
index 4d304f91ca..158f650f7c 100755
--- a/tests/qemu-iotests/187
+++ b/tests/qemu-iotests/187
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/188 b/tests/qemu-iotests/188
index 6e945ccf38..ddcbecadc0 100755
--- a/tests/qemu-iotests/188
+++ b/tests/qemu-iotests/188
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/189 b/tests/qemu-iotests/189
index 5213057b14..cefa774818 100755
--- a/tests/qemu-iotests/189
+++ b/tests/qemu-iotests/189
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/190 b/tests/qemu-iotests/190
index 577bbb70f7..4f0b6711a2 100755
--- a/tests/qemu-iotests/190
+++ b/tests/qemu-iotests/190
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1    # failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index 0f740f7b38..0337bedd00 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1 # failure is the default!
 
 MIG_SOCKET="${TEST_DIR}/migrate"
diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
index 5d0af35816..d6209c9d92 100755
--- a/tests/qemu-iotests/192
+++ b/tests/qemu-iotests/192
@@ -24,7 +24,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1	# failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/195 b/tests/qemu-iotests/195
index ff6b1fde9d..fe88617eed 100755
--- a/tests/qemu-iotests/195
+++ b/tests/qemu-iotests/195
@@ -23,7 +23,6 @@
 seq=`basename $0`
 echo "QA output created by $seq"
 
-here=`pwd`
 status=1 # failure is the default!
 
 # get standard environment, filters and checks
diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index 9fb4a694a1..9e7c6cf339 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -23,7 +23,6 @@
 seq="$(basename $0)"
 echo "QA output created by $seq"
 
-here="$PWD"
 status=1 # failure is the default!
 
 # get standard environment, filters and checks
-- 
2.13.6
