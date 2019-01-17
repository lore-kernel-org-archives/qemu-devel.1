Received: from eggs.gnu.org ([209.51.188.92]:47051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gk8Qa-0007Zi-Pm
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:13:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gk8Qa-0000Mz-1V
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:13:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60061)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gk8QZ-0000Hj-O6
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:13:51 -0500
References: <20190115145256.9593-1-berrange@redhat.com>
	<20190115145256.9593-2-berrange@redhat.com>
	<a53244ea-4ff3-c5d6-73b2-9f839b6b0195@redhat.com>
	<20190116092741.GB20275@redhat.com> <8736pr63mp.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <208a298b-bade-a3af-adf9-4b04f406126c@redhat.com>
Date: Thu, 17 Jan 2019 08:13:48 -0600
MIME-Version: 1.0
In-Reply-To: <8736pr63mp.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XrW2J6xfqslbWSvkrcvYGJ0aK5DK7AfbY"
Subject: Re: [Qemu-devel] [PATCH 01/12] chardev: fix validation of options
 for QMP created chardevs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Yongji Xie <elohimes@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XrW2J6xfqslbWSvkrcvYGJ0aK5DK7AfbY
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Yongji Xie <elohimes@gmail.com>
Message-ID: <208a298b-bade-a3af-adf9-4b04f406126c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/12] chardev: fix validation of options for
 QMP created chardevs
References: <20190115145256.9593-1-berrange@redhat.com>
 <20190115145256.9593-2-berrange@redhat.com>
 <a53244ea-4ff3-c5d6-73b2-9f839b6b0195@redhat.com>
 <20190116092741.GB20275@redhat.com> <8736pr63mp.fsf@dusky.pond.sub.org>
In-Reply-To: <8736pr63mp.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/17/19 3:21 AM, Markus Armbruster wrote:
> Eric, there's a QAPI code generation idea at the end.
>=20

>> If that is not there, then the compiler forces the
>> listing of SOCKET_ADDRESS_TYPE__MAX instead due
>> to -Wswitch
>=20
> I wonder whether generating something like
>=20
>     typedef enum SocketAddressType {
>         SOCKET_ADDRESS_TYPE_INET,
>         SOCKET_ADDRESS_TYPE_UNIX,
>         SOCKET_ADDRESS_TYPE_VSOCK,
>         SOCKET_ADDRESS_TYPE_FD,
>     } SocketAddressType;
>=20
>     #define SOCKET_ADDRESS_TYPE__MAX (SOCKET_ADDRESS_TYPE_FD + 1)
>=20
> would be better.

Or even an anon enum instead of a define:

typedef enum SocketAddressType {
    SOCKET_ADDRESS_TYPE_INET,
    SOCKET_ADDRESS_TYPE_UNIX,
    SOCKET_ADDRESS_TYPE_VSOCK,
    SOCKET_ADDRESS_TYPE_FD,
} SocketAddressType;
enum {
    SOCKET_ADDRESS_TYPE__MAX =3D SOCKET_ADDRESS_TYPE_FD + 1
};

The idea is interesting; since it is generated code, the change is
fairly easy to make.  I don't know how much fall-out we'd get in the
rest of the code base - only one way to find out.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--XrW2J6xfqslbWSvkrcvYGJ0aK5DK7AfbY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxAjZ0ACgkQp6FrSiUn
Q2rDBAgAqvCHtdNmGvywD41aQXC4zuSeLLc4jifoxee9BVKNZcGh0XQklUkyNTxp
IBslUPCerbDRCoiZvTEuQ3qdf9BWC2sAFRMEkaTqwGa67SpSQM5++cpVeEQkzeeM
rHXdMMpbb47LiUwa5UgrfqWRZTFoeEcDZqbJ7t5FJbLEf1BvD0Dc9kqyaEl5b7fd
d+PU4igGRcHObwrfM3SAXOXOsuJL7nL3KFWx9VlXLr7pUUwletxzg4bixl/25ba4
7aMuVlwoJzW/ZRcb2wkdMnDgqU/4Qyd4E0b+IiM3Qfv8Bpl5AS/9DhTPsB89puXP
IWUiT82dlkyDQ0IBYfT/FKm6XnzVNw==
=o/3I
-----END PGP SIGNATURE-----

--XrW2J6xfqslbWSvkrcvYGJ0aK5DK7AfbY--
