Received: from eggs.gnu.org ([209.51.188.92]:51306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw0u3-0000Gb-Rk
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw0u1-0004D2-R5
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gw0u1-0004Cc-DO
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:21 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 259E3420A3
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 08:37:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 19 Feb 2019 09:36:54 +0100
Message-Id: <1550565421-10944-8-git-send-email-thuth@redhat.com>
In-Reply-To: <1550565421-10944-1-git-send-email-thuth@redhat.com>
References: <1550565421-10944-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/14] MAINTAINERS: Add maintainer to the POSIX
 subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
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
index a1772d9..549f1f9 100644
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
