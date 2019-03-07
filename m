Received: from eggs.gnu.org ([209.51.188.92]:57288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1szH-0002ge-Uc
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:23:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1szG-00064X-S5
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:23:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h1szG-000643-L0
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:23:02 -0500
Date: Thu, 7 Mar 2019 13:22:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190307132254.GB32268@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
	<a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
	<CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Thu, Mar 07, 2019 at 01:09:52PM +0000, Peter Maydell wrote:
> On Thu, 7 Mar 2019 at 12:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > In any case, this wouldn't change; as you suggest below, configure could
> > remain as a front-end (well, in-srcdir builds are not supported by
> > Meson, so "../configure && ninja" perhaps).
> 
> As an aside, it might be a nice idea to drop the in-srcdir
> build altogether for QEMU anyway -- it's not really a very
> good idea and it means our build system has to cope with two
> different ways of working to no particularly useful end.

I'd be in favour of that. A huge amount of the pain I felt when
making previous changes to QEMU's makefiles has been caused by
trying to support both in-srcdir & vpath build with the same
set of rules. Fixing one often breaks the other, so you have
to cycle back & forth doing a fix in one, then testing the
other, repeat, repeat, scream, repeat.

Personally I always do in-srcdir builds, but I'd be fine to
switch to vpath builds to reduce our maint burden in the build
system as it would be a net win overall.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
