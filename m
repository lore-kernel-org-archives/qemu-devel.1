Received: from eggs.gnu.org ([209.51.188.92]:47405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1q6d-00057M-OH
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:18:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1q6c-0004EO-NB
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:18:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h1q6c-0004Dd-Fk
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:18:26 -0500
Date: Thu, 7 Mar 2019 10:18:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190307101819.GI32268@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<9fb589af-a78e-6eeb-ca1c-a5049c5ac5ab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9fb589af-a78e-6eeb-ca1c-a5049c5ac5ab@redhat.com>
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Thu, Mar 07, 2019 at 07:39:46AM +0100, Thomas Huth wrote:
> On 06/03/2019 19.12, Paolo Bonzini wrote:
> > Hi all,
> > 
> > lately I have been thinking of converting the QEMU build system to
> > Meson.  Meson is a relatively new build system that can replace
> > Autotools or hand-written Makefiles such as QEMU; as a die-hard
> > Autotools fan, I must say that Meson is by far better than anything else
> > that has ever tried to replace Autotools, and actually has the potential
> > to do so.
> > 
> > Advantages of Meson that directly matter for QEMU include:[...]
> 
> I'm not objecting a new build system per se, but could you elaborate on
>  problems of the current QEMU build system that will be fixed by this
> change? Since apart from some minor glitches (with the *.mak file
> dependencies for example), the current build system seems to work quite
> well for me ... so at least I currently don't feel enough pain yet to do
> such a big step, just because there is another new cool build system
> around...

Despite my effort to document how QEMU's makefiles are structured
(docs/devel/build-system.txt) I still find them to be pretty unintelligable
and painful to deal with. The way we have recursive make with some objects
built once & others built twice is particularly painful to deal with when
making non-trivial changes to the makefiles.

The configure script I think is very compelling to replace on the general
principle that any shell script longer than one line is better off being
written in another programming language. Portable shell programming (to
/bin/sh standards as opposed to /bn/bash) is difficult & we constantly
get it wrong introducing bash-isms. Error handling in shell is a complete
disaster zone and string quoting is not much better. 

The domain specific language used by meson is more attractive avoiding
these pitfalls of shell and reducing the need for write boilerplate
code to check features, letting you just write declarative statements
to a large extent.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
