Received: from eggs.gnu.org ([2001:4830:134:3::10]:33397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1espjc-000543-6f
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:01:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1espjZ-0003Nd-3P
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:00:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44208 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1espjY-0003NX-Uk
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:00:53 -0500
Date: Mon, 5 Mar 2018 14:00:36 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180305140036.2f8c705a@redhat.com>
In-Reply-To: <20180305132915.4dacc461@redhat.com>
References: <20180215042900.16078-1-f4bug@amsat.org>
	<20180215042900.16078-9-f4bug@amsat.org>
	<20180305132915.4dacc461@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/30] hw/i386: use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Anthony Perard <anthony.perard@citrix.com>, "open
	list:X86" <xen-devel@lists.xenproject.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, 5 Mar 2018 13:29:15 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 15 Feb 2018 01:28:38 -0300
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
>=20
> > It ease code review, unit is explicit.
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > --- =20
> [...]
>=20
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index deb440f286..9ccc6192b5 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -2320,8 +2320,8 @@ build_tpm2(GArray *table_data, BIOSLinker *linker=
, GArray *tcpalog)
> >                   (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL,=
 NULL);
> >  }
> > =20
> > -#define HOLE_640K_START  (640 * 1024)
> > -#define HOLE_640K_END   (1024 * 1024)
> > +#define HOLE_640K_START  (640 * K_BYTE)
> > +#define HOLE_640K_END   (1024 * K_BYTE) =20
> nit:
> could be 1 * M_BYTE
>=20
> [...]
>=20
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
taking it back

While building it, I get:

In file included from qemu/hw/acpi/ich9.c:38:0:
qemu/include/hw/i386/ich9.h:25:28: error: =E2=80=98K_BYTE=E2=80=99 undeclar=
ed here (not in a function)
 #define ICH9_CC_SIZE (16 * K_BYTE) /* Chipset configuration registers */
                            ^
qemu/include/hw/i386/ich9.h:56:25: note: in expansion of macro =E2=80=98ICH=
9_CC_SIZE=E2=80=99
     uint8_t chip_config[ICH9_CC_SIZE];
                         ^
make: *** [hw/acpi/ich9.o] Error 1

=20
