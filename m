Received: from eggs.gnu.org ([2001:4830:134:3::10]:55031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD070-00060b-L3
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06z-00040E-Tt
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:54 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dD06z-00040A-PY
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:53 -0400
Received: by mail-qt0-x241.google.com with SMTP id l39so20704449qtb.1
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 20:03:53 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	s190sm12918805qkh.57.2017.05.22.20.03.52 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 May 2017 20:03:52 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 22 May 2017 20:03:11 -0700
Message-Id: <20170523030312.6360-31-rth@twiddle.net>
In-Reply-To: <20170523030312.6360-1-rth@twiddle.net>
References: <20170523030312.6360-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 30/31] target/s390x: Implement CSPG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/insn-data.def | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 4c91f30..8604847 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -838,6 +838,7 @@
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
     D(0xb250, CSP,     RRE,   Z,   r1_32u, ra2, r1_P, 0, csp, 0, MO_TEUL)
+    D(0xb98a, CSPG,    RRE,   Z,   r1_o, ra2, r1_P, 0, csp, 0, MO_TEQ)
 /* DIAGNOSE (KVM hypercall) */
     C(0x8300, DIAG,    RSI,   Z,   0, 0, 0, 0, diag, 0)
 /* INSERT STORAGE KEY EXTENDED */
-- 
2.9.4
