Received: from eggs.gnu.org ([2001:4830:134:3::10]:41026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAsp-0002oW-Kw
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAsn-0001GV-Af
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:14:55 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:18 +0200
Message-Id: <1525817687-34620-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/30] configure: recognize more rpmbuild macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Olaf Hering <olaf@aepfle.de>, qemu-stable@nongnu.org

From: Olaf Hering <olaf@aepfle.de>

Extend the list of recognized, but ignored options from rpms %configure
macro. This fixes build on hosts running SUSE Linux.

Cc: qemu-stable@nongnu.org
Signed-off-by: Olaf Hering <olaf@aepfle.de>
Message-Id: <20180418075045.27393-1-olaf@aepfle.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure b/configure
index 1443422..83a6080 100755
--- a/configure
+++ b/configure
@@ -964,6 +964,8 @@ for opt do
   ;;
   --firmwarepath=*) firmwarepath="$optarg"
   ;;
+  --host=*|--build=*|\
+  --disable-dependency-tracking|\
   --sbindir=*|--sharedstatedir=*|\
   --oldincludedir=*|--datarootdir=*|--infodir=*|--localedir=*|\
   --htmldir=*|--dvidir=*|--pdfdir=*|--psdir=*)
-- 
1.8.3.1
