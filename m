Received: from eggs.gnu.org ([2001:4830:134:3::10]:33746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEs-0008G7-DE
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEr-0000Il-Kf
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:34 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:39645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEr-0000IC-Gm
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:33 -0500
Received: by mail-qk0-x244.google.com with SMTP id r8so10802525qke.6
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 09:29:33 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 14:28:59 -0300
Message-Id: <20180108172904.8772-8-f4bug@amsat.org>
In-Reply-To: <20180108172904.8772-1-f4bug@amsat.org>
References: <20180108172904.8772-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 07/12] slirp: remove unnecessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 slirp/libslirp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index f90f0f524c..540b3e5903 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -3,7 +3,6 @@
 
 #include "qemu-common.h"
 
-struct Slirp;
 typedef struct Slirp Slirp;
 
 int get_dns_addr(struct in_addr *pdns_addr);
-- 
2.15.1
