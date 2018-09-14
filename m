Received: from eggs.gnu.org ([2001:4830:134:3::10]:53423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1g0jxB-0006VE-Ny
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 04:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1g0jxA-0005Mw-7l
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 04:59:53 -0400
MIME-Version: 1.0
References: <20180908090820.15591-1-mark.cave-ayland@ilande.co.uk>
	<20180908090820.15591-4-mark.cave-ayland@ilande.co.uk>
	<CACXAS8Bc=1DrjUoyYBc5u4FYiYagXHZUGmSfAJ_Np0Ns9hwjJw@mail.gmail.com>
	<f2b715db-1041-50ff-bc47-23e104796e32@ilande.co.uk>
In-Reply-To: <f2b715db-1041-50ff-bc47-23e104796e32@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Fri, 14 Sep 2018 10:59:36 +0200
Message-ID: <CACXAS8CwJWjhYZcudXY-iUgkr9_o=DhW-i_zbE3gJ0EThXHYXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] 40p: add fixed IRQ routing for LSI
 SCSI device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: "open list:PReP" <qemu-ppc@nongnu.org>, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, qemu-devel <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On Thu, Sep 13, 2018 at 5:30 PM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 13/09/18 15:21, Artyom Tarasenko wrote:
>
> > On Sat, Sep 8, 2018 at 11:11 AM Mark Cave-Ayland
> > <mark.cave-ayland@ilande.co.uk> wrote:
> >>
> >> Whilst the PReP specification describes how all PCI IRQs are routed via IRQ
> >> 15 on the interrupt controller, the real 40p machine has routing quirk in
> >> that the LSI SCSI device is routed to IRQ 13.
> >
> > Is it a routing quirk or does 40p use both 15 and 13?
> > I used both in my AIX experiments and AIX seemed to be happy about it.
> > But maybe AIX simply doesn't care as long as the residual data is correct.
> >
> > Artyom
>
> If you boot the Linux sandalfoot zImage then you can see the LSI IRQ
> change from 15 to 13 just by changing the model name in OpenBIOS to
> match that of a real 40p (compare with
> http://www.juneau-lug.org/sandalfoot.php). There's also similar code
> that you can see in NetBSD.
>
> My guess would be that AIX does the "right thing" and parses the
> residual data correctly as expected.

This does indeed make sense.

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
