Received: from eggs.gnu.org ([2001:4830:134:3::10]:42985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gD9ek-0006Hd-Ns
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gD9ek-0000Ha-1k
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:52:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gD9ej-0000Gd-Os
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:52:09 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 18 Oct 2018 15:52:00 +0100
Message-Id: <20181018145203.11336-2-berrange@redhat.com>
In-Reply-To: <20181018145203.11336-1-berrange@redhat.com>
References: <20181018145203.11336-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [web PATCH 1/4] Underline the current page section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The current page section is rendered in bold text but this is rather
subtle to see at a glance. Add a single pixel high underline to make
it more visible.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 assets/css/style-desktop.css | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/assets/css/style-desktop.css b/assets/css/style-desktop.css
index 44ea0c7..c7800b9 100644
--- a/assets/css/style-desktop.css
+++ b/assets/css/style-desktop.css
@@ -271,6 +271,8 @@
 		#nav li.current a
 		{
 			font-weight: 500;
+			border-bottom: 1px solid #F0A833;
+			padding-bottom: 2px;
 		}
=20
 /*
--=20
2.17.2
