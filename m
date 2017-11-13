Received: from eggs.gnu.org ([2001:4830:134:3::10]:37953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eEEvE-000072-T3
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:37:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eEEvA-0008Oz-UI
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:37:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1eEEvA-0008Nk-NU
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:37:04 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E09DBC047B82
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 13:37:03 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 741EE7F768
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 13:37:03 +0000 (UTC)
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
	<1504286483-23327-16-git-send-email-eric.auger@redhat.com>
	<CAFEAcA-BfvNFMFpiQd-XwGPYGasV3D-w3oDcqfHRoAXOAT17Fg@mail.gmail.com>
	<40a0ece3-7498-0dda-9e13-234ba09bedf1@redhat.com>
	<CAFEAcA_d1DzNXoJHpi9afGA-oFcPncuM3L-n8GjiLPcAyic+TA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <0e23f2bb-a3be-2ba5-5d90-2b7c42b68d5b@redhat.com>
Date: Mon, 13 Nov 2017 14:37:01 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_d1DzNXoJHpi9afGA-oFcPncuM3L-n8GjiLPcAyic+TA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: qemu-devel@nongnu.org

Hi Peter,

On 13/11/2017 14:08, Peter Maydell wrote:
> On 13 November 2017 at 13:00, Auger Eric <eric.auger@redhat.com> wrote:
>> On 09/10/2017 19:47, Peter Maydell wrote:
>>> More generally, why is sysbus-fdt involved in this at all?
>>> I expected that instantiating and wiring up the SMMU would
>>> be the job of hw/arm/virt.c, like any other device we
>>> might have on the board.
>> I wished to have the same type of option as for x86 where
>> "-device intel-iommu" is passed to the QEMU command line. smmuv3 device
>> being a SysBusDevice, a natural framework to handle its node creation
>> function is sysbus-fdt. Having a -device approach is practical to pass
>> other options to the device (this was typically the case for the
>> "caching-mode" option). On Intel there are caching-mode, passthrough
>> (pt) options.
> 
> Not being able to conveniently wire up a sysbus device on the
> command line or pass it options are general problems. I don't
> think the SMMU is a special case that should work around these
> general issues by being created in a different way to everything
> else. If the "hard to pass options to the device" problem needs
> solving (which it does anyway if we want to drop '-net' for
> configuring embedded ethernet devices) we should solve it,
> not have some small set of sysbus devices be weirdly magic.
do you have examples of other SysbusDevices whose instantiation is made
conditional with "-device" option and which address the dt node/ACPI
table creation in a more standard manner? Or do you want me to drop the
"-device" requirement.

I may manage reaching my goal with yet another machine init done
notifier that would create the dt node from virt code at fixed base
address. But this solution still may be be virt specific. Is it the
direction you want me to follow at the moment?

Thanks

Eric

> 
> thanks
> -- PMM
> 
