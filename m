Received: from eggs.gnu.org ([2001:4830:134:3::10]:40524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eqxLe-0002F2-98
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 03:44:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eqxLd-000651-Bp
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 03:44:26 -0500
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
	<CAFEAcA9KzitEO21Rgh8Azip+gVJjyobzNbk8sHuQf-ngg+Jjxg@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <74aa2e5e-ed1b-3cf8-8ddc-41f7ef90ad7b@redhat.com>
Date: Wed, 28 Feb 2018 09:44:03 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9KzitEO21Rgh8Azip+gVJjyobzNbk8sHuQf-ngg+Jjxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 00/14] ARM SMMUv3 Emulation Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Tomasz Nowicki <tn@semihalf.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Christoffer Dall <christoffer.dall@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Bharat Bhushan <bharat.bhushan@nxp.com>, Prem Mallappa <prem.mallappa@gmail.com>, eric.auger.pro@gmail.com

Hi Peter,

On 27/02/18 20:02, Peter Maydell wrote:
> On 17 February 2018 at 18:46, Eric Auger <eric.auger@redhat.com> wrote:
>> This series implements the emulation code for ARM SMMUv3.
>>
>> SMMUv3 gets instantiated by adding ",iommu=smmuv3" to the virt
>> machine option.
>>
>> VHOST integration will be handled in a separate series. VFIO
>> integration is not targeted at the moment. Only stage 1 and
>> AArch64 PTW are supported.
>>
>> Main changes since v8:
>> - fix mingw compilation (qemu/log.h)
>> - put gpl v2 license on all files to respect initial license
>> - change proto of smmu_ptw* to clarify inputs/outputs and
>>   prepare for iotlb emulation
>> - fix hash table lookup
>> - cleanup access type handling during ptw
>> - cleanup reset infra (parent_reset)
>> - replace some inline functions by macros
>> - fix some CMD fields
>> - increment cmdq cons only after cmd execution
>> - replace some remaining error_report by qemu_log_mask
> 
> What state is this series in now? Is it "seems ready to
> go, needs review"? Are you hoping it might get in for 2.12,
> or targeting 2.13 ?
Yes I think it is in a decent state and I would be happy to get some new
reviews, for a tentative pull in 2.12. In any case I will be reactive on
any comment in that prospect.

Thanks

Eric
> 
> thanks
> -- PMM
> 
