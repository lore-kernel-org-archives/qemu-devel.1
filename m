Received: from eggs.gnu.org ([2001:4830:134:3::10]:45735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clHO0-0002PO-59
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clHNz-0005jU-54
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:50:52 -0500
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1clHNy-0005jI-V1
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:50:51 -0500
Received: by mail-wr0-x22d.google.com with SMTP id g10so4347743wrg.2
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 07:50:50 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  7 Mar 2017 15:50:45 +0000
Message-Id: <20170307155054.5833-3-alex.bennee@linaro.org>
In-Reply-To: <20170307155054.5833-1-alex.bennee@linaro.org>
References: <20170307155054.5833-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 02/11] target/i386/cpu.h: declare
 TCG_GUEST_DEFAULT_MO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>

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
