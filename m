Received: from eggs.gnu.org ([2001:4830:134:3::10]:33413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dX35T-0002Bx-Qn
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dX35O-0001dP-Pu
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:17:11 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:36816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dX35O-0001ck-JG
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:17:06 -0400
Received: by mail-wm0-x229.google.com with SMTP id t70so10706676wmt.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 03:17:06 -0700 (PDT)
Date: Mon, 17 Jul 2017 11:17:03 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170717101703.GH7163@stefanha-x1.localdomain>
References: <20170713190116.21608-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKijDXBCEH69PxaN"
Content-Disposition: inline
In-Reply-To: <20170713190116.21608-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vl.c/exit: pause cpus before closing block
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, jsnow@redhat.com


--gKijDXBCEH69PxaN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 08:01:16PM +0100, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> There's a rare exit seg if the guest is accessing
> IO during exit.
> It's always hitting the atomic_inc(&bs->in_flight) with a NULL
> bs. This was added recently in 99723548  but I don't see it
> as the cause.
>=20
> Flip vl.c around so we pause the cpus before closing the block devices,
> that way we shouldn't have anything trying to access them when
> they're gone.
>=20
> This was originally Red Hat bz https://bugzilla.redhat.com/show_bug.cgi?i=
d=3D1451015
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reported-by: Cong Li <coli@redhat.com>
>=20
> --
> This is a very rare race, I'll leave it running in a loop to see if
> we hit anything else and to check this really fixes it.
>=20
> I do worry if there are other cases that can trigger this - e.g.
> hot-unplug or ejecting a CD.
>=20
> ---
>  vl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--gKijDXBCEH69PxaN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZbI6fAAoJEJykq7OBq3PITXUIALUPkey9PSvSi6/xMsTWLCLa
8qM5zv2sA+EUiW+11ZLZkK4vdeB0R3eldHOSG6iLuiaytUmMSUq78i3lovpZLUS1
GRbklnHb7DO511+sOFAEpfVQ7TlRzFjjEisi1YA+unKwjjKdTsZrcreooODJfsFL
THZyOsHMbaKGeZMjVxJ12wAa1xQza5Zujnz7HwFceSHMUcF8txm2gCa0rnYD0Llz
r1LUFkzdlvIIvvp09iklIRuDlQ+nSmvEEp6PAt09x5ZKHPdHH8yJTwvF6RJXluh3
0+OyTafoXImNQkD5wGqQXf26ttGd9FyR33OEaLAJZDyqqvVlnO7M2Lpf+obM1qI=
=VJOS
-----END PGP SIGNATURE-----

--gKijDXBCEH69PxaN--
