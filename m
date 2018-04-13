Received: from eggs.gnu.org ([2001:4830:134:3::10]:41222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f6zCB-0006Ia-SC
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:56:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f6zCB-0003dX-6r
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:56:55 -0400
References: <1522160122-10744-1-git-send-email-eric.auger@redhat.com>
	<1522160122-10744-5-git-send-email-eric.auger@redhat.com>
	<CAFEAcA8sQSuVcYPyE58tjapxxe6FNdD5qcyftYrZeWQ0fbev8w@mail.gmail.com>
	<e2fcd39f-f7f9-f8a2-7ef2-68a626e6bd0f@redhat.com>
	<CAFEAcA-D083O3EVoF_DXPpXf2ax6Kfad9HOToFjZg8tnRE=g7Q@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <70d8e4a0-12ad-dd75-3b71-fd611b7ec0fe@redhat.com>
Date: Fri, 13 Apr 2018 15:56:47 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-D083O3EVoF_DXPpXf2ax6Kfad9HOToFjZg8tnRE=g7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 4/8] hw/intc/arm_gicv3: Implement
 register_redist_region API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Wei Huang <wei@redhat.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <cdall@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Eric Auger <eric.auger.pro@gmail.com>

Hi Peter,

On 13/04/18 15:46, Peter Maydell wrote:
> On 13 April 2018 at 14:44, Auger Eric <eric.auger@redhat.com> wrote:
>> Actually this is an API provided to the machine and not the device
>> itself directly playing with the mapping.
>>
>> If not acceptable, I need to match the existing notifier framework and
>> do something similar taking into account the new GROUP/ATTR address
>> semantics here.
> 
> I think I'd rather that we continue to tell the kernel about
> the addresses of device related regions in the same general
> way that we do at the moment.

OK I will rework in that direction then.

Thank you for the review!

Eric
> 
> thanks
> -- PMM
> 
