Received: from eggs.gnu.org ([2001:4830:134:3::10]:38413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnPqq-0004Ev-8D
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:17:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnPqk-0006nM-Gw
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:17:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnPqk-0006m8-8S
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:17:22 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C8347C054C5D
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 13:17:21 +0000 (UTC)
References: <20170313051108.26811-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fe94dc2a-f183-6225-eb4d-5c00767a188b@redhat.com>
Date: Mon, 13 Mar 2017 08:17:17 -0500
MIME-Version: 1.0
In-Reply-To: <20170313051108.26811-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ohaJ7CAvkfSiJqIKKoPBm1eMB8HKRu4cU"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: show help for invalid global
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ohaJ7CAvkfSiJqIKKoPBm1eMB8HKRu4cU
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>
Message-ID: <fe94dc2a-f183-6225-eb4d-5c00767a188b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: show help for invalid global
 options
References: <20170313051108.26811-1-stefanha@redhat.com>
In-Reply-To: <20170313051108.26811-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 12:11 AM, Stefan Hajnoczi wrote:
> The qemu-img sub-command executes regardless of invalid global options:=

>=20
>   $ qemu-img --foo info test.img
>   qemu-img: unrecognized option '--foo'
>   image: test.img
>   ...
>=20
> The unrecognized option warning may be missed by the user.  This can
> hide incorrect command-lines in scripts and confuse users.
>=20
> This patch prints the help information and terminates instead of
> executing the sub-command.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qemu-img.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index 98b836b..ce293a4 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -4339,6 +4339,7 @@ int main(int argc, char **argv)
>      while ((c =3D getopt_long(argc, argv, "+hVT:", long_options, NULL)=
) !=3D -1) {
>          switch (c) {
>          case 'h':
> +        case '?':
>              help();
>              return 0;
>          case 'V':
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ohaJ7CAvkfSiJqIKKoPBm1eMB8HKRu4cU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYxpveAAoJEKeha0olJ0NqcUsH/igS1TBlGcbIX9fyagSkPMGM
ZHmUHvcSfb5lgAc7z7OOfBHDfUYQSmAtF8qURsJBhIxQLXQU+Oxh/kYo4m+bw6O6
Hc53OEFmbjEkR209wjDqd7j6/ZgCg+DPvwpVnvPtjJ3xFr9P9t+DtX/heYIVuaAn
yVdS34PDs7TPrRg9gt/CAoOKCPt9xEHcJyHbsqT/9duYpK2VA8s7HnDzRFJjuBZw
n7+QDFc8vWnnNsbOkdsMQb0hl7St5LqEhkqWVCawOcHbUGurKx4XGf5uuU2bTNRR
tG/XMH6sl+CkwZmctO67aqRaacc1VQv/AvssI/bQxNLYgXFW3pXLBp9HY8JNLl0=
=4/0h
-----END PGP SIGNATURE-----

--ohaJ7CAvkfSiJqIKKoPBm1eMB8HKRu4cU--
