Received: from eggs.gnu.org ([2001:4830:134:3::10]:54529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEETZ-0001s2-Jc
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:08:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEETY-0007XI-9U
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:08:33 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:48288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEETY-0007Vv-3R
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:08:32 -0500
Received: by mail-wr0-x22a.google.com with SMTP id 15so14363084wrb.5
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 05:08:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <40a0ece3-7498-0dda-9e13-234ba09bedf1@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
	<1504286483-23327-16-git-send-email-eric.auger@redhat.com>
	<CAFEAcA-BfvNFMFpiQd-XwGPYGasV3D-w3oDcqfHRoAXOAT17Fg@mail.gmail.com>
	<40a0ece3-7498-0dda-9e13-234ba09bedf1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 13:08:10 +0000
Message-ID: <CAFEAcA_d1DzNXoJHpi9afGA-oFcPncuM3L-n8GjiLPcAyic+TA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 15/20] hw/arm/sysbus-fdt: Pass the
 VirtMachineState to the node creation functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, Radha Mohan <mohun106@gmail.com>, Trey Cain <tcain@qti.qualcomm.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>, jean-philippe.brucker@arm.com, robin.murphy@arm.com, Peter Xu <peterx@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, wtownsen@redhat.com

On 13 November 2017 at 13:00, Auger Eric <eric.auger@redhat.com> wrote:
> On 09/10/2017 19:47, Peter Maydell wrote:
>> More generally, why is sysbus-fdt involved in this at all?
>> I expected that instantiating and wiring up the SMMU would
>> be the job of hw/arm/virt.c, like any other device we
>> might have on the board.
> I wished to have the same type of option as for x86 where
> "-device intel-iommu" is passed to the QEMU command line. smmuv3 device
> being a SysBusDevice, a natural framework to handle its node creation
> function is sysbus-fdt. Having a -device approach is practical to pass
> other options to the device (this was typically the case for the
> "caching-mode" option). On Intel there are caching-mode, passthrough
> (pt) options.

Not being able to conveniently wire up a sysbus device on the
command line or pass it options are general problems. I don't
think the SMMU is a special case that should work around these
general issues by being created in a different way to everything
else. If the "hard to pass options to the device" problem needs
solving (which it does anyway if we want to drop '-net' for
configuring embedded ethernet devices) we should solve it,
not have some small set of sysbus devices be weirdly magic.

thanks
-- PMM
