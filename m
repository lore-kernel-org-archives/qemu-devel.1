Received: from eggs.gnu.org ([2001:4830:134:3::10]:34045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnp3H-0006hI-Ud
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnp3G-0003hv-Tx
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:11:59 -0400
References: <20170314154315.17869-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bcb24567-c232-803d-a316-c9f285494583@redhat.com>
Date: Tue, 14 Mar 2017 11:11:54 -0500
MIME-Version: 1.0
In-Reply-To: <20170314154315.17869-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="M7gHV4n3Qq2A4LrIwHIdE2rVgn2jsfELd"
Subject: Re: [Qemu-devel] [PATCH] file-posix: Don't leak fd in
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
--M7gHV4n3Qq2A4LrIwHIdE2rVgn2jsfELd
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <bcb24567-c232-803d-a316-c9f285494583@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] file-posix: Don't leak fd in
 hdev_get_max_segments
References: <20170314154315.17869-1-famz@redhat.com>
In-Reply-To: <20170314154315.17869-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/14/2017 10:43 AM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/file-posix.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index c4c0663..e6170f4 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -703,6 +703,7 @@ static int hdev_get_max_segments(const struct stat =
*st)

hdev_get_max_segments() is not part of master yet; should this just be
treated as a fixup! to a pending patch?

>      }
> =20
>  out:
> +    close(fd);
>      g_free(sysfspath);
>      return ret;
>  #else
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--M7gHV4n3Qq2A4LrIwHIdE2rVgn2jsfELd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyBZKAAoJEKeha0olJ0NqFO8H/1CZkmmCY4k7ZMvvT140y4kn
NyNd6XBbYM9iBwB/vVEP6o5kZAE+rskhGT3LTfUv45UwkrSdOc/nqtFb9iSveW++
3uNYV84wsA9FvbLwnpoeSXtb9BgpH//tHNb8NUK4IgC9HeMltPLNdsq2HZfHHV4X
RWJUaYhv+QFsuFEcGX8x1OsHRtEijUaNd2qAvEvw3V6eWxu3F0nVFwbbg2EVOnUu
ooC+3yFd3pn1zqtSUKiadvGk5UUvIyJadJjsYNgHCkXmj/b/JnEeaOH7lhLiNZEl
S1KUuAV1hUHGfLHSuLylhInMD2RGPY5F9o4eiHaLzpsxnty5TpqrYQ7NrhHyQt8=
=JVum
-----END PGP SIGNATURE-----

--M7gHV4n3Qq2A4LrIwHIdE2rVgn2jsfELd--
