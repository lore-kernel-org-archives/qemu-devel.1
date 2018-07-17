Received: from eggs.gnu.org ([2001:4830:134:3::10]:51106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffMSz-0004A0-1a
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffMSv-0007Xy-Va
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:40:21 -0400
Date: Tue, 17 Jul 2018 10:40:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180717094013.GJ18603@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180716195851.0FE177456B7@zero.eik.bme.hu>
	<CAFEAcA-Lu=gZWQOROa+oEwaWP8FWSY__=jneDQZVK=mFXAcFMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-Lu=gZWQOROa+oEwaWP8FWSY__=jneDQZVK=mFXAcFMw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] Do not enable QOM debugging by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Jul 16, 2018 at 09:41:12PM +0100, Peter Maydell wrote:
> On 16 July 2018 at 20:47, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> > Commit 3556c233d 5 years ago added an option to disable QOM debugging,
> > noting that it can have high performance cost but left the default to on.
> > Change the default to off and only enable it when debugging is requested
> > to avoid the performance penalty for those compiling without debug options.
> >
> > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> 
> Looking at the code, doesn't this disable all the type checking
> on the QOM casts? That is not something I think we should drop,
> in the same way that we do not disable assert()s even in the
> non-debug build.
> 
> Is this coming up as significant in profiling? In the past we've
> done some special casing if there are particular QOM casts in
> hot paths that use significant runtime.

There might also be scope for doing optimization of the
object_dynamic_cast_assert() implementation too.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
