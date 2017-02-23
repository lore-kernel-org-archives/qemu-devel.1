Received: from eggs.gnu.org ([2001:4830:134:3::10]:46002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ch20k-00068h-5k
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 17:37:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ch20h-0006Pd-0r
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 17:37:18 -0500
Date: Thu, 23 Feb 2017 20:29:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223092927.GB17615@umbus.fritz.box>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487763883-4877-4-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170223032118.GD12577@umbus.fritz.box>
	<8760k1tmnf.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <8760k1tmnf.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v3 03/10] target/ppc: support for 32-bit
 carry and overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2017 at 12:32:44PM +0530, Nikunj A Dadhania wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > -static void gen_read_xer(TCGv dst)
> >> +static void gen_read_xer(DisasContext *ctx, TCGv dst)
> >>  {
> >>      TCGv t0 =3D tcg_temp_new();
> >>      TCGv t1 =3D tcg_temp_new();
> >> @@ -3715,15 +3719,30 @@ static void gen_read_xer(TCGv dst)
> >>      tcg_gen_or_tl(t0, t0, t1);
> >>      tcg_gen_or_tl(dst, dst, t2);
> >>      tcg_gen_or_tl(dst, dst, t0);
> >> +    if (is_isa300(ctx)) {
> >> +        tcg_gen_shli_tl(t0, cpu_ov32, XER_OV32);
> >> +        tcg_gen_or_tl(dst, dst, t0);
> >> +        tcg_gen_shli_tl(t0, cpu_ca32, XER_CA32);
> >> +        tcg_gen_or_tl(dst, dst, t0);
> >
> > Could you use 2 deposits here, instead of 2 shifts and 2 ors?
>=20
> I checked the implementation of tcg_gen_deposit_i64, resultant will have =
much
> more than 2 shifts + 2 ors.

Ok, fair enough.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrqt1AAoJEGw4ysog2bOSpTwP/Ro9GiC2bsQYPDAKNGOI1knD
Uxi6Go8ZXo4UwuF6+N8u2zAPJFqUs+LUado9261fF6ZajWMOQTTPokqbRhmubVBX
kGjNFBZDg5PM6xixfMd2jhRqBwsUpyi/Gc41CZVxKfEpXhdk3xSUpKKC/izk7C+3
eHxtLgmFXcLOfeOQdCpy6k4vE9pMQcvg5+5itxgM8uo2y7A/ZSSIpAXyqCtzTEI4
Y8u6gf2k3m2SaAY3EppOzOslB9D1LJIGZS0WS1rNhqy4GST9G3NtVGoF9wKfnVEP
l08WqvIagX5dL+j/PbcImodwdNsP8YuSu6jBJK6yQ/YMqRa9Vd5nz2g6Dm7tqDvW
MnAv9bM50elutC3vLwGsaLoUBnPfMqRgDAtNBPAjKTHa19rNSMZmS1ItBA5TU/sA
fgfzZqjRn4Szpd5ALIp6lIVH6KHo6fSuI3Fm57VrodUcsd2/tFFda+x+HRb9h1aS
P/SmFgPFDytNEsB8XFkJZzzHjOG4IuHwniqysCFapfedXSiIga8rFAea1vvWfei9
hIWs3cjD7XhH6ePKXDJ5HQrHCxxFxYyw3Xn9rqp89Op98McL28h5ozEw4LQMYNiq
C5bLSLoazXNi7pT1PWibSbhUSupnaiYxtX7aPoxS/0HMBiUaFD1DcZFwZTivof/J
JzGRf2jr9E3eppq4QGpc
=BH1z
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
