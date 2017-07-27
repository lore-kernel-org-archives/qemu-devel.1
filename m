Received: from eggs.gnu.org ([2001:4830:134:3::10]:37387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dafjh-0000qC-Se
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dafjd-0000hH-RG
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:09:41 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 27 Jul 2017 12:09:34 +0200
Message-Id: <1501150174-19431-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Improve the NetBSD regex pattern
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <kamil@netbsd.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org

Currently get_maintainers.pl claims that the configure script is
maintained by Kamil:

 $ scripts/get_maintainer.pl -f configure
 Kamil Rytarowski <kamil@netbsd.org> (maintainer:NETBSD)
 qemu-devel@nongnu.org (open list:All patches CC here)

This happens because the regex pattern for the NETBSD entry triggers
on everything that contains the keyword "NetBSD". Ease the situation
a little bit by restricting this to "Subject:" lines only, like
we do it in the "trivial patches" section already.

Reported-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ce2341a..ccee28b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -353,7 +353,7 @@ NETBSD
 L: qemu-devel@nongnu.org
 M: Kamil Rytarowski <kamil@netbsd.org>
 S: Maintained
-K: (?i)NetBSD
+K: ^Subject:.*(?i)NetBSD
=20
 W32, W64
 L: qemu-devel@nongnu.org
--=20
1.8.3.1
