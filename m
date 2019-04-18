Received: from eggs.gnu.org ([209.51.188.92]:59761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hHCGt-0000Z8-G8
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 15:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hHCGr-0007uQ-De
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 15:00:31 -0400
References: <20180713111424.23670-1-mreitz@redhat.com>
	<20180713111424.23670-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a36f26f1-61b3-799f-5cee-281257cba123@redhat.com>
Date: Thu, 18 Apr 2019 13:55:23 -0500
MIME-Version: 1.0
In-Reply-To: <20180713111424.23670-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JSxaEokpMAphqXSFNOxFcydsU20fsIL31"
Subject: Re: [Qemu-devel] [PATCH 1/3] qemu-img: Allow rebase with no input
 base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JSxaEokpMAphqXSFNOxFcydsU20fsIL31
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <a36f26f1-61b3-799f-5cee-281257cba123@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] qemu-img: Allow rebase with no input
 base
References: <20180713111424.23670-1-mreitz@redhat.com>
 <20180713111424.23670-2-mreitz@redhat.com>
In-Reply-To: <20180713111424.23670-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 7/13/18 6:14 AM, Max Reitz wrote:
> Currently, you cannot add a backing file to an image when it currently
> has none.  It is really simple to allow this, though (effectively by
> setting old_backing_size to 0), so this patch does just that.

Can't you do that with 'rebase -u'? I guess the point of this patch is
to make 'rebase' without -u also able to add a backing file?  A bit more
clarity in the commit message, such as a sample command line (and
possibly even the error it issued pre-patch) would help.

>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qemu-img.c | 61 ++++++++++++++++++++++++++++++------------------------=

>  1 file changed, 34 insertions(+), 27 deletions(-)

At any rate, the code looks fine, even if the diff is harder to read
because of added indentation.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--JSxaEokpMAphqXSFNOxFcydsU20fsIL31
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly4yBsACgkQp6FrSiUn
Q2rUmwf9Gb7c8svGiKLSFr+WF7arBQnJ2OaQmTneU1Kp3wZPpoU+ZssRgCkJz4TZ
Zvsa23cg+Dm1VMlPMGRp2/lkh/cjNTnH8rBR/CxYYLE6UfJ/ixR/m4/t6C0G/mt+
iMffyQPbPBwpFNgQoJ/pR8hfbbYKNGSWdpZRg5ARKhPPktPHXuZMq58D+/c+fMuh
zms/HfWcyrmktgnGWYbZ/CGa0yFVsIym2Q/Ti0hLNOFhP5KukoEzCzrC36CjcaJ+
NLgJo6JsH1M0b9lJf1s4LL+Db2w0nD6N84eqGqRlOANeRO5eUmX9SB5lrvQ1KOaf
rFCbVXiSbkOooBbVcabQXTW6It9OUg==
=4Kqp
-----END PGP SIGNATURE-----

--JSxaEokpMAphqXSFNOxFcydsU20fsIL31--
