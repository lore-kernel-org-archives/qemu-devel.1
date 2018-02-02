Received: from eggs.gnu.org ([2001:4830:134:3::10]:50845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdDS-0003IN-2i
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:29:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdAr-0000V2-Le
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:25:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehdAr-0000TV-7K
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:22:45 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 535B339B30
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 15:22:44 +0000 (UTC)
References: <20180202111022.19269-1-kraxel@redhat.com>
	<20180202111022.19269-4-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4705869f-7dc1-2fd5-22e4-c0d28d24f339@redhat.com>
Date: Fri, 2 Feb 2018 09:22:35 -0600
MIME-Version: 1.0
In-Reply-To: <20180202111022.19269-4-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zsFynIhklZMe88nq1OZ4BHGSxCTfHIUdx"
Subject: Re: [Qemu-devel] [PATCH v3 03/12] vl: rename DisplayType to
 LegacyDisplayType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zsFynIhklZMe88nq1OZ4BHGSxCTfHIUdx
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <4705869f-7dc1-2fd5-22e4-c0d28d24f339@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 03/12] vl: rename DisplayType to
 LegacyDisplayType
References: <20180202111022.19269-1-kraxel@redhat.com>
 <20180202111022.19269-4-kraxel@redhat.com>
In-Reply-To: <20180202111022.19269-4-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 05:10 AM, Gerd Hoffmann wrote:
> qapi DisplayType will replace the current enum.  For the transition bot=
h
> will coexist though, so rename it so we don't have a name clash.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  vl.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--zsFynIhklZMe88nq1OZ4BHGSxCTfHIUdx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0gjsACgkQp6FrSiUn
Q2r7Xgf+PUTGvNU4UARx6o0sAyIak6jbmkhQiTFYNYafCn46/xPMiVJszCFSLvmn
AjRStS7miVj0NmUb7Rz/jyJfbkPY9E2mirOX88BwVafkjbG436DpdxoxUV+W0fJk
gxlP6v78KyvRxju0gZhkXg3SCmQCiX4qMUnpylsicdck02OpgS2vRZ3LGU2lUZ1A
b4xL+R78+uobRXBiozt41KM4hEmjx4+jT/YiAp5mJQkULMbZrE6/jfyoPt8JrfS2
ITvJCcO9ilzlKgdLJduQBpPfjfLYA2VqxiCUlpXRr8puHgTXb7Dx9N3uh2c/6KBH
/lZ9oW5VZ+KoaZ8ajoD9Lg6VYDiwlw==
=+2Ss
-----END PGP SIGNATURE-----

--zsFynIhklZMe88nq1OZ4BHGSxCTfHIUdx--
