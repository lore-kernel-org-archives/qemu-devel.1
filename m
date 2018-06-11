Received: from eggs.gnu.org ([2001:4830:134:3::10]:57388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fSIGf-0006ok-9Y
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fSIGe-0004Le-Hx
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:33:37 -0400
Message-ID: <5B1E33A4.7070509@huawei.com>
Date: Mon, 11 Jun 2018 16:32:36 +0800
From: Shannon Zhao <zhaoshenglong@huawei.com>
MIME-Version: 1.0
References: <1527736557-11084-1-git-send-email-zhaoshenglong@huawei.com>
	<1527736557-11084-2-git-send-email-zhaoshenglong@huawei.com>
	<e7bb1cbd-7fad-5bd2-641c-885f0f473680@redhat.com>
In-Reply-To: <e7bb1cbd-7fad-5bd2-641c-885f0f473680@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/2] arm_gicv3_kvm:
 kvm_dist_get/put_priority: skip the registers banked by GICR_IPRIORITYR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, qemu-stable@nongnu.org



On 2018/5/31 19:01, Auger Eric wrote:
> Hi,
> 
> On 05/31/2018 05:15 AM, Shannon Zhao wrote:
>> While for_each_dist_irq_reg loop starts from GIC_INTERNAL, it forgot to
>> offset the date array and index. This will overlap the GICR registers
>> value and leave the last GIC_INTERNAL irq's registers out of update.
>>
>> Fixes: 367b9f527becdd20ddf116e17a3c0c2bbc486920
>> Cc: qemu-stable@nongnu.org
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
Hi Peter,

Looks like we missed picking up this patch. I didn't include this in v6
since you and Eric both reviewed it.

Could you please pick it up?

Thanks,
-- 
Shannon
