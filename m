Received: from eggs.gnu.org ([2001:4830:134:3::10]:43372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhslV-0006Mj-Iy
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 03:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhslU-00058S-Rr
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 03:29:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dhslU-000583-LV
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 03:29:20 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 16 Aug 2017 15:20:56 +0800
Message-Id: <20170816072104.24420-2-famz@redhat.com>
In-Reply-To: <20170816072104.24420-1-famz@redhat.com>
References: <20170816072104.24420-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 1/9] gitignore: Ignore vm test images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, stefanha@redhat.com, pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Kamil Rytarowski <kamil@netbsd.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index cf65316863..693e2f3009 100644
--- a/.gitignore
+++ b/.gitignore
@@ -52,6 +52,8 @@
 /vscclient
 /vhost-user-scsi
 /fsdev/virtfs-proxy-helper
+/tests/vm/*.img
+/tests/vm/*.tmp
 *.[1-9]
 *.a
 *.aux
-- 
2.13.4
