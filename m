Received: from eggs.gnu.org ([2001:4830:134:3::10]:49174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcF-0007Mj-4P
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcE-0004wY-BP
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59372 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0pcE-0004wP-6b
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C8A61EB6F4
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 14:30:21 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue, 27 Mar 2018 09:30:04 -0500
Message-Id: <20180327143014.1767669-5-eblake@redhat.com>
In-Reply-To: <20180327143014.1767669-1-eblake@redhat.com>
References: <20180327143014.1767669-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 04/14] error: Remove NULL checks on
 error_propagate() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Laurent Vivier <lvivier@redhat.com>

Re-run Coccinelle patch
scripts/coccinelle/error_propagate_null.cocci

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20180323143202.28879-4-lvivier@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 io/channel-websock.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index ec48a305f02..e6608b969d7 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -586,9 +586,7 @@ static gboolean qio_channel_websock_handshake_io(QIOChannel *ioc,
         return TRUE;
     }

-    if (err) {
-        error_propagate(&wioc->io_err, err);
-    }
+    error_propagate(&wioc->io_err, err);

     trace_qio_channel_websock_handshake_reply(ioc);
     qio_channel_add_watch(
-- 
2.14.3
