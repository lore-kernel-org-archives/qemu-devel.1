Received: from eggs.gnu.org ([2001:4830:134:3::10]:58665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8d-0003id-B4
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8c-0000Hc-Ep
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45842 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8c-0000HJ-AE
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:22 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:29 +0200
Message-Id: <20180531171253.21012-30-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 29/53] memory: delete struct AddressSpaceOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jay Zhou <jianjay.zhou@huawei.com>

From: Jay Zhou <jianjay.zhou@huawei.com>

Since struct AddressSpaceOps isn't used anywhere else,
so just delete it.

Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
Message-Id: <1526384108-49348-1-git-send-email-jianjay.zhou@huawei.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/memory.c b/memory.c
index 7ead90f8cd..e4f484b73e 100644
--- a/memory.c
+++ b/memory.c
@@ -219,8 +219,6 @@ struct FlatRange {
     bool readonly;
 };
 
-typedef struct AddressSpaceOps AddressSpaceOps;
-
 #define FOR_EACH_FLAT_RANGE(var, view)          \
     for (var = (view)->ranges; var < (view)->ranges + (view)->nr; ++var)
 
-- 
2.17.0
