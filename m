Received: from eggs.gnu.org ([209.51.188.92]:57734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gn8T0-0007bI-OP
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 15:52:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gn8Sz-0004TX-9R
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 15:52:46 -0500
References: <20190125174653.4604-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bb4ba98b-bbf9-fa61-b9f0-c56948a58bb9@redhat.com>
Date: Fri, 25 Jan 2019 14:52:21 -0600
MIME-Version: 1.0
In-Reply-To: <20190125174653.4604-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wDEuDf2uhsJ2fzKnJGhMMVB89o46DHUpk"
Subject: Re: [Qemu-devel] [PATCH 0/3] scsi-disk: Device Identification fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, pkrempa@redhat.com, berrange@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wDEuDf2uhsJ2fzKnJGhMMVB89o46DHUpk
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, pkrempa@redhat.com,
 berrange@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org
Message-ID: <bb4ba98b-bbf9-fa61-b9f0-c56948a58bb9@redhat.com>
Subject: Re: [PATCH 0/3] scsi-disk: Device Identification fixes
References: <20190125174653.4604-1-kwolf@redhat.com>
In-Reply-To: <20190125174653.4604-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/25/19 11:46 AM, Kevin Wolf wrote:
> The vendor specific designator in the Device Identification VPD page ha=
s
> two problems:
>=20
> 1. It defaults to the BlockBackend name (-drive id=3D...), which everyo=
ne
>    expected to be a host detail that the guest never sees
>=20
> 2. With -blockdev based setups it defaults to an empty string; if this
>    default is used with more than one disk, the guest OS will interpret=

>    this as a single multipath disk.
>=20
> We can address problem 2 immediately, and start running the deprecation=

> clock for problem 1.
>=20
> Related bug reports:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1669446
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1668248
>=20
> Kevin Wolf (3):
>   scsi-disk: Don't use empty string as device id
>   scsi-disk: Add device_id property
>   scsi-disk: Deprecate device_id fallback to BlockBackend name

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--wDEuDf2uhsJ2fzKnJGhMMVB89o46DHUpk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxLdwUACgkQp6FrSiUn
Q2rQXwf/SbpgTeyrcLnE5UzaZTGBPjWWNrxMi88FVYz/ykMIfYDMtqptKKbnNUbu
kayf+QU+FSpuYSRrLIwWPWSgGjE+thr9P0TKS4pjhp1lskZzHzGgHVfkNxQra8Et
8WKvjVZYFCHy0ZIJGtREBiw2V/oyFqNnouY8KD5ZTRja5M5lMn1RjR/bMPa2w1uo
ufT0tbNFwqs+/bfbdRrQ2lQBUnALzuouNTrWWs9zElxd/D7QLetvVXRyRye5qyTk
23X1dKbFL7TvNsy7ydMOuJOXR3jp6iqicjXyHEd7+OHwHznzX6NHhEX6SNNyOuJf
Pv0CGu7M7HH8C0vGaV0cNqwQzKbwdg==
=BdBE
-----END PGP SIGNATURE-----

--wDEuDf2uhsJ2fzKnJGhMMVB89o46DHUpk--
