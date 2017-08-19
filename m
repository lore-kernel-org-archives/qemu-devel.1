Received: from eggs.gnu.org ([2001:4830:134:3::10]:53837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dj0b7-00066w-0B
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 06:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dj0b3-0000G3-Ub
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 06:03:17 -0400
Date: Sat, 19 Aug 2017 12:03:11 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <AM5P194MB01328DE5DCCC5E8CDD9C3C44C8800@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
Message-ID: <alpine.BSF.2.21.1708191121300.89556@zero.eik.bme.hu>
References: <cover.1502643878.git.balaton@eik.bme.hu>,
	<0362ffdbfb08b46edef0e2180387078299a9b721.1502643878.git.balaton@eik.bme.hu>
	<AM5P194MB0132F81D398EB4EB8EB13E22C8800@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>,
	<alpine.BSF.2.21.1708181418010.19483@zero.eik.bme.hu>
	<AM5P194MB01328DE5DCCC5E8CDD9C3C44C8800@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH 09/12] ppc440: Add emulation
 of plb-pcix controller found in some 440 SoCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luigi burdo <intermediadc@hotmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Francois Revol <revol@free.fr>, David Gibson <david@gibson.dropbear.id.au>

On Fri, 18 Aug 2017, luigi burdo wrote:
> i have sam460 amigaos cdrom iso as my backup and can test it inside 
> qemu. sharing the logs if you needed.

It may help if you can do that. You need to compile QEMU from git with 
this patch series applied and copy the u-boot-sam460-20100605-fixed.bin 
linked from the cover message as u-boot-sam460-20100605.bin to the current 
dir. Then try booting the CD and see if it shows something. It should 
print some messages to console where it's started with -serial stdio when 
you start AmigaOS with debug (you may need to set os4_commandline in 
U-Boot for this but I don't know AmigaOS).

> about real hardware no problem i will ask inside amigan community if 
> someone have the opportunity to share the serial debug of sam 460 
> runinng amigaos.

Do you know about a good place for such requests? Is there some forum or 
mailing list I should be aware of?

> can i ask you something ?
> why you dont try to integrate in qemu the pegasos 2 or the efika 
> machine. i have the feeling that probably it can be more simple because 
> more old machine and components.

The age of a machine and components has nothing to do with how easy it is 
to emulate. It depends on what is already emulated in QEMU. If none of 
those old components are implemented by QEMU already then it's a lot of 
work to write emulation of them. (Such as the Marvell system controller 
chip in Pegasos or the SoC the Efika uses. Besides, does AmigaOS run on 
Efika?) If there are some previous work we can build on then it's easier. 
QEMU already had ppc440 emulation including a similar board and Francois 
has started sam460ex emulation so it was easier to finish this than making 
a new one. (Also firmware and graphics emulation may be more difficult for 
those other boards.)

At the end it does not matter which machine we emulate if the goal is to 
run these OSes. If we have any of the supported boards they will run so we 
don't need more of these just one and it was the sam460 which was nearest 
to start working. (The MorphOS team or one of the developers may have some 
Pegasos 2 emulation but they don't intend to publish that and I don't know 
about previous work on Efika so the Sam460ex seems like a good choice with 
support for a lot of OSes, including porting Haiku which was why Francois 
has started emulating it so this may help that activity as well 
increasing the available OSes.)

Regards,
BALATON Zoltan
