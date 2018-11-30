Received: from eggs.gnu.org ([2001:4830:134:3::10]:37490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gSlA4-0001hD-63
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:57:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gSl9y-0000aa-Hx
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:56:58 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42685)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gSl9x-0000ZL-Ac
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:56:53 -0500
Date: Fri, 30 Nov 2018 10:56:50 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181130155650.GA7766@flamenco>
References: <20181128053834.10861-1-richard.henderson@linaro.org>
	<20181128221530.GA32160@flamenco>
	<9d890088-8dd6-517d-52a7-a6166f0cd8a6@linaro.org>
	<20181130003915.GA3323@flamenco> <20181130030009.GA14990@flamenco>
	<CABoDooOcT-Yp__TJMj4roHMeq_T20=14-kf4L1gGNemv-gRoZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABoDooOcT-Yp__TJMj4roHMeq_T20=14-kf4L1gGNemv-gRoZg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 00/12] tcg: Improve register allocation for
 calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Desnogues <laurent.desnogues@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Fri, Nov 30, 2018 at 08:15:56 +0100, Laurent Desnogues wrote:
> On Fri, Nov 30, 2018 at 4:00 AM Emilio G. Cota <cota@braap.org> wrote:
> >
> > On Thu, Nov 29, 2018 at 19:39:15 -0500, Emilio G. Cota wrote:
> > > A64 and POWER9 host numbers:
> > >
> > >   https://imgur.com/a/m6Pss99
> > >
> > > There's quite a bit of noise in the P9 measurements, but it's
> > > a shared machine so I can't do much about that.
> > >
> > > I'll update the A64 results with error bars later tonight,
> > > when I get further results.
> >
> > Here they are:
> >
> >   https://imgur.com/a/EAAapSW
> 
> What is a X-Gene A57? It's either X-Gene or A57 :-)

You're right -- this is an X-Gene (xgene 1).

The A57 reference came from here:

 https://www.cloudlab.us/hardware.php
 m400 nodes: 45 per chassis, 315 total
 Processor/Chipset: Applied Micro X-Gene system-on-chip
 Eight 64-bit ARMv8 (Atlas/A57) cores at 2.4 GHz
                           ^^^

I'm not familiar with ARMv8's commercial offerings, so I
just quoted the above--which turns out to be wrong,
since A57 is an ARM design and X-Gene is not.

Thanks,

		E.
