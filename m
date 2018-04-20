Received: from eggs.gnu.org ([2001:4830:134:3::10]:56945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f9MPe-00055D-Io
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f9MPb-0001Fi-FY
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:08:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51070 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f9MPb-0001FI-5O
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:08:35 -0400
Date: Fri, 20 Apr 2018 11:08:28 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180420030828.GE17690@lemon.usersys.redhat.com>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-32-alex.bennee@linaro.org>
	<8ccf1143-5895-ca8b-eea5-c7d96c992455@amsat.org>
	<87vacn9jd5.fsf@linaro.org>
	<CAFEAcA8u5sfzcoqGhAagoUj6cE014hdyRgdm6=LBDfE9rV+cjw@mail.gmail.com>
	<60b519a7-f49b-95e7-b9db-3e74133cf8c0@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <60b519a7-f49b-95e7-b9db-3e74133cf8c0@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 31/43] tests/tcg: enable building for
 MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, "Emilio G. Cota" <cota@braap.org>, "Daniel P. Berrange" <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, andrzej zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, Yongbok Kim <yongbok.kim@mips.com>

On Thu, 04/19 23:57, Philippe Mathieu-Daud=E9 wrote:
> On 04/19/2018 02:58 PM, Peter Maydell wrote:
> > On 19 April 2018 at 18:49, Alex Benn=E9e <alex.bennee@linaro.org> wro=
te:
> >> Philippe Mathieu-Daud=E9 <f4bug@amsat.org> writes:
> >>> On 04/19/2018 10:58 AM, Alex Benn=E9e wrote:
> >>>> This doesn't add any additional tests but enables building the
> >>>> multiarch tests for MIPS using docker cross compilers. We don't ha=
ve a
> >>>> cross compiler for mips64 big endian though.
> >>>
> >>> Oh we have one, using CFLAGS+=3D-EB
> >>>
> >>> we don't have cross libraries although.
> >>
> >> Yeah I thought the same with the ARM compilers (-mbig-endian) but it=
's
> >> the libraries that let us down. If, as you say, newlib gets this rig=
ht I
> >> suspect we should use that to build the compilers not supported out =
of
> >> the box by Debian.
> >=20
> > I don't think we really want to get into the business of
> > building our own cross compilers if we can avoid it...it's harder
> > than it looks and we would be essentially reinventing the wheel.
>=20
> I totally agree.
>=20
> I'v been looking at existing maintained images we can use to
> cross-build, so we only have to pull (download) and image and use it,
> not wasting cpu time building it.
>=20
> However some images might be huge, full of things we don't need. But I
> prefer that rather than having to maintain cross toolchains.
>=20
> An example I like to use is the coreboot-sdk, designed to build
> i386/amd64 binaries, it fulfills our needs. But takes 2GB...
>=20
> $ docker pull coreboot/coreboot-sdk:1.47
> 1.47: Pulling from coreboot/coreboot-sdk
> 3d6aedfc3e47: Downloading [>              ]  538.2kB/1.201GB
> d23c9a72f1e5: Waiting
>=20
> Another candidate is crossbuild, ~1GB
> $ docker pull multiarch/crossbuild

Makes sense to me. It is not insanely big. It might take some time to dow=
nload
depending on the network but it's more likely a one-off thing compared to
building one from a handcraft dockerfile we make, which probably will inv=
olve
even more downloading time and disk usage.

Fam
