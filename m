Received: from eggs.gnu.org ([209.51.188.92]:48913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h2EVF-0005Sx-RV
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:21:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h2EVE-0002mu-20
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:21:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h2EVD-0002iF-RY
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:21:27 -0500
Date: Fri, 8 Mar 2019 12:21:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190308122118.GF19819@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
	<a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
	<CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
	<62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
	<CAMxuvaxeAdZKk_CQOyqCJdd_1kVZEBPCm0LRoP2u9aijOtbDxg@mail.gmail.com>
	<c0e04289-3373-3a56-b367-0d6033c52789@redhat.com>
	<81f2035b-f584-f9b7-e6af-4754707b2f17@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <81f2035b-f584-f9b7-e6af-4754707b2f17@redhat.com>
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Thu, Mar 07, 2019 at 01:24:07PM -0600, Eric Blake wrote:
> On 3/7/19 1:04 PM, Eric Blake wrote:
> 
> > I don't mind a switch to mandatory out-of-tree builds (I like the
> > convenience of in-tree for quick hacks, but VPATH is infinitely more
> > flexible when testing multiple build configurations in parallel, and
> > I've worked on other projects with mandatory VPATH builds without seeing
> > too many complaints there).
> 
> I will add: The GNU Coding Standards require both in-tree and
> out-of-tree builds to work (and you get that with Autotool'd projects).

You only get it with autotools if you are good at writing Makefile.ams :-)
libvirt frequently breaks VPATH by accident when using autotools by
missing $(srcdir) prefixes on paths.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
