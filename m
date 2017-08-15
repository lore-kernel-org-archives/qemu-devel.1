Received: from eggs.gnu.org ([2001:4830:134:3::10]:37173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhgLk-0007sv-GU
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 14:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhgLj-0002gv-HY
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 14:13:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dhgLj-0002gL-8P
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 14:13:55 -0400
References: <20170815163959.6632-1-f4bug@amsat.org>
	<20170815163959.6632-2-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a2773ebe-e841-4f3f-0234-d89e48811336@redhat.com>
Date: Tue, 15 Aug 2017 13:13:50 -0500
MIME-Version: 1.0
In-Reply-To: <20170815163959.6632-2-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uB8DGAKIlwn4OFJO4JTxx4W2On6l7aQ8r"
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] libqtest: add qtest_accel() to
 avoid warnings when kvm is not available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uB8DGAKIlwn4OFJO4JTxx4W2On6l7aQ8r
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a2773ebe-e841-4f3f-0234-d89e48811336@redhat.com>
Subject: Re: [RFC PATCH 1/2] libqtest: add qtest_accel() to avoid warnings
 when kvm is not available
References: <20170815163959.6632-1-f4bug@amsat.org>
 <20170815163959.6632-2-f4bug@amsat.org>
In-Reply-To: <20170815163959.6632-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/15/2017 11:39 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> only warn once about it.
>=20
> - kernel without kvm:
>=20
>     # make check-qtest-x86_64
>       GTESTER check-qtest-x86_64
>     Could not access KVM kernel module: No such device
>     qemu-system-x86_64: failed to initialize KVM: No such device
>     qemu-system-x86_64: Back to tcg accelerator

How does this differ from what commit 2f6b38d1 was trying to do?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--uB8DGAKIlwn4OFJO4JTxx4W2On6l7aQ8r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmTOd4ACgkQp6FrSiUn
Q2pmGAf/RRsNDP/UAgki1xWbt7ItQHoa+DQzYq8n+JrJXMZV3fxo5JApIbHuv7ON
mDvqf/ftKKOu3vrBxTLLB13YjhIpMh5APZUBjnSkFH/HJwbsKw8Ju7wsjxUbbsTZ
48i4rb2jBShLXDfR2DQJq+kJtvSG0QO1mUYAHbPBfLR79nucoSXEKvyJIdRH2QID
bPnNXynBK/7UURRC9EodLj8bC9bSnq+lViNX/iU/ztGfdOyLwoOlECxz7p3qhhGO
sYHy3MbLHk6aoV/fYKxmRfjf0g6ZIUhLU47Bt08ePOxL9PyYaX42ywCsWfIDCEIl
uDJJSZrdP7/HaRNHZFYfMsFrKcd7cQ==
=gieH
-----END PGP SIGNATURE-----

--uB8DGAKIlwn4OFJO4JTxx4W2On6l7aQ8r--
