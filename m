Received: from eggs.gnu.org ([209.51.188.92]:44478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hH2J4-0007Xm-24
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hH2J3-0004W2-3q
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:22:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hH2J2-0004Vj-IG
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:22:04 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
Date: Thu, 18 Apr 2019 10:21:59 +0200
In-Reply-To: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com> (Paolo
	Bonzini's message of "Wed, 6 Mar 2019 19:12:33 +0100")
Message-ID: <87v9zbpvtk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, =?utf-8?Q?M?= =?utf-8?Q?arc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>

Paolo Bonzini <pbonzini@redhat.com> writes:

> Hi all,
>
> lately I have been thinking of converting the QEMU build system to
> Meson.  Meson is a relatively new build system that can replace
> Autotools or hand-written Makefiles such as QEMU; as a die-hard
> Autotools fan, I must say that Meson is by far better than anything else
> that has ever tried to replace Autotools, and actually has the potential
> to do so.
>
> Advantages of Meson that directly matter for QEMU include:
>
> - build definitions in a very readable and user friendly DSL, which
> supports looping and conditions.
>
> - ability to introspect the build definitions so that you can find out
> what is built without building it (the DSL is not Turing complete and
> most objects in it are immutable, so it cannot be abused that much :))
>
> - support for a non-recursive build from per-subdirectory input (similar
> to Makefile.objs)

Could Meson build the $(TARGET_DIRS) non-recursively?

I'm asking because I find the make recursion there annoying.  As usual
with recursion, we have to dumb down dependencies: if anything made by
the recursion needs X, then everything does.  If making X fails, we
don't recurse.  Defeats -k.

> - ease of distributing a full copy of Meson to support distros that ship
> an older version (no dependencies apart from Python 3.5).  At 40000
> lines of Python, Meson is relatively small.

[...]
