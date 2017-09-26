Received: from eggs.gnu.org ([2001:4830:134:3::10]:44791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwrHz-00012n-3U
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwrHy-0007Sv-CL
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:56:47 -0400
References: <20170926142133.2498-1-kwolf@redhat.com>
	<20170926142133.2498-9-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <88194ed0-b5ea-2eef-8294-6557739ae605@redhat.com>
Date: Tue, 26 Sep 2017 09:56:32 -0500
MIME-Version: 1.0
In-Reply-To: <20170926142133.2498-9-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rsCnbqJmD3uxBt4wrAeDk4lmRMiVISeCv"
Subject: Re: [Qemu-devel] [PULL 08/24] iotests: Print full path of bad
 output if mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rsCnbqJmD3uxBt4wrAeDk4lmRMiVISeCv
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Message-ID: <88194ed0-b5ea-2eef-8294-6557739ae605@redhat.com>
Subject: Re: [Qemu-devel] [PULL 08/24] iotests: Print full path of bad output
 if mismatch
References: <20170926142133.2498-1-kwolf@redhat.com>
 <20170926142133.2498-9-kwolf@redhat.com>
In-Reply-To: <20170926142133.2498-9-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/26/2017 09:21 AM, Kevin Wolf wrote:
> From: Fam Zheng <famz@redhat.com>
>=20
> So it is easier to copy paste the path.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/check | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index d504b6e455..4583a0c269 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -353,7 +353,7 @@ do
>                  else
>                      echo " - output mismatch (see $seq.out.bad)"
>                      mv $tmp.out $seq.out.bad
> -                    $diff -w "$reference" $seq.out.bad
> +                    $diff -w "$reference" $(realpath $seq.out.bad)

This missed my review comments about being unsafe if $PWD contains spaces=
:
https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04241.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rsCnbqJmD3uxBt4wrAeDk4lmRMiVISeCv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnKaqAACgkQp6FrSiUn
Q2p+owf/Ut27EnBc75tojqkXo2NEoi+WMWZ93KnkTrTaD+VzKgPBfh/dW4c9KUQy
d0An9O0XJ4byA8wcfEgzKCQK0QRzHEkbIyha1r2RMkIrmw1ojmkxj247AomMb7Hj
kdT5CMOzbIPqe+byxILNOCAfGQxDTyJ1XiBsc+8nhd4BEt+RuHHZpmi7Q2W8sNYF
WouQXS+hZt+1yyIi0AYLjN+CqMxLST4hhNuvj3LEEFZANXJrcyVbkebQFOA8Mfuh
QmAsXIjInO9Y46pezkguxReQGWh2LjPMuURvAJNltTRjD8rXub1WQtIHB2aGX2Cn
bd+U6XzCxp49aLyAUzi4C38iWRYHmw==
=bTGz
-----END PGP SIGNATURE-----

--rsCnbqJmD3uxBt4wrAeDk4lmRMiVISeCv--
