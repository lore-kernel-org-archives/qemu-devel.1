Received: from eggs.gnu.org ([2001:4830:134:3::10]:58281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1chMpa-0000hf-Q8
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 15:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1chMpX-0005yY-PL
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 15:51:10 -0500
Date: Fri, 24 Feb 2017 21:51:05 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA8gde7GfWhyRLyOB5yL_5zrm4b7tj4pH=GTj=RwZO_4wg@mail.gmail.com>
Message-ID: <alpine.BSF.2.20.1702242148080.76443@zero.eik.bme.hu>
References: <cover.1487522123.git.balaton@eik.bme.hu>
	<5077e2a9732e1b9afcb0754e93624b787589ac61.1487522123.git.balaton@eik.bme.hu>
	<CAFEAcA8gde7GfWhyRLyOB5yL_5zrm4b7tj4pH=GTj=RwZO_4wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH 10/10] ppc: Add SM501 device in config for
 ppc and ppcemb targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On Fri, 24 Feb 2017, Peter Maydell wrote:
> On 19 February 2017 at 16:35, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> This is not used by default on any emulated machine yet but it is
>> still useful to have it compiled so it can be added from the command
>> line for clients that can use it (e.g. MorphOS has no driver for any
>> other emulated video cards but can output via SM501)
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> If this is a generic PCI device then shouldn't it go into
> default-configs/pci.mak ?

This is a multimedia chip usually found on sh4 systems and some ppc boards 
that's why I've only added it to these but I can move it to pci.mak if you 
think it's a better place for it.

Thanks again for taking the time to review, if you could answer these 
questions I can try to prepare a v2.
