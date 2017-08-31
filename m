Received: from eggs.gnu.org ([2001:4830:134:3::10]:60078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnM7s-00062M-IY
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnM7p-0004dj-Gc
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:51:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dnM7p-0004dS-Ar
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:51:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 69B25C0587E9
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 09:51:00 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 31 Aug 2017 10:50:57 +0100
Message-Id: <20170831095057.22923-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] io: fix typo in docs comment for
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
