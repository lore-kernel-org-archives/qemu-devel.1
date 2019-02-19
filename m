Received: from eggs.gnu.org ([209.51.188.92]:51359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw0uC-0000Np-73
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw0u7-0004Ed-Ni
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gw0u5-0004DN-Oc
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 755CB8762F
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 08:37:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 19 Feb 2019 09:36:56 +0100
Message-Id: <1550565421-10944-10-git-send-email-thuth@redhat.com>
In-Reply-To: <1550565421-10944-1-git-send-email-thuth@redhat.com>
References: <1550565421-10944-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/14] MAINTAINERS: Add maintainers to the
 Linux subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Add Michael, Cornelia and Paolo as maintainers of the Linux subsystem.

Remove the qemu-devel@nongnu.org entry because the list is always
selected by the 'All patches CC here' section.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
[thuth: Add update-linux-headers.sh, too]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 258ba5a..e6e08c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -425,10 +425,12 @@ Hosts:
 ------
=20
 LINUX
-L: qemu-devel@nongnu.org
+M: Michael S. Tsirkin <mst@redhat.com>
+M: Cornelia Huck <cohuck@redhat.com>
+M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
-F: linux-*
 F: linux-headers/
+F: scripts/update-linux-headers.sh
=20
 POSIX
 M: Paolo Bonzini <pbonzini@redhat.com>
--=20
1.8.3.1
