Received: from eggs.gnu.org ([2001:4830:134:3::10]:48552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCnTf-0008Do-Ip
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:06:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCnTe-000422-Iz
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:06:43 -0500
References: <20171109013804.14488-1-mreitz@redhat.com>
	<20171109013804.14488-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e0cb220d-e73c-91db-b604-d86d940fd223@redhat.com>
Date: Thu, 9 Nov 2017 08:06:30 -0600
MIME-Version: 1.0
In-Reply-To: <20171109013804.14488-4-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qdtbbPeKXtMbpSe2HiL7iTWSItK1e3CNl"
Subject: Re: [Qemu-devel] [PATCH 3/5] iotests: Make 055 less flaky
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qdtbbPeKXtMbpSe2HiL7iTWSItK1e3CNl
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <e0cb220d-e73c-91db-b604-d86d940fd223@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] iotests: Make 055 less flaky
References: <20171109013804.14488-1-mreitz@redhat.com>
 <20171109013804.14488-4-mreitz@redhat.com>
In-Reply-To: <20171109013804.14488-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/08/2017 07:38 PM, Max Reitz wrote:
> First of all, test 055 does a valiant job of invoking pause_drive()
> sometimes, but that is worth nothing without blkdebug.  So the first
> thing to do is to sprinkle a couple of "blkdebug::" in there -- with th=
e
> exception of the transaction tests, because the blkdebug break points
> make the transaction QMP command hang (which is bad).  In that case, we=

> can get away with throttling the block job that it effectively is
> paused.
>=20
> Then, 055 usually does not pause the drive before starting a block job
> that should be cancelled.  This means that the backup job might be
> completed already before block-job-cancel is invoked; thus making the
> test either fail (currently) or moot if cancel_and_wait() ignored this
> condition.  Fix this by pausing the drive before starting the job.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/055 | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qdtbbPeKXtMbpSe2HiL7iTWSItK1e3CNl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloEYOYACgkQp6FrSiUn
Q2qZXAf/TxW2Sm8tykImzFeY0x6Y94w5Mcaog6MZ/sqSrSAn49hvYr3GzkarqnPZ
7vOxtkmnHnSf5Wk+7qgBkqxjc6WycKfF0wnkaNsfPQTnC246h517kH7MhceB7QpT
NTru6M/tjof3iysn4INT7D1TdG70BHZDZIE9eQI3wwul8qxoSqlhumlfKsjrAzul
NiZCekgTSJwPcpxLe1dfCGiTMwPy05u9lI3UwS1EC96dbEterHwC2S7cCfome2/6
LUJKbGnRxfMKmKs1faK+ANikZH8vqxxCmQjHCTqRuIh7b2rGZ2UmU0Hb1Q6XW/Hu
mwGnn8cTu1pRBuiavFxV27eVGcfs7A==
=KZgs
-----END PGP SIGNATURE-----

--qdtbbPeKXtMbpSe2HiL7iTWSItK1e3CNl--
