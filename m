Received: from eggs.gnu.org ([2001:4830:134:3::10]:37203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dah4K-0005kt-Ry
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dah4I-0003el-6T
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:35:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dah4H-0003cG-ML
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:35:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A78EAF1D6C
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 11:35:00 +0000 (UTC)
References: <20170727104720.30061-1-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9b351c01-41a5-6048-f71a-17e56c4cd70f@redhat.com>
Date: Thu, 27 Jul 2017 06:34:55 -0500
MIME-Version: 1.0
In-Reply-To: <20170727104720.30061-1-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TV0el4eRoKgf7u7Cix8dCt2rFic6A1SC6"
Subject: Re: [Qemu-devel] [PATCH] ui: drop altgr and altgr_r QKeyCodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TV0el4eRoKgf7u7Cix8dCt2rFic6A1SC6
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <9b351c01-41a5-6048-f71a-17e56c4cd70f@redhat.com>
Subject: Re: [PATCH] ui: drop altgr and altgr_r QKeyCodes
References: <20170727104720.30061-1-kraxel@redhat.com>
In-Reply-To: <20170727104720.30061-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/27/2017 05:47 AM, Gerd Hoffmann wrote:
> The right alt key (alt_r aka KEY_RIGHTALT) is used for AltGr.
> The altgr and altgr_r keys simply don't exist.  Drop them.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

> +++ b/qapi-schema.json
> @@ -4863,13 +4863,14 @@
>  # @ac_stop: since 2.10
>  # @ac_refresh: since 2.10
>  # @ac_bookmarks: since 2.10
> +# altgr, altgr_r: dropped in 2.10
>  #

Dropping members is unusual; it may break unsuspecting clients relying
on the names - but the argument is that the keys don't exist, so no one
can have been relying on the name to do anything meaningful.

Reviewed-by: Eric Blake <eblake@redhat.com>

and worth inclusion in 2.10

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TV0el4eRoKgf7u7Cix8dCt2rFic6A1SC6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll5z98ACgkQp6FrSiUn
Q2pUUQf+JJYfuLc8oui/fsLaWC9DEWgY/s6ONL7FAq8hYtAYvYVyHm+leJ1NzbpU
CkGe8i3oKbWB8whNkjunnUYDMfq2wh+S0D/pqoENtI7KrRaN1VOIBGkztFi7dCow
RQMFeEqDnCocuwkFH1MFN+aSRbPDv/nVLR0/iqj0o46+Iwq78e2LTFvfQ+PxalfG
/q6K5hM7s0HD7NdVozzR2wCH+n4hSBTPqPiMjC1B2Fzu7AGwRGAx/NnaAuAasv/a
Dlthzz6ohsL+DpBucRmVhDzRqgOxKtOcMP6NsMCYp1bsTOjIP2j28kOoiSNfTRbZ
BUkZL6ORj2brAwucVdge8nHKrFruXg==
=/NJg
-----END PGP SIGNATURE-----

--TV0el4eRoKgf7u7Cix8dCt2rFic6A1SC6--
