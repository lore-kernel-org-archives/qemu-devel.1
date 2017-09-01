Received: from eggs.gnu.org ([2001:4830:134:3::10]:33756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnmuP-0001lv-PA
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 10:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnmuL-0001nx-4C
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 10:26:57 -0400
References: <20170901105434.3288-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5fff868d-4d35-ec3f-cdd8-9b7363c4e6d3@redhat.com>
Date: Fri, 1 Sep 2017 09:26:30 -0500
MIME-Version: 1.0
In-Reply-To: <20170901105434.3288-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qSOTgUTTTJbC4A134cIx6C51liwG1Kcc8"
Subject: Re: [Qemu-devel] [PATCH 0/2] Fix / skip recent iotests with LUKS
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qSOTgUTTTJbC4A134cIx6C51liwG1Kcc8
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <famz@redhat.com>
Message-ID: <5fff868d-4d35-ec3f-cdd8-9b7363c4e6d3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] Fix / skip recent iotests with LUKS
 driver
References: <20170901105434.3288-1-berrange@redhat.com>
In-Reply-To: <20170901105434.3288-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/01/2017 05:54 AM, Daniel P. Berrange wrote:
> Two recently added iotests are currently breaking 'check -luks',
> fix the easy one and disable the hard one.
>=20
> Daniel P. Berrange (2):
>   iotests: rewrite 192 to use _launch_qemu to fix LUKS support
>   iotests: blacklist 194 with the luks driver

Since both tests involve an NBD server, I can take this series through
my NBD queue.  Or, since both involve LUKS, you can push it in your next
crypto pull request.  Any preferences?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qSOTgUTTTJbC4A134cIx6C51liwG1Kcc8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmpbhYACgkQp6FrSiUn
Q2rJ2Af/T4ySIODAC3xjuGH7fJGRDipdHlrACmTZK/OFDHt6VtwMjzkHjsYVXfyV
5UbjsEmW+tUFf0p1yJqS0uhYNemNmAGRyJLu59KCsR0VhlLypNWb3LGNhc3W/eOM
lp52niVCiZ2qF21KeYLWev03Dkfo8yZeVpp1kKIyyg28cXhKCoi24nsZJ31tzkov
DVddm4hWLA8pKM7B3ehXEgg9cY1QHRAb6lvZ5hwcF9Snk1X2NsbVJVu19omHDCsu
P69eTl+l02ngpZgVG1hR8/4ZqvEQrP07KRuoedNK3XRP7N0Txj3YT8fOp4vnPwsL
+P5y8NEfMbii4hASZIrX+Rm38oIylg==
=SsIT
-----END PGP SIGNATURE-----

--qSOTgUTTTJbC4A134cIx6C51liwG1Kcc8--
