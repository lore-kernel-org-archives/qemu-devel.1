Received: from eggs.gnu.org ([2001:4830:134:3::10]:55073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dd0Bn-0005mc-LX
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 16:24:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dd0Bj-0003Qo-Ce
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 16:24:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20811)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dd0Bj-0003QD-2r
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 16:24:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F2527C0587D7
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 20:24:13 +0000 (UTC)
References: <20170802201900.11890-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f5d1ac06-5f69-e46b-9e5c-acbdcc72bc5c@redhat.com>
Date: Wed, 2 Aug 2017 15:24:09 -0500
MIME-Version: 1.0
In-Reply-To: <20170802201900.11890-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gbw60MNeKWIw1CofFSO7h9Eq8L0EN59HC"
Subject: Re: [Qemu-devel] [PATCH for-2.10?] test-qga: Kill broken and dead
 QGA_TEST_SIDE_EFFECTING code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gbw60MNeKWIw1CofFSO7h9Eq8L0EN59HC
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armbru@redhat.com
Message-ID: <f5d1ac06-5f69-e46b-9e5c-acbdcc72bc5c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10?] test-qga: Kill broken and dead
 QGA_TEST_SIDE_EFFECTING code
References: <20170802201900.11890-1-eblake@redhat.com>
In-Reply-To: <20170802201900.11890-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/02/2017 03:19 PM, Eric Blake wrote:
> Back when the test was introduced, in commit 62c39b307, the
> test was set up to run qemu-ga directly on the host performing
> the test, and defaults to limiting itself to safe commands.  At
> the time, it was envisioned that setting QGA_TEST_SIDE_EFFECTING
> in the environment could cover a few more commands, while noting
> the potential danger of those side effects running in the host.

> Rather than leave this untested time-bomb in place, rip it out.

Oh, I meant to add that I'm wondering if this should be considered 2.10
material.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gbw60MNeKWIw1CofFSO7h9Eq8L0EN59HC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmCNOkACgkQp6FrSiUn
Q2pidwgApgi45n32TyPXaqxCUkYlbuqbuWmAFIkQ0L1FVfhpG7BeJ7obMDtcFxqD
VUra7bpCu3GgrWT6xNxYmqkur3Jc/uwDfsEFK4zVEtYzbr5pYZSJeKFkrMx4KPH9
TK1Ye0csQxox+8iLa2VjEr64EMqnDcAotnz2j7cb3eiliWP6msmTvRqNbtbuMmAG
buMYd9OH8dDBKgizUKZZpR4ITnajcX+sfTjybSM9Wi02rsiqPxLGEs5aMIllAsTo
6qMgw/YOjBIAabvKypHBN0CrK6RArFF+Uzhcb9qI3AJxcmHEm5ADn0tpJ7k/COKz
7XpowQX15Mgb5GSDUA2EElZ7JcGvCw==
=mQi5
-----END PGP SIGNATURE-----

--gbw60MNeKWIw1CofFSO7h9Eq8L0EN59HC--
