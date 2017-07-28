Received: from eggs.gnu.org ([2001:4830:134:3::10]:49323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db8Gl-00077w-HS
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db8Gk-00032r-LE
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:37:43 -0400
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-10-eblake@redhat.com>
	<20170728130538.GQ12364@stefanha-x1.localdomain>
	<3c27944c-bb18-a501-39b5-139059a4aa85@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <307cae51-da45-4968-f6c9-4fa1ad4b22f8@redhat.com>
Date: Fri, 28 Jul 2017 11:37:25 -0500
MIME-Version: 1.0
In-Reply-To: <3c27944c-bb18-a501-39b5-139059a4aa85@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0BoW3XjXRWbxUdAXOh5eIfqJfpKTrTQU5"
Subject: Re: [Qemu-devel] [PATCH v3 09/12] tests/libqos/pci: Clean up string
 interpolation into QMP input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, "open list:virtio-blk" <qemu-block@nongnu.org>, armbru@redhat.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0BoW3XjXRWbxUdAXOh5eIfqJfpKTrTQU5
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, "open list:virtio-blk" <qemu-block@nongnu.org>,
 armbru@redhat.com, stefanha@redhat.com
Message-ID: <307cae51-da45-4968-f6c9-4fa1ad4b22f8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 09/12] tests/libqos/pci: Clean up string
 interpolation into QMP input
References: <20170725211523.3998-1-eblake@redhat.com>
 <20170725211523.3998-10-eblake@redhat.com>
 <20170728130538.GQ12364@stefanha-x1.localdomain>
 <3c27944c-bb18-a501-39b5-139059a4aa85@redhat.com>
In-Reply-To: <3c27944c-bb18-a501-39b5-139059a4aa85@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 11:35 AM, Eric Blake wrote:
>>> +    QObject *extra_args =3D qobject_from_jsonf("{ 'shm': '%s', 'size=
': '1M' }",
>>> +                                             tmpshm);
>>

> Passing '%s' through qobject_from_jsonf() is generally wrong (it would
> produce ''...'' instead of the intended '...').
>=20
> Looks like something to fix on the next round.
>=20

What's scary is that the testsuite didn't start failing.  That's not
good; we'll want to figure out why the bug didn't impact the test.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0BoW3XjXRWbxUdAXOh5eIfqJfpKTrTQU5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7aEUACgkQp6FrSiUn
Q2rXygf6A2kOt1oREniuka97f98TuqFU0DmU6FPwtypNXa/5Y5rEOWhrkPJ3tSSQ
nnDBfGQWjPQZCY4C7HYFek5ksG3mvcKf02EBQuxPIiUpLWc2gHmIyU+9zb8Cuiha
E61ZgulEZfi+SCGSI80aUF9w44NMVtJ8pFDrF9pmVBmwhJSshouXBGzrAMX05oV6
ian/wEbj7+1YCfTVSB8IgtrhFpUahW+8rSQF4uaUd/5Wp6nC3r53wZFHj976lASd
ov5nWpPyqUwS8FNDQu3A4yqS8yE7V9lu2a8oIt/3V2hjbKpPB9bhwjQJ8oLi0XcJ
JSBv4B9rAPegXqVWHHZfVk/2mWUYgg==
=ftok
-----END PGP SIGNATURE-----

--0BoW3XjXRWbxUdAXOh5eIfqJfpKTrTQU5--
