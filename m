Received: from eggs.gnu.org ([2001:4830:134:3::10]:44121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZwKd-0001m8-Fx
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZwKc-0003TA-KO
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:40:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dZwKc-0003Re-Dq
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:40:46 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 25 Jul 2017 11:40:15 +0200
Message-Id: <20170725094026.5376-4-cohuck@redhat.com>
In-Reply-To: <20170725094026.5376-1-cohuck@redhat.com>
References: <20170725094026.5376-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 03/14] s390/cpumodel: remove KSS from
 the default model of z14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, thuth@redhat.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

The SIE_KSS feature will allow a guest to use KSS for a nested guest.
To create a nested guest the SIE_F2 facility is still necessary.
Since SIE_F2 is not part of the default model it does not make
a lot of sense to provide the SIE_KSS feature in the default model.
Let's also create a dependency check.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Message-Id: <1500550051-7821-2-git-send-email-borntraeger@de.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_models.c   | 1 +
 target/s390x/gen-features.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index f4e5bb6611..d91b7b85f6 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -723,6 +723,7 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_KLMD_SHAKE_256, S390_FEAT_MSA },
         { S390_FEAT_PRNO_TRNG_QRTCR, S390_FEAT_MSA_EXT_5 },
         { S390_FEAT_PRNO_TRNG, S390_FEAT_MSA_EXT_5 },
+        { S390_FEAT_SIE_KSS, S390_FEAT_SIE_F2 },
     };
     int i;
 
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index cf69157610..c8dc104bc1 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -535,7 +535,6 @@ static uint16_t default_GEN14_GA1[] = {
     S390_FEAT_GROUP_MSA_EXT_6,
     S390_FEAT_GROUP_MSA_EXT_7,
     S390_FEAT_GROUP_MSA_EXT_8,
-    S390_FEAT_SIE_KSS,
 };
 
 /****** END FEATURE DEFS ******/
-- 
2.13.3
