Received: from eggs.gnu.org ([2001:4830:134:3::10]:54900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkXM6-0004Ne-AF
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkXM2-0005f0-BR
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:14:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dkXM2-0005eW-1j
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:14:02 -0400
References: <150305905460.11582.12289718300820278863.malonedeb@wampee.canonical.com>
	<150350012253.19046.4268047906681155989.malone@chaenomeles.canonical.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d299b9c5-c380-4420-06b5-80dea66b0688@redhat.com>
Date: Wed, 23 Aug 2017 10:13:59 -0500
MIME-Version: 1.0
In-Reply-To: <150350012253.19046.4268047906681155989.malone@chaenomeles.canonical.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="F4mmUCar1gxJvLgc4nOB11pgqusaO2gRn"
Subject: Re: [Qemu-devel] [Bug 1711602] Re: --copy-storage-all failing with
 qemu 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1711602 <1711602@bugs.launchpad.net>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F4mmUCar1gxJvLgc4nOB11pgqusaO2gRn
From: Eric Blake <eblake@redhat.com>
To: Bug 1711602 <1711602@bugs.launchpad.net>, qemu-devel@nongnu.org
Message-ID: <d299b9c5-c380-4420-06b5-80dea66b0688@redhat.com>
Subject: Re: [Qemu-devel] [Bug 1711602] Re: --copy-storage-all failing with
 qemu 2.10
References: <150305905460.11582.12289718300820278863.malonedeb@wampee.canonical.com>
 <150350012253.19046.4268047906681155989.malone@chaenomeles.canonical.com>
In-Reply-To: <150350012253.19046.4268047906681155989.malone@chaenomeles.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/23/2017 09:55 AM, ChristianEhrhardt wrote:
> Ok, clarified with Stefanha
> It has exactly the same title as a series of 18th August which was rela=
ted to a similar issue.
> It is about an hour old now on qemu-devel, quoting
>=20
> "This fixes the issue reported as
> https://bugs.launchpad.net/bugs/1711602
>=20
> Fam Zheng (3):
>   block-backend: Refactor inactivate check
>   block-backend: Allow more "can inactivate" cases
>   mirror: Mark target BB as "force allow inactivate"
>=20
> Stefan Hajnoczi (1):
>   block: Update open_flags after ->inactivate() callback"
>=20
>=20
> I'll prep a build with that and test as well

Here's what is brewing for my pull request, although if you can
successfully test things, I'm happy to add a Tested-by: tag before
actually sending the pull request:

git fetch  git://repo.or.cz/qemu/ericb.git nbd

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--F4mmUCar1gxJvLgc4nOB11pgqusaO2gRn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmdm7cACgkQp6FrSiUn
Q2ql0wgAlCxh32IoZ3PRqrn71WMohuvIxcJqoIrNlcM/MXeuWkAoNlm7y9oLhA+7
n5Q5+2J+3woXYdChf3YfkLcsjd9iyLSE7rnsf+O8eyaF1afbv/+zwJuzonYt7ewQ
GIlbCz03xgOTe7hKRaBqtKaTQkAq7pq6r8+p/mm2hQU08tSL/BLr+8sF2UPYFiAd
tYnobidM2z4F2DJYTzDITP+zb7pbc19yMpAOjL2ApFeUBoEn6MS019ZIGAGrT2AN
xvm+bjwQjhnWiIxnSnVaPPaU8GaQ5GSHqUwe5TOck7JHAjyrYPAiACIkinoQfO4y
Y6bCsMab5waIqJcILbJTPQYP8rnhkQ==
=mwSN
-----END PGP SIGNATURE-----

--F4mmUCar1gxJvLgc4nOB11pgqusaO2gRn--
