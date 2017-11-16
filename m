Received: from eggs.gnu.org ([2001:4830:134:3::10]:60029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eFO7x-0007sK-O4
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:39:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eFO7p-0003xG-6i
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:39:01 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 16 Nov 2017 12:38:06 -0500
Message-Id: <20171116173810.16457-7-crosa@redhat.com>
In-Reply-To: <20171116173810.16457-1-crosa@redhat.com>
References: <20171116173810.16457-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 06/10] qemu-iotests: turn owner variable into a
 comment
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

This variables has no real use.  To avoid pretending it does, while
still keeping the information, let's turn it into a comment.

The format chosen is the one already being used on tests 149 and 194.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/qemu-iotests/001 | 5 ++---
 tests/qemu-iotests/002 | 5 ++---
 tests/qemu-iotests/003 | 5 ++---
 tests/qemu-iotests/004 | 5 ++---
 tests/qemu-iotests/005 | 5 ++---
 tests/qemu-iotests/007 | 5 ++---
 tests/qemu-iotests/008 | 5 ++---
 tests/qemu-iotests/009 | 5 ++---
 tests/qemu-iotests/010 | 5 ++---
 tests/qemu-iotests/011 | 5 ++---
 tests/qemu-iotests/012 | 5 ++---
 tests/qemu-iotests/013 | 5 ++---
 tests/qemu-iotests/014 | 5 ++---
 tests/qemu-iotests/015 | 5 ++---
 tests/qemu-iotests/017 | 5 ++---
 tests/qemu-iotests/018 | 5 ++---
 tests/qemu-iotests/019 | 5 ++---
 tests/qemu-iotests/020 | 5 ++---
 tests/qemu-iotests/021 | 5 ++---
 tests/qemu-iotests/022 | 5 ++---
 tests/qemu-iotests/023 | 5 ++---
 tests/qemu-iotests/024 | 5 ++---
 tests/qemu-iotests/025 | 5 ++---
 tests/qemu-iotests/026 | 5 ++---
 tests/qemu-iotests/027 | 5 ++---
 tests/qemu-iotests/028 | 5 ++---
 tests/qemu-iotests/029 | 5 ++---
 tests/qemu-iotests/031 | 5 ++---
 tests/qemu-iotests/032 | 5 ++---
 tests/qemu-iotests/033 | 5 ++---
 tests/qemu-iotests/034 | 5 ++---
 tests/qemu-iotests/035 | 5 ++---
 tests/qemu-iotests/036 | 5 ++---
 tests/qemu-iotests/037 | 5 ++---
 tests/qemu-iotests/038 | 5 ++---
 tests/qemu-iotests/039 | 5 ++---
 tests/qemu-iotests/040 | 1 +
 tests/qemu-iotests/042 | 5 ++---
 tests/qemu-iotests/043 | 5 ++---
 tests/qemu-iotests/046 | 5 ++---
 tests/qemu-iotests/047 | 5 ++---
 tests/qemu-iotests/048 | 4 ++--
 tests/qemu-iotests/049 | 5 ++---
 tests/qemu-iotests/050 | 5 ++---
 tests/qemu-iotests/051 | 5 ++---
 tests/qemu-iotests/052 | 5 ++---
 tests/qemu-iotests/053 | 5 ++---
 tests/qemu-iotests/054 | 5 ++---
 tests/qemu-iotests/058 | 5 ++---
 tests/qemu-iotests/059 | 5 ++---
 tests/qemu-iotests/060 | 5 ++---
 tests/qemu-iotests/061 | 5 ++---
 tests/qemu-iotests/062 | 5 ++---
 tests/qemu-iotests/063 | 5 ++---
 tests/qemu-iotests/064 | 5 ++---
 tests/qemu-iotests/066 | 5 ++---
 tests/qemu-iotests/067 | 5 ++---
 tests/qemu-iotests/068 | 5 ++---
 tests/qemu-iotests/069 | 5 ++---
 tests/qemu-iotests/070 | 5 ++---
 tests/qemu-iotests/071 | 5 ++---
 tests/qemu-iotests/072 | 5 ++---
 tests/qemu-iotests/073 | 5 ++---
 tests/qemu-iotests/074 | 3 +--
 tests/qemu-iotests/075 | 5 ++---
 tests/qemu-iotests/076 | 5 ++---
 tests/qemu-iotests/077 | 5 ++---
 tests/qemu-iotests/078 | 5 ++---
 tests/qemu-iotests/079 | 5 ++---
 tests/qemu-iotests/080 | 5 ++---
 tests/qemu-iotests/081 | 5 ++---
 tests/qemu-iotests/082 | 5 ++---
 tests/qemu-iotests/083 | 5 ++---
 tests/qemu-iotests/084 | 5 ++---
 tests/qemu-iotests/085 | 5 ++---
 tests/qemu-iotests/086 | 5 ++---
 tests/qemu-iotests/087 | 5 ++---
 tests/qemu-iotests/088 | 5 ++---
 tests/qemu-iotests/089 | 5 ++---
 tests/qemu-iotests/090 | 5 ++---
 tests/qemu-iotests/091 | 5 ++---
 tests/qemu-iotests/092 | 5 ++---
 tests/qemu-iotests/094 | 5 ++---
 tests/qemu-iotests/095 | 4 ++--
 tests/qemu-iotests/097 | 5 ++---
 tests/qemu-iotests/098 | 5 ++---
 tests/qemu-iotests/099 | 5 ++---
 tests/qemu-iotests/101 | 5 ++---
 tests/qemu-iotests/102 | 5 ++---
 tests/qemu-iotests/103 | 5 ++---
 tests/qemu-iotests/104 | 5 ++---
 tests/qemu-iotests/105 | 5 ++---
 tests/qemu-iotests/106 | 5 ++---
 tests/qemu-iotests/107 | 5 ++---
 tests/qemu-iotests/108 | 5 ++---
 tests/qemu-iotests/109 | 5 ++---
 tests/qemu-iotests/110 | 5 ++---
 tests/qemu-iotests/111 | 5 ++---
 tests/qemu-iotests/112 | 5 ++---
 tests/qemu-iotests/113 | 5 ++---
 tests/qemu-iotests/114 | 5 ++---
 tests/qemu-iotests/115 | 5 ++---
 tests/qemu-iotests/116 | 5 ++---
 tests/qemu-iotests/117 | 5 ++---
 tests/qemu-iotests/119 | 5 ++---
 tests/qemu-iotests/120 | 5 ++---
 tests/qemu-iotests/121 | 5 ++---
 tests/qemu-iotests/122 | 5 ++---
 tests/qemu-iotests/123 | 5 ++---
 tests/qemu-iotests/125 | 5 ++---
 tests/qemu-iotests/126 | 5 ++---
 tests/qemu-iotests/127 | 5 ++---
 tests/qemu-iotests/128 | 5 ++---
 tests/qemu-iotests/130 | 5 ++---
 tests/qemu-iotests/131 | 5 ++---
 tests/qemu-iotests/133 | 5 ++---
 tests/qemu-iotests/134 | 5 ++---
 tests/qemu-iotests/135 | 5 ++---
 tests/qemu-iotests/137 | 5 ++---
 tests/qemu-iotests/138 | 5 ++---
 tests/qemu-iotests/140 | 5 ++---
 tests/qemu-iotests/141 | 5 ++---
 tests/qemu-iotests/142 | 5 ++---
 tests/qemu-iotests/143 | 5 ++---
 tests/qemu-iotests/144 | 5 ++---
 tests/qemu-iotests/145 | 5 ++---
 tests/qemu-iotests/146 | 5 ++---
 tests/qemu-iotests/150 | 5 ++---
 tests/qemu-iotests/153 | 5 ++---
 tests/qemu-iotests/154 | 5 ++---
 tests/qemu-iotests/156 | 5 ++---
 tests/qemu-iotests/157 | 5 ++---
 tests/qemu-iotests/158 | 5 ++---
 tests/qemu-iotests/159 | 4 ++--
 tests/qemu-iotests/160 | 4 ++--
 tests/qemu-iotests/162 | 5 ++---
 tests/qemu-iotests/170 | 4 ++--
 tests/qemu-iotests/171 | 5 ++---
 tests/qemu-iotests/172 | 5 ++---
 tests/qemu-iotests/173 | 4 ++--
 tests/qemu-iotests/174 | 5 ++---
 tests/qemu-iotests/175 | 5 ++---
 tests/qemu-iotests/176 | 5 ++---
 tests/qemu-iotests/177 | 5 ++---
 tests/qemu-iotests/178 | 5 ++---
 tests/qemu-iotests/179 | 5 ++---
 tests/qemu-iotests/181 | 5 ++---
 tests/qemu-iotests/182 | 5 ++---
 tests/qemu-iotests/183 | 5 ++---
 tests/qemu-iotests/184 | 5 ++---
 tests/qemu-iotests/185 | 5 ++---
 tests/qemu-iotests/186 | 5 ++---
 tests/qemu-iotests/187 | 5 ++---
 tests/qemu-iotests/188 | 5 ++---
 tests/qemu-iotests/189 | 5 ++---
 tests/qemu-iotests/190 | 5 ++---
 tests/qemu-iotests/191 | 5 ++---
 tests/qemu-iotests/192 | 5 ++---
 tests/qemu-iotests/195 | 5 ++---
 tests/qemu-iotests/197 | 5 ++---
 160 files changed, 318 insertions(+), 470 deletions(-)

