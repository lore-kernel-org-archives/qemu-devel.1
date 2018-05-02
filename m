Received: from eggs.gnu.org ([2001:4830:134:3::10]:51440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fDqTl-0007tc-BO
	for qemu-devel@nongnu.org; Wed, 02 May 2018 08:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fDqTg-0000AS-Fs
	for qemu-devel@nongnu.org; Wed, 02 May 2018 08:03:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53226 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1fDqTg-00009k-8y
	for qemu-devel@nongnu.org; Wed, 02 May 2018 08:03:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02AA04270971
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 12:03:18 +0000 (UTC)
Date: Wed, 2 May 2018 14:03:08 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20180502120308.GT38016@angien.pipo.sk>
References: <20180430185943.35714-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4TQTIWrJ7dNhoZyf"
Content-Disposition: inline
In-Reply-To: <20180430185943.35714-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Migration+TLS: Fix crash due to double
 cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, quintela@redhat.com, peterx@redhat.com


--4TQTIWrJ7dNhoZyf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 19:59:43 +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> During a TLS connect we see:
>   migration_channel_connect calls
>   migration_tls_channel_connect
>   (calls after TLS setup)
>   migration_channel_connect
>=20
> My previous error handling fix made migration_channel_connect
> call migrate_fd_connect in all cases; unfortunately the above
> means it gets called twice and crashes doing double cleanup.
>=20
> Fixes: 688a3dcba98
>=20
> Reported-by: Peter Krempa <pkrempa@redhat.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

This fixes both crashes I've observed:

1) if the TLS environment is incorrect and certificate validation fails,
I've seen crash in migrate_fd_connect in call to qemu_file_set_blocking

2) if the TLS environment was correct, I've seen a crash in cleanup
phase

Tested-by: Peter Krempa <pkrempa@redhat.com>

Unfortunately I don't feel familiar enough with the migration code to
provide a qualified review.

--4TQTIWrJ7dNhoZyf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlrpqPkACgkQHGwCByjY
1Gp+kQ/+M9aPmAhFi2fyHNGQi2Id5aNgiw6yGE1H9OuVwq9jvtobwRsLbq+L7gz+
Vd0KLSTcUxsWoOYPccl/5s/9AVP1He0pSMa4TpWkQguGKZR/iNL4uYIH8dbt8Vca
b4a/lpGSzEsOomqyr9OptEQvsj+wIDxK5PRIUlQw/4pDXCTCbjWvGbKRzQJiVgx1
SUHd0CkUw21NiSEVMCntaMIsbafOVNfoOaDxWM3z7qV+u4rY3X0ndr+KheKipvfW
CNrPTo7nlyedPJHqHSSEQrpqB0wj6Yu5wczayJgvvn8MEUUb1Hf92eqkdR9QtyoY
ucszJFwUjDbsbraKsFrRNBS2No2SMF1xyoT87ZwrUkXjWTcH3cgl55sROqwYsQW9
AQHAns3ldMfm27MVsi6aivXZXbpm+hD06htQfCYMM8uXZEP32ERYZ+mKB3fBmCbN
fifi/9ABGGw+OzVzLcYTwf+vhVSPGAGe8wIlRxS2Gz0WDg+EJD9URStJr82mBDJ2
v1dkcnV9rx7b54/g/8qxfqKB48rLhPqEMxXqm0qKOHetNpNG79AEVdtR6qhfeMU+
aq979FehD7kkAGM5E65j/QEBHvPDahH9KYRaaJvYVndQhz6MbcEXdsUcgMA49zxY
9VVuWJzRWhQvqi9Ko1FrBaePxqWpXFNYHKQrmviWNK4oV7ynQAU=
=kbDg
-----END PGP SIGNATURE-----

--4TQTIWrJ7dNhoZyf--
