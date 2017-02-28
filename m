Received: from eggs.gnu.org ([2001:4830:134:3::10]:52299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cijN1-0003fB-3T
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:07:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cijMw-0002mv-IM
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:07:19 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:37790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cijMw-0002mo-CT
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:07:14 -0500
Received: by mail-wm0-x230.google.com with SMTP id v77so14046074wmv.0
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 07:07:14 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 28 Feb 2017 15:07:08 +0000
Message-Id: <20170228150709.27453-3-alex.bennee@linaro.org>
In-Reply-To: <20170228150709.27453-1-alex.bennee@linaro.org>
References: <20170228150709.27453-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 2/3] target/i386/cpu.h: declare
 TCG_GUEST_DEFAULT_MO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

This suppresses the incorrect warning when forcing MTTCG for x86
guests on x86 hosts. A future patch will still warn when
TARGET_SUPPORT_MTTCG hasn't been defined for the guest (which is still
pending for x86).

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/i386/cpu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 573f2aa988..6be19d7e74 100644
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