diff --git a/tests/qemu-iotests/001 b/tests/qemu-iotests/001
index 22d82e4be8..b38fb0c73d 100755
--- a/tests/qemu-iotests/001
+++ b/tests/qemu-iotests/001
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=hch@lst.de
+# Creator/Owner: hch@lst.de
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/002 b/tests/qemu-iotests/002
index 6fd7183974..608d62652a 100755
--- a/tests/qemu-iotests/002
+++ b/tests/qemu-iotests/002
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=hch@lst.de
+# Creator/Owner: hch@lst.de
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/003 b/tests/qemu-iotests/003
index acad5a2a4d..68beb32aea 100755
--- a/tests/qemu-iotests/003
+++ b/tests/qemu-iotests/003
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=hch@lst.de
+# Creator/Owner: hch@lst.de
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/004 b/tests/qemu-iotests/004
index 954a46ef7b..5afb23c9fd 100755
--- a/tests/qemu-iotests/004
+++ b/tests/qemu-iotests/004
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=hch@lst.de
+# Creator/Owner: hch@lst.de
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
index f77caab3eb..a860062847 100755
--- a/tests/qemu-iotests/005
+++ b/tests/qemu-iotests/005
@@ -20,9 +20,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=hch@lst.de
+# Creator/Owner: hch@lst.de
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/007 b/tests/qemu-iotests/007
index b0bd1e1520..f9048f9a7a 100755
--- a/tests/qemu-iotests/007
+++ b/tests/qemu-iotests/007
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/008 b/tests/qemu-iotests/008
index 7ab1a403f1..7755c00a43 100755
--- a/tests/qemu-iotests/008
+++ b/tests/qemu-iotests/008
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=hch@lst.de
+# Creator/Owner: hch@lst.de
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/009 b/tests/qemu-iotests/009
index aeaed1d782..418c0a56f7 100755
--- a/tests/qemu-iotests/009
+++ b/tests/qemu-iotests/009
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/010 b/tests/qemu-iotests/010
index ce3e939796..6e9beb953d 100755
--- a/tests/qemu-iotests/010
+++ b/tests/qemu-iotests/010
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/011 b/tests/qemu-iotests/011
index 8c98c9510e..275b0cc29c 100755
--- a/tests/qemu-iotests/011
+++ b/tests/qemu-iotests/011
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/012 b/tests/qemu-iotests/012
index 484b47a9d3..59cac183e2 100755
--- a/tests/qemu-iotests/012
+++ b/tests/qemu-iotests/012
@@ -19,9 +19,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=hch@lst.de
+# Creator/Owner: hch@lst.de
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/013 b/tests/qemu-iotests/013
index afc4c5a2b0..d33969be6a 100755
--- a/tests/qemu-iotests/013
+++ b/tests/qemu-iotests/013
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/014 b/tests/qemu-iotests/014
index 7307e10015..360379f2b3 100755
--- a/tests/qemu-iotests/014
+++ b/tests/qemu-iotests/014
@@ -19,9 +19,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/015 b/tests/qemu-iotests/015
index 735f597dac..c1b920fd56 100755
--- a/tests/qemu-iotests/015
+++ b/tests/qemu-iotests/015
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/017 b/tests/qemu-iotests/017
index 765dee9157..b2a95c5166 100755
--- a/tests/qemu-iotests/017
+++ b/tests/qemu-iotests/017
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/018 b/tests/qemu-iotests/018
index ae7907c1e9..5375eae206 100755
--- a/tests/qemu-iotests/018
+++ b/tests/qemu-iotests/018
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/019 b/tests/qemu-iotests/019
index 3b0e97feb9..c2af8a0236 100755
--- a/tests/qemu-iotests/019
+++ b/tests/qemu-iotests/019
@@ -19,9 +19,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index a2bad2f04e..0361809a6d 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/021 b/tests/qemu-iotests/021
index e34d50be52..2ea6b1d161 100755
--- a/tests/qemu-iotests/021
+++ b/tests/qemu-iotests/021
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=hch@lst.de
+# Creator/Owner: hch@lst.de
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/022 b/tests/qemu-iotests/022
index 13c13e3e3e..f577278db9 100755
--- a/tests/qemu-iotests/022
+++ b/tests/qemu-iotests/022
@@ -19,9 +19,8 @@
 # Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
 # USA
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/023 b/tests/qemu-iotests/023
index c7d64cf026..ca8440ad83 100755
--- a/tests/qemu-iotests/023
+++ b/tests/qemu-iotests/023
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index d2efc27aae..189d5c3fc1 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/025 b/tests/qemu-iotests/025
index afb5cf0ae0..eb12d1c7d6 100755
--- a/tests/qemu-iotests/025
+++ b/tests/qemu-iotests/025
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=stefanha@linux.vnet.ibm.com
+# Creator/Owner: stefanha@linux.vnet.ibm.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index a3be017ccb..3fb915f289 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/027 b/tests/qemu-iotests/027
index ea950e09d1..9a25a63c28 100755
--- a/tests/qemu-iotests/027
+++ b/tests/qemu-iotests/027
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=stefanha@linux.vnet.ibm.com
+# Creator/Owner: stefanha@linux.vnet.ibm.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index 0192004d84..e75611bab3 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -20,9 +20,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=stefanha@linux.vnet.ibm.com
+# Creator/Owner: stefanha@linux.vnet.ibm.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/029 b/tests/qemu-iotests/029
index d18d004e18..01ed075402 100755
--- a/tests/qemu-iotests/029
+++ b/tests/qemu-iotests/029
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/031 b/tests/qemu-iotests/031
index b2aa016e00..1ac200f191 100755
--- a/tests/qemu-iotests/031
+++ b/tests/qemu-iotests/031
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/032 b/tests/qemu-iotests/032
index 97404db0da..c9f9cf5439 100755
--- a/tests/qemu-iotests/032
+++ b/tests/qemu-iotests/032
@@ -19,9 +19,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/033 b/tests/qemu-iotests/033
index 1b9c3ba37a..dd8fc32ea8 100755
--- a/tests/qemu-iotests/033
+++ b/tests/qemu-iotests/033
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=pbonzini@redhat.com
+# Creator/Owner: pbonzini@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/034 b/tests/qemu-iotests/034
index 8c9db83134..1bdd7f2e04 100755
--- a/tests/qemu-iotests/034
+++ b/tests/qemu-iotests/034
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/035 b/tests/qemu-iotests/035
index cead994725..1cd2475ba6 100755
--- a/tests/qemu-iotests/035
+++ b/tests/qemu-iotests/035
@@ -18,9 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
index 07f3d30f77..e49e4a7f85 100755
--- a/tests/qemu-iotests/036
+++ b/tests/qemu-iotests/036
@@ -20,9 +20,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=stefanha@linux.vnet.ibm.com
+# Creator/Owner: stefanha@linux.vnet.ibm.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/037 b/tests/qemu-iotests/037
index 510d113990..06ba02a9f9 100755
--- a/tests/qemu-iotests/037
+++ b/tests/qemu-iotests/037
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/038 b/tests/qemu-iotests/038
index 2286c081d6..1ad0efd1a3 100755
--- a/tests/qemu-iotests/038
+++ b/tests/qemu-iotests/038
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index cc1e7d74db..cf83895f23 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -20,9 +20,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=stefanha@linux.vnet.ibm.com
+# Creator/Owner: stefanha@linux.vnet.ibm.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 90b5b4f2ad..4466811195 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -20,6 +20,7 @@
 #
 # Test for live block commit
 # Derived from Image Streaming Test 030
