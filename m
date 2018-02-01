Received: from eggs.gnu.org ([2001:4830:134:3::10]:42732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehHKv-0003i6-DD
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 11:03:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehHKs-0003iM-AB
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 11:03:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehHKr-0003hy-W8
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 11:03:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 16D56C0221
	for <qemu-devel@nongnu.org>; Thu,  1 Feb 2018 16:03:37 +0000 (UTC)
References: <20180201155841.27509-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bedde7ad-4174-a608-ea43-c3b6535f7280@redhat.com>
Date: Thu, 1 Feb 2018 10:03:23 -0600
MIME-Version: 1.0
In-Reply-To: <20180201155841.27509-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LrpjEMM0ti9AnEzXRk8ldjW1ImqBXK74b"
Subject: Re: [Qemu-devel] [PATCH v1] ui: correctly advance output buffer
 when writing SASL data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LrpjEMM0ti9AnEzXRk8ldjW1ImqBXK74b
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <bedde7ad-4174-a608-ea43-c3b6535f7280@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1] ui: correctly advance output buffer when
 writing SASL data
References: <20180201155841.27509-1-berrange@redhat.com>
In-Reply-To: <20180201155841.27509-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/01/2018 09:58 AM, Daniel P. Berrang=C3=A9 wrote:
> In this previous commit:
>=20
>   commit 8f61f1c5a6bc06438a1172efa80bc7606594fa07
>   Author: Daniel P. Berrange <berrange@redhat.com>
>   Date:   Mon Dec 18 19:12:20 2017 +0000
>=20
>     ui: track how much decoded data we consumed when doing SASL encodin=
g
>=20
> I attempted to fix a flaw with tracking how much data had actually been=

> processed when encoding with SASL. With that flaw, the VNC server could=

> mistakenly discard queued data that had not been sent.
>=20
> The fix was not quite right though, because it merely decremented the
> vs->output.offset value. This is effectively to discarding data from th=
e

s/to //

> end of the pending output buffer. We actually need to discard data from=

> the start of the pending output buffer. We also want to free memory tha=
t
> is no longer required. The correct way to handle this is to use the
> buffer_advance() helper method instead of directly manipulating the
> offset value.
>=20
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  ui/vnc-auth-sasl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LrpjEMM0ti9AnEzXRk8ldjW1ImqBXK74b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpzOksACgkQp6FrSiUn
Q2p0Ywf/bhjbz7kzl/o5HNA4pPb6kXT8fy9UUHwOKQ3qNJhHsinrFhRB8po+4GZn
cPCpqDlqO2XrT+vo3LaN3cSCOvkQrbcbsUyAm2Oqk1VwQBjCPaqmj+t+CDio8oC+
Z49RUrZjX88rZXZXxt/vXwiathQyosQDAEYcaCMPzGwaH/147afgUuuLYcCzb3GZ
jl1gPkYpEz4xXgldoGhuE+gogoboewzORQCJSfYZIniJgQ4+AzmGgu6/k+rhj7dI
Eg+C4qGh9RaJTAQo3NKepqBYtnbNPdRzl8xYGSCt0utFsPDn0ecexZwryXva/MeC
uENoPd59KmRHaNRnfH6fZENHTSPnkw==
=8YLT
-----END PGP SIGNATURE-----

--LrpjEMM0ti9AnEzXRk8ldjW1ImqBXK74b--
