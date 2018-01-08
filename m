Received: from eggs.gnu.org ([2001:4830:134:3::10]:42517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eYaUz-0000Z0-Oh
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:42:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eYaUx-0007hF-57
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:42:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eYaUw-0007bm-Rz
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:42:07 -0500
Date: Mon, 8 Jan 2018 18:41:43 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180108183619-mutt-send-email-mst@kernel.org>
References: <1515108094-11508-1-git-send-email-mst@redhat.com>
	<CAAdtpL4WQhtLOZcRSTFvTbLGs7f4miRKTPtE-uqrP0h2qOm32A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAAdtpL4WQhtLOZcRSTFvTbLGs7f4miRKTPtE-uqrP0h2qOm32A@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] isa/piix: move to mips
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, Michael Tokarev <mjt@tls.msk.ru>, Thomas Huth <thuth@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>

On Fri, Jan 05, 2018 at 04:15:18PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi Michael,
>=20
> On Thu, Jan 4, 2018 at 8:21 PM, Michael S. Tsirkin <mst@redhat.com> wro=
te:
> > This device is only used on mips, move to the correct maintainer
> > section.
> >
> > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > Cc: Yongbok Kim <yongbok.kim@mips.com>
> > Cc: Herv=E9 Poussineau <hpoussin@reactos.org>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  MAINTAINERS | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0255113..ab30f1f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -175,6 +175,7 @@ F: include/hw/intc/mips_gic.h
> >  F: include/hw/timer/mips_gictimer.h
> >  F: tests/tcg/mips/
> >  F: disas/mips.c
> > +F: hw/isa/piix4.c
>=20
> NACK this isn't the correct section (MIPS architecture),
>=20
> The section you want to update is the "Malta board" one.
>=20
> Now the 82371 devices are broadly use with X86 machines, so I am a bit
> reluctant to this change.
>=20
> Maybe I am misunderstanding the 'X86 machines PC' entry, but I see you
> are the unique maintainer of this entry which status is "Supported:
> Someone is actually paid to look after this".
> My guess is you are paid to work on _recent_ PC machines and you are
> probably receiving too many patches.

As I said, I don't test mips. As long as isa/piix is not event built
on x86, it doesn't make sense for me to merge patches.

> I suggest we split this section in "recent PC" vs "outdated PC".
> It might be hard to draw a line, but maybe i440FX vs Q35 is a good one.
> If you agree to unburden some files you don't find relevant to the
> "recent PC" entry,
> Herv=E9 and I volunteer for the "outdated PC" one with a "Odd Fixes" st=
atus
> (has a maintainer but they don't have time to do much other than throw
> the odd patch in).

That's not a level of support i440fx needs though, it's used
in production on too many systems.

> I hope you won't take this suggestion badly, we just offer help :)
>=20
> Regards,
>=20
> Phil.

For things that are actually used with x86 guests,
I think we are good, Marcel recently joined with that.

I'd like to split out pc bits that are not used with x86 guests.

> >  Moxie
> >  M: Anthony Green <green@moxielogic.com>
> > @@ -849,7 +850,6 @@ F: hw/pci-host/q35.c
> >  F: hw/pci-host/pam.c
> >  F: include/hw/pci-host/q35.h
> >  F: include/hw/pci-host/pam.h
> > -F: hw/isa/piix4.c
> >  F: hw/isa/lpc_ich9.c
> >  F: hw/i2c/smbus_ich9.c
> >  F: hw/acpi/piix4.c
> > --
> > MST
