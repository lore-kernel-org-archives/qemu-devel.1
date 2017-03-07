Received: from eggs.gnu.org ([2001:4830:134:3::10]:45895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clHO9-0002Z1-MA
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:51:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clHO6-0005sB-VU
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:51:01 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:36336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1clHO6-0005rv-OM
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:50:58 -0500
Received: by mail-wm0-x22c.google.com with SMTP id n11so93217227wma.1
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 07:50:58 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  7 Mar 2017 15:50:53 +0000
Message-Id: <20170307155054.5833-11-alex.bennee@linaro.org>
In-Reply-To: <20170307155054.5833-1-alex.bennee@linaro.org>
References: <20170307155054.5833-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 10/11] target/arm/helper: make it clear the
 EC field is also in hex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

..just like the rest of the displayed ESR register. Otherwise people
might scratch their heads if a not obviously hex number is displayed
for the EC field.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: KONRAD Frederic <fred.konrad@greensocs.com>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3f4211b572..76b608f0ba 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6857,7 +6857,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
                   new_el);
     if (qemu_loglevel_mask(CPU_LOG_INT)
         && !excp_is_internal(cs->exception_index)) {
-        qemu_log_mask(CPU_LOG_INT, "...with ESR %x/0x%" PRIx32 "\n",
+        qemu_log_mask(CPU_LOG_INT, "...with ESR 0x%x/0x%" PRIx32 "\n",
                       env->exception.syndrome >> ARM_EL_EC_SHIFT,
                       env->exception.syndrome);
     }
-- 
2.11.0
