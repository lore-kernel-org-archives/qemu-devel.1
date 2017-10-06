Received: from eggs.gnu.org ([2001:4830:134:3::10]:59359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PS8-0006wk-BI
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PS6-0000Pz-4k
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0PS5-0000Ow-Vf
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:54 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Oct 2017 11:59:55 +0200
Message-Id: <20171006095956.27534-33-cohuck@redhat.com>
In-Reply-To: <20171006095956.27534-1-cohuck@redhat.com>
References: <20171006095956.27534-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 32/33] s390x/tcg: initialize machine check queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

Just as for external interrupts and I/O interrupts, we need to
initialize mchk_index during cpu reset.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 4e1823a3e0..3fdf9bae70 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -111,6 +111,7 @@ static void s390_cpu_initial_reset(CPUState *s)
     for (i = 0; i < ARRAY_SIZE(env->io_index); i++) {
         env->io_index[i] = -1;
     }
+    env->mchk_index = -1;
 
     /* tininess for underflow is detected before rounding */
     set_float_detect_tininess(float_tininess_before_rounding,
@@ -148,6 +149,7 @@ static void s390_cpu_full_reset(CPUState *s)
     for (i = 0; i < ARRAY_SIZE(env->io_index); i++) {
         env->io_index[i] = -1;
     }
+    env->mchk_index = -1;
 
     /* tininess for underflow is detected before rounding */
     set_float_detect_tininess(float_tininess_before_rounding,
-- 
2.13.6
