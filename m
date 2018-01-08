Received: from eggs.gnu.org ([2001:4830:134:3::10]:47093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYZnJ-0004oD-MM
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:57:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYZnI-0008PD-Rd
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:57:01 -0500
References: <20180108153311.21949-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a2036acf-3281-a5a2-f998-66c22f2f4a80@redhat.com>
Date: Mon, 8 Jan 2018 09:56:51 -0600
MIME-Version: 1.0
In-Reply-To: <20180108153311.21949-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0pQfeHiB6oNZ6IPWJKLzebZxeym1lk90u"
Subject: Re: [Qemu-devel] [PATCH] tests/.gitignore: Add test-bdrv-drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0pQfeHiB6oNZ6IPWJKLzebZxeym1lk90u
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <a2036acf-3281-a5a2-f998-66c22f2f4a80@redhat.com>
Subject: Re: [PATCH] tests/.gitignore: Add test-bdrv-drain
References: <20180108153311.21949-1-kwolf@redhat.com>
In-Reply-To: <20180108153311.21949-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/08/2018 09:33 AM, Kevin Wolf wrote:
> Commit 881cfd17 added a new test binary, include it in .gitignore.
>=20
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/.gitignore | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

[We've had conversations in the past about renaming all tests to have a
common suffix, so that we don't have to keep adding rules to .gitignore
- but that's busy-work that no one has wanted to tackle yet]

>=20
> diff --git a/tests/.gitignore b/tests/.gitignore
> index 74e55d7264..e5c744b7ed 100644
> --- a/tests/.gitignore
> +++ b/tests/.gitignore
> @@ -18,6 +18,7 @@ test-aio
>  test-aio-multithread
>  test-arm-mptimer
>  test-base64
> +test-bdrv-drain
>  test-bitops
>  test-bitcnt
>  test-blockjob
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0pQfeHiB6oNZ6IPWJKLzebZxeym1lk90u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpTlMMACgkQp6FrSiUn
Q2pBGgf/ed/f6pYCDZnZepUz7Two3L1mWbY6nyUW//8u8JBvp2MzKnDuw/67nQEg
bV1fPFJOUewE4mkXh7R1ISEXvcVLZxxDlQKkR3nXXkuSM/Wo7xfo6s8tJWqynX+n
pR7jWFi8AY4C1s95EaYSM27YkNd4aeR4E6KUT8yvKssvZXVaGET9hN6HDmwNXc6W
BlK+PftqegJd1wEi5oigYCm/LGJkMCNLfC/v8oFWriLtZlllkauGqKvxclKbX7XB
vNwKjQldAOkN5JZqeQ3o+Zqc5H0H44dxoIkUU/pwBuiCCxXgrOUmJSFmOJGyPRdF
flOMw1V0NfMnNeXKjr5RfoK9hm2q9w==
=mbRU
-----END PGP SIGNATURE-----

--0pQfeHiB6oNZ6IPWJKLzebZxeym1lk90u--
