Received: from eggs.gnu.org ([2001:4830:134:3::10]:36759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckvus-0006xS-E8
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:55:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckvur-0003SY-GD
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:55:22 -0500
References: <20170305214857.9510-1-krzk@kernel.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f441f1d9-b312-5f96-0fbf-53a46a8b16a8@redhat.com>
Date: Mon, 6 Mar 2017 10:55:12 -0600
MIME-Version: 1.0
In-Reply-To: <20170305214857.9510-1-krzk@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XduqJM5unoi09FuBBwo3kCEsnQkTOEsv5"
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/arm/exynos: Convert fprintf to
 error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XduqJM5unoi09FuBBwo3kCEsnQkTOEsv5
From: Eric Blake <eblake@redhat.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Message-ID: <f441f1d9-b312-5f96-0fbf-53a46a8b16a8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/arm/exynos: Convert fprintf to
 error_report()
References: <20170305214857.9510-1-krzk@kernel.org>
In-Reply-To: <20170305214857.9510-1-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/05/2017 03:48 PM, Krzysztof Kozlowski wrote:
> error_report() is preferred over fprintf() for logging errors.  Also
> remove square brackets [] and additional new line characters in printed=

> messages.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

I don't see a 0/3 cover letter. When sending multiple patches, it's
always best to package them in-reply-to the cover letter ('git config
format.coverLetter auto' makes it easy to remember).


> @@ -101,9 +102,8 @@ static Exynos4210State *exynos4_boards_init_common(=
MachineState *machine,
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> =20
>      if (smp_cpus !=3D EXYNOS4210_NCPUS && !qtest_enabled()) {
> -        fprintf(stderr, "%s board supports only %d CPU cores. Ignoring=
 smp_cpus"
> -                " value.\n",
> -                mc->name, EXYNOS4210_NCPUS);
> +        error_report("%s board supports only %d CPU cores. Ignoring sm=
p_cpus value.",

Most uses of error_report() avoid trailing dot.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--XduqJM5unoi09FuBBwo3kCEsnQkTOEsv5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvZRwAAoJEKeha0olJ0Nqke8H/0d9WaPKCNPvEmj8RA2a6G+c
a+6QIct0bZjKggUu3P2YuLgBUdj7wOKBWwpCvTHTfSaQt6JXgvfxeMLymHO4vIfp
gnV4xc2K8LhR9/oFSUb8WFhveovCsIyfR/GL5ZXS8Mj6in0ZssLjcbDDNm0WfBju
Th2qBQrMm42yUJd/mwZMIt43oHg/5e+Bj53eSvbGLbiK6hKNYFv4wDfcpWpQRJF6
VTEp8QncjiX1SjS3aSNlKZ6TikBvNOOgmOJQX9Kpx7y0AZ7zXFX2ZA94i3tRIDPp
JtFoQzmByDxgYUD2NYButzPXxYsFWTYT7/wjuOSJlNPrwk8Rukw2SBrEUi3fKMY=
=aSXV
-----END PGP SIGNATURE-----

--XduqJM5unoi09FuBBwo3kCEsnQkTOEsv5--