+#
 
 import time
 import os
diff --git a/tests/qemu-iotests/042 b/tests/qemu-iotests/042
index 45d533b7d9..db66fc8434 100755
--- a/tests/qemu-iotests/042
+++ b/tests/qemu-iotests/042
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/043 b/tests/qemu-iotests/043
index b63073db37..7d106ddb3b 100755
--- a/tests/qemu-iotests/043
+++ b/tests/qemu-iotests/043
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=stefanha@redhat.com
+# Creator/Owner: stefanha@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index 09192b25de..f6914ccd1e 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/047 b/tests/qemu-iotests/047
index a11d212d44..474c5cb47d 100755
--- a/tests/qemu-iotests/047
+++ b/tests/qemu-iotests/047
@@ -18,9 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/048 b/tests/qemu-iotests/048
index f75cb4926e..531bed217c 100755
--- a/tests/qemu-iotests/048
+++ b/tests/qemu-iotests/048
@@ -19,8 +19,8 @@
 ## along with this program.  If not, see <http://www.gnu.org/licenses/>.
 ##
 #
-# creator
-owner=mrezanin@redhat.com
+# Creator/Owner: mrezanin@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/049 b/tests/qemu-iotests/049
index 20207a7023..2f4d8ab932 100755
--- a/tests/qemu-iotests/049
+++ b/tests/qemu-iotests/049
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/050 b/tests/qemu-iotests/050
index 9d22200910..7096fa535c 100755
--- a/tests/qemu-iotests/050
+++ b/tests/qemu-iotests/050
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=pbonzini@redhat.com
+# Creator/Owner: pbonzini@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 0ad210c560..e726df6e01 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/052 b/tests/qemu-iotests/052
index 3355094e3e..c521a6fc36 100755
--- a/tests/qemu-iotests/052
+++ b/tests/qemu-iotests/052
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=stefanha@redhat.com
+# Creator/Owner: stefanha@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/053 b/tests/qemu-iotests/053
index 09e6a4f8bb..c8fda86672 100755
--- a/tests/qemu-iotests/053
+++ b/tests/qemu-iotests/053
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=stefanha@redhat.com
+# Creator/Owner: stefanha@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/054 b/tests/qemu-iotests/054
index 46d0714881..bcea34ef86 100755
--- a/tests/qemu-iotests/054
+++ b/tests/qemu-iotests/054
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/058 b/tests/qemu-iotests/058
index 34dcd10a58..17970357cd 100755
--- a/tests/qemu-iotests/058
+++ b/tests/qemu-iotests/058
@@ -19,9 +19,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=xiawenc@linux.vnet.ibm.com
+# Creator/Owner: xiawenc@linux.vnet.ibm.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index 96883b78b9..6af6c6fada 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=famz@redhat.com
+# Creator/Owner: famz@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 5775ec2871..d562b2c967 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index 2097d64fe4..ffc27213a5 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/062 b/tests/qemu-iotests/062
index 6116453e30..4c6c3d70f4 100755
--- a/tests/qemu-iotests/062
+++ b/tests/qemu-iotests/062
@@ -18,9 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/063 b/tests/qemu-iotests/063
index fbffd6d9e7..29acdf3a8b 100755
--- a/tests/qemu-iotests/063
+++ b/tests/qemu-iotests/063
@@ -18,9 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=alex@alex.org.uk
+# Creator/Owner: alex@alex.org.uk
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/064 b/tests/qemu-iotests/064
index 3bfb46146a..0f220282c7 100755
--- a/tests/qemu-iotests/064
+++ b/tests/qemu-iotests/064
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=jcody@redhat.com
+# Creator/Owner: jcody@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/066 b/tests/qemu-iotests/066
index f29fcc7eae..c8b0bee3be 100755
--- a/tests/qemu-iotests/066
+++ b/tests/qemu-iotests/066
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/067 b/tests/qemu-iotests/067
index cbc3180af0..976822b34c 100755
--- a/tests/qemu-iotests/067
+++ b/tests/qemu-iotests/067
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
index a0df34898e..dc00ee1c2d 100755
--- a/tests/qemu-iotests/068
+++ b/tests/qemu-iotests/068
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/069 b/tests/qemu-iotests/069
index e01cbc98f4..1d44ef37a1 100755
--- a/tests/qemu-iotests/069
+++ b/tests/qemu-iotests/069
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/070 b/tests/qemu-iotests/070
index 6cbe62e1a0..d52a85f624 100755
--- a/tests/qemu-iotests/070
+++ b/tests/qemu-iotests/070
@@ -18,9 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=jcody@redhat.com
+# Creator/Owner: jcody@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 66806e3a8c..fd74238312 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/072 b/tests/qemu-iotests/072
index 2d28db91d5..568f8774d8 100755
--- a/tests/qemu-iotests/072
+++ b/tests/qemu-iotests/072
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/073 b/tests/qemu-iotests/073
index 2738010eb3..37e68263b4 100755
--- a/tests/qemu-iotests/073
+++ b/tests/qemu-iotests/073
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/074 b/tests/qemu-iotests/074
index 0dcbe946da..d454580067 100755
--- a/tests/qemu-iotests/074
+++ b/tests/qemu-iotests/074
@@ -18,9 +18,8 @@
 ## You should have received a copy of the GNU General Public License
 ## along with this program.  If not, see <http://www.gnu.org/licenses/>.
 ##
