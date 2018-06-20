Received: from eggs.gnu.org ([2001:4830:134:3::10]:40213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVdrM-0001xo-2u
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVdrI-0007Se-Vr
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:13:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37704 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fVdrI-0007SX-PX
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:13:16 -0400
Date: Wed, 20 Jun 2018 15:13:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180620141310.GQ3441@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180619154435.18898-1-alex.bennee@linaro.org>
	<CAFEAcA-4=X-ag+v56_C4PoYe17DHVgawKAdw7D5v1k=rmFwL3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-4=X-ag+v56_C4PoYe17DHVgawKAdw7D5v1k=rmFwL3A@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/56] add check-tcg and associated machinery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, andrzej zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>

On Wed, Jun 20, 2018 at 11:43:57AM +0100, Peter Maydell wrote:
> On 19 June 2018 at 16:43, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> > The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5=
799fa2:
> >
> >   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-=
20180615a' into staging (2018-06-15 18:13:35 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/stsquad/qemu.git tags/pull-tcg-testing-revivial-=
190618-1
> >
> > for you to fetch changes up to 03c79cb5825f2e930a39839e8375dc0feef6d5=
7d:
> >
> >   .travis.yml: add check-tcg test (2018-06-19 16:38:54 +0100)
> >
> > ----------------------------------------------------------------
> > Add check-tcg machinary
> >
> > This restores the ability to run TCG smoke tests by using our docker
> > infrastructure to support cross building simple tests. It represents
> > the first step to making better cross-architecture testing available
> > straight from the source tree ;-)
> >
> > ----------------------------------------------------------------
>=20
> On x86-64/Linux I get:
>=20

[snip]

> ERROR: configure test passed without -Werror but failed with -Werror.
>        This is probably a bug in the configure script. The failing comm=
and
>        will be at the bottom of config.log.
>        You can run configure with --disable-werror to bypass this check=
.

[snip]

> ccache gcc -o config-temp/qemu-conf.exe config-temp/qemu-conf.c -static
> ccache -Werror gcc -o config-temp/qemu-conf.exe config-temp/qemu-conf.c=
 -static

This looks dubious - the -Werror arg is in the wrong place on the
command line, hence ccache complaining:

> ccache: invalid option -- 'W'
> Usage:
>     ccache [options]
>     ccache compiler [compiler options]
>     compiler [compiler options]          (via symbolic link)
>=20
> Options:
>     -c, --cleanup         delete old files and recalculate size counter=
s
>                           (normally not needed as this is done automati=
cally)
>     -C, --clear           clear the cache completely (except configurat=
ion)
>     -F, --max-files=3DN     set maximum number of files in cache to N (=
use 0 for
>                           no limit)
>     -M, --max-size=3DSIZE   set maximum size of cache to SIZE (use 0 fo=
r no
>                           limit); available suffixes: k, M, G, T (decim=
al) and
>                           Ki, Mi, Gi, Ti (binary); default suffix: G
>     -o, --set-config=3DK=3DV  set configuration key K to value V
>     -p, --print-config    print current configuration options
>     -s, --show-stats      show statistics summary
>     -z, --zero-stats      zero statistics counters
>=20
>     -h, --help            print this help text
>     -V, --version         print version and copyright information
>=20
> See also <http://ccache.samba.org>.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
