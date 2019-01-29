Received: from eggs.gnu.org ([209.51.188.92]:35065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXdE-0003B8-9X
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXd3-0001GH-Sn
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:57:06 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 29 Jan 2019 18:53:51 +0100
Message-Id: <20190129175403.18017-7-philmd@redhat.com>
In-Reply-To: <20190129175403.18017-1-philmd@redhat.com>
References: <20190129175403.18017-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 06/18] qemu-iotests: Improve portability by
 searching bash in the $PATH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

Bash is not always installed as /bin/bash. In particular on OpenBSD,
the package installs it in /usr/local/bin.
Use the 'env' shebang to search bash in the $PATH.

Patch created mechanically by running:

  $ git grep -lE '#! ?/bin/bash' -- tests/qemu-iotests | \
    while read f; do \
      sed -i 's_#!.\?/bin/bash_#! /usr/bin/env bash_' $f; \
    done

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Can 'env' be located elsewhere than /usr/bin/env?
---
 tests/qemu-iotests/001            | 2 +-
 tests/qemu-iotests/002            | 2 +-
 tests/qemu-iotests/003            | 2 +-
 tests/qemu-iotests/004            | 2 +-
 tests/qemu-iotests/005            | 2 +-
 tests/qemu-iotests/007            | 2 +-
 tests/qemu-iotests/008            | 2 +-
 tests/qemu-iotests/009            | 2 +-
 tests/qemu-iotests/010            | 2 +-
 tests/qemu-iotests/011            | 2 +-
 tests/qemu-iotests/012            | 2 +-
 tests/qemu-iotests/013            | 2 +-
 tests/qemu-iotests/014            | 2 +-
 tests/qemu-iotests/015            | 2 +-
 tests/qemu-iotests/017            | 2 +-
 tests/qemu-iotests/018            | 2 +-
 tests/qemu-iotests/019            | 2 +-
 tests/qemu-iotests/020            | 2 +-
 tests/qemu-iotests/021            | 2 +-
 tests/qemu-iotests/022            | 2 +-
 tests/qemu-iotests/023            | 2 +-
 tests/qemu-iotests/024            | 2 +-
 tests/qemu-iotests/025            | 2 +-
 tests/qemu-iotests/026            | 2 +-
 tests/qemu-iotests/027            | 2 +-
 tests/qemu-iotests/028            | 2 +-
 tests/qemu-iotests/029            | 2 +-
 tests/qemu-iotests/031            | 2 +-
 tests/qemu-iotests/032            | 2 +-
 tests/qemu-iotests/033            | 2 +-
 tests/qemu-iotests/034            | 2 +-
 tests/qemu-iotests/035            | 2 +-
 tests/qemu-iotests/036            | 2 +-
 tests/qemu-iotests/037            | 2 +-
 tests/qemu-iotests/038            | 2 +-
 tests/qemu-iotests/039            | 2 +-
 tests/qemu-iotests/042            | 2 +-
 tests/qemu-iotests/043            | 2 +-
 tests/qemu-iotests/046            | 2 +-
 tests/qemu-iotests/047            | 2 +-
 tests/qemu-iotests/048            | 2 +-
 tests/qemu-iotests/049            | 2 +-
 tests/qemu-iotests/050            | 2 +-
 tests/qemu-iotests/051            | 2 +-
 tests/qemu-iotests/052            | 2 +-
 tests/qemu-iotests/053            | 2 +-
 tests/qemu-iotests/054            | 2 +-
 tests/qemu-iotests/058            | 2 +-
 tests/qemu-iotests/059            | 2 +-
 tests/qemu-iotests/060            | 2 +-
 tests/qemu-iotests/061            | 2 +-
 tests/qemu-iotests/062            | 2 +-
 tests/qemu-iotests/063            | 2 +-
 tests/qemu-iotests/064            | 2 +-
 tests/qemu-iotests/066            | 2 +-
 tests/qemu-iotests/067            | 2 +-
 tests/qemu-iotests/068            | 2 +-
 tests/qemu-iotests/069            | 2 +-
 tests/qemu-iotests/070            | 2 +-
 tests/qemu-iotests/071            | 2 +-
 tests/qemu-iotests/072            | 2 +-
 tests/qemu-iotests/073            | 2 +-
 tests/qemu-iotests/074            | 2 +-
 tests/qemu-iotests/075            | 2 +-
 tests/qemu-iotests/076            | 2 +-
 tests/qemu-iotests/077            | 2 +-
 tests/qemu-iotests/078            | 2 +-
 tests/qemu-iotests/079            | 2 +-
 tests/qemu-iotests/080            | 2 +-
 tests/qemu-iotests/081            | 2 +-
 tests/qemu-iotests/082            | 2 +-
 tests/qemu-iotests/083            | 2 +-
 tests/qemu-iotests/084            | 2 +-
 tests/qemu-iotests/085            | 2 +-
 tests/qemu-iotests/086            | 2 +-
 tests/qemu-iotests/087            | 2 +-
 tests/qemu-iotests/088            | 2 +-
 tests/qemu-iotests/089            | 2 +-
 tests/qemu-iotests/090            | 2 +-
 tests/qemu-iotests/091            | 2 +-
 tests/qemu-iotests/092            | 2 +-
 tests/qemu-iotests/094            | 2 +-
 tests/qemu-iotests/095            | 2 +-
 tests/qemu-iotests/097            | 2 +-
 tests/qemu-iotests/098            | 2 +-
 tests/qemu-iotests/099            | 2 +-
 tests/qemu-iotests/101            | 2 +-
 tests/qemu-iotests/102            | 2 +-
 tests/qemu-iotests/103            | 2 +-
 tests/qemu-iotests/104            | 2 +-
 tests/qemu-iotests/105            | 2 +-
 tests/qemu-iotests/106            | 2 +-
 tests/qemu-iotests/107            | 2 +-
 tests/qemu-iotests/108            | 2 +-
 tests/qemu-iotests/109            | 2 +-
 tests/qemu-iotests/110            | 2 +-
 tests/qemu-iotests/111            | 2 +-
 tests/qemu-iotests/112            | 2 +-
 tests/qemu-iotests/113            | 2 +-
 tests/qemu-iotests/114            | 2 +-
 tests/qemu-iotests/115            | 2 +-
 tests/qemu-iotests/116            | 2 +-
 tests/qemu-iotests/117            | 2 +-
 tests/qemu-iotests/119            | 2 +-
 tests/qemu-iotests/120            | 2 +-
 tests/qemu-iotests/121            | 2 +-
 tests/qemu-iotests/122            | 2 +-
 tests/qemu-iotests/123            | 2 +-
 tests/qemu-iotests/125            | 2 +-
 tests/qemu-iotests/126            | 2 +-
 tests/qemu-iotests/127            | 2 +-
 tests/qemu-iotests/128            | 2 +-
 tests/qemu-iotests/130            | 2 +-
 tests/qemu-iotests/131            | 2 +-
 tests/qemu-iotests/133            | 2 +-
 tests/qemu-iotests/134            | 2 +-
 tests/qemu-iotests/135            | 2 +-
 tests/qemu-iotests/137            | 2 +-
 tests/qemu-iotests/138            | 2 +-
 tests/qemu-iotests/140            | 2 +-
 tests/qemu-iotests/141            | 2 +-
 tests/qemu-iotests/142            | 2 +-
 tests/qemu-iotests/143            | 2 +-
 tests/qemu-iotests/144            | 2 +-
 tests/qemu-iotests/145            | 2 +-
 tests/qemu-iotests/146            | 2 +-
 tests/qemu-iotests/150            | 2 +-
 tests/qemu-iotests/153            | 2 +-
 tests/qemu-iotests/154            | 2 +-
 tests/qemu-iotests/156            | 2 +-
 tests/qemu-iotests/157            | 2 +-
 tests/qemu-iotests/158            | 2 +-
 tests/qemu-iotests/159            | 2 +-
 tests/qemu-iotests/160            | 2 +-
 tests/qemu-iotests/161            | 2 +-
 tests/qemu-iotests/162            | 2 +-
 tests/qemu-iotests/170            | 2 +-
 tests/qemu-iotests/171            | 2 +-
 tests/qemu-iotests/172            | 2 +-
 tests/qemu-iotests/173            | 2 +-
 tests/qemu-iotests/174            | 2 +-
 tests/qemu-iotests/175            | 2 +-
 tests/qemu-iotests/176            | 2 +-
 tests/qemu-iotests/177            | 2 +-
 tests/qemu-iotests/178            | 2 +-
 tests/qemu-iotests/179            | 2 +-
 tests/qemu-iotests/181            | 2 +-
 tests/qemu-iotests/182            | 2 +-
 tests/qemu-iotests/183            | 2 +-
 tests/qemu-iotests/184            | 2 +-
 tests/qemu-iotests/185            | 2 +-
 tests/qemu-iotests/186            | 2 +-
 tests/qemu-iotests/187            | 2 +-
 tests/qemu-iotests/188            | 2 +-
 tests/qemu-iotests/189            | 2 +-
 tests/qemu-iotests/190            | 2 +-
 tests/qemu-iotests/191            | 2 +-
 tests/qemu-iotests/192            | 2 +-
 tests/qemu-iotests/195            | 2 +-
 tests/qemu-iotests/197            | 2 +-
 tests/qemu-iotests/198            | 2 +-
 tests/qemu-iotests/200            | 2 +-
 tests/qemu-iotests/201            | 2 +-
 tests/qemu-iotests/204            | 2 +-
 tests/qemu-iotests/214            | 2 +-
 tests/qemu-iotests/215            | 2 +-
 tests/qemu-iotests/217            | 2 +-
 tests/qemu-iotests/220            | 2 +-
 tests/qemu-iotests/221            | 2 +-
 tests/qemu-iotests/223            | 2 +-
 tests/qemu-iotests/225            | 2 +-
 tests/qemu-iotests/226            | 2 +-
 tests/qemu-iotests/227            | 2 +-
 tests/qemu-iotests/229            | 2 +-
 tests/qemu-iotests/231            | 2 +-
 tests/qemu-iotests/232            | 2 +-
 tests/qemu-iotests/233            | 2 +-
 tests/qemu-iotests/check          | 2 +-
 tests/qemu-iotests/common.config  | 2 +-
 tests/qemu-iotests/common.filter  | 2 +-
 tests/qemu-iotests/common.nbd     | 2 +-
 tests/qemu-iotests/common.pattern | 2 +-
 tests/qemu-iotests/common.qemu    | 2 +-
 tests/qemu-iotests/common.rc      | 2 +-
 tests/qemu-iotests/common.tls     | 2 +-
 185 files changed, 185 insertions(+), 185 deletions(-)

