Received: from eggs.gnu.org ([2001:4830:134:3::10]:33311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRWBr-0008Bn-SM
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRWBr-00022g-8e
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:36:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cRWBr-00022T-3m
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:36:39 -0500
From: Peter Xu <peterx@redhat.com>
Date: Thu, 12 Jan 2017 11:36:20 +0800
Message-Id: <1484192182-13760-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1484192182-13760-1-git-send-email-peterx@redhat.com>
References: <1484192182-13760-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v6 1/3] run_tests: fix errno for
 param parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>, peterx@redhat.com, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 run_tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/run_tests.sh b/run_tests.sh
index 254129d..2cfa365 100755
--- a/run_tests.sh
+++ b/run_tests.sh
@@ -41,7 +41,7 @@ while getopts "g:hv" opt; do
             verbose="yes"
             ;;
         *)
-            exit 1
+            exit 2
             ;;
     esac
 done
-- 
2.7.4
