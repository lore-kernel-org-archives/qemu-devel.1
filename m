Received: from eggs.gnu.org ([2001:4830:134:3::10]:52310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dcIMh-0004nu-QL
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 17:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dcIMe-0007f4-MY
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 17:36:39 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:20531
	helo=imgpgp01.kl.imgtec.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <James.Hogan@imgtec.com>)
	id 1dcIMe-0007dW-DG
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 17:36:36 -0400
Date: Mon, 31 Jul 2017 22:36:33 +0100
From: James Hogan <james.hogan@imgtec.com>
Message-ID: <20170731213633.GC6973@jhogan-linux.le.imgtec.org>
References: <cover.6535001d6b9cd2357109d19b1060e3f6a2b958a7.1501506432.git-series.james.hogan@imgtec.com>
	<ad80a5d3ff807996b3cdf70504cab7efd66c4295.1501506432.git-series.james.hogan@imgtec.com>
	<93cb4cb7-842c-1a37-c2dd-a7c522076a1d@twiddle.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iRQTiiVA1juStYAd"
Content-Disposition: inline
In-Reply-To: <93cb4cb7-842c-1a37-c2dd-a7c522076a1d@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 2/2] mips: Add KVM T&E segment support for
 TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Yongbok Kim <yongbok.kim@imgtec.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Aurelien Jarno <aurelien@aurel32.net>

--iRQTiiVA1juStYAd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2017 at 01:47:48PM -0700, Richard Henderson wrote:
> On 07/31/2017 06:09 AM, James Hogan wrote:
> > +static int mips_um_ksegs;
> > +
> >   uint64_t cpu_mips_kseg0_to_phys(void *opaque, uint64_t addr)
> >   {
> >       return addr & 0x1fffffffll;
> > @@ -38,3 +40,13 @@ uint64_t cpu_mips_kvm_um_phys_to_kseg0(void *opaque,=
 uint64_t addr)
> >   {
> >       return addr | 0x40000000ll;
> >   }
> > +
> > +int mips_um_ksegs_enabled(void)
>=20
> bool?

Sure, I'll respin,

>=20
> Otherwise,
> Reviewed-by: Richard Henderson <rth@twiddle.net>

Thanks for the review!

Cheers
James

--iRQTiiVA1juStYAd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAll/otcACgkQbAtpk944
dnrxFQ//cQAjWWW7cZPuy5AqmyFuHIHsMYVHBRlHBH2lUHT219MxtO3hCDirQezj
djeFcLfBbHxfZSh9Bj86U0tTNaEYCZiVL+LeozUXOYSx5uNiUPGaarQ01zp/oi7j
39g8aDBt9RWDjSjXYkdsG9q9WuTOr0RhdYS5fmbNUDzIijPISvlgsRUYlbhrGf6x
aDIpxbhKVVIkO9AdGOTTQfoGT4dcSvaNxjB8/GlubWVGVV8rw0LaudpBONlYJr2E
TfdSrjvraiighO5jHsRsFNNxor9l3cut62CT5W77xaXnuPb5KQAbZNWi0yPiuC5t
zkPXSYa0lZrOP4mlVpoML19QgrZa8Yw2JnsH0Y+PVlkQb9K/uY+SFSk5SWeLBUrL
9HiDYawKsvI6pOxhSkITgk1dBE3jXGWQHFYhz8jLNsCo4BOPsUyk5GQAxYvpv85C
A69in732lQuP8KLV7qUU1ZO/eIdl9/3I7f9HG7kxduUXJxHN7Y6mN/92xOQTUKMI
4nSluS0dFJcJ9vQ++Yji3IHNA0bvrucgxcPhJN9szi5sdKNWmgG8X36dUhAe2sUV
mDJ5xuFHqKqyNG/iVC6QEfAOnTZrUfrNRqHFC97si0p18vWd5YQhoQlmvJDc6Fpp
kutEh4FjNwOp2XRWaHuKNif3k1fw2KDkM8OovrKOfiJwaFN47H8=
=p06B
-----END PGP SIGNATURE-----

--iRQTiiVA1juStYAd--
