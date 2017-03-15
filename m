Received: from eggs.gnu.org ([2001:4830:134:3::10]:34302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1co8WT-00031M-DG
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:59:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1co8WL-00010g-BL
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:59:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1co8WL-0000zP-2q
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:59:17 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D49CC2570
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 12:59:14 +0000 (UTC)
References: <20170315123421.28815-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1cd7fccc-62ad-84d4-6745-aa7ad4e7c7ca@redhat.com>
Date: Wed, 15 Mar 2017 07:59:11 -0500
MIME-Version: 1.0
In-Reply-To: <20170315123421.28815-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Hl2ACaUKf5GtgggSplQsFARtBB7grdMUA"
Subject: Re: [Qemu-devel] [PATCH v2] trace: ensure $(tracetool-y) is defined
 in top level makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hl2ACaUKf5GtgggSplQsFARtBB7grdMUA
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <1cd7fccc-62ad-84d4-6745-aa7ad4e7c7ca@redhat.com>
Subject: Re: [PATCH v2] trace: ensure $(tracetool-y) is defined in top level
 makefile
References: <20170315123421.28815-1-berrange@redhat.com>
In-Reply-To: <20170315123421.28815-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/15/2017 07:34 AM, Daniel P. Berrange wrote:
> The build rules for trace files have a dependancy on $(tracetool-y).
> This variable populated in the trace/Makefile.objs file and thus its
> definition gets pulled into the top level makefile. This happens too
> late in the process though, so by the time $(tracetool-y) is defined,
> make has already evaluated $(tracetool-y) in the dependancies and
> found it to be empty. The result is that when the tracetool source
> is changed, the generated files are not rebuilt. The solution is to
> define the variable in the top level makefile too
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  Makefile            | 3 +++
>  trace/Makefile.objs | 8 --------
>  2 files changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Hl2ACaUKf5GtgggSplQsFARtBB7grdMUA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyTqfAAoJEKeha0olJ0NqdX8IAJXflLroinLBeCcOSzpuZmol
jCehMCwypRTYvd+acUQR4iUBcYW+kuFszxxO8h9DrXvWAgewRrKbWGzl0X3eGD3f
z2piRCUWgWeQRxgOwTjRTnvdrObM/ZH/ip06bjE/gUU3yyOE4PpB01sgkIkM78Xs
WrhqJR/8VLIWL6o2EVoWB2J7sDommPYNh1Lw9tiWd6ajIwgof7+UG1mkDTMwKHev
Nnp/OwIublGFMJ3lAzx+V7mS9k5dKnYxUQ6fKuCdCxqCNWzMtGj0RjXNY9oZOmVw
fL2dMvOMAyEqEBreNSV7s7/aJmLcyAhHV6Vo8A/t7hlQ0ugjt8n3aevcs5w76io=
=kfVJ
-----END PGP SIGNATURE-----

--Hl2ACaUKf5GtgggSplQsFARtBB7grdMUA--