diff --git a/tests/qemu-iotests/001 b/tests/qemu-iotests/001
index 55dcbb71d9..c1031a0815 100755
--- a/tests/qemu-iotests/001
+++ b/tests/qemu-iotests/001
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test simple read/write using plain bdrv_read/bdrv_write
 #
diff --git a/tests/qemu-iotests/002 b/tests/qemu-iotests/002
index 74572b4711..ee414a6b4f 100755
--- a/tests/qemu-iotests/002
+++ b/tests/qemu-iotests/002
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test simple read/write using plain bdrv_pread/bdrv_pwrite
 #
diff --git a/tests/qemu-iotests/003 b/tests/qemu-iotests/003
index bf2595559b..90aadea557 100755
--- a/tests/qemu-iotests/003
+++ b/tests/qemu-iotests/003
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test simple read/write using bdrv_aio_readv/bdrv_aio_writev
 #
diff --git a/tests/qemu-iotests/004 b/tests/qemu-iotests/004
index 841b15dfac..ff5d07fc4c 100755
--- a/tests/qemu-iotests/004
+++ b/tests/qemu-iotests/004
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Make sure we can't read and write outside of the image size.
 #
diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
index 8aa4283a4d..c0fecc331a 100755
--- a/tests/qemu-iotests/005
+++ b/tests/qemu-iotests/005
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Make sure qemu-img can create 5TB images
 #
diff --git a/tests/qemu-iotests/007 b/tests/qemu-iotests/007
index b983022a7f..9c404e7f6b 100755
--- a/tests/qemu-iotests/007
+++ b/tests/qemu-iotests/007
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Check for one possible case of qcow2 refcount corruption.
 #
diff --git a/tests/qemu-iotests/008 b/tests/qemu-iotests/008
index 8dfa10bcb8..3254b2e049 100755
--- a/tests/qemu-iotests/008
+++ b/tests/qemu-iotests/008
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test simple asynchronous read/write operations.
 #
diff --git a/tests/qemu-iotests/009 b/tests/qemu-iotests/009
index 73ae09db69..f7b5162faf 100755
--- a/tests/qemu-iotests/009
+++ b/tests/qemu-iotests/009
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Nolan I qcow2 corruption - incorrectly reports free clusters
 #
diff --git a/tests/qemu-iotests/010 b/tests/qemu-iotests/010
index 751aca9813..4715bec9da 100755
--- a/tests/qemu-iotests/010
+++ b/tests/qemu-iotests/010
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Nolan II qcow2 corruption - wrong used cluster
 #
diff --git a/tests/qemu-iotests/011 b/tests/qemu-iotests/011
index 35909564a9..ae6d9b06f7 100755
--- a/tests/qemu-iotests/011
+++ b/tests/qemu-iotests/011
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test for AIO allocation on the same cluster
 #
diff --git a/tests/qemu-iotests/012 b/tests/qemu-iotests/012
index de9a5fb4d5..91278d6e79 100755
--- a/tests/qemu-iotests/012
+++ b/tests/qemu-iotests/012
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Make sure we can open read-only images
 #