+## Creator/Owner: famz@redhat.com
 #
-# creator
-owner=famz@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/075 b/tests/qemu-iotests/075
index 2e819c2a5a..3e7ab6de95 100755
--- a/tests/qemu-iotests/075
+++ b/tests/qemu-iotests/075
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=stefanha@redhat.com
+# Creator/Owner: stefanha@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/076 b/tests/qemu-iotests/076
index d7406739a1..df4a1614fb 100755
--- a/tests/qemu-iotests/076
+++ b/tests/qemu-iotests/076
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/077 b/tests/qemu-iotests/077
index eb6a189bdf..8d4be8c1e8 100755
--- a/tests/qemu-iotests/077
+++ b/tests/qemu-iotests/077
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/078 b/tests/qemu-iotests/078
index 1664c9c74c..b5f7c3a44a 100755
--- a/tests/qemu-iotests/078
+++ b/tests/qemu-iotests/078
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
index fc9de46cc7..3363e43146 100755
--- a/tests/qemu-iotests/079
+++ b/tests/qemu-iotests/079
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=hutao@cn.fujitsu.com
+# Creator/Owner: hutao@cn.fujitsu.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index 0947ed0559..e7e7caf00d 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/081 b/tests/qemu-iotests/081
index b067348fb2..33b18106c1 100755
--- a/tests/qemu-iotests/081
+++ b/tests/qemu-iotests/081
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=benoit@irqsave.net
+# Creator/Owner: benoit@irqsave.net
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index 64075693f3..fd904d69f8 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/083 b/tests/qemu-iotests/083
index b724b6bf14..51fd8825b4 100755
--- a/tests/qemu-iotests/083
+++ b/tests/qemu-iotests/083
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=stefanha@redhat.com
+# Creator/Owner: stefanha@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/084 b/tests/qemu-iotests/084
index 1a610e1ad4..333488a949 100755
--- a/tests/qemu-iotests/084
+++ b/tests/qemu-iotests/084
@@ -18,9 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=jcody@redhat.com
+# Creator/Owner: jcody@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index 12df84d6bc..da481225d6 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -22,9 +22,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=jcody@redhat.com
+# Creator/Owner: jcody@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/086 b/tests/qemu-iotests/086
index 9329e14b62..8611514049 100755
--- a/tests/qemu-iotests/086
+++ b/tests/qemu-iotests/086
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index 3e29e5f9fe..dd6e5976ca 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/088 b/tests/qemu-iotests/088
index dcde4813d2..f6e1848ce9 100755
--- a/tests/qemu-iotests/088
+++ b/tests/qemu-iotests/088
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index e1093f73c3..f925f5f245 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/090 b/tests/qemu-iotests/090
index f88b3a7992..2ae70f7d79 100755
--- a/tests/qemu-iotests/090
+++ b/tests/qemu-iotests/090
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index b1c5988c8a..48cf18d312 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -19,9 +19,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=jcody@redhat.com
+# Creator/Owner: jcody@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/092 b/tests/qemu-iotests/092
index eb6064daeb..eeb039c7bd 100755
--- a/tests/qemu-iotests/092
+++ b/tests/qemu-iotests/092
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/094 b/tests/qemu-iotests/094
index e8a07c195b..aa5faff5de 100755
--- a/tests/qemu-iotests/094
+++ b/tests/qemu-iotests/094
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/095 b/tests/qemu-iotests/095
index da0cc9fed2..fa17640c2c 100755
--- a/tests/qemu-iotests/095
+++ b/tests/qemu-iotests/095
@@ -21,8 +21,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-# creator
-owner=jcody@redhat.com
+# Creator/Owner: jcody@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/097 b/tests/qemu-iotests/097
index 10aa13a0ce..2914da2da3 100755
--- a/tests/qemu-iotests/097
+++ b/tests/qemu-iotests/097
@@ -18,9 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/098 b/tests/qemu-iotests/098
index 61c27f1f46..97f890dcf7 100755
--- a/tests/qemu-iotests/098
+++ b/tests/qemu-iotests/098
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/099 b/tests/qemu-iotests/099
index 90924c2ad2..8e8306d1e3 100755
--- a/tests/qemu-iotests/099
+++ b/tests/qemu-iotests/099
@@ -18,9 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/101 b/tests/qemu-iotests/101
index 663038378b..38dace6aec 100755
--- a/tests/qemu-iotests/101
+++ b/tests/qemu-iotests/101
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=stefanha@redhat.com
+# Creator/Owner: stefanha@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
index 4ed1f77542..0fac4555b2 100755
--- a/tests/qemu-iotests/102
+++ b/tests/qemu-iotests/102
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq=$(basename $0)
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
index 0185cc73b2..55df533835 100755
--- a/tests/qemu-iotests/103
+++ b/tests/qemu-iotests/103
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq=$(basename $0)
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/104 b/tests/qemu-iotests/104
index 869f6c5c09..903471346f 100755
--- a/tests/qemu-iotests/104
+++ b/tests/qemu-iotests/104
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=hutao@cn.fujitsu.com
+# Creator/Owner: hutao@cn.fujitsu.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/105 b/tests/qemu-iotests/105
index 0f1c73eacd..68c6b732c2 100755
--- a/tests/qemu-iotests/105
+++ b/tests/qemu-iotests/105
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=famz@redhat.com
+# Creator/Owner: famz@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
index 4adf5b8e74..9771198d70 100755
--- a/tests/qemu-iotests/106
+++ b/tests/qemu-iotests/106
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq=$(basename $0)
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/107 b/tests/qemu-iotests/107
index 92c5854a80..7ddb27fbc9 100755
--- a/tests/qemu-iotests/107
+++ b/tests/qemu-iotests/107
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
index d44fc8ae17..1284fc98d1 100755
--- a/tests/qemu-iotests/108
+++ b/tests/qemu-iotests/108
@@ -18,9 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
index 6bf5deb664..87985f66fb 100755
--- a/tests/qemu-iotests/109
+++ b/tests/qemu-iotests/109
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index ea8eecb3e7..0f62778f15 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/111 b/tests/qemu-iotests/111
index 73396468d4..85b6dd1746 100755
--- a/tests/qemu-iotests/111
+++ b/tests/qemu-iotests/111
@@ -18,9 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/112 b/tests/qemu-iotests/112
index ac5745a559..5c4ecfeb4c 100755
--- a/tests/qemu-iotests/112
+++ b/tests/qemu-iotests/112
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/113 b/tests/qemu-iotests/113
index 69c2dab1bc..91af75d687 100755
--- a/tests/qemu-iotests/113
+++ b/tests/qemu-iotests/113
@@ -18,9 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/114 b/tests/qemu-iotests/114
index a35f2baa61..66313cae91 100755
--- a/tests/qemu-iotests/114
+++ b/tests/qemu-iotests/114
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/115 b/tests/qemu-iotests/115
index cdd095bde2..2f06622e36 100755
--- a/tests/qemu-iotests/115
+++ b/tests/qemu-iotests/115
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/116 b/tests/qemu-iotests/116
index b5e962130b..7378c34bd6 100755
--- a/tests/qemu-iotests/116
+++ b/tests/qemu-iotests/116
@@ -20,9 +20,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=stefanha@redhat.com
+# Creator/Owner: stefanha@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/117 b/tests/qemu-iotests/117
index 147d19053b..2ace2c9f89 100755
--- a/tests/qemu-iotests/117
+++ b/tests/qemu-iotests/117
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/119 b/tests/qemu-iotests/119
index d2342ff0bd..3df227748a 100755
--- a/tests/qemu-iotests/119
+++ b/tests/qemu-iotests/119
@@ -18,9 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/120 b/tests/qemu-iotests/120
index 83bc551d16..0ce0a2c9cd 100755
--- a/tests/qemu-iotests/120
+++ b/tests/qemu-iotests/120
@@ -18,9 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/121 b/tests/qemu-iotests/121
index 6c69c2beee..c6ce9e782a 100755
--- a/tests/qemu-iotests/121
+++ b/tests/qemu-iotests/121
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index 10104ea49a..e513b6abbf 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/123 b/tests/qemu-iotests/123
index 8f68a76ee4..9edcc4c8d2 100755
--- a/tests/qemu-iotests/123
+++ b/tests/qemu-iotests/123
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
index 62a6d7fb1f..1a11496024 100755
--- a/tests/qemu-iotests/125
+++ b/tests/qemu-iotests/125
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq=$(basename $0)
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
index f3058e046a..73ed16a9af 100755
--- a/tests/qemu-iotests/126
+++ b/tests/qemu-iotests/126
@@ -18,9 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/127 b/tests/qemu-iotests/127
index 34e1eddc57..ee7e3d365d 100755
--- a/tests/qemu-iotests/127
+++ b/tests/qemu-iotests/127
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq=$(basename $0)
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/128 b/tests/qemu-iotests/128
index 934b6e7e33..412d4f86ca 100755
--- a/tests/qemu-iotests/128
+++ b/tests/qemu-iotests/128
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=stefanha@redhat.com
+# Creator/Owner: stefanha@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/130 b/tests/qemu-iotests/130
index 4906019543..e5986d59bb 100755
--- a/tests/qemu-iotests/130
+++ b/tests/qemu-iotests/130
@@ -19,9 +19,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/131 b/tests/qemu-iotests/131
index fb771fed95..930a80e02f 100755
--- a/tests/qemu-iotests/131
+++ b/tests/qemu-iotests/131
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=den@openvz.org
+# Creator/Owner: den@openvz.org
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
index 1daf5895c1..61af222c9e 100755
--- a/tests/qemu-iotests/133
+++ b/tests/qemu-iotests/133
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index 5d476e1b16..59f2662614 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=berrange@redhat.com
+# Creator/Owner: berrange@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/135 b/tests/qemu-iotests/135
index 676e2a2c70..a6d35c147a 100755
--- a/tests/qemu-iotests/135
+++ b/tests/qemu-iotests/135
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=jcody@redhat.com
+# Creator/Owner: jcody@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
index 66ea0e9d1a..1c3981c982 100755
--- a/tests/qemu-iotests/137
+++ b/tests/qemu-iotests/137
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
index 5624ef11db..4b21217038 100755
--- a/tests/qemu-iotests/138
+++ b/tests/qemu-iotests/138
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
index a0d255ee5f..bdc1e08027 100755
--- a/tests/qemu-iotests/140
+++ b/tests/qemu-iotests/140
@@ -21,9 +21,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
index 0bee4f8cde..c5e3981530 100755
--- a/tests/qemu-iotests/141
+++ b/tests/qemu-iotests/141
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/142 b/tests/qemu-iotests/142
index dca66f8675..6a8d6d8daa 100755
--- a/tests/qemu-iotests/142
+++ b/tests/qemu-iotests/142
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/143 b/tests/qemu-iotests/143
index 2a8a1f044f..100d225e24 100755
--- a/tests/qemu-iotests/143
+++ b/tests/qemu-iotests/143
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/144 b/tests/qemu-iotests/144
index c12441a632..65fcfb77a6 100755
--- a/tests/qemu-iotests/144
+++ b/tests/qemu-iotests/144
@@ -19,9 +19,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=jcody@redhat.com
+# Creator/Owner: jcody@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
index cd02edd3a8..3fa205a07d 100755
--- a/tests/qemu-iotests/145
+++ b/tests/qemu-iotests/145
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/146 b/tests/qemu-iotests/146
index 30fe5e07bc..6b418c60f7 100755
--- a/tests/qemu-iotests/146
+++ b/tests/qemu-iotests/146
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=jcody@redhat.com
+# Creator/Owner: jcody@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/150 b/tests/qemu-iotests/150
index 6e77566d78..51e4e124cd 100755
--- a/tests/qemu-iotests/150
+++ b/tests/qemu-iotests/150
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index 6947b017f0..ae9158fa91 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=famz@redhat.com
+# Creator/Owner: famz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/154 b/tests/qemu-iotests/154
index d8f07422ca..7bf0c2e91e 100755
--- a/tests/qemu-iotests/154
+++ b/tests/qemu-iotests/154
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index 907d5f4e42..62100fff7a 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -25,9 +25,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/157 b/tests/qemu-iotests/157
index 4f2e299008..2b2b886e99 100755
--- a/tests/qemu-iotests/157
+++ b/tests/qemu-iotests/157
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index 51c46dd259..fe3318bbe2 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=berrange@redhat.com
+# Creator/Owner: berrange@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/159 b/tests/qemu-iotests/159
index 463228de96..799ff57040 100755
--- a/tests/qemu-iotests/159
+++ b/tests/qemu-iotests/159
@@ -17,8 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-owner=fullmanet@gmail.com
+# Creator/Owner: fullmanet@gmail.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/160 b/tests/qemu-iotests/160
index ae6f799c9f..41ffad5774 100755
--- a/tests/qemu-iotests/160
+++ b/tests/qemu-iotests/160
@@ -17,8 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-owner=fullmanet@gmail.com
+# Creator/Owner: fullmanet@gmail.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/162 b/tests/qemu-iotests/162
index 0572e91c9a..6cadc0c75b 100755
--- a/tests/qemu-iotests/162
+++ b/tests/qemu-iotests/162
@@ -18,9 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/170 b/tests/qemu-iotests/170
index 9454485e52..736c61f8e9 100755
--- a/tests/qemu-iotests/170
+++ b/tests/qemu-iotests/170
@@ -17,8 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-owner=fullmanet@gmail.com
+# Creator/Owner: fullmanet@gmail.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/171 b/tests/qemu-iotests/171
index 2c6d6e4995..3ea97f46b6 100755
--- a/tests/qemu-iotests/171
+++ b/tests/qemu-iotests/171
@@ -18,9 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=tgolembi@redhat.com
+# Creator/Owner: tgolembi@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
index 0b63d0b116..2fd80c7844 100755
--- a/tests/qemu-iotests/172
+++ b/tests/qemu-iotests/172
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/173 b/tests/qemu-iotests/173
index f08f4d93d1..0df1865199 100755
--- a/tests/qemu-iotests/173
+++ b/tests/qemu-iotests/173
@@ -18,8 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-# creator
-owner=jcody@redhat.com
+# Creator/Owner: jcody@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/174 b/tests/qemu-iotests/174
index 46f557402f..2c530a1e64 100755
--- a/tests/qemu-iotests/174
+++ b/tests/qemu-iotests/174
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=nirsof@gmail.com
+# Creator/Owner: nirsof@gmail.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index d96ac79b04..a000405737 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=nirsof@gmail.com
+# Creator/Owner: nirsof@gmail.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/176 b/tests/qemu-iotests/176
index b0f87e4bf4..9928833137 100755
--- a/tests/qemu-iotests/176
+++ b/tests/qemu-iotests/176
@@ -21,9 +21,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=mreitz@redhat.com
+# Creator/Owner: mreitz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/177 b/tests/qemu-iotests/177
index 3afad516da..2c0c70ec6d 100755
--- a/tests/qemu-iotests/177
+++ b/tests/qemu-iotests/177
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=eblake@redhat.com
+# Creator/Owner: eblake@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
index 875b4e002b..ffa3d3148b 100755
--- a/tests/qemu-iotests/178
+++ b/tests/qemu-iotests/178
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=stefanha@redhat.com
+# Creator/Owner: stefanha@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/179 b/tests/qemu-iotests/179
index 45f82a1a2d..ccede3bc04 100755
--- a/tests/qemu-iotests/179
+++ b/tests/qemu-iotests/179
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=eblake@redhat.com
+# Creator/Owner: eblake@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index c0254623b1..b308c8194f 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
index 4fbc1d95f9..c7cd4ff678 100755
--- a/tests/qemu-iotests/182
+++ b/tests/qemu-iotests/182
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=famz@redhat.com
+# Creator/Owner: famz@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index 320d03e6f6..764632c16b 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
index e2af0660c7..1b2859de5a 100755
--- a/tests/qemu-iotests/184
+++ b/tests/qemu-iotests/184
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner="Manos Pitsidianakis"
+# Creator/Owner: Manos Pitsidianakis
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index 7ba20c9eb7..563ae366fd 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index c7e28d4435..3d52508452 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/187 b/tests/qemu-iotests/187
index a53d2637e0..4351702784 100755
--- a/tests/qemu-iotests/187
+++ b/tests/qemu-iotests/187
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/188 b/tests/qemu-iotests/188
index ba523e0b50..042bf96178 100755
--- a/tests/qemu-iotests/188
+++ b/tests/qemu-iotests/188
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=berrange@redhat.com
+# Creator/Owner: berrange@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/189 b/tests/qemu-iotests/189
index a2f62fc520..9108495d99 100755
--- a/tests/qemu-iotests/189
+++ b/tests/qemu-iotests/189
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=berrange@redhat.com
+# Creator/Owner: berrange@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/190 b/tests/qemu-iotests/190
index 0a848a6c94..aceba63b49 100755
--- a/tests/qemu-iotests/190
+++ b/tests/qemu-iotests/190
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=eblake@redhat.com
+# Creator/Owner: eblake@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index b29822c9c3..25d94211d9 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
index 4bf2ea2757..37fbb71cd0 100755
--- a/tests/qemu-iotests/192
+++ b/tests/qemu-iotests/192
@@ -18,9 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=famz@redhat.com
+# Creator/Owner: famz@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/195 b/tests/qemu-iotests/195
index 31135ac290..248cf90f53 100755
--- a/tests/qemu-iotests/195
+++ b/tests/qemu-iotests/195
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=kwolf@redhat.com
+# Creator/Owner: kwolf@redhat.com
+#
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index 0f7361611f..9fb4a694a1 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -17,9 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=eblake@redhat.com
+# Creator/Owner: eblake@redhat.com
+#
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
-- 
2.13.6
