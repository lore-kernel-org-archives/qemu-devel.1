Received: from eggs.gnu.org ([2001:4830:134:3::10]:56671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6FJ-0001jt-Pc
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6FF-00058E-T5
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn6FF-00057t-Mk
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:37 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:17 +0200
Message-Id: <20170830165252.13421-10-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 09/44] s390x/tcg: specification exception for
 unknown diag
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

While the PoP is silent on the issue, z/VM documentation states
that unknown diagnose codes trigger a specification exception.
We already do that when running with kvm, so change tcg to do so
as well.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/misc_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index d23ffcd890..5a1eba02ab 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -109,7 +109,7 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
     }
 
     if (r) {
-        program_interrupt(env, PGM_OPERATION, ILEN_AUTO);
+        program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
     }
 }
 
-- 
2.13.5
