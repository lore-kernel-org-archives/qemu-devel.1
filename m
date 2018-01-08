Received: from eggs.gnu.org ([2001:4830:134:3::10]:50531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbkx-00050B-IB
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbkw-00067O-37
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:02:43 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:39081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbkv-00066w-W2
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:02:42 -0500
Received: by mail-qt0-x243.google.com with SMTP id k19so14684092qtj.6
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 10:02:41 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 15:02:25 -0300
Message-Id: <20180108180231.21122-2-f4bug@amsat.org>
In-Reply-To: <20180108180231.21122-1-f4bug@amsat.org>
References: <20180108180231.21122-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/7] net: struct MACAddr can use the
 QEMU_PACKED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/net/net.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/net.h b/include/net/net.h
index 4afac1a9dd..70f5bb3419 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -23,7 +23,7 @@
 
 struct MACAddr {
     uint8_t a[6];
-};
+} QEMU_PACKED;
 
 /* qdev nic properties */
 
-- 
2.15.1
