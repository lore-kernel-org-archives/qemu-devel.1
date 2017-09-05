Received: from eggs.gnu.org ([2001:4830:134:3::10]:58236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpD8u-0004SN-Hw
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpD8p-00006k-VQ
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:39:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpD8p-00006M-PB
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:39:43 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  5 Sep 2017 13:39:33 +0100
Message-Id: <20170905123935.26645-4-berrange@redhat.com>
In-Reply-To: <20170905123935.26645-1-berrange@redhat.com>
References: <20170905123935.26645-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v2 3/5] io: fix typo in docs comment for
 qio_channel_read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/io/channel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index db9bb022a1..54f3dc252f 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -299,7 +299,7 @@ ssize_t qio_channel_writev(QIOChannel *ioc,
                            Error **errp);
 
 /**
- * qio_channel_readv:
+ * qio_channel_read:
  * @ioc: the channel object
  * @buf: the memory region to read data into
  * @buflen: the length of @buf
-- 
2.13.5
