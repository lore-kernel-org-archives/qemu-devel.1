Received: from eggs.gnu.org ([2001:4830:134:3::10]:55814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ehDvn-0004Cl-Nt
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:25:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ehDvj-0000rY-MC
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:25:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1ehDvj-0000rD-EZ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:25:27 -0500
Date: Thu, 1 Feb 2018 13:25:20 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180201122520.b2o75bmjaqwukuqs@kamzik.brq.redhat.com>
References: <CAKv+Gu80p5G_gWp0Dg7HJ2SAgc3WCQe+g9ear9oM44bt-KmSFA@mail.gmail.com>
	<CAMJs5B_S0fO32=uh7iavn=BN1BC3=7qZAh1YcpVJFZoRC+GgOA@mail.gmail.com>
	<CAKv+Gu-dmNOnZbfJzuJ8BauGKktO_TaDRS29PuAftccfySw6ig@mail.gmail.com>
	<CAMJs5B8CWm2bj-Be_j4p9Y_3wXr=W2K7zE8593ke-97QR20qcA@mail.gmail.com>
	<CAKv+Gu935vi1wCRAKqC-nscXa+=CKX6P=HPO-3dNA4fx0Fm-NA@mail.gmail.com>
	<CAMJs5B-S=qVWYP2eTN1qsOQctmfUR8jCXBaz2DKyaKRT7LrAyA@mail.gmail.com>
	<CAKv+Gu-7d5jbt9V8bORkrZXxNmshMNjsqg+EiwhA-CYrNLFotA@mail.gmail.com>
	<CAMJs5B8W7-yfco1qkWBY0FU4hiner05jp1jBycWwT6wCTegBfA@mail.gmail.com>
	<20180201104222.bwbrsfp2kmkwd7zp@kamzik.brq.redhat.com>
	<20180201104831.GB21802@cbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201104831.GB21802@cbox>
Subject: Re: [Qemu-devel] [PATCH V1 1/1] tests: Add migration test for
 aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Wei Huang <wei@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Feb 01, 2018 at 11:48:31AM +0100, Christoffer Dall wrote:
> On Thu, Feb 01, 2018 at 11:42:22AM +0100, Andrew Jones wrote:
> > On Thu, Feb 01, 2018 at 10:59:54AM +0100, Christoffer Dall wrote:
> > > On Thu, Feb 1, 2018 at 10:33 AM, Ard Biesheuvel
> > > > If you could use dirty page tracking to only perform the cache
> > > > invalidation when the framebuffer memory has been updated, you can at
> > > > least limit the impact to cases where the framebuffer is actually
> > > > used, rather than sitting idle with a nice wallpaper image.
> > 
> > Yes, this is the exact approach I took back when I experimented with
> > this. I must have screwed up my PoC in some way (like using the gcc
> > builtin), because it wasn't working for me...
> > 
> Does that mean you have some code you feel like reviving and use to send
> out an RFC based on? ;)
>

I don't usually delete things, but I do do some sort of copy on use
from old homedirs to new ones from time to time, letting stuff that
gets really old completely drop at some point. I might be able to
find the old work, or just hack a quick and ugly version from my
memory to share - hopefully whatever I did to cause it to fail last
time has been forgotten :-)

drew
