Received: from eggs.gnu.org ([2001:4830:134:3::10]:43292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX699-0005c2-9E
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX696-0006Gj-5P
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:33:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dX695-0006GB-SA
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:33:08 -0400
References: <20170717132110.29962-1-lvivier@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e19af7a0-53cb-9ca6-c593-a4e4567eca39@redhat.com>
Date: Mon, 17 Jul 2017 08:33:01 -0500
MIME-Version: 1.0
In-Reply-To: <20170717132110.29962-1-lvivier@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0LjMXu7hQ0WiHCihmJmXoUM0eq2hcHWCA"
Subject: Re: [Qemu-devel] [PATCH] accel: cleanup error output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Ben Warren <ben@skyportsystems.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0LjMXu7hQ0WiHCihmJmXoUM0eq2hcHWCA
From: Eric Blake <eblake@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Ben Warren <ben@skyportsystems.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <e19af7a0-53cb-9ca6-c593-a4e4567eca39@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] accel: cleanup error output
References: <20170717132110.29962-1-lvivier@redhat.com>
In-Reply-To: <20170717132110.29962-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 08:21 AM, Laurent Vivier wrote:
> Only emit "XXX accelerator not found", if there are not
> further accelerators listed. eg
>=20
>    accel=3Dkvm:tcg
>=20
> doesn't print a "KVM accelerator not found" warning
> when it falls back to tcg, but a
>=20
>    accel=3Dkvm
>=20
> prints a warning, since no fallback is given.
>=20
> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  accel/accel.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)


> @@ -110,7 +110,8 @@ void configure_accelerator(MachineState *ms)
> =20
>      if (!accel_initialised) {
>          if (!init_failed) {
> -            fprintf(stderr, "No accelerator found!\n");
> +            fprintf(stderr, "-machine accel=3D%s: No accelerator found=
!\n",

It may be worth dropping the '!', as we tend not to shout at the user;
but whether or not you tweak that,

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0LjMXu7hQ0WiHCihmJmXoUM0eq2hcHWCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllsvI0ACgkQp6FrSiUn
Q2pRpggAlqZ0B95qvOFUEm8whdhT5IwV7XeO6zjcXeuBirAU2SXcc+wjsrSZbRxF
oj10UdiP+JNRniCirksF+pVhh/9fxlAHX5TldKnvMmNZPcTZ8Ngvu8pKhJ0cfLmg
PJnS6rgqlSKZUyq4HrWa/oTq1VjZW3BFqfWNo4+nW5voFUuVc5AuDJklOCuoiPqf
KVoB9kAF2tYeCrrA2xyRwQTRiyRfUl/sEIHOf551E/FA6NVoMMo5gVwUQlgWapKa
sjgmxtiPCwoVMnfDPQm+tf07P6WhBifYtjH0GfnRaB28sV3Q5w93iBV5UT6HNpSJ
TbEOLTwHhhI3/tdcjwCrVddVTipzYg==
=2Iar
-----END PGP SIGNATURE-----

--0LjMXu7hQ0WiHCihmJmXoUM0eq2hcHWCA--