diff --git a/tests/qemu-iotests/013 b/tests/qemu-iotests/013
index 5e1efcee28..0e6d0ee8ba 100755
--- a/tests/qemu-iotests/013
+++ b/tests/qemu-iotests/013
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # qcow2 pattern test, empty and compressed image - 4k cluster patterns
 #
diff --git a/tests/qemu-iotests/014 b/tests/qemu-iotests/014
index 9ade571a95..8abadea3fd 100755
--- a/tests/qemu-iotests/014
+++ b/tests/qemu-iotests/014
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # qcow2 pattern test, complex patterns including compression and snapsho=
ts
 # Using patterns for 4k cluster size.
diff --git a/tests/qemu-iotests/015 b/tests/qemu-iotests/015
index 21f7d42c84..d6c9c1eaa5 100755
--- a/tests/qemu-iotests/015
+++ b/tests/qemu-iotests/015
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Combined test to grow the refcount table and test snapshots.
 #
diff --git a/tests/qemu-iotests/017 b/tests/qemu-iotests/017
index 1ac6f74502..203e404477 100755
--- a/tests/qemu-iotests/017
+++ b/tests/qemu-iotests/017
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Simple backing file reads
 #
diff --git a/tests/qemu-iotests/018 b/tests/qemu-iotests/018
index bba30a1be2..97940b058e 100755
--- a/tests/qemu-iotests/018
+++ b/tests/qemu-iotests/018
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Merge backing file into test image when converting the image
 #
diff --git a/tests/qemu-iotests/019 b/tests/qemu-iotests/019
index 8f911a79c1..34b138bc7f 100755
--- a/tests/qemu-iotests/019
+++ b/tests/qemu-iotests/019
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # When using a backing file for the output image in qemu-img convert,
 # the backing file clusters must not copied. The data must still be
diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index 6b972d082f..70fedda0d1 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Commit changes to backing file
 #
diff --git a/tests/qemu-iotests/021 b/tests/qemu-iotests/021
index c15ebf9eb8..4944381b03 100755
--- a/tests/qemu-iotests/021
+++ b/tests/qemu-iotests/021
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test handling of invalid patterns arguments to qemu-io
 #
diff --git a/tests/qemu-iotests/022 b/tests/qemu-iotests/022
index 44765c7b7a..397071ac79 100755
--- a/tests/qemu-iotests/022
+++ b/tests/qemu-iotests/022
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test bdrv_load/save_vmstate using the usual patterns
 #
diff --git a/tests/qemu-iotests/023 b/tests/qemu-iotests/023
index c8e1b9a761..1aeff56e85 100755
--- a/tests/qemu-iotests/023
+++ b/tests/qemu-iotests/023
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # qcow2 pattern test with various cluster sizes
 #
diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index 428b5c815d..439e64aada 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Rebasing COW images
 #
diff --git a/tests/qemu-iotests/025 b/tests/qemu-iotests/025
index fcd4d97c17..fc9a16120a 100755
--- a/tests/qemu-iotests/025
+++ b/tests/qemu-iotests/025
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Resizing images
 #
diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index 31276d9027..25a66274a5 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # qcow2 error path testing
 #
diff --git a/tests/qemu-iotests/027 b/tests/qemu-iotests/027
index 2c46ae1457..50cf5abda5 100755
--- a/tests/qemu-iotests/027
+++ b/tests/qemu-iotests/027
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test that sub-cluster allocating writes zero the rest of the cluster
 #
diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index a2a7c93bcd..352b15d269 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test that backing files can be smaller than the image
 #
diff --git a/tests/qemu-iotests/029 b/tests/qemu-iotests/029
index cf0fe0f6a6..b6571634d1 100755
--- a/tests/qemu-iotests/029
+++ b/tests/qemu-iotests/029
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # qcow2 internal snapshots/VM state tests
 #
diff --git a/tests/qemu-iotests/031 b/tests/qemu-iotests/031
index ac0dfaed7d..bde0a27514 100755
--- a/tests/qemu-iotests/031
+++ b/tests/qemu-iotests/031
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test that all qcow2 header extensions survive a header rewrite
 #
diff --git a/tests/qemu-iotests/032 b/tests/qemu-iotests/032
index 3e86bb0111..fac4251ac8 100755
--- a/tests/qemu-iotests/032
+++ b/tests/qemu-iotests/032
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test that AIO requests are drained before an image is closed. This use=
d
 # to segfault because the request coroutine kept running even after the
diff --git a/tests/qemu-iotests/033 b/tests/qemu-iotests/033
index 46b91388ef..f510dd4534 100755
--- a/tests/qemu-iotests/033
+++ b/tests/qemu-iotests/033
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test aligned and misaligned write zeroes operations.
 #
diff --git a/tests/qemu-iotests/034 b/tests/qemu-iotests/034
index 62812cd53c..b6bd114755 100755
--- a/tests/qemu-iotests/034
+++ b/tests/qemu-iotests/034
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test bdrv_pwrite_zeroes with backing files (see also 154)
 #
diff --git a/tests/qemu-iotests/035 b/tests/qemu-iotests/035
index 85d9ef7f8e..470ac6938f 100755
--- a/tests/qemu-iotests/035
+++ b/tests/qemu-iotests/035
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Let a few AIO requests run in parallel and have them access different =
L2
 # tables so that the cache has a chance to get used up.
diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
index 4e76602a93..0e0bd01079 100755
--- a/tests/qemu-iotests/036
+++ b/tests/qemu-iotests/036
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test qcow2 feature bits
 #
diff --git a/tests/qemu-iotests/037 b/tests/qemu-iotests/037
index a11992dad2..c56cc49e73 100755
--- a/tests/qemu-iotests/037
+++ b/tests/qemu-iotests/037
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test COW from backing files
 #
diff --git a/tests/qemu-iotests/038 b/tests/qemu-iotests/038
index 575093e8cf..238e195d1d 100755
--- a/tests/qemu-iotests/038
+++ b/tests/qemu-iotests/038
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test COW from backing files with AIO
 #
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index b3c344cb27..a886bb0950 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test qcow2 lazy refcounts
 #
diff --git a/tests/qemu-iotests/042 b/tests/qemu-iotests/042
index beaa339000..c735d9fc93 100755
--- a/tests/qemu-iotests/042
+++ b/tests/qemu-iotests/042
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test qemu-img operation on zero size images
 #
diff --git a/tests/qemu-iotests/043 b/tests/qemu-iotests/043
index fc9005b28f..0758247246 100755
--- a/tests/qemu-iotests/043
+++ b/tests/qemu-iotests/043
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test that qemu-img info --backing-chain detects infinite loops
 #
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index 5e41d96daa..e10be442fb 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test concurrent cluster allocations
 #
