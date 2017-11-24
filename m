Received: from eggs.gnu.org ([2001:4830:134:3::10]:32975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eIF1e-0003LL-2u
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 09:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eIF1d-0002HB-7a
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 09:32:18 -0500
References: <1511533107-5315-1-git-send-email-eric.auger@redhat.com>
	<CAFEAcA_K4f=mmuoEbyuFCHP2dor5p2UPyedteELQoxPYFzAcEg@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <dd80f8f3-26da-5893-fa4b-cfa31790394d@redhat.com>
Date: Fri, 24 Nov 2017 15:32:05 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_K4f=mmuoEbyuFCHP2dor5p2UPyedteELQoxPYFzAcEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/4] ITS Reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, wanghaibin.wang@huawei.com, Vijay Kilari <vijay.kilari@gmail.com>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, wu.wubin@huawei.com

Hi Peter,

On 24/11/17 15:20, Peter Maydell wrote:
> On 24 November 2017 at 14:18, Eric Auger <eric.auger@redhat.com> wrote:
>> At the moment the ITS is not properly reset. On System reset or
>> reboot, previous ITS register values and caches are left
>> unchanged. Some of the registers might point to some guest RAM
>> tables which are not valid anymore. This leads to state
>> inconsistencies that are detected by the kernel save/restore
>> code. And eventually this may cause qemu abort.
>>
>> This series adds vITS reset modality:
>> - the 2 first patches bring a minimalist reset through individual
>>   register writes. However, with kernel versions < 4.15, this reset
>>   is not complete (vITS caches are not voided).
>> - With kernel versions >= 4.15 we can rely on a new ITS KVM device
>>   reset IOTCL. The last 2 patches introduce the full reset.
>>
>> Tested with 4.11, 4.14 and 4.15 host kernels.
> 
> Thanks. My remaining question is: how important it is to
> put some of this into 2.11? We're getting quite close to
> the release now so I'm getting gradually more reluctant
> to put in changes.

I fully understand.

Anyway clean and comprehensive reset modality would require v4.15 + full
QEMU series (otherwise you get the scary error message even if full
reset can be achieved by individual register writes).

This means the migration of guests while they are booting will not be
functional in 2.11. However it should not abort QEMU as it did before,
with a kernel >= v4.14.

Thanks

Eric

> 
> thanks
> -- PMM
> 
