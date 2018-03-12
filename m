Received: from eggs.gnu.org ([2001:4830:134:3::10]:48647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evP1i-0007pA-9s
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evP1h-0005vf-Ew
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:06:14 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:43975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evP1h-0005v2-8N
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:06:13 -0400
Received: by mail-ot0-x243.google.com with SMTP id m22so15574744otf.10
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 08:06:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f22e252d-463e-78ed-f405-6164b0c8d566@redhat.com>
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
	<1518893216-9983-13-git-send-email-eric.auger@redhat.com>
	<CAFEAcA-BZ=wcpEKVQnX0dBh7tZVPNfHRm1E39DYEMZ=UStEamA@mail.gmail.com>
	<f22e252d-463e-78ed-f405-6164b0c8d566@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Mar 2018 15:05:52 +0000
Message-ID: <CAFEAcA8W66ZorjHp_C4-DvZhn2V+sLyAecRhv4pJ833BriWv-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v9 12/14] hw/arm/virt: Add SMMUv3 to the
 virt board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Tomasz Nowicki <tn@semihalf.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Christoffer Dall <christoffer.dall@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Bharat Bhushan <bharat.bhushan@nxp.com>, Prem Mallappa <prem.mallappa@gmail.com>, Eric Auger <eric.auger.pro@gmail.com>

On 12 March 2018 at 15:01, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Peter,
>
> On 12/03/18 13:46, Peter Maydell wrote:
>> On 17 February 2018 at 18:46, Eric Auger <eric.auger@redhat.com> wrote:
>>> +    qemu_fdt_setprop(vms->fdt, node, "dma-coherent", NULL, 0);
>>
>> Is this definitely the right setting for dma-coherent? My (possibly
>> naive) thought is that for an emulated SMMU our page-table walks are
>> going to be coherent with the CPU's view.
>
> Indeed we add the dma-capable property to make the DMA ops of the SMMU
> cache coherent with the CPU. We pass NULL/O since there is just
> dma-coherent in the dt property. What am I missing?

My mistake, I thought this was the equivalent of "dma-coherent = 0;".

thanks
-- PMM
