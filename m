Received: from eggs.gnu.org ([2001:4830:134:3::10]:51405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNd7d-000156-Ly
	for qemu-devel@nongnu.org; Tue, 29 May 2018 07:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNd7c-0000Z5-S2
	for qemu-devel@nongnu.org; Tue, 29 May 2018 07:49:01 -0400
References: <20180525163327.23097-1-kwolf@redhat.com>
	<20180525163327.23097-7-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2b57e7d1-6980-298e-3cd4-9370595f58d7@redhat.com>
Date: Tue, 29 May 2018 13:48:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180525163327.23097-7-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kykeFbAAHcKaXmE7DZ8iCW3Uv31CGkK0z"
Subject: Re: [Qemu-devel] [PATCH 06/14] qemu-iotests: Add VM.qmp_log()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kykeFbAAHcKaXmE7DZ8iCW3Uv31CGkK0z
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <2b57e7d1-6980-298e-3cd4-9370595f58d7@redhat.com>
Subject: Re: [PATCH 06/14] qemu-iotests: Add VM.qmp_log()
References: <20180525163327.23097-1-kwolf@redhat.com>
 <20180525163327.23097-7-kwolf@redhat.com>
In-Reply-To: <20180525163327.23097-7-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-25 18:33, Kevin Wolf wrote:
> This adds a helper function that logs both the QMP request and the
> received response before returning it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
=2Epy
> index 17aa7c88dc..319d898172 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -206,6 +206,10 @@ def filter_qmp_event(event):
>          event['timestamp']['microseconds'] =3D 'USECS'
>      return event
> =20
> +def filter_testfiles(msg):
> +    prefix =3D os.path.join(test_dir, "%s-" % (os.getpid()))
> +    return msg.replace(prefix, 'TEST_DIR/')

I'd prefer 'TEST_DIR/PID-' (just because).

But if you really like just 'TEST_DIR/'...  Then OK.

> +
>  def log(msg, filters=3D[]):
>      for flt in filters:
>          msg =3D flt(msg)
> @@ -389,6 +393,13 @@ class VM(qtest.QEMUQtestMachine):
>              result.append(filter_qmp_event(ev))
>          return result
> =20
> +    def qmp_log(self, cmd, **kwargs):
> +        logmsg =3D "{'execute': '%s', 'arguments': %s}" % (cmd, kwargs=
)
> +        log(filter_testfiles(logmsg))
> +        result =3D self.qmp(cmd, **kwargs)
> +        log(result)

I think we should apply the testfiles filter here, too (error messages
may contain file names, after all).

Max

> +        return result
> +
> =20
>  index_re =3D re.compile(r'([^\[]+)\[([^\]]+)\]')
> =20
>=20



--kykeFbAAHcKaXmE7DZ8iCW3Uv31CGkK0z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsNPhwACgkQ9AfbAGHV
z0AxBQf/T+I2zn+0VgMDYVUPK1nD+Ct7F2wvG1DHyRyaf9447pm+1xHnVoDpu08S
TC8Npq3OIRT+2bqPEoocC3jyev8qmwxxc8rWk3STDFC3y8DFzYBAfsd6Mf+Czz/0
4ooWnXEKiSTvlzpFJsfPD0gfSkf139lpFrRWu+bcg/DIwr+TURGbxqzD+Ji2xMh2
4QhtgYOdjiinweWLvTYIclBdV0sH27t989BZRuCl/4OETjk50U8ozpKd3spMmioM
vhty8spfTEXfostkEJEB27L3x/hcfjNLYzKqECXC9Hssq5bdJySCWv6lJszEOFlW
lbChtEHL2Bri+KqeUmuoeWWplFI6Pg==
=vofz
-----END PGP SIGNATURE-----

--kykeFbAAHcKaXmE7DZ8iCW3Uv31CGkK0z--
