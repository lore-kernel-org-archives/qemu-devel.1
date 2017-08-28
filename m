Received: from eggs.gnu.org ([2001:4830:134:3::10]:33128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmO8C-0006WZ-O6
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmO8C-0001vw-45
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:47:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dmO8B-0001ux-Tz
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:47:24 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 29 Aug 2017 01:46:58 +0800
Message-Id: <20170828174707.20786-2-famz@redhat.com>
In-Reply-To: <20170828174707.20786-1-famz@redhat.com>
References: <20170828174707.20786-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 01/10] gitignore: Ignore vm test images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index cf65316863..643e23e515 100644
--- a/.gitignore
+++ b/.gitignore
@@ -52,6 +52,8 @@
 /vscclient
 /vhost-user-scsi
 /fsdev/virtfs-proxy-helper
+/tests/vm/*.img
+*.tmp
 *.[1-9]
 *.a
 *.aux
-- 
2.13.5
