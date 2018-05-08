Received: from eggs.gnu.org ([2001:4830:134:3::10]:39694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fFzt5-0007k5-7V
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fFzt0-0006Vh-4m
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:30:27 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:38372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fFzsz-0006V2-Sy
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:30:22 -0400
Received: by mail-wr0-x242.google.com with SMTP id 94-v6so30441774wrf.5
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 03:30:21 -0700 (PDT)
Date: Tue, 8 May 2018 11:30:19 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180508103019.GH19710@stefanha-x1.localdomain>
References: <20180502105552.22925-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U3BNvdZEnlJXqmh+"
Content-Disposition: inline
In-Reply-To: <20180502105552.22925-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vhost-user+postcopy: Use qemu_set_nonblock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, peter.maydell@linaro.org


--U3BNvdZEnlJXqmh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 02, 2018 at 11:55:52AM +0100, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Use qemu_set_nonblock rather than a simple fcntl; cleaner
> and I have no reason to change other flags.
>=20
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/virtio/vhost-user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--U3BNvdZEnlJXqmh+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa8Xw7AAoJEJykq7OBq3PIG18H/jA9xTPDCj4qMhDF/blKKJGi
FZf6u8sOX1ql69JtkZTEaVuusers/qU2jSo1ocLV6Ikt5kU2CPzpqSpt7HQP0kl6
a5yohUmn3j9I8x3UbZXKug1syMitugIDVgXXmt3lb3XTMJ9on2hshQrjpL/+Aln9
l+pGoQ+mnYeI0aM+da3byb3/4XEaEC22+wufTbQJaj7iHAriiToIwoCBp9pm6CA9
IpWRMBs5/+86D0j+r1u67lb0ZZA61fqyoGGM6YmnKuDMF1WV3ApTcph0l4Dpz6KW
diQYbN/u3W0Adz6AMxDVrtw/Gxz1wsPBNTRrhCbgYoETmTH4u16xqQwXTnx+MXk=
=rudN
-----END PGP SIGNATURE-----

--U3BNvdZEnlJXqmh+--
