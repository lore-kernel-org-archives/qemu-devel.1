Received: from eggs.gnu.org ([209.51.188.92]:40597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grkx1-0002V7-CL
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:46:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grkx0-0007WP-DC
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:46:51 -0500
References: <20190206195551.28893-1-mreitz@redhat.com>
	<20190206195551.28893-2-mreitz@redhat.com>
	<87mun8jddk.fsf@dusky.pond.sub.org>
	<041a22c8-ae8d-2a25-736d-2ef4e3dc2f8b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4ccd4724-af9c-ccf1-3598-399bd3e4483b@redhat.com>
Date: Thu, 7 Feb 2019 08:46:25 -0600
MIME-Version: 1.0
In-Reply-To: <041a22c8-ae8d-2a25-736d-2ef4e3dc2f8b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SYhO708rTXaSeAlYZLv5mmBhNjGuhtUOf"
Subject: Re: [Qemu-devel] [PATCH v3 1/8] qapi: Add default-variant for flat
 unions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SYhO708rTXaSeAlYZLv5mmBhNjGuhtUOf
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <4ccd4724-af9c-ccf1-3598-399bd3e4483b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/8] qapi: Add default-variant for flat
 unions
References: <20190206195551.28893-1-mreitz@redhat.com>
 <20190206195551.28893-2-mreitz@redhat.com>
 <87mun8jddk.fsf@dusky.pond.sub.org>
 <041a22c8-ae8d-2a25-736d-2ef4e3dc2f8b@redhat.com>
In-Reply-To: <041a22c8-ae8d-2a25-736d-2ef4e3dc2f8b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/7/19 8:01 AM, Eric Blake wrote:

>> I think there is: we could provide for an *optional* default value.  I=
f
>> the schema specifies it, that's what 'absent' means.  If it doesn't, a=
ll
>> bets are off, just like they are now.
>=20
> And we already have the planned syntax, thanks to our recent work on
> adding conditionals - where we now have:
>=20
> { '*field': 'mytype' }
>=20
> we can also do long-hand:
>=20
> { { 'name': '*field', 'type': 'mytype' } }

I'd better use the actual syntax, instead of inventing non-JSON off the
top of my head:

{ '*field': { 'type': 'mytype' } }

>=20
> which also lends itself well to declaring a default:
>=20
> { { 'name': '*field', 'type': 'mytype', 'default': 'xyz' } }

{ '*field': { 'type': 'mytype', 'default': 'xyz' } }

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--SYhO708rTXaSeAlYZLv5mmBhNjGuhtUOf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxcRMEACgkQp6FrSiUn
Q2rTyQgAmiXP8d123Jdv7ttawXK/WOHOLt43SAot3/jM7hOhuv7e1gqM8DRTV09q
zquPvFak35l39sdD8QxZ64FTRytwvMVPQn2iBOypOIykNfA8vAATJFX5sUR4Krzl
Mu4Cm8hz00ZFNNS0v4CJQudEI0a6J2+nb/iI37yZH0ZzIIfMxW7iEqpxpfwbUhbK
/Dmz7g0MsXYSpIN+He2VlbhbML70DvRDch/HT1Ni+za9d/+iExJcVx6Qy+/266Ak
wJ8sBwnj+wQH7/A8QpFvXz9xE+DMrTT9aBqUJYs929caQLaQLCl1A40PoUmTM4zH
VN+JfBO3pQgZcX6Ew8JT8/JW3x4yyw==
=VXp/
-----END PGP SIGNATURE-----

--SYhO708rTXaSeAlYZLv5mmBhNjGuhtUOf--
