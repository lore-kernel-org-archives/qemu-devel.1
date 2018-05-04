Received: from eggs.gnu.org ([2001:4830:134:3::10]:44404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fEdxP-00015A-5i
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fEdxO-0007t4-F1
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:53:19 -0400
References: <1524665762-31355-1-git-send-email-eric.auger@redhat.com>
	<CAFEAcA9SyY=1eVdXkHpxyES004T5WAx_h9axDSSo-vk440sfiA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <0df11de9-aaa4-0fb4-afc2-f4841bb9006b@redhat.com>
Date: Fri, 4 May 2018 18:52:57 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9SyY=1eVdXkHpxyES004T5WAx_h9axDSSo-vk440sfiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v12 00/17] ARM SMMUv3 Emulation Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <cdall@kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

Hi Peter,

On 05/04/2018 06:51 PM, Peter Maydell wrote:
> On 25 April 2018 at 15:15, Eric Auger <eric.auger@redhat.com> wrote:
>> This series implements the emulation code for ARM SMMUv3.
>>
>> SMMUv3 gets instantiated by adding ",iommu=smmuv3" to the virt
>> machine option.
>>
>> Only stage 1 and AArch64 PTW are supported. [1 - 14] bring the core
>> emulation code. [15, 16] bring optimizations and 17 brings the vhost
>> integration.
>>
>> Important Note:
>> I added the last 3 patches for consistency but I would be happy
>> if [1 - 14] could land upstream first, without waiting for the last
>> 3 patch additional review cycles.
> 
> I have applied 1-14 to target-arm.next; haven't looked at 15-17,
> so I suggest you repost those as their own series once 1-14 are
> in master.

Sure.

Thanks

Eric
> 
> thanks
> -- PMM
> 
