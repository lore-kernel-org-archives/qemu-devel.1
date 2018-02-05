Received: from eggs.gnu.org ([2001:4830:134:3::10]:35460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eieC3-0005r7-HX
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 05:40:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eieC0-0000mT-ET
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 05:40:11 -0500
Date: Mon, 5 Feb 2018 11:39:54 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180205113954.4dc30b5f@redhat.com>
In-Reply-To: <CAFEAcA-0wV+DDwFEEnB1=VvUSOsG2yQRCDFBHRF+O=gayPGLVQ@mail.gmail.com>
References: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
	<1512670493-18114-5-git-send-email-peter.maydell@linaro.org>
	<d8c2c2ca-5046-f19b-9514-d3cbef3b7c3a@amsat.org>
	<CAFEAcA9k2KKrXk+2LQd+X7-RFuDQO96bYSo8xi81zfb80+ApFg@mail.gmail.com>
	<fde1ca29-873b-5e5c-76d3-d620301c924b@amsat.org>
	<CAFEAcA-0wV+DDwFEEnB1=VvUSOsG2yQRCDFBHRF+O=gayPGLVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/6] target/arm: Add "-cpu max" support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, "patches@linaro.org" <patches@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>

On Fri, 2 Feb 2018 17:54:43 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 26 January 2018 at 15:44, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
> > On 01/26/2018 11:33 AM, Peter Maydell wrote: =20
> >> On 26 January 2018 at 14:29, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote: =20
> >>> Why not use arm_any_initfn() here? =20
> >>
> >> That function (and the 'any' cpu) are deliberately only
> >> included in the linux-user binaries, not the system-emulation binaries=
. =20
> >
> > why not use the V8 features? =20
>=20
> What v8 features?
>=20
> >> (Also arm_any_initfn() only initializes userspace-visible stuff, it
> >> doesn't provide ID register values etc for kernel-visible things.) =20
> >
> > I'd still use an unique arm_max_initfn() such
> >
> >   // initializes userspace-visible stuff
> > #ifndef CONFIG_USER_ONLY
> >   // initializes kernel-visible things
> > #endif =20
>=20
> >>> Actually what seems cleaner is to move "any" features here, and kill =
the
> >>> "any" cpu, using "max" for this purpose. =20
> >>
> >> We can't kill 'any', that would break back-compatibility
> >> of command lines. =20
> >
> > and use an alias for 'any' -> 'max' or just
I'd suggest to place easy any -> max compat hack into
arm_cpu_class_by_name()

> >
> >   { .name =3D "any", .initfn =3D arm_max_initfn }, /* backward compat *=
/ =20
>=20
> Yes, we could probably do something similar to this.
>=20
> thanks
> -- PMM
>=20
