Received: from eggs.gnu.org ([2001:4830:134:3::10]:47743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@redhat.com>) id 1fkIkL-000443-6y
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 20:42:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@redhat.com>) id 1fkIkG-0006bM-CJ
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 20:42:41 -0400
Date: Tue, 31 Jul 2018 10:42:25 +1000
From: David Gibson <dgibson@redhat.com>
Message-ID: <20180731104225.30522b28@umbus.fritz.box>
In-Reply-To: <f20a1874-bcdf-34cf-3c87-e3bc4d386eed@vivier.eu>
References: <153294521235.6959.12520498748431693809.stgit@dhcp-9-109-246-16>
	<4a633022-d560-a704-e143-928b8467f09c@linaro.org>
	<f20a1874-bcdf-34cf-3c87-e3bc4d386eed@vivier.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/OohMXSKXQpTj9Kac5aG=ulE";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3] linux-user: ppc64: don't use volatile
 register during safe_syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Richard Henderson <richard.henderson@linaro.org>, Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>, riku.voipio@iki.fi, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/OohMXSKXQpTj9Kac5aG=ulE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Jul 2018 21:16:35 +0200
Laurent Vivier <laurent@vivier.eu> wrote:

> Le 30/07/2018 =C3=A0 14:44, Richard Henderson a =C3=A9crit=C2=A0:
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>=20
> Tested-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>=20
> I think this patch should go into the next -rc because it fixes a lot of
> failures in the LTP on ppc64 host (hundreds of failure...).
>=20
> David, if you want, I can take it through the linux-user tree.

That'd be great, thanks.

>=20
> Thanks,
> Laurent


--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/OohMXSKXQpTj9Kac5aG=ulE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltfsHEACgkQbDjKyiDZ
s5JYRRAA4e163a1brRL+OMN6QtaMaWfERNEJHSx3AyK2o0dqw84sROeSFfjsckPm
1gYVGPghjeH2Fig5Om9hGIBTao6VZ67yZPf2XQ2fQMmYb9tjIr7odPbgQI8b6bl6
I1Bv29Ze/mr1LBbZXQa7qVMAfM1QOJ7NUaKdZ9ZXEj/55c3wk3Av4s46IQi5CyHA
Aatdi0kS385PZrd4iGX+ablAk47AdRH4QmtLVd5UdKCxiC3P/3Z69wb56deuC48K
5c4kJpFN1TF8vgQlPTggjJEunhQ3mE9i7tnyHxGAFCxpxJAvZfyvBTo5p+sZt4Do
C4wkjHUdtbIYjG2VEiRpIe0+z2I276fTZEJSRuOUxrRLb3vyrwlf+1IavT6SlB6K
KClCEXYCqd/4/tBBDqmU30o6Okvky9yDYK2XPIQOQBM8y0UMQngKN3ziwijfeXqv
TypPNZqjcN1cLCOHTjbqD3Xfz+c564NdyTd6rLYGxjP+ECXkg+Uik20HQwq/3a/N
23y7fgL9YBTaCjy8e2Ud90vJ8sQPb1EAoZj6hGDlumsyktmGJ4FAyJycaZXeVYrM
jpxrl+imXkaySkHTSZ2OqFs1qUYnD9pHrstl8hbvmxD7lbTF8thOM1MoUPrefhiY
09lBjnB8PcP+4zw8pOSJ7mN+XmS5+TcyDwckwzFDkJddkbCyMhs=
=BT12
-----END PGP SIGNATURE-----

--Sig_/OohMXSKXQpTj9Kac5aG=ulE--
