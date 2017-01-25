Received: from eggs.gnu.org ([2001:4830:134:3::10]:58780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cWSFd-0005ph-AV
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:24:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cWSFY-0003Qs-K6
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:24:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1cWSFY-0003Qb-BI
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:24:52 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 715EDC05AA76
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 18:24:52 +0000 (UTC)
References: <9a93d47ddba5f86d36cbdf884d86e2fa6f5542ae.1485364872.git.jcody@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <343adad0-1e18-5777-ad73-3d6fb7be8424@redhat.com>
Date: Wed, 25 Jan 2017 19:24:48 +0100
MIME-Version: 1.0
In-Reply-To: <9a93d47ddba5f86d36cbdf884d86e2fa6f5542ae.1485364872.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DNiprKkmo1XIMFxrMKgx445Xp0wTJxq4s"
Subject: Re: [Qemu-devel] [PATCH 1/1] block: check full backing filename
 when searching protocol filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DNiprKkmo1XIMFxrMKgx445Xp0wTJxq4s
From: Max Reitz <mreitz@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com
Message-ID: <343adad0-1e18-5777-ad73-3d6fb7be8424@redhat.com>
Subject: Re: [PATCH 1/1] block: check full backing filename when searching
 protocol filenames
References: <9a93d47ddba5f86d36cbdf884d86e2fa6f5542ae.1485364872.git.jcody@redhat.com>
In-Reply-To: <9a93d47ddba5f86d36cbdf884d86e2fa6f5542ae.1485364872.git.jcody@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 25.01.2017 18:22, Jeff Cody wrote:
> In bdrv_find_backing_image(), if we are searching an image for a backin=
g
> file that contains a protocol, we currently only compare unmodified
> paths.
>=20
> However, some management software will change the backing filename to b=
e
> a relative filename in a path.  QEMU is able to handle this fine,
> because internally it will use path_combine to put together the full
> protocol URI.
>=20
> However, this can lead to an inability to match an image during a QAPI
> command that needs to use bdrv_find_backing_image() to find the image,
> when it is searched by the full URI.
>=20
> When searching for a protocol filename, if the straight comparison
> fails, this patch will also compare against the full backing filename t=
o
> see if that is a match.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Thanks, applied to my block tree:

https://github.com/XanClic/qemu/commits/block


How much would you mind writing an iotest?

Max


--DNiprKkmo1XIMFxrMKgx445Xp0wTJxq4s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliI7XASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A7H4H/3ZSMiWoCfZshxQG8OyZaB0NLaFFbGx5
+mx2gB+VpVvG9i2sqwYxgXQaa+7BHEtbbAh38zFxH6alj0O7tEhTdEkIgcYLAhWt
MnzEuba9IaEgtzbEpJRLjh5lMuDHguTcpdQAtVDGwdEPToq7cQ1gtF62rww5glO8
znb+EjLktCcYy58y5Cw6KuTZpH+TW5BaQXL6CtoApLRTSWgkzlWA3QoPjz6y/oQe
gzhVDnTMP7wdOVihRLK7/qFSVyB5wyUCM9LBklI4FnKBSeKqiOYg/Ees97cYuKmM
9dLArXZgAt8H3uUGetDPfpZrPrk3GyHBt1Uh+4vcINmEVvDCxlYoV8A=
=juwx
-----END PGP SIGNATURE-----

--DNiprKkmo1XIMFxrMKgx445Xp0wTJxq4s--
