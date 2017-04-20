Received: from eggs.gnu.org ([2001:4830:134:3::10]:60175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ytht.net@gmail.com>) id 1d1HsQ-0002nz-1r
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 15:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ytht.net@gmail.com>) id 1d1HsP-0004AQ-6B
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 15:36:26 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:36002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ytht.net@gmail.com>) id 1d1HsP-0004AC-1j
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 15:36:25 -0400
Received: by mail-io0-x244.google.com with SMTP id x86so19921419ioe.3
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 12:36:24 -0700 (PDT)
From: Tao Wu <ytht.net@gmail.com>
Date: Thu, 20 Apr 2017 12:36:16 -0700
Message-Id: <20170420193616.36780-1-lepton@google.com>
Subject: [Qemu-devel] [PATCH 1/1] Fix wrong mss bug.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Tao Wu <lepton@google.com>

This bug was introduced by https://github.com/qemu/qemu/commit/98c6305

Signed-off-by: Tao Wu <lepton@google.com>
---
 slirp/tcp_input.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/slirp/tcp_input.c b/slirp/tcp_input.c
index edb98f06f3..07bcbdb2dd 100644
--- a/slirp/tcp_input.c
+++ b/slirp/tcp_input.c
@@ -1587,11 +1587,11 @@ tcp_mss(struct tcpcb *tp, u_int offer)
 	switch (so->so_ffamily) {
 	case AF_INET:
             mss = MIN(IF_MTU, IF_MRU) - sizeof(struct tcphdr)
-	                              + sizeof(struct ip);
+	                              - sizeof(struct ip);
 	    break;
 	case AF_INET6:
             mss = MIN(IF_MTU, IF_MRU) - sizeof(struct tcphdr)
-	                              + sizeof(struct ip6);
+	                              - sizeof(struct ip6);
 	    break;
 	default:
 	    g_assert_not_reached();
-- 
2.12.2.816.g2cccc81164-goog
