Received: from eggs.gnu.org ([209.51.188.92]:53882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1uTD-00048Z-Oz
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:58:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1uTC-0008Ef-Ls
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:58:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:61565)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h1uTC-0008E9-DL
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:58:02 -0500
Date: Thu, 7 Mar 2019 14:57:56 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190307145756.GG32268@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190307142822.8531-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190307142822.8531-1-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/2] OpenBSD: Let QEMU 4.0 be usable
 from OpenBSD 6.0 and onwards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Brad Smith <brad@comstyle.com>

On Thu, Mar 07, 2019 at 03:28:20PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Since OpenBSD 6.0, the W^X protection is enforced by default.
> TCG is incompatible with this protection, to be able to use the
> QEMU binary, this protection has to be disabled.
> The OpenBSD ports seens to have downstream patches to be able to
> use QEMU, but these patches were never upstreamed.
> This series allow to run QEMU when built from the mainstream sources.
>=20
> I salvaged the minimum patches required to be able to run OpenBSD
> from a previous series, which aimed at running the QEMU QTest suite
> on OpenBSD. Sadly it seems there is not much interest in having this
> OS covered by tests (except by Peter Maydell).

What were the blocking issues with getting the test fixes accepted in
previous postings ?  Was it simply no one interested in reviewing it
or actual review problems ?

With our increased interest in CI & push to drop build targets which
are not actively maintained, I'd question whether OpenBSD (or any
build target in the same situation) should continue to be supported
if the test suite hasn't worked for several releases in a row & not
enough people are willing to contribute to fix it.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
