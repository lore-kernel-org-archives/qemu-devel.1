Received: from eggs.gnu.org ([2001:4830:134:3::10]:45706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlIdF-00063J-2e
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 13:42:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlIdA-000823-HF
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 13:42:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dlIdA-00080b-8b
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 13:42:52 -0400
References: <20170825155732.15665-1-stefanha@redhat.com>
	<4eede1a1-5ac4-41e3-e6ef-700348fc3d37@amsat.org>
	<CAFEAcA_skx8s28zo38uTwM-TcJvX1pC6oTAxjy3q_AVN3JwHBA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4f21291d-d696-9651-e317-78ec4f08cbda@redhat.com>
Date: Fri, 25 Aug 2017 12:42:44 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_skx8s28zo38uTwM-TcJvX1pC6oTAxjy3q_AVN3JwHBA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fHXBpREAtSmhQq4oXGw2weTktCFkCbmbV"
Subject: Re: [Qemu-devel] [PATCH 0/3] scripts: add argparse module for
 Python 2.6 compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Ishani Chugh <chugh.ishani@research.iiit.ac.in>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fHXBpREAtSmhQq4oXGw2weTktCFkCbmbV
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Ishani Chugh <chugh.ishani@research.iiit.ac.in>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <4f21291d-d696-9651-e317-78ec4f08cbda@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] scripts: add argparse module for Python
 2.6 compatibility
References: <20170825155732.15665-1-stefanha@redhat.com>
 <4eede1a1-5ac4-41e3-e6ef-700348fc3d37@amsat.org>
 <CAFEAcA_skx8s28zo38uTwM-TcJvX1pC6oTAxjy3q_AVN3JwHBA@mail.gmail.com>
In-Reply-To: <CAFEAcA_skx8s28zo38uTwM-TcJvX1pC6oTAxjy3q_AVN3JwHBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/25/2017 11:40 AM, Peter Maydell wrote:
> Our choices about our dependencies are generally driven by "what
> are the versions available on the oldest distros which we wish
> to support building QEMU on", which typically is whatever the
> long-term-support versions of Ubuntu, SUSE, Redhat, etc are.
>=20
> Has somebody checked what that means for our Python version
> requirements?

At least this one:

RHEL/CentOS 6: Python-2.6.6

> (It would certainly be nicer if we could get away
> with bumping the version-req rather than including a big lump
> of code with yet-another-software-license, but maybe we can't.)

Based on the above, no sooner than when Red Hat is done supporting RHEL
6 (well, upstream can always decide to bump the minimum requirements it
and make Red Hat do the downstream back-compat work in isolation, but
there's enough Red Hat contributors that it shouldn't surprise anyone
that back-compat work patches will still be posted upstream...)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fHXBpREAtSmhQq4oXGw2weTktCFkCbmbV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmgYZQACgkQp6FrSiUn
Q2oumQf9G8vdjAeh+9HTpS76sTQ9YWqX4ONBNxBZjXzXWBKG6rrYcCEL1wnVm9KY
3qg67nhwFMYVIKRpHXR3TKBtRtr9/+JqF3ZeSF7oMnYFZW/rdCM26vdAFjxAfM+i
7g4U2XyR9LwXqCx/6Eg6Cp8ucorJw1oCfFu/hBRLZM/lSMuuWD4tslRKKUJ9peQ7
YTCZHFfMpta53WcgrkZz0Qo7zLCd+UGIoxZUHWhYjiirDg5Ngvo37Uq3i+C17KYV
pycgyih+0DaefvAYjEw/hwVoFprgq0Nqxu/fD1N+iwVb+IdBZBDij65ziDCGeaPZ
6AZTNAGn4kg40dehpyzdMf1jf+MmqQ==
=XUFC
-----END PGP SIGNATURE-----

--fHXBpREAtSmhQq4oXGw2weTktCFkCbmbV--
