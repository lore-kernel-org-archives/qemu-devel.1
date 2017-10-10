Received: from eggs.gnu.org ([2001:4830:134:3::10]:42681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1xst-0004af-Tn
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1xsq-0000UU-1i
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:00:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e1xsp-0000UH-Oe
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:59:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B36F67EA9E
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:59:54 +0000 (UTC)
References: <20171010154328.8419-1-berrange@redhat.com>
	<20171010154328.8419-4-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9a66918e-ac37-051f-401d-db090d29a944@redhat.com>
Date: Tue, 10 Oct 2017 11:59:53 -0500
MIME-Version: 1.0
In-Reply-To: <20171010154328.8419-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PA8gk4DgewGGSbjbQwEwOEhANITndvHWw"
Subject: Re: [Qemu-devel] [PATCH v1 3/7] io: get rid of
 qio_channel_websock_encode helper method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PA8gk4DgewGGSbjbQwEwOEhANITndvHWw
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <9a66918e-ac37-051f-401d-db090d29a944@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/7] io: get rid of
 qio_channel_websock_encode helper method
References: <20171010154328.8419-1-berrange@redhat.com>
 <20171010154328.8419-4-berrange@redhat.com>
In-Reply-To: <20171010154328.8419-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2017 10:43 AM, Daniel P. Berrange wrote:
> The qio_channel_websock_encode method is only used in one place,
> everything else calls qio_channel_websock_encode_buffer directly.
> It can also be pushed up a level into the qio_channel_websock_writev
> method, since every other caller of qio_channel_websock_write_wire
> has already filled encoutput.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  io/channel-websock.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PA8gk4DgewGGSbjbQwEwOEhANITndvHWw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnc/IkACgkQp6FrSiUn
Q2ohnwgArokry+XwZ+sJSr/MU4EkPQQsSNOB5AvHptllqgfGfolfI5bPtqjmfJ5K
v/Bb7eUNSXRCDBe05sAATuPY3lupfi31lTxSDicpK9o7MgMtq1OEu1EI6ezuUMky
bhaVuDwIhNPdM0MZs7lrPlR4hvot1oDOcrubpJ45EdRVMVxFPTIWUUtW3dLcRwt8
aPQ9wwGGFLun8RBpYTB/yXkmPe3u9JaqDEw/1oKX+NMb77aHf2Xm9qtH0NHkeGaz
QvTgEMwdoKjhlkJOzQjTCrCPL8MC9G3bhwdnGYzipN0EJIFHdlljW5sWL0TvQu4w
qohh+f2IV79GGOQlCM18EbtoiUGPUg==
=fnfX
-----END PGP SIGNATURE-----

--PA8gk4DgewGGSbjbQwEwOEhANITndvHWw--
