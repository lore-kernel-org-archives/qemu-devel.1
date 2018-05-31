Received: from eggs.gnu.org ([2001:4830:134:3::10]:49987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fOGzw-0002Up-Dd
	for qemu-devel@nongnu.org; Thu, 31 May 2018 02:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fOGzv-0004GX-J2
	for qemu-devel@nongnu.org; Thu, 31 May 2018 02:23:44 -0400
References: <1527690380-9782-1-git-send-email-eric.auger@redhat.com>
	<1527690380-9782-3-git-send-email-eric.auger@redhat.com>
	<273bb69a-a463-7fbe-edb0-a87622556afb@redhat.com>
	<5B0F52F6.8060006@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <9711bb05-d02a-5c23-6494-951ce6783923@redhat.com>
Date: Thu, 31 May 2018 08:23:33 +0200
MIME-Version: 1.0
In-Reply-To: <5B0F52F6.8060006@huawei.com>
Content-Type: text/plain; charset=utf-8
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
To: Shannon Zhao <zhaoshenglong@huawei.com>, Laszlo Ersek <lersek@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: wei@redhat.com, liujinsong <liu.jinsong@huawei.com>, drjones@redhat.com, ard.biesheuvel@linaro.org

Hi Shannon,

On 05/31/2018 03:42 AM, Shannon Zhao wrote:
> 
> 
> On 2018/5/31 0:18, Laszlo Ersek wrote:
>> +    vms->highmem_ecam &= vms->highmem && (!firmware_loaded || aarch64);
>>> +
> Does it need a info log here to tell user that even though you enable
> the highmem_ecam but due to some other reasons it's disabled.
> 
> Also, if user enables highmem_ecam but finally it can't enable, does it
> need to error out?

highmem_ecam is not a user settable option. highmem is. highmem_ecam is
computed based on the machine type capability to support this feature,
the fact highmem is set and we don't have an aarch32 FW being used.

Thanks

Eric
> 
> Thanks,
> 
