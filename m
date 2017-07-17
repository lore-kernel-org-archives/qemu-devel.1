Received: from eggs.gnu.org ([2001:4830:134:3::10]:59987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX4Kt-0005TO-P9
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX4Ks-00078B-R5
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:37:11 -0400
References: <CAPuOgO2q9nNtoPOYuXSWDxBVVsXcWEMbMboLT4OdpXA_Dq5O=Q@mail.gmail.com>
	<7a891962-9c57-7668-e2fd-69e5e13b9078@redhat.com>
	<CAMr-obtga00C5cKS63T_5RW99hK2W1nKMDba4cnTGH8dVYrXaA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <07dfafaa-884c-9b86-cf37-dbdc454d2b91@redhat.com>
Date: Mon, 17 Jul 2017 06:36:56 -0500
MIME-Version: 1.0
In-Reply-To: <CAMr-obtga00C5cKS63T_5RW99hK2W1nKMDba4cnTGH8dVYrXaA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cjubSFa4aXMR4vTGvXPsx1WllFUOfupV3"
Subject: Re: [Qemu-devel] Supporting unsafe create when backing file is not
 accessible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nirsof@gmail.com>, Ala Hino <ahino@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-discuss@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>, John Snow Huston <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cjubSFa4aXMR4vTGvXPsx1WllFUOfupV3
From: Eric Blake <eblake@redhat.com>
To: Nir Soffer <nirsof@gmail.com>, Ala Hino <ahino@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-discuss@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 John Snow Huston <jsnow@redhat.com>
Message-ID: <07dfafaa-884c-9b86-cf37-dbdc454d2b91@redhat.com>
Subject: Re: [Qemu-devel] Supporting unsafe create when backing file is not
 accessible
References: <CAPuOgO2q9nNtoPOYuXSWDxBVVsXcWEMbMboLT4OdpXA_Dq5O=Q@mail.gmail.com>
 <7a891962-9c57-7668-e2fd-69e5e13b9078@redhat.com>
 <CAMr-obtga00C5cKS63T_5RW99hK2W1nKMDba4cnTGH8dVYrXaA@mail.gmail.com>
In-Reply-To: <CAMr-obtga00C5cKS63T_5RW99hK2W1nKMDba4cnTGH8dVYrXaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/14/2017 02:13 PM, Nir Soffer wrote:

> Eric, we are more concerned about using the current qemu version.
>=20
> We can use the fact that providing both size and backing format,
> qemu does not open the backing file, but this is not documented, and
> we don't want to base oVirt code on undocumented behavior.
>=20
> What we would like to have is:
> - qemu blessing for using this undocumented behaviour

But how are you going to get that? By the time someone writes a
documentation patch, it won't land until qemu 2.10, but by then, they
might as well have written the -u patch instead.

Older versions will continue to have the older behavior, unless someone
backports a patch to give them the newer behavior - but if someone is
backporting -u, presumably they will also backport whatever
introspection mechanisms you would also use against upstream qemu to
learn if -u is present.  If the introspection mechanism is not present
or gives the answer that -u is not present, then you can safely assume
the old behavior (because the new behavior is only going to be present
intentionally).  But that is STILL not something that we are going to
explicitly document, because it makes more sense to implement the
working feature than to document the workaround to a missing feature.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cjubSFa4aXMR4vTGvXPsx1WllFUOfupV3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZbKFYAAoJEKeha0olJ0Nqj3kH/1Ycbzw72wPB4YA6RT5+XoII
bcWbhpHlrS/mX5SVhna4QLE555LGUEDss3XhSe061YPa1puLiJ+GgODu4YoryCu5
Yo6ufmozfqSO4W3FzVL+wJqndB8aqVqiBmJrdyuyjundd6dTlvTDXhSE8zutNBHB
ffgSFV1YV9cytH3QD8IFYt5PFRHuUy4JAMF6nLq2R7MDSP6uQ++or0f3URPIuouU
C4H4cY9UhelG5gngQt5UrsWyOx3caTDdVD36X+5g8IDsOApCA73BVOgoNbGVkaCS
Cfp5JKGP2dmoxwekD8y1X+kZz9vLysfuG1BktYrH5JeDTW3tQvumoa10XbqtQKE=
=uVdB
-----END PGP SIGNATURE-----

--cjubSFa4aXMR4vTGvXPsx1WllFUOfupV3--
