Received: from eggs.gnu.org ([2001:4830:134:3::10]:47034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W6q-00028x-1j
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:02:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W6g-0008CR-1q
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:02:07 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1g9W6f-0006yM-P3
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:01:57 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W4u-0003e6-SP
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:00:08 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  8 Oct 2018 14:59:32 +0100
Message-Id: <20181008140004.12612-2-peter.maydell@linaro.org>
In-Reply-To: <20181008140004.12612-1-peter.maydell@linaro.org>
References: <20181008140004.12612-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/33] target/arm: fix code comments error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Dongjiu Geng <gengdongjiu@huawei.com>

The parameter of kvm_arm_init_cpreg_list() is ARMCPU instead of
CPUState, so correct the note to make it match the code.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Message-id: 1538069046-5757-1-git-send-email-gengdongjiu@huawei.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 4 ++--
 target/arm/kvm.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 863f205822e..5948e8b5602 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -50,9 +50,9 @@ void kvm_arm_register_device(MemoryRegion *mr, uint64_t devid, uint64_t group,
 
 /**
  * kvm_arm_init_cpreg_list:
- * @cs: CPUState
+ * @cpu: ARMCPU
  *
- * Initialize the CPUState's cpreg list according to the kernel's
+ * Initialize the ARMCPU cpreg list according to the kernel's
  * definition of what CPU registers it knows about (and throw away
  * the previous TCG-created cpreg list).
  *
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 65f867d5692..54ef5f711b8 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -310,7 +310,7 @@ static int compare_u64(const void *a, const void *b)
     return 0;
 }
 
-/* Initialize the CPUState's cpreg list according to the kernel's
+/* Initialize the ARMCPU cpreg list according to the kernel's
  * definition of what CPU registers it knows about (and throw away
  * the previous TCG-created cpreg list).
  */
-- 
2.19.0