diff --git a/tests/qemu-iotests/047 b/tests/qemu-iotests/047
index 6e776d2ce5..4c2d6297ac 100755
--- a/tests/qemu-iotests/047
+++ b/tests/qemu-iotests/047
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Regression test for commit b7ab0fea (which was a corruption fix,
 # despite the commit message claiming otherwise)
diff --git a/tests/qemu-iotests/048 b/tests/qemu-iotests/048
index 9ed04a068d..5963139ef3 100755
--- a/tests/qemu-iotests/048
+++ b/tests/qemu-iotests/048
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 ##
 ## qemu-img compare test
 ##
diff --git a/tests/qemu-iotests/049 b/tests/qemu-iotests/049
index 97d8a64697..92b6333a69 100755
--- a/tests/qemu-iotests/049
+++ b/tests/qemu-iotests/049
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Check qemu-img option parsing
 #
diff --git a/tests/qemu-iotests/050 b/tests/qemu-iotests/050
index 963a0db97f..51bda876e3 100755
--- a/tests/qemu-iotests/050
+++ b/tests/qemu-iotests/050
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test qemu-img rebase with zero clusters
 #
diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 32741d7efd..5717083205 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test command line configuration of block devices and driver-specific o=
ptions
 #
diff --git a/tests/qemu-iotests/052 b/tests/qemu-iotests/052
index b992adf4ff..0985e4724f 100755
--- a/tests/qemu-iotests/052
+++ b/tests/qemu-iotests/052
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test bdrv_read/bdrv_write using BDRV_O_SNAPSHOT
 #
diff --git a/tests/qemu-iotests/053 b/tests/qemu-iotests/053
index afa109c950..1fa7ebf800 100755
--- a/tests/qemu-iotests/053
+++ b/tests/qemu-iotests/053
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test qemu-img convert when image length is not a multiple of cluster s=
ize
 #
diff --git a/tests/qemu-iotests/054 b/tests/qemu-iotests/054
index cf88a7c76e..bd70b2e789 100755
--- a/tests/qemu-iotests/054
+++ b/tests/qemu-iotests/054
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test huge qcow2 images
 #
diff --git a/tests/qemu-iotests/058 b/tests/qemu-iotests/058
index d6d4f94d5d..c5c85e4e7c 100755
--- a/tests/qemu-iotests/058
+++ b/tests/qemu-iotests/058
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test export internal snapshot by qemu-nbd, convert it by qemu-img.
 #
diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index 54d5567acc..4bd2751b51 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for vmdk
 #
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index af0588ae9a..afa764785e 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for image corruption (overlapping data structures) in qcow2
 #
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index 1a50163419..aa1ccb817a 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for image option amendment in qcow2.
 #
diff --git a/tests/qemu-iotests/062 b/tests/qemu-iotests/062
index 985fbef41e..29bc89e113 100755
--- a/tests/qemu-iotests/062
+++ b/tests/qemu-iotests/062
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for snapshotting images with unallocated zero clusters in
 # qcow2
diff --git a/tests/qemu-iotests/063 b/tests/qemu-iotests/063
index 041fb5c1ac..d287da974e 100755
--- a/tests/qemu-iotests/063
+++ b/tests/qemu-iotests/063
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # test of qemu-img convert -n - convert without creation
 #
diff --git a/tests/qemu-iotests/064 b/tests/qemu-iotests/064
index f55ff37ca7..e57242eb19 100755
--- a/tests/qemu-iotests/064
+++ b/tests/qemu-iotests/064
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test VHDX read/write from a sample image created with Hyper-V
 #
diff --git a/tests/qemu-iotests/066 b/tests/qemu-iotests/066
index 26c043711b..758e1fe162 100755
--- a/tests/qemu-iotests/066
+++ b/tests/qemu-iotests/066
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for preallocated zero clusters in qcow2
 #
diff --git a/tests/qemu-iotests/067 b/tests/qemu-iotests/067
index 342b2b0a30..efcca25704 100755
--- a/tests/qemu-iotests/067
+++ b/tests/qemu-iotests/067
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test automatic deletion of BDSes created by -drive/drive_add
 #
diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
index f0583d52ae..f92a13351c 100755
--- a/tests/qemu-iotests/068
+++ b/tests/qemu-iotests/068
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for loading a saved VM state from a qcow2 image
 #
diff --git a/tests/qemu-iotests/069 b/tests/qemu-iotests/069
index fdee121f43..a9c8bcb038 100755
--- a/tests/qemu-iotests/069
+++ b/tests/qemu-iotests/069
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for deleting a backing file
 #
diff --git a/tests/qemu-iotests/070 b/tests/qemu-iotests/070
index 78e0390f5f..c3e3a567f6 100755
--- a/tests/qemu-iotests/070
+++ b/tests/qemu-iotests/070
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test VHDX log replay from an image with a journal that needs to be
 # replayed
diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 6e467dc1da..f47c9ce77c 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for the QMP blkdebug and blkverify interfaces
 #
diff --git a/tests/qemu-iotests/072 b/tests/qemu-iotests/072
index 08ef29f5b4..ad8f512e5a 100755
--- a/tests/qemu-iotests/072
+++ b/tests/qemu-iotests/072
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for nested image formats
 #
diff --git a/tests/qemu-iotests/073 b/tests/qemu-iotests/073
index 5e7f76cb7f..ddde6eeab5 100755
--- a/tests/qemu-iotests/073
+++ b/tests/qemu-iotests/073
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test count_contiguous_clusters in qcow2
 #
diff --git a/tests/qemu-iotests/074 b/tests/qemu-iotests/074
index b17866bd34..f2a335188e 100755
--- a/tests/qemu-iotests/074
+++ b/tests/qemu-iotests/074
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 ##
 ## qemu-img compare test (qcow2 only ones)
 ##
diff --git a/tests/qemu-iotests/075 b/tests/qemu-iotests/075
index 45b8901ef0..82da837f03 100755
--- a/tests/qemu-iotests/075
+++ b/tests/qemu-iotests/075
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # cloop format input validation tests
 #
diff --git a/tests/qemu-iotests/076 b/tests/qemu-iotests/076
index 3b5ab3fd08..560bdbbc57 100755
--- a/tests/qemu-iotests/076
+++ b/tests/qemu-iotests/076
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # parallels format input validation tests
 #
diff --git a/tests/qemu-iotests/077 b/tests/qemu-iotests/077
index 58fe8932b3..c46b3d2e4c 100755
--- a/tests/qemu-iotests/077
+++ b/tests/qemu-iotests/077
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test concurrent pread/pwrite
 #
diff --git a/tests/qemu-iotests/078 b/tests/qemu-iotests/078
index 68d0ea8802..1a1a7643fc 100755
--- a/tests/qemu-iotests/078
+++ b/tests/qemu-iotests/078
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # bochs format input validation tests
 #
diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
index fca2f77d37..baeaa8407c 100755
--- a/tests/qemu-iotests/079
+++ b/tests/qemu-iotests/079
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test qcow2 preallocation with different cluster_sizes
 #
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index cec2376f59..2c2e3e0709 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # qcow2 format input validation tests
 #
diff --git a/tests/qemu-iotests/081 b/tests/qemu-iotests/081
index edf6e6172a..84a034ebc2 100755
--- a/tests/qemu-iotests/081
+++ b/tests/qemu-iotests/081
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test Quorum block driver
 #
diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index 61eec63797..3fb76d61ee 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test qemu-img command line parsing
 #
diff --git a/tests/qemu-iotests/083 b/tests/qemu-iotests/083
index 89f67db70f..2384dbcb46 100755
--- a/tests/qemu-iotests/083
+++ b/tests/qemu-iotests/083
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test NBD client unexpected disconnect
 #
diff --git a/tests/qemu-iotests/084 b/tests/qemu-iotests/084
index e131fa9642..5632099a65 100755
--- a/tests/qemu-iotests/084
+++ b/tests/qemu-iotests/084
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for VDI header corruption; image too large, and too many blo=
cks.
 # Also simple test for creating dynamic and static VDI images.
diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index ade68ef853..c3aa6c20fe 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Live snapshot tests
 #
diff --git a/tests/qemu-iotests/086 b/tests/qemu-iotests/086
index 3cca3687ea..b47f9459f0 100755
--- a/tests/qemu-iotests/086
+++ b/tests/qemu-iotests/086
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test qemu-img progress output
 #
diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index f625887082..ef4e56e3e2 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test unsupported blockdev-add cases
 #
diff --git a/tests/qemu-iotests/088 b/tests/qemu-iotests/088
index c5e9ab42c7..eafc64ee0b 100755
--- a/tests/qemu-iotests/088
+++ b/tests/qemu-iotests/088
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # vpc (VHD) format input validation tests
 #
diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index 3165d79e2a..731930e5ab 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for support of JSON filenames
 #
diff --git a/tests/qemu-iotests/090 b/tests/qemu-iotests/090
index 1450993e15..08e9a7f6bd 100755
--- a/tests/qemu-iotests/090
+++ b/tests/qemu-iotests/090
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test for discarding compressed clusters on qcow2 images
 #
diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index 2f2f98ee64..4d12476f1d 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Live migration test
 #
diff --git a/tests/qemu-iotests/092 b/tests/qemu-iotests/092
index 8e318f10b9..2c38c5cf7b 100755
--- a/tests/qemu-iotests/092
+++ b/tests/qemu-iotests/092
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # qcow1 format input validation tests
 #
diff --git a/tests/qemu-iotests/094 b/tests/qemu-iotests/094
index 7adc9b9138..1a6a31b61f 100755
--- a/tests/qemu-iotests/094
+++ b/tests/qemu-iotests/094
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for drive-mirror to NBD
 #
diff --git a/tests/qemu-iotests/095 b/tests/qemu-iotests/095
index 9fc47f6b87..5930a021f2 100755
--- a/tests/qemu-iotests/095
+++ b/tests/qemu-iotests/095
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test for commit of larger active layer
 #
diff --git a/tests/qemu-iotests/097 b/tests/qemu-iotests/097
index 7234b16053..18c664ab0f 100755
--- a/tests/qemu-iotests/097
+++ b/tests/qemu-iotests/097
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Commit changes into backing chains and empty the top image if the
 # backing image is not explicitly specified
diff --git a/tests/qemu-iotests/098 b/tests/qemu-iotests/098
index c7977da99a..8303630e0f 100755
--- a/tests/qemu-iotests/098
+++ b/tests/qemu-iotests/098
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test qcow2's bdrv_make_empty for images without internal snapshots
 #
diff --git a/tests/qemu-iotests/099 b/tests/qemu-iotests/099
index 578808b747..0faab57632 100755
--- a/tests/qemu-iotests/099
+++ b/tests/qemu-iotests/099
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test valid filenames for blkdebug and blkverify representatively for
 # other protocols (such as NBD) when queried
diff --git a/tests/qemu-iotests/101 b/tests/qemu-iotests/101
index 3001ba3c0a..c80201f54d 100755
--- a/tests/qemu-iotests/101
+++ b/tests/qemu-iotests/101
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test short file I/O
 #
diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
index 29a6a940e2..e7cbd74d90 100755
--- a/tests/qemu-iotests/102
+++ b/tests/qemu-iotests/102
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for qemu-io -c map and qemu-img map
 #
diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
index 66f8167f02..87c2b10d0a 100755
--- a/tests/qemu-iotests/103
+++ b/tests/qemu-iotests/103
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for qcow2 metadata cache size specification
 #
diff --git a/tests/qemu-iotests/104 b/tests/qemu-iotests/104
index 34bb0d23ba..2d3ba91764 100755
--- a/tests/qemu-iotests/104
+++ b/tests/qemu-iotests/104
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test image creation with aligned and unaligned sizes
 #
diff --git a/tests/qemu-iotests/105 b/tests/qemu-iotests/105
index 943bda2f4f..c82e48fcf7 100755
--- a/tests/qemu-iotests/105
+++ b/tests/qemu-iotests/105
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Create, read, write big image
 #
diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
index 4129fee6bc..771a3a6c7a 100755
--- a/tests/qemu-iotests/106
+++ b/tests/qemu-iotests/106
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test preallocated resize of raw images
 #
diff --git a/tests/qemu-iotests/107 b/tests/qemu-iotests/107
index 5d70ad2007..c78da8b660 100755
--- a/tests/qemu-iotests/107
+++ b/tests/qemu-iotests/107
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Tests updates of the qcow2 L1 table
 #
diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
index 58e8ad7636..d4ebf1a87e 100755
--- a/tests/qemu-iotests/108
+++ b/tests/qemu-iotests/108
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for repairing qcow2 images which cannot be repaired using
 # the on-disk refcount structures
diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
index b51e4616c6..8ce6e5ea1b 100755
--- a/tests/qemu-iotests/109
+++ b/tests/qemu-iotests/109
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test writing image headers of other formats into raw images
 #
diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index b64b3b215a..6846174fe3 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for relative backing file names in complex BDS trees
 #
diff --git a/tests/qemu-iotests/111 b/tests/qemu-iotests/111
index e15e66ac5d..d4ed91e6ba 100755
--- a/tests/qemu-iotests/111
+++ b/tests/qemu-iotests/111
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for non-existing backing file when creating a qcow2 image
 # and not specifying the size
diff --git a/tests/qemu-iotests/112 b/tests/qemu-iotests/112
index d67e6ebe9c..0ec5e2509d 100755
--- a/tests/qemu-iotests/112
+++ b/tests/qemu-iotests/112
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test cases for different refcount_bits values
 #
diff --git a/tests/qemu-iotests/113 b/tests/qemu-iotests/113
index d8d78c46dc..2f74ee89de 100755
--- a/tests/qemu-iotests/113
+++ b/tests/qemu-iotests/113
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for accessing creation options on image formats and
 # protocols not supporting image creation
diff --git a/tests/qemu-iotests/114 b/tests/qemu-iotests/114
index e17fb514cb..391489dbb1 100755
--- a/tests/qemu-iotests/114
+++ b/tests/qemu-iotests/114
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test invalid backing file format in qcow2 images
 #
diff --git a/tests/qemu-iotests/115 b/tests/qemu-iotests/115
index 0581e03c26..aad0602bd5 100755
--- a/tests/qemu-iotests/115
+++ b/tests/qemu-iotests/115
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for non-self-referential qcow2 refcount blocks
 #
diff --git a/tests/qemu-iotests/116 b/tests/qemu-iotests/116
index f8a27b9c02..131d90af70 100755
--- a/tests/qemu-iotests/116
+++ b/tests/qemu-iotests/116
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test error code paths for invalid QED images
 #
diff --git a/tests/qemu-iotests/117 b/tests/qemu-iotests/117
index e533e230a3..465d95436c 100755
--- a/tests/qemu-iotests/117
+++ b/tests/qemu-iotests/117
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for shared BDS between backend trees
 #
diff --git a/tests/qemu-iotests/119 b/tests/qemu-iotests/119
index 32810d52c9..804034f59c 100755
--- a/tests/qemu-iotests/119
+++ b/tests/qemu-iotests/119
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # NBD test case for overriding BDRV_O_PROTOCOL by explicitly specifying
 # a driver
diff --git a/tests/qemu-iotests/120 b/tests/qemu-iotests/120
index 76afdf449b..83e63e213d 100755
--- a/tests/qemu-iotests/120
+++ b/tests/qemu-iotests/120
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Non-NBD test cases for overriding BDRV_O_PROTOCOL by explicitly
 # specifying a driver
diff --git a/tests/qemu-iotests/121 b/tests/qemu-iotests/121
index d2885c700f..27651cddcf 100755
--- a/tests/qemu-iotests/121
+++ b/tests/qemu-iotests/121
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test cases for qcow2 refcount table growth
 #
diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index eab3399dd6..7d0abee6bf 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test some qemu-img convert cases
 #
diff --git a/tests/qemu-iotests/123 b/tests/qemu-iotests/123
index 168b985c8b..4e60d3fd17 100755
--- a/tests/qemu-iotests/123
+++ b/tests/qemu-iotests/123
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for qemu-img convert to NBD
 #
diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
index 778c874933..3efc4f957a 100755
--- a/tests/qemu-iotests/125
+++ b/tests/qemu-iotests/125
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test preallocated growth of qcow2 images
 #
diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
index 91148383ad..8fb6fab3f1 100755
--- a/tests/qemu-iotests/126
+++ b/tests/qemu-iotests/126
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Tests handling of colons in filenames (which may be confused with prot=
ocol
 # prefixes)
diff --git a/tests/qemu-iotests/127 b/tests/qemu-iotests/127
index c9139ed5e6..29e30c1d13 100755
--- a/tests/qemu-iotests/127
+++ b/tests/qemu-iotests/127
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for mirroring with dataplane
 #
diff --git a/tests/qemu-iotests/128 b/tests/qemu-iotests/128
index 925f5c7e98..24dae3c567 100755
--- a/tests/qemu-iotests/128
+++ b/tests/qemu-iotests/128
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test that opening O_DIRECT succeeds when image file I/O produces EIO
 #
diff --git a/tests/qemu-iotests/130 b/tests/qemu-iotests/130
index f2f2706b28..1800be2ecb 100755
--- a/tests/qemu-iotests/130
+++ b/tests/qemu-iotests/130
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test that temporary backing file overrides (on the command line or in
 # blockdev-add) don't replace the original path stored in the image duri=
ng
diff --git a/tests/qemu-iotests/131 b/tests/qemu-iotests/131
index 58c25f7abe..ac4d79adf0 100755
--- a/tests/qemu-iotests/131
+++ b/tests/qemu-iotests/131
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # parallels format validation tests (created by QEMU)
 #
diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
index 565e0b1b6e..fc4479e23d 100755
--- a/tests/qemu-iotests/133
+++ b/tests/qemu-iotests/133
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test for reopen
 #
diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index cacabcd28b..cdcdbb7879 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test encrypted read/write using plain bdrv_read/bdrv_write
 #
diff --git a/tests/qemu-iotests/135 b/tests/qemu-iotests/135
index a18a0c7230..e7de998cb1 100755
--- a/tests/qemu-iotests/135
+++ b/tests/qemu-iotests/135
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test VPC open of image with large Max Table Entries value.
 #
diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
index 09cd4450ca..0a9492703f 100755
--- a/tests/qemu-iotests/137
+++ b/tests/qemu-iotests/137
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test qcow2 reopen
 #
diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
index eccbcae3a6..f3a3401bb7 100755
--- a/tests/qemu-iotests/138
+++ b/tests/qemu-iotests/138
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # General test case for qcow2's image check
 #
diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
index d4623b5a5d..ab5b6ab44d 100755
--- a/tests/qemu-iotests/140
+++ b/tests/qemu-iotests/140
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for ejecting a BlockBackend with an NBD server attached to i=
t
 #
diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
index e2408c7988..41bd4b8acf 100755
--- a/tests/qemu-iotests/141
+++ b/tests/qemu-iotests/141
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for ejecting BDSs with block jobs still running on them
 #
diff --git a/tests/qemu-iotests/142 b/tests/qemu-iotests/142
index 5fc488f5d2..2b4c2a58d9 100755
--- a/tests/qemu-iotests/142
+++ b/tests/qemu-iotests/142
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test for configuring cache modes of arbitrary nodes (requires O_DIRECT=
)
 #
diff --git a/tests/qemu-iotests/143 b/tests/qemu-iotests/143
index d6302cc06d..09b4abc3eb 100755
--- a/tests/qemu-iotests/143
+++ b/tests/qemu-iotests/143
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for connecting to a non-existing NBD export name
 #
diff --git a/tests/qemu-iotests/144 b/tests/qemu-iotests/144
index 118c099994..dbc99f2f60 100755
--- a/tests/qemu-iotests/144
+++ b/tests/qemu-iotests/144
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 # Check live snapshot, followed by active commit, and another snapshot.
 #
 # This test is to catch the error case of BZ #1300209:
diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
index 6ce8a46f92..53b8dd1d79 100755
--- a/tests/qemu-iotests/145
+++ b/tests/qemu-iotests/145
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test the combination of -incoming and snapshot=3Don
 #
diff --git a/tests/qemu-iotests/146 b/tests/qemu-iotests/146
index 3f61351ffe..3cf9484662 100755
--- a/tests/qemu-iotests/146
+++ b/tests/qemu-iotests/146
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test VHD image format creator detection and override
 #
diff --git a/tests/qemu-iotests/150 b/tests/qemu-iotests/150
index 955b877efa..b9508cf10a 100755
--- a/tests/qemu-iotests/150
+++ b/tests/qemu-iotests/150
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test that qemu-img convert -S 0 fully allocates the target image
 #
diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index 3120a61da4..05be7667a7 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test image locking
 #
diff --git a/tests/qemu-iotests/154 b/tests/qemu-iotests/154
index 4a4abf0589..cd9f8ff3d8 100755
--- a/tests/qemu-iotests/154
+++ b/tests/qemu-iotests/154
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # qcow2 specific bdrv_pwrite_zeroes tests with backing files (complement=
s 034)
 #
diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index f97f96f666..0c7f3ced8c 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Tests oVirt-like storage migration:
 #  - Create snapshot
diff --git a/tests/qemu-iotests/157 b/tests/qemu-iotests/157
index 6fb26596ad..7a6993360d 100755
--- a/tests/qemu-iotests/157
+++ b/tests/qemu-iotests/157
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test command line configuration of block devices with qdev
 #
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index d277ddcc94..121141e078 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test encrypted read/write using backing files
 #
diff --git a/tests/qemu-iotests/159 b/tests/qemu-iotests/159
index e74b2739de..27736efbfd 100755
--- a/tests/qemu-iotests/159
+++ b/tests/qemu-iotests/159
@@ -1,4 +1,4 @@
-#! /bin/bash
+#! /usr/bin/env bash
 #
 # qemu-img dd test with different block sizes
 #
diff --git a/tests/qemu-iotests/160 b/tests/qemu-iotests/160
index 92fff45d10..965d5199cc 100755
--- a/tests/qemu-iotests/160
+++ b/tests/qemu-iotests/160
@@ -1,4 +1,4 @@
-#! /bin/bash
+#! /usr/bin/env bash
 #
 # qemu-img dd test for the skip option
 #
diff --git a/tests/qemu-iotests/161 b/tests/qemu-iotests/161
index 180df17ad6..788dbb7ce1 100755
--- a/tests/qemu-iotests/161
+++ b/tests/qemu-iotests/161
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test reopening a backing image after block-stream and block-commit
 #
diff --git a/tests/qemu-iotests/162 b/tests/qemu-iotests/162
index ef02d844a2..97d0368b1b 100755
--- a/tests/qemu-iotests/162
+++ b/tests/qemu-iotests/162
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for specifying runtime options of the wrong type to some
 # block drivers
diff --git a/tests/qemu-iotests/170 b/tests/qemu-iotests/170
index 861eabf5cc..0e3feacc88 100755
--- a/tests/qemu-iotests/170
+++ b/tests/qemu-iotests/170
@@ -1,4 +1,4 @@
-#! /bin/bash
+#! /usr/bin/env bash
 #
 # qemu-img dd test
 #
diff --git a/tests/qemu-iotests/171 b/tests/qemu-iotests/171
index 5b46069fde..06617ea112 100755
--- a/tests/qemu-iotests/171
+++ b/tests/qemu-iotests/171
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test 'offset' and 'size' options of the raw driver. Make sure we can't
 # (or can) read and write outside of the image size.
diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
index 1e60a7e3d6..f8efc06759 100755
--- a/tests/qemu-iotests/172
+++ b/tests/qemu-iotests/172
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test floppy configuration
 #
diff --git a/tests/qemu-iotests/173 b/tests/qemu-iotests/173
index 1fe8c5d738..2043f55e92 100755
--- a/tests/qemu-iotests/173
+++ b/tests/qemu-iotests/173
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test QAPI commands looking up protocol based images with relative
 # filename backing strings
diff --git a/tests/qemu-iotests/174 b/tests/qemu-iotests/174
index d8bb05c4e2..5c7c74f232 100755
--- a/tests/qemu-iotests/174
+++ b/tests/qemu-iotests/174
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test that qemu-io fail with non-zero exit code
 #
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index ebbeb6e74c..374920f28c 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test creating raw image preallocation mode
 #
diff --git a/tests/qemu-iotests/176 b/tests/qemu-iotests/176
index 4ecd5894a3..b951a0f263 100755
--- a/tests/qemu-iotests/176
+++ b/tests/qemu-iotests/176
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Commit changes into backing chains and empty the top image if the
 # backing image is not explicitly specified.
diff --git a/tests/qemu-iotests/177 b/tests/qemu-iotests/177
index f0c1155e80..b6dbf75f3c 100755
--- a/tests/qemu-iotests/177
+++ b/tests/qemu-iotests/177
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test corner cases with unusual block geometries
 #
diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
index 3f4b4a4564..d990455582 100755
--- a/tests/qemu-iotests/178
+++ b/tests/qemu-iotests/178
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # qemu-img measure sub-command tests
 #
diff --git a/tests/qemu-iotests/179 b/tests/qemu-iotests/179
index 3040631636..f4671cbcf2 100755
--- a/tests/qemu-iotests/179
+++ b/tests/qemu-iotests/179
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for write zeroes with unmap
 #
diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index 0c44108dac..5e7c98f7b3 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test postcopy live migration with shared storage
 #
diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
index 9e078c5484..8533f26eab 100755
--- a/tests/qemu-iotests/182
+++ b/tests/qemu-iotests/182
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test image locking for POSIX locks
 #
diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index ebb5e304ac..2e20b63dbc 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test old-style block migration (migrate -b)
 #
diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
index 0af7a73aca..7021e3cde9 100755
--- a/tests/qemu-iotests/184
+++ b/tests/qemu-iotests/184
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test I/O throttle block filter driver interface
 #
diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index d8f1505cd8..822eaf5bc9 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test exiting qemu while jobs are still running
 #
diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index c27dc953b6..525f2b23c5 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test 'info block' with all kinds of configurations
 #
diff --git a/tests/qemu-iotests/187 b/tests/qemu-iotests/187
index 1feddca508..ae6762c82b 100755
--- a/tests/qemu-iotests/187
+++ b/tests/qemu-iotests/187
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test switching between read-only and read-write
 #
diff --git a/tests/qemu-iotests/188 b/tests/qemu-iotests/188
index af40e496ee..a1f98744bf 100755
--- a/tests/qemu-iotests/188
+++ b/tests/qemu-iotests/188
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test encrypted read/write using plain bdrv_read/bdrv_write
 #
diff --git a/tests/qemu-iotests/189 b/tests/qemu-iotests/189
index 222bec133b..67b1ba64bc 100755
--- a/tests/qemu-iotests/189
+++ b/tests/qemu-iotests/189
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test encrypted read/write using backing files
 #
diff --git a/tests/qemu-iotests/190 b/tests/qemu-iotests/190
index 95ba06d8f4..3eb50477af 100755
--- a/tests/qemu-iotests/190
+++ b/tests/qemu-iotests/190
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # qemu-img measure sub-command tests on huge qcow2 files
 #
diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index 198272ea3b..d9de1a0bde 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test commit block job where top has two parents
 #
diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
index 415c706db5..53a7e76950 100755
--- a/tests/qemu-iotests/192
+++ b/tests/qemu-iotests/192
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test NBD export with -incoming (non-shared storage migration use case =
from
 # libvirt)
diff --git a/tests/qemu-iotests/195 b/tests/qemu-iotests/195
index a977c9798e..dfd06eba23 100755
--- a/tests/qemu-iotests/195
+++ b/tests/qemu-iotests/195
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test change-backing-file command
 #
diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index 8170f5d4ab..f8d1a7adc3 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for copy-on-read into qcow2
 #
diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
index 4d961f4f3a..4e5abba161 100755
--- a/tests/qemu-iotests/198
+++ b/tests/qemu-iotests/198
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test commit of encrypted qcow2 files
 #
diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
index b9ebd5a8c7..758f5bc1be 100755
--- a/tests/qemu-iotests/200
+++ b/tests/qemu-iotests/200
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Block job co-routine race condition test.
 #
diff --git a/tests/qemu-iotests/201 b/tests/qemu-iotests/201
index c1a1e00077..69de2d5a54 100755
--- a/tests/qemu-iotests/201
+++ b/tests/qemu-iotests/201
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test savevm and loadvm after live migration with postcopy flag
 #
diff --git a/tests/qemu-iotests/204 b/tests/qemu-iotests/204
index 30f0653ce9..192a4490b1 100755
--- a/tests/qemu-iotests/204
+++ b/tests/qemu-iotests/204
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test corner cases with unusual block geometries
 #
diff --git a/tests/qemu-iotests/214 b/tests/qemu-iotests/214
index 7a2d5391bb..fee7eca8e2 100755
--- a/tests/qemu-iotests/214
+++ b/tests/qemu-iotests/214
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test qcow2 image compression
 #
diff --git a/tests/qemu-iotests/215 b/tests/qemu-iotests/215
index 230fd2551a..9b0b155a56 100755
--- a/tests/qemu-iotests/215
+++ b/tests/qemu-iotests/215
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test case for copy-on-read into qcow2, using the COR filter driver
 #
diff --git a/tests/qemu-iotests/217 b/tests/qemu-iotests/217
index d3ab5d72be..28a94f1ab2 100755
--- a/tests/qemu-iotests/217
+++ b/tests/qemu-iotests/217
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # I/O errors when working with internal qcow2 snapshots, and repairing
 # the result
diff --git a/tests/qemu-iotests/220 b/tests/qemu-iotests/220
index 0c5682bda0..93b5c2639a 100755
--- a/tests/qemu-iotests/220
+++ b/tests/qemu-iotests/220
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # max limits on compression in huge qcow2 files
 #
diff --git a/tests/qemu-iotests/221 b/tests/qemu-iotests/221
index 06f48f1f23..5e72287e4b 100755
--- a/tests/qemu-iotests/221
+++ b/tests/qemu-iotests/221
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test qemu-img vs. unaligned images
 #
diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index f120a01646..b45c18c2a3 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test reading dirty bitmap over NBD
 #
diff --git a/tests/qemu-iotests/225 b/tests/qemu-iotests/225
index e42ee94ff0..c1cad7a474 100755
--- a/tests/qemu-iotests/225
+++ b/tests/qemu-iotests/225
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test vmdk backing file correlation
 #
diff --git a/tests/qemu-iotests/226 b/tests/qemu-iotests/226
index aec413b23c..b81aaa80fd 100755
--- a/tests/qemu-iotests/226
+++ b/tests/qemu-iotests/226
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # This test covers expected filetypes for the file, host_cdrom and
 # host_device drivers.
diff --git a/tests/qemu-iotests/227 b/tests/qemu-iotests/227
index be1b636af0..68c362c92e 100755
--- a/tests/qemu-iotests/227
+++ b/tests/qemu-iotests/227
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test query-blockstats with different ways to create a BB
 #
diff --git a/tests/qemu-iotests/229 b/tests/qemu-iotests/229
index 893d098ad2..463080636e 100755
--- a/tests/qemu-iotests/229
+++ b/tests/qemu-iotests/229
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test for force canceling a running blockjob that is paused in
 # an error state.
diff --git a/tests/qemu-iotests/231 b/tests/qemu-iotests/231
index e9f8aaacd3..327e074489 100755
--- a/tests/qemu-iotests/231
+++ b/tests/qemu-iotests/231
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test legacy and modern option parsing for rbd/ceph.  This will not
 # actually connect to a ceph server, but rather looks for the appropriat=
e
diff --git a/tests/qemu-iotests/232 b/tests/qemu-iotests/232
index 0708b8b155..044710ee79 100755
--- a/tests/qemu-iotests/232
+++ b/tests/qemu-iotests/232
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test for auto-read-only
 #
diff --git a/tests/qemu-iotests/233 b/tests/qemu-iotests/233
index fc345a1a46..b8ba12dcaf 100755
--- a/tests/qemu-iotests/233
+++ b/tests/qemu-iotests/233
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Test NBD TLS certificate / authorization integration
 #
diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 89ed275988..6b618628f1 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Copyright (C) 2009 Red Hat, Inc.
 # Copyright (c) 2000-2002,2006 Silicon Graphics, Inc.  All Rights Reserv=
ed.
diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common=
.config
index 9f460f203d..c87c944f7a 100644
--- a/tests/qemu-iotests/common.config
+++ b/tests/qemu-iotests/common.config
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Copyright (C) 2009 Red Hat, Inc.
 # Copyright (c) 2000-2003,2006 Silicon Graphics, Inc.  All Rights Reserv=
ed.
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common=
.filter
index 2031e353a5..17eb3402a7 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Copyright (C) 2009 Red Hat, Inc.
 # Copyright (c) 2000-2001 Silicon Graphics, Inc.  All Rights Reserved.
diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/common.nb=
d
index 233187a25c..c762435bae 100644
--- a/tests/qemu-iotests/common.nbd
+++ b/tests/qemu-iotests/common.nbd
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 # -*- shell-script-mode -*-
 #
 # Helpers for NBD server related config
diff --git a/tests/qemu-iotests/common.pattern b/tests/qemu-iotests/commo=
n.pattern
index b67bb34136..8d3fdbaf0e 100644
--- a/tests/qemu-iotests/common.pattern
+++ b/tests/qemu-iotests/common.pattern
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Copyright (C) 2009 Red Hat, Inc.
 #
diff --git a/tests/qemu-iotests/common.qemu b/tests/qemu-iotests/common.q=
emu
index 7c87b897fa..39098c2c13 100644
--- a/tests/qemu-iotests/common.qemu
+++ b/tests/qemu-iotests/common.qemu
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # This allows for launching of multiple QEMU instances, with independent
 # communication possible to each instance.
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index e15e7a7c8e..0c4f0a5987 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Copyright (C) 2009 Red Hat, Inc.
 # Copyright (c) 2000-2006 Silicon Graphics, Inc.  All Rights Reserved.
diff --git a/tests/qemu-iotests/common.tls b/tests/qemu-iotests/common.tl=
s
index eae81789bb..191c26df09 100644
--- a/tests/qemu-iotests/common.tls
+++ b/tests/qemu-iotests/common.tls
@@ -1,4 +1,4 @@
-#!/bin/bash
+#! /usr/bin/env bash
 #
 # Helpers for TLS related config
 #
--=20
2.20.1
