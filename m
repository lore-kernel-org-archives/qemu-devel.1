Received: from eggs.gnu.org ([209.51.188.92]:41217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1ghGWb-0000YK-Q6
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1ghGWa-0004uW-QX
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:16:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1ghGWa-0004sM-G6
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:16:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9979A368DD
	for <qemu-devel@nongnu.org>; Wed,  9 Jan 2019 16:07:48 +0000 (UTC)
References: <20190109102311.7635-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <6e3df370-15c7-3e58-6fba-b795131b8779@redhat.com>
Date: Wed, 9 Jan 2019 17:07:31 +0100
MIME-Version: 1.0
In-Reply-To: <20190109102311.7635-1-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bhoj5LY3XG96sbb9bxh2L6QjPCC5uYby8"
Subject: Re: [Qemu-devel] [PATCH] qdev: fix -device scsi-hd,help regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, cohuck@redhat.com, ehabkost@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bhoj5LY3XG96sbb9bxh2L6QjPCC5uYby8
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: imammedo@redhat.com, cohuck@redhat.com, ehabkost@redhat.com
Message-ID: <6e3df370-15c7-3e58-6fba-b795131b8779@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qdev: fix -device scsi-hd,help regression
References: <20190109102311.7635-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190109102311.7635-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 09. 01. 19 v 11:23 Marc-Andr=C3=A9 Lureau napsal(a):
> Since commit ea9ce8934, device_post_init() applies globals directly
> from machines and accelerator classes.
>=20
> There are cases, such as -device scsi-hd,help, where the machine is
> setup but there in no accelerator.
>=20
> Let's skip accelerator globals in this case.
>=20
> Fixes SEGV:
>  #0  0x0000555558ea04ff in object_get_class (obj=3D0x0) at /home/elmarc=
o/src/qemu/build/../qom/object.c:857
>  #1  0x000055555854c797 in object_apply_compat_props (obj=3D0x616000078=
980) at /home/elmarco/src/qemu/build/../hw/core/qdev.c:978
>  #2  0x000055555854c797 in object_apply_compat_props (obj=3D0x616000078=
980) at /home/elmarco/src/qemu/build/../hw/core/qdev.c:973
>  #3  0x000055555854c959 in device_post_init (obj=3D0x616000078980) at /=
home/elmarco/src/qemu/build/../hw/core/qdev.c:989
>  #4  0x0000555558e9e250 in object_post_init_with_type (ti=3D<optimized =
out>, obj=3D0x616000078980) at /home/elmarco/src/qemu/build/../qom/object=
=2Ec:365
>  #5  0x0000555558e9e250 in object_initialize_with_type (data=3D0x616000=
078980, size=3D616, type=3D<optimized out>) at /home/elmarco/src/qemu/bui=
ld/../qom/object.c:425
>  #6  0x0000555558e9e571 in object_new_with_type (type=3D0x613000031900)=
 at /home/elmarco/src/qemu/build/../qom/object.c:588
>  #7  0x000055555830c048 in qmp_device_list_properties (typename=3Dtypen=
ame@entry=3D0x60200000c2d0 "scsi-hd", errp=3Derrp@entry=3D0x7fffffffc540)=
 at /home/elmarco/src/qemu/qmp.c:519
>  #8  0x00005555582c4027 in qdev_device_help (opts=3D<optimized out>) at=
 /home/elmarco/src/qemu/qdev-monitor.c:283
>  #9  0x0000555559378fa2 in qemu_opts_foreach (list=3D<optimized out>, f=
unc=3Dfunc@entry=3D0x5555582cfca0 <device_help_func>, opaque=3Dopaque@ent=
ry=3D0x0, errp=3Derrp@entry=3D0x0) at /home/elmarco/src/qemu/util/qemu-op=
tion.c:1171
>=20
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1664364
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/core/qdev.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 3769a2bccb..47bddacb4f 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -975,10 +975,13 @@ void object_apply_compat_props(Object *obj)
>      if (object_dynamic_cast(qdev_get_machine(), TYPE_MACHINE)) {
>          MachineState *m =3D MACHINE(qdev_get_machine());
>          MachineClass *mc =3D MACHINE_GET_CLASS(m);
> -        AccelClass *ac =3D ACCEL_GET_CLASS(m->accelerator);
> =20
> -        if (ac->compat_props) {
> -            object_apply_global_props(obj, ac->compat_props, &error_ab=
ort);
> +        if (m->accelerator) {
> +            AccelClass *ac =3D ACCEL_GET_CLASS(m->accelerator);
> +
> +            if (ac->compat_props) {
> +                object_apply_global_props(obj, ac->compat_props, &erro=
r_abort);
> +            }
>          }
>          object_apply_global_props(obj, mc->compat_props, &error_abort)=
;
>      }
>=20

Thank you, this addresses my issue and doesn't seem to introduce new ones=
=2E

Reviewed-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>=20


--bhoj5LY3XG96sbb9bxh2L6QjPCC5uYby8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAlw2HEMACgkQJrNi5H/P
IsEvDQf/apVjYCKuBC5dSTOIUO30PkmVXy148FmAos9SoHrJphR9h0vjaAZHxewo
uOHkB/YmO24cqv/EisG42K2cPbxLhBh5KhxIZoVK9ywLZRrs7AWNBY5XnBU9CKNs
s1Q6lu698PJV7Q5MbAcLYXsE3FpoUtRTZ3i2tiqoeZflqHox59Cfqq2nKH8pjxXd
SZ3SkRSArqiqb3hWyXjND7DDDtiGZtEezdp7p0N9OQHw/m8icq0kRu5mhoUhGrzl
I88Tmw2PtnV3OteF3rbiryLOUvOIpP46WNtbiibTM431l+6jeIXP7BwoJKvtOs8j
v1XoOAzzOe88+0upZqjFt7CrvPQUjQ==
=BV4E
-----END PGP SIGNATURE-----

--bhoj5LY3XG96sbb9bxh2L6QjPCC5uYby8--
