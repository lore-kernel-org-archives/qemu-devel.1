Received: from eggs.gnu.org ([2001:4830:134:3::10]:36231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e08V7-0006gh-8M
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e08V3-0002vw-5v
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:55:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e08V2-0002vb-SE
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:55:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C61705AFC7
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 15:55:47 +0000 (UTC)
References: <20171005155057.7664-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4e9f79ee-9966-6332-d429-19e88399f633@redhat.com>
Date: Thu, 5 Oct 2017 10:55:36 -0500
MIME-Version: 1.0
In-Reply-To: <20171005155057.7664-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vnWBdMe55NmVB1eciKQxqSVPBprwejTvM"
Subject: Re: [Qemu-devel] [PATCH v2] char: don't skip client cleanup if
 'connected' flag is unset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vnWBdMe55NmVB1eciKQxqSVPBprwejTvM
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Message-ID: <4e9f79ee-9966-6332-d429-19e88399f633@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] char: don't skip client cleanup if
 'connected' flag is unset
References: <20171005155057.7664-1-berrange@redhat.com>
In-Reply-To: <20171005155057.7664-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/05/2017 10:50 AM, Daniel P. Berrange wrote:
> The tcp_chr_free_connection & tcp_chr_disconnect methods both
> skip all of their cleanup work unless the 's->connected' flag
> is set.  This flag is set when the incoming client connection
> is ready to use. Crucially this is *after* the TLS handshake
> has been completed. So if the TLS handshake fails and we try
> to cleanup the failed client, all the cleanup is skipped as
> 's->connected' is still false.
>=20
> The only important thing that should be skipped in this case
> is sending of the CHR_EVENT_CLOSED, because we never got as
> far as sending the corresponding CHR_EVENT_OPENED. Every other
> bit of cleanup can be robust against being called even when
> s->connected is false.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>=20
> Changed in v2:
>=20
>  - Remove conditional checks for NULL (Marc-Andr=C3=A9)
>  - Don't use camelCase variable name (Marc-Andr=C3=A9)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vnWBdMe55NmVB1eciKQxqSVPBprwejTvM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnWVfgACgkQp6FrSiUn
Q2qSNgf/bNnETs6/6KYThyfDUT+jpEgNSIfb5Pb83hgb9JIwNycF1L4u1tP4QzuP
hQeMlA4s+A3LLzg2fQgfyhdpCTWwB5Tw0Q28du7tphUXrqGIyW/H+67aq9sIROem
ACDxNB/V5Bmcvyfhi1pqc00jzSisznvQZf9CXe5ptv/oPTt50Q7LZhappJ3dFaRd
qU3Eqs3PQYZ43L9/H69iIKSa3hGQsjEQCIlX6l9hp4OPPDamd27gKvkh8hXjiJV3
tJKz7aiGn19yGCGG19Eq9CRjfGobuJJGL2fROyyjSWUxk9fge87YiCX2kjdusCyj
EeNQxP2thcgVFLlU7T8AUHRMn7M34g==
=mtKo
-----END PGP SIGNATURE-----

--vnWBdMe55NmVB1eciKQxqSVPBprwejTvM--
