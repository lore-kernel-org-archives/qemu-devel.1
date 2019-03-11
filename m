Received: from eggs.gnu.org ([209.51.188.92]:35788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h3IA5-0006H2-SE
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h3I1n-0004BS-EX
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:19:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h3I1n-00046D-7B
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:19:27 -0400
Date: Mon, 11 Mar 2019 10:14:00 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190311101400.GJ12393@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bevglf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r2bevglf.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Sun, Mar 10, 2019 at 05:28:44PM +0100, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
> > Hi all,
> >
> > lately I have been thinking of converting the QEMU build system to
> > Meson.  Meson is a relatively new build system that can replace
> > Autotools or hand-written Makefiles such as QEMU; as a die-hard
> > Autotools fan, I must say that Meson is by far better than anything else
> > that has ever tried to replace Autotools, and actually has the potential
> > to do so.
> >
> > Advantages of Meson that directly matter for QEMU include:
> [...]
> > - ease of distributing a full copy of Meson to support distros that ship
> > an older version (no dependencies apart from Python 3.5).  At 40000
> > lines of Python, Meson is relatively small.
> 
> Meson is licensed under the Apache 2 license.  QEMU as a whole is
> licensed under GPLv2 (and no later versions).  From
> <https://www.gnu.org/licenses/license-list.html#apache2>:
> 
>     This is a free software license, compatible with version 3 of the
>     GNU GPL.
> 
>     Please note that this license is not compatible with GPL version 2,
>     because it has some requirements that are not in that GPL version.
>     These include certain patent termination and indemnification
>     provisions.  The patent termination provision is a good thing, which
>     is why we recommend the Apache 2.0 license for substantial programs
>     over other lax permissive licenses.
> 
> Can we distribute Meson along with QEMU anyway?

Yes, it is not a problem (from a legal POV at least). A single source
tar.gz is fine to bundle code under a mixture of licenses, even if those
licenses are not compatible. What matters is what you then do with that
code & how it comes together into combined works.

Meson in this case is just part of the toolchain and none of its code
is integrated into the final QEMU binaries. As such its license does
not have impact on the licence of the QEMU binaries.

We could of course need to update our top level LICENSE file to make it
clear to users/downstream vendors that we've got new license included,
but this isn't much of a surprise as QEMU has many licenses already :-)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
