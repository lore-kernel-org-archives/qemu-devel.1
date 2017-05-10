Received: from eggs.gnu.org ([2001:4830:134:3::10]:47619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d8Lxd-0003RQ-L5
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d8Lxa-00063b-HT
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:23:01 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Wed, 10 May 2017 10:22:46 +0300
Message-Id: <bcd711feb0420d66e069498ed243a9e2b81ec167.1494400777.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494400777.git.mjt@msgid.tls.msk.ru>
References: <cover.1494400777.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494400777.git.mjt@msgid.tls.msk.ru>
References: <cover.1494400777.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/23] channel-file: fix wrong parameter comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "sochin.jiang" <sochin@aliyun.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: "sochin.jiang" <sochin@aliyun.com>

Signed-off-by: sochin.jiang <sochin@aliyun.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/io/channel-file.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/io/channel-file.h b/include/io/channel-file.h
index d2462c2ed7..79245f1183 100644
--- a/include/io/channel-file.h
+++ b/include/io/channel-file.h
@@ -71,7 +71,7 @@ qio_channel_file_new_fd(int fd);
=20
 /**
  * qio_channel_file_new_path:
- * @fd: the file descriptor
+ * @path: the file path
  * @flags: the open flags (O_RDONLY|O_WRONLY|O_RDWR, etc)
  * @mode: the file creation mode if O_WRONLY is set in @flags
  * @errp: pointer to initialized error object
--=20
2.11.0
