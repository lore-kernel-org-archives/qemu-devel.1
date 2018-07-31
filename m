Received: from eggs.gnu.org ([2001:4830:134:3::10]:46621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fkQzT-0005uJ-4Z
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fkQzQ-0000WC-17
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:30:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58624 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fkQzP-0000Uq-Ry
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:30:47 -0400
Date: Tue, 31 Jul 2018 10:30:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180731093043.GC29167@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <eb8233618cf64aa21c87e2809933f112a7aedf68.1532735306.git.alistair.francis@wdc.com>
	<9d7f6a73-a00f-ebc1-efb3-18367e3c0f32@amsat.org>
	<CAFEAcA_nr=hS4Qe=n-=HU389S5cvZArt97QJ83jLQ-x2xRKFWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_nr=hS4Qe=n-=HU389S5cvZArt97QJ83jLQ-x2xRKFWQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/1] configure: Add RISC-V host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Michael Clark <mjc@sifive.com>, Alistair Francis <alistair.francis@wdc.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>

On Mon, Jul 30, 2018 at 07:37:55PM +0100, Peter Maydell wrote:
> On 30 July 2018 at 19:20, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> > Before this patch:
> >
> > $ ./configure
> >
> > ERROR: Unsupported CPU =3D riscv64, try --enable-tcg-interpreter
> >
> > $ ./configure --enable-tcg-interpreter
> > Unsupported CPU =3D riscv64, will use TCG with TCI (experimental)
> >
> > [...]
> >
> > WARNING: SUPPORT FOR THIS HOST CPU WILL GO AWAY IN FUTURE RELEASES!
>=20
>=20
> > It is unlikely the RISC-V port goes away in the next future releases =
:)
>=20
> ...but it is not supported as a *host* CPU.
>=20
> We should fix this somewhat nonsensical error message by
> completing the deprecate-and-drop cycle for this bit of
> configure, ie by outright rejecting attempts to build on
> host CPU types we don't recognize and support, the same
> way we do with unrecognized host OS types.

Do you mean to imply that we should drop  the TCG intepreter too, or do
you consider that something that makes it a supported host CPU ?  TCG
intepretor essentially makes any host supportable, if we keep it.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
