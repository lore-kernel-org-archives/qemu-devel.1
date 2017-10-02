Received: from eggs.gnu.org ([2001:4830:134:3::10]:42146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz1OJ-0001ef-T9
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:08:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz1OH-0008Ir-6M
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:08:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dz1OG-0008IS-Sw
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:08:13 -0400
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<c861ba99329355f1f3096b833660d0be68b737c2.1506730372.git.alistair.francis@xilinx.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d0306786-e8b9-c297-e0af-7861cf76ecb4@redhat.com>
Date: Mon, 2 Oct 2017 09:08:07 -0500
MIME-Version: 1.0
In-Reply-To: <c861ba99329355f1f3096b833660d0be68b737c2.1506730372.git.alistair.francis@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="T5as6tCDw1gNLFkpoTWr3WPt6tfP95OAK"
Subject: Re: [Qemu-devel] [PATCH v2 03/47] audio: Replace AUDIO_FUNC with
 __func__
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Gerd Hoffmann <kraxel@redhat.com>, armbru@redhat.com
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T5as6tCDw1gNLFkpoTWr3WPt6tfP95OAK
From: Eric Blake <eblake@redhat.com>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Gerd Hoffmann <kraxel@redhat.com>, armbru@redhat.com
Message-ID: <d0306786-e8b9-c297-e0af-7861cf76ecb4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/47] audio: Replace AUDIO_FUNC with
 __func__
References: <cover.1506730372.git.alistair.francis@xilinx.com>
 <c861ba99329355f1f3096b833660d0be68b737c2.1506730372.git.alistair.francis@xilinx.com>
In-Reply-To: <c861ba99329355f1f3096b833660d0be68b737c2.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/29/2017 07:15 PM, Alistair Francis wrote:
> Apparently we don't use __MSC_VER as a compiler anymore and we always
> require a C99 compiler (which means we always have __func__) so we don'=
t
> need a special AUDIO_FUNC macro. We can just repleace AUDIO_FUNC with
> __func__ instead.
>=20
> Checkpatch failures where manually fixed.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> ---

Module the typo fixes spotted by Thomas,
Reviewed-by: Eric Blake <eblake@redhat.com>

> +++ b/audio/audio.c
> @@ -424,12 +424,12 @@ static void audio_process_options (const char *pr=
efix,
>      const char qemu_prefix[] =3D "QEMU_";
>      size_t preflen, optlen;
> =20
> -    if (audio_bug (AUDIO_FUNC, !prefix)) {
> +    if (audio_bug(__func__, !prefix)) {

I wonder if it would be nicer to have audio_bug() as a macro that
supplies __func__ automatically; but it's not enough of a concern to
prevent this patch from going in as-is.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--T5as6tCDw1gNLFkpoTWr3WPt6tfP95OAK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnSSEcACgkQp6FrSiUn
Q2oxPAf/bjhX1caPyAvDP5izsuKU8LQYZ/jeAD6/Rx3YxuXNQRXz2hu2EjxPKxTo
P0iI4Dldrn9AD00VmnlsF0Fi/+OPvBl9D3+sw1UfTpXsQDD693fcoNQ/5tbtTRRO
FChuVD6DFwXLnuvGLYpO4NgD3RzqlyOV04vHMwbwGQYq+YvrIRsnprcqdgHZXLmb
7JGb5/zSQy69VNJCT4cLuWB2iagsgCSwtlQk2l25ReWfDM1FAPE8/MbBCaUF/Q52
NhD8nrcNDik3D4ZjUYtmnjbjTqpzG0d9IWbb4XbelAtCc7brG2pzC6tS86KLdfE/
+HIYF25xNINz9WKfeWeGoYGS6tvWbw==
=2Hlg
-----END PGP SIGNATURE-----

--T5as6tCDw1gNLFkpoTWr3WPt6tfP95OAK--
