Received: from eggs.gnu.org ([2001:4830:134:3::10]:33769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEw-0008JK-AJ
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEv-0000NY-Gp
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:38 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:41036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEv-0000N2-Bp
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:37 -0500
Received: by mail-qt0-x242.google.com with SMTP id i40so14524531qti.8
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 09:29:37 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 14:29:00 -0300
Message-Id: <20180108172904.8772-9-f4bug@amsat.org>
In-Reply-To: <20180108172904.8772-1-f4bug@amsat.org>
References: <20180108172904.8772-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 08/12] slirp: removed unused code
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
 slirp/ip.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/slirp/ip.h b/slirp/ip.h
index e29ccd3c9f..71c3642cfe 100644
--- a/slirp/ip.h
+++ b/slirp/ip.h
@@ -233,17 +233,4 @@ struct	ipasfrag {
 #define ipf_next     ipf_link.next
 #define ipf_prev     ipf_link.prev
 
-/*
- * Structure stored in mbuf in inpcb.ip_options
- * and passed to ip_output when ip options are in use.
- * The actual length of the options (including ipopt_dst)
- * is in m_len.
- */
-#define MAX_IPOPTLEN	40
-
-struct ipoption {
-	struct	in_addr ipopt_dst;	/* first-hop dst if source routed */
-	int8_t	ipopt_list[MAX_IPOPTLEN];	/* options proper */
-} QEMU_PACKED;
-
 #endif
-- 
2.15.1
