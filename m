Received: from eggs.gnu.org ([2001:4830:134:3::10]:59916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fMNHj-0006Lc-41
	for qemu-devel@nongnu.org; Fri, 25 May 2018 20:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fMNHi-0001hR-B4
	for qemu-devel@nongnu.org; Fri, 25 May 2018 20:42:15 -0400
Message-ID: <5B08AD46.9020101@huawei.com>
Date: Sat, 26 May 2018 08:41:42 +0800
From: Shannon Zhao <zhaoshenglong@huawei.com>
MIME-Version: 1.0
References: <152724816757.234.340581049808773005@d39dc562802a>
In-Reply-To: <152724816757.234.340581049808773005@d39dc562802a>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/2] Fix ARM KVM GICv3 get/put data
 shift bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-arm@nongnu.org, peter.maydell@linaro.org, shannon.zhaosl@gmail.com, eric.auger@redhat.com



On 2018/5/25 19:36, no-reply@patchew.org wrote:
> /tmp/qemu-test/src/hw/intc/arm_gicv3_common.c: In function 'gicv3_gicd_no_migration_shift_bug_post_load':
> /tmp/qemu-test/src/hw/intc/arm_gicv3_common.c:165:9: error: 'gicd_no_migration_shift_bug' undeclared (first use in this function); did you mean 'gicv3_gicd_no_migration_shift_bug_pre_load'?
>      if (gicd_no_migration_shift_bug) {
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>          gicv3_gicd_no_migration_shift_bug_pre_load

After compiling the patches, I add this check while forgot to use
cs->gicd_no_migration_shift_bug. My bad. I'll address this with other
comments in next version.

Thanks,
-- 
Shannon
