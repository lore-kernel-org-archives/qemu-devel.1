Received: from eggs.gnu.org ([2001:4830:134:3::10]:53734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <okaya@codeaurora.org>) id 1cgCT0-0000Br-GD
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:35:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <okaya@codeaurora.org>) id 1cgCSz-0002C2-AK
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:35:02 -0500
References: <1487683100-16013-1-git-send-email-eric.auger@redhat.com>
	<1487683100-16013-2-git-send-email-eric.auger@redhat.com>
	<98d4d9e8-761c-76f9-ecb0-c5a4a658dfab@codeaurora.org>
	<2dcc9002-ec06-c55e-c0a2-75d05fe05762@redhat.com>
	<970561bf-0adc-4f60-bf2b-57bbafabb0aa@codeaurora.org>
	<8d790f60-6ee6-9b48-6dfc-524532db112b@redhat.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <a9ed1831-5a1c-5c27-25b0-71d06c7dee2e@codeaurora.org>
Date: Tue, 21 Feb 2017 10:34:49 -0500
MIME-Version: 1.0
In-Reply-To: <8d790f60-6ee6-9b48-6dfc-524532db112b@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] vfio/platform: make the vfio-platform
 device non abstract
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: shankerd@codeaurora.org, vikrams@codeaurora.org, agraf@suse.de, pelcan@codeaurora.org

On 2/21/2017 10:23 AM, Auger Eric wrote:
>> Note that the goal is to be able to instantiate any platform device by just
>> passing a compatible string and the object from the host. We don't want
>> to make changes to QEMU every time somebody comes up with a new platform device.
>> This step is unnecessary.
> Well we need to generate a device tree node for your device. We have not
> proven yet the function that creates this latter can be generic. There
> are some helpers that can read the host dt node, copy some properties
> from the host to the guest. But still at the moment we can't make things
> as generic as PCIe and this is why the platform passthrough still is
> controversial. So this patch aims at lowering the integration efforts
> but minimal specialization needs to be done in sysbus-fdt. Same on
> kernel side with the reset module.

Understood. You need to bring in the entire device tree parameters for a full-blown
solution. We can always treat this as a TODO.

I was more interested in simple devices like XHCI, AHCI, HIDMA where there
is no platform device attribute besides the interrupt number and memory
resources. QEMU already has access to these.

I was hoping to cover this at least. More complex objects need their own
implementation like the AMD driver in your example.

I'm pasting my comment from the archives here. 

https://lists.gnu.org/archive/html/qemu-devel/2016-08/msg03267.html

"Why submit a new SATA AHCI driver for QEMU just to set the compat string?"


> 
> Thanks
> 
> Eric
> 
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
