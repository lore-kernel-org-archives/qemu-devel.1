Received: from eggs.gnu.org ([2001:4830:134:3::10]:32926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dFxqu-0001lJ-Ch
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:15:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dFxqq-0006Yz-Ax
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:15:32 -0400
References: <1494697399-352-1-git-send-email-eric.auger@redhat.com>
	<1494697399-352-5-git-send-email-eric.auger@redhat.com>
	<CAFEAcA-GCKfxEpy9p=k7NzoY2zez-KVXNMuAx-ruW5t27ZMgQQ@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2c81529b-6916-8dd6-eee9-45e5768d82ca@redhat.com>
Date: Wed, 31 May 2017 09:15:12 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-GCKfxEpy9p=k7NzoY2zez-KVXNMuAx-ruW5t27ZMgQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 4/5] hw/arm/virt: Add 2.10 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, prem.mallappa@gmail.com, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, Radha Mohan <mohun106@gmail.com>, Trey Cain <tcain@qti.qualcomm.com>

Hi Peter,

On 30/05/2017 18:04, Peter Maydell wrote:
> On 13 May 2017 at 18:43, Eric Auger <eric.auger@redhat.com> wrote:
>> The new machine type allows smmuv3 instantiation. A new option
>> is introduced to turn the feature on/off (off by default).
> 
> Should we go for default-on, or would that break guests?
> For other things added to the virt board I think the
> approach we've taken has been:
>  * if this is just an extra device, simply provide it in the
>    new virt-n.nn machine by default
>  * if this is something that changes how the machine behaves
>    even for code that doesn't care about that feature (eg
>    EL2, EL3, since they change what mode you start in on boot)
>    then default it to off
>  * if the feature only works with TCG and not KVM then
>    maybe default it to off

OK thanks for the guidelines. I put it off by default since it can
largely degrade the performance in some use cases. Also instantiating
the smmu can also induce some option changes at other levels: for
instance virtio-pci devices may be used along with iommu_platform option
for the guest to use dma ops.

Thanks

Eric
> 
> thanks
> -- PMM
> 
