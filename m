Received: from eggs.gnu.org ([2001:4830:134:3::10]:37429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnpC4-0005fo-Rz
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnpBz-0007wW-0J
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:21:04 -0400
References: <20170314161205.19415-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <66715588-a25e-3028-d008-8fd285edb755@redhat.com>
Date: Tue, 14 Mar 2017 11:20:51 -0500
MIME-Version: 1.0
In-Reply-To: <20170314161205.19415-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xISfubWLiNR3tLDq1jbMr5INUpc4l9bFJ"
Subject: Re: [Qemu-devel] [PATCH v2] file-posix: Don't leak fd in
 hdev_get_max_segments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xISfubWLiNR3tLDq1jbMr5INUpc4l9bFJ
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <66715588-a25e-3028-d008-8fd285edb755@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] file-posix: Don't leak fd in
 hdev_get_max_segments
References: <20170314161205.19415-1-famz@redhat.com>
In-Reply-To: <20170314161205.19415-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/14/2017 11:12 AM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/file-posix.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index c4c0663..d670be3 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -703,6 +703,9 @@ static int hdev_get_max_segments(const struct stat =
*st)
>      }
> =20
>  out:
> +    if (fd !=3D -1) {
> +        close(fd);
> +    }

Mails crossed - I see I asked about this in reply to v1 after you
already sent v2 minutes earlier.

I still think it might be nice to mention a commit id that you are
fixing (one of my reply-to-self on your v1), but either way,

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--xISfubWLiNR3tLDq1jbMr5INUpc4l9bFJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyBhkAAoJEKeha0olJ0NqzoYH/2SKah2FH9q3SJSpjVFWN8W+
b+ok/nn3KtXjR2vJQ4A4rA/yHZBytDLc5imX4UHqm/nckYYQMdT4Kd0HOTBhN/eL
FPtZATeQbqGvLdLaVopyApjwpGD/Tq3kAU6bSnP9P68ty+Jcjv708OKtIDmD1k4J
Pb3KHZJGeU6yyGffirZNwheSBhv+KhgUhx1i4l6VWggjI8nX2RacZheZbVGlkjmP
7RoakjA6/ibjX2OsKpsGsAXuBfPtz2xManTlLWuPU4pGZZ4B/9Q48q1Y+/KZlpaY
3d1TLatLf9TE90SKLQuMQV/dLYtNNSjkMkuBQh+rbzLbqA4msEuD7EpyVceNBns=
=Q5Sh
-----END PGP SIGNATURE-----

--xISfubWLiNR3tLDq1jbMr5INUpc4l9bFJ--
