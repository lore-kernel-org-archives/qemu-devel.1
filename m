Received: from eggs.gnu.org ([209.51.188.92]:57782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmKDA-0002wB-17
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:13:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmKD9-0002cs-7x
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:13:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmKD9-0002c1-1I
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:13:03 -0500
Date: Wed, 23 Jan 2019 16:12:57 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190123151257.3bchv7msj754jyt2@sirius.home.kraxel.org>
References: <20190123093657.GC27270@redhat.com>
	<d7c274a7-00ac-d767-69fc-238b88cfd61b@redhat.com>
	<20190123101238.GD27270@redhat.com>
	<379cce5d-71e1-b210-c0de-c0b8a478de3a@gmx.com>
	<CAFEAcA-HOjPGz2U4wXJ_ujbUmHn1V2PohiL8wPkPz8iV6TPSig@mail.gmail.com>
	<52937a07-9462-6910-610c-5b1ee5d2541a@gmx.com>
	<20190123122015.uvyqe4vsxhhgugz7@sirius.home.kraxel.org>
	<da0587e0-44a2-a0f8-3df4-628973db42fd@gmx.com>
	<20190123135903.v2jjfpsp5pqitva4@sirius.home.kraxel.org>
	<ddf0684d-37cb-1860-9b73-0b23bd5dbde6@comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddf0684d-37cb-1860-9b73-0b23bd5dbde6@comstyle.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>
Cc: Kamil Rytarowski <n54@gmx.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>

On Wed, Jan 23, 2019 at 09:54:13AM -0500, Brad Smith wrote:
> On 1/23/2019 8:59 AM, Gerd Hoffmann wrote:
> 
> >    Hi,
> > 
> > > > What is the native sound interface for openbsd btw?  oss doesn't
> > > > compile (missing sys/soundcard.h header).
> > > OpenBSD uses sndio, a similar audio daemon to pulseaudio and it's
> > > enforced for all [well integrated] audio applications.
> > Hmm.  Yet another audio daemon.  /me wonders why people keep reinventing
> > the wheel.
> 
> The wheel wouldn't be reinvented if there were viable options. There were
> none.

https://xkcd.com/927/

> > > SDL is an optional intermediate layer kept for practical/compatibility
> > > purposes, but all software shall use sndio natively.
> > Is pulseaudio supported?  The package is at least in the package
> > collection.  If so, then we can choose between pulse and sdl as middle
> > man, due to the lack of a sndio backend.  Which of the two should be
> > preferred?
> 
> Very much SDL. PulseAudio is avoided like the plague.

Ok, so be it.  Lets go with SDL only for openbsd.

cheers,
  Gerd
