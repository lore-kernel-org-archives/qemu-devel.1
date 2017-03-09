Received: from eggs.gnu.org ([2001:4830:134:3::10]:54395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clw4G-0005AL-RR
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:17:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clw4E-0006So-1t
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:17:12 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:35009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1clw4D-0006Sc-SO
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:17:09 -0500
Received: by mail-wm0-x22c.google.com with SMTP id v186so136672816wmd.0
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 03:17:09 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  9 Mar 2017 11:17:05 +0000
Message-Id: <20170309111714.20394-3-alex.bennee@linaro.org>
In-Reply-To: <20170309111714.20394-1-alex.bennee@linaro.org>
References: <20170309111714.20394-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/11] target/i386/cpu.h: declare
 TCG_GUEST_DEFAULT_MO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

This suppresses the incorrect warning when forcing MTTCG for x86
guests on x86 hosts. A future patch will still warn when
TARGET_SUPPORT_MTTCG hasn't been defined for the guest (which is still
pending for x86).

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ac2ad6d443..fb09aee7f8 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -30,6 +30,9 @@
 #define TARGET_LONG_BITS 32
 #endif
 
+/* The x86 has a strong memory model with some store-after-load re-ordering */
+#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
+
 /* Maximum instruction code size */
 #define TARGET_MAX_INSN_SIZE 16
 
-- 
2.11.0
