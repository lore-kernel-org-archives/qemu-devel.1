Received: from eggs.gnu.org ([2001:4830:134:3::10]:37772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fOCcH-0001Up-Vj
	for qemu-devel@nongnu.org; Wed, 30 May 2018 21:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fOCcH-0006oO-8j
	for qemu-devel@nongnu.org; Wed, 30 May 2018 21:43:02 -0400
Message-ID: <5B0F52F6.8060006@huawei.com>
Date: Thu, 31 May 2018 09:42:14 +0800
From: Shannon Zhao <zhaoshenglong@huawei.com>
MIME-Version: 1.0
References: <1527690380-9782-1-git-send-email-eric.auger@redhat.com>
	<1527690380-9782-3-git-send-email-eric.auger@redhat.com>
	<273bb69a-a463-7fbe-edb0-a87622556afb@redhat.com>
In-Reply-To: <273bb69a-a463-7fbe-edb0-a87622556afb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/arm/virt: Add virt-3.0 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: drjones@redhat.com, wei@redhat.com, ard.biesheuvel@linaro.org, liujinsong <liu.jinsong@huawei.com>



On 2018/5/31 0:18, Laszlo Ersek wrote:
> +    vms->highmem_ecam &= vms->highmem && (!firmware_loaded || aarch64);
>> +
Does it need a info log here to tell user that even though you enable
the highmem_ecam but due to some other reasons it's disabled.

Also, if user enables highmem_ecam but finally it can't enable, does it
need to error out?

Thanks,
-- 
Shannon
