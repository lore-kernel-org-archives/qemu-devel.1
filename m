Received: from eggs.gnu.org ([2001:4830:134:3::10]:47488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCRQw-0008QC-2j
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCRQu-0004Jh-Tn
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:34:26 -0500
References: <20171107172638.29942-1-kwolf@redhat.com>
	<9306085c-07c4-b6f7-5222-2b73ee706dac@redhat.com>
	<20171108100417.GA30890@localhost.localdomain>
	<20171108122049.GE30890@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fc63bdbd-fc7a-03a5-a187-67611869529e@redhat.com>
Date: Wed, 8 Nov 2017 08:34:17 -0600
MIME-Version: 1.0
In-Reply-To: <20171108122049.GE30890@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="13kn6pnkFk6pqxahU74qkOndPcuO3uH5G"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Deprecate
 bdrv_set_read_only() and users
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--13kn6pnkFk6pqxahU74qkOndPcuO3uH5G
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Message-ID: <fc63bdbd-fc7a-03a5-a187-67611869529e@redhat.com>
Subject: Re: [Qemu-block] [PATCH] block: Deprecate bdrv_set_read_only() and
 users
References: <20171107172638.29942-1-kwolf@redhat.com>
 <9306085c-07c4-b6f7-5222-2b73ee706dac@redhat.com>
 <20171108100417.GA30890@localhost.localdomain>
 <20171108122049.GE30890@localhost.localdomain>
In-Reply-To: <20171108122049.GE30890@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/08/2017 06:20 AM, Kevin Wolf wrote:

>> Well, they don't only need an explicitly set option, but the important=

>> point is that they don't work with the default value. But I can add
>> something to this effect.
>=20
> I'll squash this in if it looks good to you:
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index ab96e348e6..76bf50f813 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3134,8 +3134,11 @@
>  #                 This option is required on the top level of blockdev=
-add.
>  # @discard:       discard-related options (default: ignore)
>  # @cache:         cache-related options
> -# @read-only:     whether the block device should be read-only
> -#                 (default: false)
> +# @read-only:     whether the block device should be read-only (defaul=
t: false).
> +#                 Note that some block drivers support only read-only =
access,
> +#                 either generally or in certain configurations. In th=
is case,
> +#                 the default value does not work and the option must =
be
> +#                 specified explicitly.

Yes, that looks reasonable, if we aren't interested in toying with the
idea of a per-driver default instead.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--13kn6pnkFk6pqxahU74qkOndPcuO3uH5G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloDFekACgkQp6FrSiUn
Q2ohqQf+PPFg6RkjKxGON6nyaQTwduHQ31uUmPh1bYcblxSidJtZe3Qrt/g3ATH0
GYpyC9tR9V9muPu9Ryvsfyr5797sQbRqgSdmTFF0UX9mwzME0zTQd4reHzqZTUcu
Gn6rpQzqmCxBDbJ5IlIF5G3na0u1GZfauEfEUaOoUwenPSHF3SnqAWFVQp5QxaHc
3dBjVwQdP9ymrUcIkC123dZeRJsZC6Hrq6FVA39IrpUaTjPL/U+hGkWnVf1h8xvD
NRAp7ioSGcYBESaxaOuz7QX9QlH5/bmemU85vsPGKaP1+00axvpJZEZJGGdSNIxK
dz2tYOIaCLGOkPWIpmOmWZLHcqtt/w==
=Ubxo
-----END PGP SIGNATURE-----

--13kn6pnkFk6pqxahU74qkOndPcuO3uH5G--
