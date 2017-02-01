Received: from eggs.gnu.org ([2001:4830:134:3::10]:36825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cYqrh-0002mt-Fj
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:06:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cYqre-0004l5-Bj
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:06:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cYqre-0004ks-2q
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:06:06 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1195w3W073365
	for <qemu-devel@nongnu.org>; Wed, 1 Feb 2017 04:06:05 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28bbdktvbq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 04:06:03 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 1 Feb 2017 09:04:50 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed,  1 Feb 2017 10:04:44 +0100
In-Reply-To: <1485939884-39956-1-git-send-email-borntraeger@de.ibm.com>
References: <1485939884-39956-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1485939884-39956-4-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 3/3] target/s390x: use "qemu" cpu model in user
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, qemu-stable@nongnu.org

From: David Hildenbrand <david@redhat.com>

"any" does not exist, therefore resulting in a misleading error message.

Reported-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170130145025.26475-1-david@redhat.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Alexander Graf <agraf@suse.de>
Cc: qemu-stable@nongnu.org
---
 linux-user/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index 3004958..e588f58 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4322,6 +4322,8 @@ int main(int argc, char **argv, char **envp)
 # endif
 #elif defined TARGET_SH4
         cpu_model = TYPE_SH7785_CPU;
+#elif defined TARGET_S390X
+        cpu_model = "qemu";
 #else
         cpu_model = "any";
 #endif
-- 
2.7.4
