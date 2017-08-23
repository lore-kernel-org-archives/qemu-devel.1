Received: from eggs.gnu.org ([2001:4830:134:3::10]:55096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkPuQ-0007Al-Np
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 03:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkPuM-0005nB-2P
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 03:17:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dkPuL-0005mp-Rt
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 03:16:57 -0400
Date: Wed, 23 Aug 2017 09:16:50 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170823091650.48e7c44e.cohuck@redhat.com>
In-Reply-To: <20170823002907.GC5379@umbus.fritz.box>
References: <20170816082650.21880-1-cohuck@redhat.com>
	<223c4e3c-097f-5a91-37fa-df4bfb427d60@redhat.com>
	<CAFEAcA_UfM_XNKdc5zfHsehoRE6Q+EszRZX3FByskir7c+0Lww@mail.gmail.com>
	<20170822010917.GO12356@umbus.fritz.box>
	<CAFEAcA8wbRjjJYtk-65NJEsu-ELVdKgtwreipabSaMtLTfS--Q@mail.gmail.com>
	<3f0dc918-0f55-e2f4-bf47-fe4abf5453bb@redhat.com>
	<CAFEAcA_ezKWweEuUB-cXTer0LLaeuiGDkSdfhApedhw4ykDT0Q@mail.gmail.com>
	<20170822112046.GC12356@umbus.fritz.box>
	<20170822134815.77020eb8.cohuck@redhat.com>
	<20170823002907.GC5379@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10] boot-serial-test: prefer tcg
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, 23 Aug 2017 10:29:07 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Aug 22, 2017 at 01:48:15PM +0200, Cornelia Huck wrote:
> > On Tue, 22 Aug 2017 21:20:46 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >   
> > > Obviously it's not a thing to fix right now, but I've really been
> > > thinking that none of the tests should use this "TCG or KVM" stuff.
> > > They should instead be run with *both* options - or at least the ones
> > > that are available on the host.  
> > 
> > Having one test as a 'smoke test' that is run for everything available
> > sounds like a good idea, and the boot-serial test may be a good
> > candidate for that.
> > 
> > I would not want to run every test with every accelerator, however, as
> > this makes 'make check' even slower than it is now. (Although it may be
> > useful to be able to trigger 'run everything' tests on some dedicated
> > test machines.)  
> 
> I'd be fine with only running the full matrix on a "make check-harder"
> or whatever, target.  But I'd like the option to be there.  Sometimes
> (like when preparing a pull request) a slower check is an acceptable
> cost for better coverage.

make check with one smoke test + make check-harder (like the name :)
sounds like a good combination.
