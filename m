Received: from eggs.gnu.org ([2001:4830:134:3::10]:35918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gZGNE-0000ud-JE
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:29:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gZGNA-0000zm-U0
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:29:28 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 18 Dec 2018 15:28:48 +0100
Message-Id: <20181218142851.9477-2-laurent@vivier.eu>
In-Reply-To: <20181218142851.9477-1-laurent@vivier.eu>
References: <20181218142851.9477-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/4] docs/devel/build-system: fix 'softmu' typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, qemu-block@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, David Hildenbrand <david@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-trivial@nongnu.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20181128153423.11916-1-cota@braap.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 docs/devel/build-system.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/build-system.txt b/docs/devel/build-system.txt
index 52501f2ad9..f9fd27fab0 100644
--- a/docs/devel/build-system.txt
+++ b/docs/devel/build-system.txt
@@ -393,7 +393,7 @@ all use $(obj) as a prefix to the target, e.g.
 This file provides the entry point used to build each individual system
 or userspace emulator target. Each enabled target has its own
 subdirectory. For example if configure is run with the argument
-'--target-list=x86_64-softmmu', then a sub-directory 'x86_64-softmu'
+'--target-list=x86_64-softmmu', then a sub-directory 'x86_64-softmmu'
 will be created, containing a 'Makefile' which symlinks back to
 Makefile.target
 
-- 
2.19.2
