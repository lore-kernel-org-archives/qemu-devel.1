Received: from eggs.gnu.org ([2001:4830:134:3::10]:47155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duKbD-0005m5-9S
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duKb9-0003ws-C5
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:38:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1duKb9-0003wE-2q
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:38:07 -0400
References: <1505328054-23805-1-git-send-email-thuth@redhat.com>
	<f09b7bd0-2055-9f1c-4bb8-ab5f2bbf6837@redhat.com>
	<d8375329-3c52-1932-df65-1fbfea488a66@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7c083b2f-70b0-0c5a-c404-755cd713f3ac@redhat.com>
Date: Tue, 19 Sep 2017 10:37:55 -0500
MIME-Version: 1.0
In-Reply-To: <d8375329-3c52-1932-df65-1fbfea488a66@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m7cAwuXvXnFV3eMM3PckUro8AvjbxuLeh"
Subject: Re: [Qemu-devel] [PATCH v2] tests: Introduce generic device
 hot-plug/hot-unplug functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Cc: Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m7cAwuXvXnFV3eMM3PckUro8AvjbxuLeh
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>
Cc: Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <7c083b2f-70b0-0c5a-c404-755cd713f3ac@redhat.com>
Subject: Re: [PATCH v2] tests: Introduce generic device hot-plug/hot-unplug
 functions
References: <1505328054-23805-1-git-send-email-thuth@redhat.com>
 <f09b7bd0-2055-9f1c-4bb8-ab5f2bbf6837@redhat.com>
 <d8375329-3c52-1932-df65-1fbfea488a66@redhat.com>
In-Reply-To: <d8375329-3c52-1932-df65-1fbfea488a66@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/19/2017 10:22 AM, Thomas Huth wrote:

>>> +    response2 =3D qmp("");
>>
>> Hmm, this new use of qmp("") means I get to rebase the efforts to remo=
ve
>> the empty qmp command usage from the testsuite efforts.
>=20
> Sorry about that :-/ I hope it's not too much of a hassle!
>=20
> Maybe we should finally also add some assert(strlen(fmt) > 0) to that
> function to avoid that the problem sneaks in again?

Yep, already proposed (and thus part of my ongoing rebase work):
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg00599.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--m7cAwuXvXnFV3eMM3PckUro8AvjbxuLeh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnBOdMACgkQp6FrSiUn
Q2p81wf+KvTjXGXzPLuyHQsP0jewtx6p+RCDgIRjV9E/3DzhkgGPLnANzw6+FS6U
lLqg7H/lDJf4qITaUYkxo0O9aov+tcIu4AYSG1KCeXwarVmu8KrZrPXhjWD1lEKR
U6CtcfKu6M9Ndp5vljg99BSACTfIJaUzeUCKddff9l1b++ZV19B1VjgEHKcPrODn
WsJ4cCMU4fV4r4OwgQiCnp87S8YuS9mAZCWiRPG4Yhi6ey0ltfX4R0oe15rW4cmm
vpWjy4jClnz0UIYA6w/Kd+rqpEvxiiVQD9gKTSqDI+KdhWHW8pN1XDwcWsVEbb1N
waAVL6D253gdSooeUNDaDE9l2DeBlg==
=eabR
-----END PGP SIGNATURE-----

--m7cAwuXvXnFV3eMM3PckUro8AvjbxuLeh--
