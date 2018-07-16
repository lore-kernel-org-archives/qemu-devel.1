Received: from eggs.gnu.org ([2001:4830:134:3::10]:41253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ffA4b-0003OZ-V5
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 16:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ffA4Y-0002m7-Ot
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 16:26:21 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:22938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1ffA4Y-0002lc-C3
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 16:26:18 -0400
Date: Mon, 16 Jul 2018 22:26:16 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180716025346.GF2599@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1807162207210.15021@zero.eik.bme.hu>
References: <alpine.BSF.2.21.1807151041060.88858@zero.eik.bme.hu>
	<20180716025346.GF2599@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] hw/display/sm501* status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Gerd Hoffmann <kraxel@redhat.com>, Sebastian Bauer <mail@sebastianbauer.info>, qemu-devel@nongnu.org

On Mon, 16 Jul 2018, David Gibson wrote:
> On Sun, Jul 15, 2018 at 11:29:56AM +0200, BALATON Zoltan wrote:
>> So before sending more patches I'd like to clear who can review and merge
>> patches for sm501 in the future and what is the maintainership of this
>> device?
>
> The unfortunate answer is that there isn't any great choice: that's
> basically what having no maintainer means.
>
> I suspect Gerd is the most qualified to review patches to this
> technically, but even then that's only by general familiarity with
> display devices.
>
> At Peter's request, I'm willing to take sm501 patches through the ppc
> tree.  Since I can't review the patches in depth, I'd be pretty much
> taking anything you send unless there's something obviously bogus.
>
> .. which would make you de facto sub-maintainer of sm501.  Given
> which, I encourage you again to become *actual* maintainer; there
> really is no-one better qualified at this point.  I realize that you
> don't want to make a big ongoing job of thise, but AFAIK that's
> exactly what the "Odd Fixes" maintainership status exists for.

There's already a section for sam460ex in MAINTAINERS where I've claimed 
some devices that I've added and used by this machine. I did not take 
sm501 because it was part of SH4 R2D but surprisingly it's not listed 
there either and the maintainer listed there remained silent so far so it 
seems that is not maintained any more.

I could list sm501 in the sam460ex section thus formally taking 
sub-maintainership but this would only go as far that I'll get cc-d on 
changes and try to review them. I still can't (and don't want to) maintain 
my own tree and send pull requests directly so I'd need someone's help 
with that who can take my patches and merge them via their tree. If it's 
OK to continue to use the PPC tree for that I'm fine with that if David 
agrees (which I think he did above).

So is it OK to add sm501 to sam460ex section so I claim responsibility for 
changes and will continue sending patches cc-ing David (and maybe Gerd to 
help spotting problems) then David could take these via the PPC tree?

Regards,
BALATON Zoltan
