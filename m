Received: from eggs.gnu.org ([2001:4830:134:3::10]:41189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cy6ux-00082F-BV
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 21:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cy6uw-0006Q7-Fl
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 21:17:55 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 11 Apr 2017 21:17:27 -0400
Message-Id: <1491959850-30756-8-git-send-email-cota@braap.org>
In-Reply-To: <1491959850-30756-1-git-send-email-cota@braap.org>
References: <1491959850-30756-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 07/10] tcg: add tcg_temp_local_new_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Claudio Fontana <claudio.fontana@huawei.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

This will be used by TCG targets to implement a fast path
for indirect branches.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 6c216bb..37a7c8e 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -912,6 +912,7 @@ do {\
 #define tcg_global_mem_new_ptr(R, O, N) \
     TCGV_NAT_TO_PTR(tcg_global_mem_new_i32((R), (O), (N)))
 #define tcg_temp_new_ptr() TCGV_NAT_TO_PTR(tcg_temp_new_i32())
+#define tcg_temp_local_new_ptr() TCGV_NAT_TO_PTR(tcg_temp_local_new_i32())
 #define tcg_temp_free_ptr(T) tcg_temp_free_i32(TCGV_PTR_TO_NAT(T))
 #else
 #define TCGV_NAT_TO_PTR(n) MAKE_TCGV_PTR(GET_TCGV_I64(n))
@@ -923,6 +924,7 @@ do {\
 #define tcg_global_mem_new_ptr(R, O, N) \
     TCGV_NAT_TO_PTR(tcg_global_mem_new_i64((R), (O), (N)))
 #define tcg_temp_new_ptr() TCGV_NAT_TO_PTR(tcg_temp_new_i64())
+#define tcg_temp_local_new_ptr() TCGV_NAT_TO_PTR(tcg_temp_local_new_i64())
 #define tcg_temp_free_ptr(T) tcg_temp_free_i64(TCGV_PTR_TO_NAT(T))
 #endif
 
-- 
2.7.4
