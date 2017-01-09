Received: from eggs.gnu.org ([2001:4830:134:3::10]:49495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cQZOb-0006ca-At
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 07:49:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cQZOX-000059-Ef
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 07:49:53 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1483194856-14079-1-git-send-email-hpoussin@reactos.org>
Date: Mon, 09 Jan 2017 13:49:44 +0100
In-Reply-To: <1483194856-14079-1-git-send-email-hpoussin@reactos.org>
	(=?utf-8?Q?=22Herv=C3=A9?=
	Poussineau"'s message of "Sat, 31 Dec 2016 15:34:16 +0100")
Message-ID: <8737gsl7o7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vl: disable default cdrom when using
 explicitely scsi-hd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>

Herv=C3=A9 Poussineau <hpoussin@reactos.org> writes:

> 'ide-hd', 'ide-cd' and 'scsi-cd' devices already disable default cdrom.
> Make it the same for 'scsi-hd'.
>
> That way, we can add/replace the device on lun=3D2 without using -nodefau=
lts.

Yes, but it might upset existing usage that relies on the default
CD-ROM.  In my opinion, making your needs explicit is better than
relying on defaults, but that doesn't mean we can change the defaults
unthinkingly.  Definitely not qemu-trivial.

Opinions on the change?

> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> ---
>  vl.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/vl.c b/vl.c
> index d77dd86..da97fe2 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -223,6 +223,7 @@ static struct {
>      { .driver =3D "ide-hd",               .flag =3D &default_cdrom     },
>      { .driver =3D "ide-drive",            .flag =3D &default_cdrom     },
>      { .driver =3D "scsi-cd",              .flag =3D &default_cdrom     },
> +    { .driver =3D "scsi-hd",              .flag =3D &default_cdrom     },
>      { .driver =3D "virtio-serial-pci",    .flag =3D &default_virtcon   },
>      { .driver =3D "virtio-serial",        .flag =3D &default_virtcon   },
>      { .driver =3D "VGA",                  .flag =3D &default_vga       },
