Received: from eggs.gnu.org ([209.51.188.92]:51401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzKnX-0001WJ-R1
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzKnX-0007Ya-5C
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gzKnW-0007YE-VU
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:23 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 28 Feb 2019 13:27:48 +0100
Message-Id: <1551356875-30676-7-git-send-email-thuth@redhat.com>
In-Reply-To: <1551356875-30676-1-git-send-email-thuth@redhat.com>
References: <1551356875-30676-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/13] MAINTAINERS: Add maintainer to the POSIX
 subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Add Paolo as maintainer of the POSIX subsystem.

Remove the qemu-devel@nongnu.org entry because the list is always
selected by the 'All patches CC here' section.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 892d2c4..30a3359 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -431,9 +431,12 @@ F: linux-*
 F: linux-headers/
=20
 POSIX
-L: qemu-devel@nongnu.org
+M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
-F: *posix*
+F: os-posix.c
+F: include/sysemu/os-posix.h
+F: util/*posix*.c
+F: include/qemu/*posix*.h
=20
 NETBSD
 L: qemu-devel@nongnu.org
--=20
1.8.3.1
