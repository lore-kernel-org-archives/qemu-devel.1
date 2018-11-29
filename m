Received: from eggs.gnu.org ([2001:4830:134:3::10]:51265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gSOZZ-0001oe-ML
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:49:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gSOZY-0007kG-5h
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:49:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gSOZX-0007h3-TP
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:49:48 -0500
Date: Thu, 29 Nov 2018 10:49:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181129104930-mutt-send-email-mst@kernel.org>
References: <20181126182844.23109-1-minyard@acm.org>
	<d7a7cb4a-a55d-ec84-4bd8-89ef3fad7ebf@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d7a7cb4a-a55d-ec84-4bd8-89ef3fad7ebf@mvista.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] pc:piix4: Update smbus I/O space after a
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <cminyard@mvista.com>
Cc: minyard@acm.org, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

On Thu, Nov 29, 2018 at 09:45:17AM -0600, Corey Minyard wrote:
> On 11/26/18 12:28 PM, minyard@acm.org wrote:
> > From: Corey Minyard <cminyard@mvista.com>
> >=20
> > Otherwise it won't be set up correctly and won't work after
> > miigration.
>=20
> Any opinions on this?=A0 I think this would be good for 3.1. Without
> this when a migration occurs on piix4 the SMBus address space
> appears in the wrong place.=A0 I'm not sure how bad that is, but
> SMBus certainly ceases to work.
>=20
> -corey


I have this queued. Thanks!

>=20
> > Signed-off-by: Corey Minyard <cminyard@mvista.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Igor Mammedov <imammedo@redhat.com>
> > ---
> >   hw/acpi/piix4.c | 1 +
> >   1 file changed, 1 insertion(+)
> >=20
> > A rather obvious fix, in hindsight :).
> >=20
> > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > index e330f24c71..2f4dd03b83 100644
> > --- a/hw/acpi/piix4.c
> > +++ b/hw/acpi/piix4.c
> > @@ -173,6 +173,7 @@ static int vmstate_acpi_post_load(void *opaque, i=
nt version_id)
> >       PIIX4PMState *s =3D opaque;
> >       pm_io_space_update(s);
> > +    smbus_io_space_update(s);
> >       return 0;
> >   }
>=20
