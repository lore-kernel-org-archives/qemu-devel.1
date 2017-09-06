Received: from eggs.gnu.org ([2001:4830:134:3::10]:59823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpcOz-0005eG-EZ
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpcOo-0007RT-KL
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:38:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpcOo-0007NB-2M
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:37:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A23E81E08
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 15:37:51 +0000 (UTC)
References: <cover.1504696921.git.mprivozn@redhat.com>
	<9fe40ce91ada6dfdade83f32940f420e8b373db2.1504696921.git.mprivozn@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6ac4f80c-3e80-297b-a4d6-2f4ae0b70d66@redhat.com>
Date: Wed, 6 Sep 2017 10:37:48 -0500
MIME-Version: 1.0
In-Reply-To: <9fe40ce91ada6dfdade83f32940f420e8b373db2.1504696921.git.mprivozn@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FWlh09l7Uc6KC1NnHsWWaNDq0chApmMOW"
Subject: Re: [Qemu-devel] [PATCH v4 2/3] watchdog.h: Drop local redefinition
 of actions enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FWlh09l7Uc6KC1NnHsWWaNDq0chApmMOW
From: Eric Blake <eblake@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com
Message-ID: <6ac4f80c-3e80-297b-a4d6-2f4ae0b70d66@redhat.com>
Subject: Re: [PATCH v4 2/3] watchdog.h: Drop local redefinition of actions
 enum
References: <cover.1504696921.git.mprivozn@redhat.com>
 <9fe40ce91ada6dfdade83f32940f420e8b373db2.1504696921.git.mprivozn@redhat.com>
In-Reply-To: <9fe40ce91ada6dfdade83f32940f420e8b373db2.1504696921.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/06/2017 06:24 AM, Michal Privoznik wrote:
> We already have enum that enumerates all the action that a

s/action/actions/

> watchdog can take when hitting its timeout: WatchdogAction.
> Use that instead of inventing our own.
>=20
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---

> @@ -77,27 +77,16 @@ int select_watchdog(const char *p)
> =20
>  int select_watchdog_action(const char *p)
>  {
> -    if (strcasecmp(p, "reset") =3D=3D 0)
> -        watchdog_action =3D WDT_RESET;

The old code was case-insensitive,

> +    action =3D qapi_enum_parse(&WatchdogAction_lookup, p, -1, NULL);

the new code is not.  Do we care?  (I don't, but we could be breaking
someone's control flow).  Should qapi_enum_parse be taught to be
case-insensitive?  Or perhaps we answer related questions first: Do we
have any QAPI enums that have values differing only in case? Do we
prevent such QAPI definitions, to give us the potential of making the
parsing insensitive?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FWlh09l7Uc6KC1NnHsWWaNDq0chApmMOW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmwFkwACgkQp6FrSiUn
Q2pDPQf/REL7E4Do78ayEXNEMmgtsImZkW/5yD1GwInokMHAvr7/GljqDCxksBb1
F8X0YSNbfl0ElCjKP5fYRYbrspMZZpKrghPD9yuE2rWGJEAMT4ONScT5THxYrXDr
HwTZgFTkDOs/vyQk+8f8YzoZRz6WGwgrdIHfT84gs9CiYKUATE3cNQQkYEcK5ynX
rhlXB9hunalMv7gJ3a7KBhehUKM4m3chw4MR+w7/Oseb87e1j49UQubU4ij9OWp9
S0t7DQMqfT/cK4dUkEzgdsJXyKjig0CDgFDpO2yLN+qRq3goaEhhy8QCRk5DTBqa
kRRlsUa73xTH5EndSIogAJ5E/6uvNA==
=72ba
-----END PGP SIGNATURE-----

--FWlh09l7Uc6KC1NnHsWWaNDq0chApmMOW--
