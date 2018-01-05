Received: from eggs.gnu.org ([2001:4830:134:3::10]:44862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXFuG-0003xc-Q5
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 19:30:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXFuC-0000f9-37
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 19:30:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eXFuB-0000da-NS
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 19:30:39 -0500
References: <20180103093834.20879-1-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ce168bf2-8e61-1f62-8042-7e7df2decd8c@redhat.com>
Date: Thu, 4 Jan 2018 18:30:32 -0600
MIME-Version: 1.0
In-Reply-To: <20180103093834.20879-1-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CMUQgucCzeYFzu65r6jXjBCKymt0TPjf3"
Subject: Re: [Qemu-devel] [PULL 00/14] Migration pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com, Alexey <a.perevalov@samsung.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CMUQgucCzeYFzu65r6jXjBCKymt0TPjf3
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com,
 Alexey <a.perevalov@samsung.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <ce168bf2-8e61-1f62-8042-7e7df2decd8c@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/14] Migration pull request
References: <20180103093834.20879-1-quintela@redhat.com>
In-Reply-To: <20180103093834.20879-1-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/03/2018 03:38 AM, Juan Quintela wrote:
> Hi
>=20
> This are the changes for migration that are already reviewed.
>=20
> Please, apply.
>=20

> Alexey Perevalov (6):
>       migration: introduce postcopy-blocktime capability
>       migration: add postcopy blocktime ctx into MigrationIncomingState=

>       migration: calculate vCPU blocktime on dst side
>       migration: postcopy_blocktime documentation
>       migration: add blocktime calculation into migration-test
>       migration: add postcopy total blocktime into query-migrate

I had unanswered questions about these patches in the v12 series, where
I'm not sure if the interface is still quite right.  We're still early
enough that we could adjust the interface after the fact depending on
how the questions are answered; but we're also early enough that it may
be smarter to get the interface right before including it in a pull
request.  I'll leave it to Peter and Juan to sort out whether this means
an updated pull request is needed, or to take this as-is.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CMUQgucCzeYFzu65r6jXjBCKymt0TPjf3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpOxygACgkQp6FrSiUn
Q2pRxAgAoLgMQkSdgammuis4wcX/SnCa1b9tKGv4aVpaXxzNDEZC81lP1LR3dce4
IaNjH3go8GdNRsmSmXnufULD4hZ/ABRyJe/9WjJ58piJB1Mk8Nm8HOWN14sfnrqK
Z9TD5odjWLftTi9iuiRNAhVRYTrIIvf0oUwRX4xSEiK+BT8Vi0V719qemZ3rcSwU
Mlwibtjtf36CEVfJXlYbDw9k2kLgu9lJFGdCqwt7XGGp+2QCTjDI+/C6NFdqxZwP
J+Y3e65tsvAdpUjOoo4wifSeWB5cOJIjBMHlXfAp7atc+sycO+16k3Yva6ute9PA
7o9skY1QT7k5fkP+xHWSRHF3SyVznw==
=RgDX
-----END PGP SIGNATURE-----

--CMUQgucCzeYFzu65r6jXjBCKymt0TPjf3--
