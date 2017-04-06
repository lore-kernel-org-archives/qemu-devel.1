Received: from eggs.gnu.org ([2001:4830:134:3::10]:41236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw86A-0005n1-9k
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw866-0002Kd-7W
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:09:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cw865-0002KM-UN
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:09:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F4323DBED
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 14:09:13 +0000 (UTC)
References: <20170406131326.2418-1-quintela@redhat.com>
	<20170406131326.2418-5-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <76d42218-b542-4136-af87-5c0bc4d4afac@redhat.com>
Date: Thu, 6 Apr 2017 09:09:10 -0500
MIME-Version: 1.0
In-Reply-To: <20170406131326.2418-5-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fUdUWe0KnVG5ordFj5HhQhSPu1hE0vj5S"
Subject: Re: [Qemu-devel] [PATCH 4/5] migration: Disable hotplug/unplug
 during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fUdUWe0KnVG5ordFj5HhQhSPu1hE0vj5S
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com
Message-ID: <76d42218-b542-4136-af87-5c0bc4d4afac@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] migration: Disable hotplug/unplug during
 migration
References: <20170406131326.2418-1-quintela@redhat.com>
 <20170406131326.2418-5-quintela@redhat.com>
In-Reply-To: <20170406131326.2418-5-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 08:13 AM, Juan Quintela wrote:
> Until we have reviewed what can/can't be hotplug during migration,

s/hotplug/hotplugged/

> disable it.  We can enable it later for the things that we know that
> work.  For instance, memory hotplug during postcopy don't work

s/don't/doesn't/

> currently.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>=20
> --
>=20

> @@ -603,6 +604,11 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error=
 **errp)
>          return NULL;
>      }
> =20
> +    if (!migration_is_idle()) {
> +        error_setg(errp, "device_add not allowed while migrating");
> +        return NULL;
> +    }
> +
>      /* create device */
>      dev =3D DEVICE(object_new(driver));
> =20
> @@ -853,6 +859,11 @@ void qdev_unplug(DeviceState *dev, Error **errp)
>          return;
>      }
> =20
> +    if (!migration_is_idle()) {
> +        error_setg(errp, "device_add not allowed while migrating");

s/device_add/device_del/ ?

> +        return;
> +    }
> +
>      qdev_hot_removed =3D true;
> =20
>      hotplug_ctrl =3D qdev_get_hotplug_handler(dev);
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--fUdUWe0KnVG5ordFj5HhQhSPu1hE0vj5S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5kwGAAoJEKeha0olJ0NqxzIH/2k2yJw+GgoObhJvyAwcIZBN
ctTQx63vbfF3G5qWaGfYpiIemHOXX4ryAGploendhwWTy2ln8vMPNzIcKIkC5bgx
PhdW8g9vWy+kd7jPEJN+YyxaL0hv621+jyHNpsErOzPX/Wva69OlO+jZJuzptetK
EW/wLV0E9beMoc8Jv4pGr838jbNO/1RQhO/AR/8EbokvuhmynJzmT7A2506cdIlI
0Scim6WOZKkGcf28XJzxMy36XciZBsVZSxDBTKgOp4i16HbBC19aCjFvRoAE1+mZ
9f41aI3y42fbseIEjH/V0/6+I2fWLWoQsUOW7yfONaIpqC3495pqWDsbWEHCTGs=
=qi1M
-----END PGP SIGNATURE-----

--fUdUWe0KnVG5ordFj5HhQhSPu1hE0vj5S--
