Received: from eggs.gnu.org ([2001:4830:134:3::10]:41217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpA4H-0001DZ-3N
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpA4C-0002mE-GP
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpA4C-0002le-As
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:44 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  5 Sep 2017 10:22:28 +0100
Message-Id: <20170905092230.8243-8-berrange@redhat.com>
In-Reply-To: <20170905092230.8243-1-berrange@redhat.com>
References: <20170905092230.8243-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 7/9] io: fix typo in docs comment for
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
