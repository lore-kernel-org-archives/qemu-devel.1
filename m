Received: from eggs.gnu.org ([2001:4830:134:3::10]:40577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhI6-0001Jl-Rf
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhI6-0002En-1T
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:18:46 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:20 -0500
Message-Id: <20180723201748.25573-12-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 11/99] configure: recognize more rpmbuild macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Olaf Hering <olaf@aepfle.de>, Paolo Bonzini <pbonzini@redhat.com>

From: Olaf Hering <olaf@aepfle.de>

Extend the list of recognized, but ignored options from rpms %configure
macro. This fixes build on hosts running SUSE Linux.

Cc: qemu-stable@nongnu.org
Signed-off-by: Olaf Hering <olaf@aepfle.de>
Message-Id: <20180418075045.27393-1-olaf@aepfle.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 181ce1d05c6d4f1c80f0e7ebb41e489c2b541edf)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 configure | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure b/configure
index 0a19b033bc..44bf1fef04 100755
--- a/configure
+++ b/configure
@@ -959,6 +959,8 @@ for opt do
   ;;
   --firmwarepath=*) firmwarepath="$optarg"
   ;;
+  --host=*|--build=*|\
+  --disable-dependency-tracking|\
   --sbindir=*|--sharedstatedir=*|\
   --oldincludedir=*|--datarootdir=*|--infodir=*|--localedir=*|\
   --htmldir=*|--dvidir=*|--pdfdir=*|--psdir=*)
-- 
2.17.1
