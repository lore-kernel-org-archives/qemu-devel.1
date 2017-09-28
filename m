Received: from eggs.gnu.org ([2001:4830:134:3::10]:53722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfaP-00057I-Nc
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfaL-0003lA-QN
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:39:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfaL-0003kw-KD
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:39:05 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:37:05 +0200
Message-Id: <20170928203708.9376-28-david@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 27/30] s390x/cpumodel: allow to enable SENSE
 RUNNING STATUS for qemu
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>
List-ID: <qemu-devel.nongnu.org>

As we properly implement it, allow to enable it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_models.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 07ef8a3b6e..095a11cbca 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -823,6 +823,7 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
         S390_FEAT_DAT_ENH,
         S390_FEAT_IDTE_SEGMENT,
         S390_FEAT_STFLE,
+        S390_FEAT_SENSE_RUNNING_STATUS,
         S390_FEAT_EXTENDED_IMMEDIATE,
         S390_FEAT_EXTENDED_TRANSLATION_2,
         S390_FEAT_MSA,
-- 
2.13.5
