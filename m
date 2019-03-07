Received: from eggs.gnu.org ([209.51.188.92]:33267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1rH6-0003nT-6g
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:33:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1rH5-0001CT-0e
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:33:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h1rH3-0001B9-0f
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:33:18 -0500
Date: Thu, 7 Mar 2019 11:33:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190307113309.GN32268@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<9fb589af-a78e-6eeb-ca1c-a5049c5ac5ab@redhat.com>
	<CAFEAcA_RQU+HYczN4Z=vEL8U31---GTi_HOxg8y50pzX8p+p7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_RQU+HYczN4Z=vEL8U31---GTi_HOxg8y50pzX8p+p7Q@mail.gmail.com>
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
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Thu, Mar 07, 2019 at 10:13:13AM +0000, Peter Maydell wrote:
> So I think we'd need a more compelling reason to move right now.
> (This might change in the future, eg if Meson catches on to the
> extent that everybody is using it and competitors like CMake are
> more obviously eclipsed by it, in the way that git took over
> from svn and relegated mercurial and bzr to obscurity.)

I don't think we'll see the same level of domination as you see with
git, for a number of reasons.

It is compelling enough though that I think it will ultimately win
over autotools for newly started projects with little difficulty.
Everyone I know grumbles about autoconf & m4, and libtool, so they
won't be missed. 

Switching SCM is relatively straightforward as for most projects it
doesn't affect the way the code works. At simplest you can just copy
the code into git & away you go. If you want to preseve history there
are many convertors from SVN/CVS and of course free project hosting
on github just re-inforces the benefits.

Switching build systems by comparison requires careful technical
work whose burden increases as the complexity of the project increases.
This is a much larger barrier than seen with GIT conversions. So I think
it will have a harder time getting existing projects to convert than
was seen getting projeects from switch to GIT. This is true of any
build system conversion though, not just meson. There's no real scope
for automatic conversions to help her.

Most major modern programming languages comes some kind of standard
build system. So while meson can work with non-C languages it is not
likely to make much headway there IMHO.

Even if we don't switch build systems in the near term, I think it
is worth watching the space & being open to the idea at some point.

I think our current build system does put off contributors. I'm
personally put off touching any make based build system that is
not using autoconf/automake. Project specific hand crafted make
files have their own new way to doing things you have to learn
and so for a long time I dared not try changing anything complex
in QEMU's build.

As long term contributors we've built enough enough knowledge to
QEMU to consider our build system attractive or even "simple",
which skews our view of the benefits of alternatives to people
without this tribal knowledge.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
