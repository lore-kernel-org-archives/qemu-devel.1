Received: from eggs.gnu.org ([2001:4830:134:3::10]:44481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1e4epj-0003Ub-Rv
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 23:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1e4epi-0002Ay-OB
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 23:15:51 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-vg31x5q7f1poJfHfrwKTrHEZo2Btua6o9xREHUzd8hQ@mail.gmail.com>
References: <1508176489-9002-1-git-send-email-sundeep.lkml@gmail.com>
	<CAFEAcA-vg31x5q7f1poJfHfrwKTrHEZo2Btua6o9xREHUzd8hQ@mail.gmail.com>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Wed, 18 Oct 2017 08:45:48 +0530
Message-ID: <CALHRZupURgAaiktM-mgWHud_2C07hNLY48BUbkbXE7ZV7EXqaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu devel PATCH] msf2: Remove dead code reported
 by Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair23@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi Peter,

On Tue, Oct 17, 2017 at 8:58 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 16 October 2017 at 18:54, Subbaraya Sundeep <sundeep.lkml@gmail.com>
> wrote:
> > Fixed incorrect frame size mask, validated maximum frame
> > size in spi_write and removed dead code.
> >
> > Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> > ---
> >  hw/ssi/mss-spi.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/ssi/mss-spi.c b/hw/ssi/mss-spi.c
> > index 5a8e308..1e49cbc 100644
> > --- a/hw/ssi/mss-spi.c
> > +++ b/hw/ssi/mss-spi.c
> > @@ -76,9 +76,10 @@
> >  #define C_BIGFIFO            (1 << 29)
> >  #define C_RESET              (1 << 31)
> >
> > -#define FRAMESZ_MASK         0x1F
> > +#define FRAMESZ_MASK         0x3F
> >  #define FMCOUNT_MASK         0x00FFFF00
> >  #define FMCOUNT_SHIFT        8
> > +#define FRAMESZ_MAX          32
> >
> >  static void txfifo_reset(MSSSpiState *s)
> >  {
> > @@ -106,8 +107,6 @@ static void set_fifodepth(MSSSpiState *s)
> >          s->fifo_depth = 16;
> >      } else if (size <= 32) {
>
> Shouldn't this just be "} else {" now ?
>
> Yes. I will send v2.

Thanks,
Sundeep

>          s->fifo_depth = 8;
> > -    } else {
> > -        s->fifo_depth = 4;
> >      }
> >  }
>
> thanks
> -- PMM
>
