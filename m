Received: from eggs.gnu.org ([2001:4830:134:3::10]:59021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fasLu-0000a5-F8
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 20:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fasLt-0008VE-Br
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 20:42:30 -0400
Date: Thu, 5 Jul 2018 10:13:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180705001304.GC3450@umbus.fritz.box>
References: <20180704144400.9419-1-f4bug@amsat.org>
	<alpine.BSF.2.21.1807041838350.151@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1807041838350.151@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH] ppc440_uc: Fix a copy/paste error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 04, 2018 at 06:40:35PM +0200, BALATON Zoltan wrote:
> On Wed, 4 Jul 2018, Philippe Mathieu-Daud=E9 wrote:
> > Missed in 3c409c1927e, hopefully reported by Coverity.
>=20
> Apparently Coverity did report it and Paolo already notified me about tha=
t.
> I was about to send a patch but you were faster. Thank you very much.
>=20
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

Applied to ppc-for-3.0, thanks.

>=20
> > Fixes: Coverity CID 1393788 (Copy-paste error)
> > Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > ---
> > hw/ppc/ppc440_uc.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
> > index 0bbaa6844a..09ccda548f 100644
> > --- a/hw/ppc/ppc440_uc.c
> > +++ b/hw/ppc/ppc440_uc.c
> > @@ -935,7 +935,7 @@ static void dcr_write_dma(void *opaque, int dcrn, u=
int32_t val)
> >                     if (wptr) {
> >                         cpu_physical_memory_unmap(wptr, wlen, 1, didx);
> >                     }
> > -                    if (wptr) {
> > +                    if (rptr) {
> >                         cpu_physical_memory_unmap(rptr, rlen, 0, sidx);
> >                     }
> >                 }
> >=20


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls9YpAACgkQbDjKyiDZ
s5LB5A//d9LhtzjhexyMQp58XWQ0pxndtPwlumt1GR8LvHa0gbqcHIqQmJ0kYA82
u627zmjWb0PUr+nvrRP9aPjmcSE87KXvevnIRso90/ndaGtfcS2HezaFuRxIE8CF
Sx12aZY7zyQhEIymzSPXxY2uI+G9JWTmJP2Z2TXrw7q5ax4APkJ8WfBRdMAKb8hl
15SQlrPbod+QaGBj13BkuSm92nKHupBrI/+6aBGIXqH7N3Rq1ttZ2AhlyjgeLwCU
+OQutTAvE0KkbPzc2ItVuYNeLsNLBTYnFX+2FpD+VnxVfMVuaNxkudB9ZFiKqIEX
j2VTP6JCIXHy7gPAsx2OwohbsUmsCjB836mKXztdkor35fZVcQlVVf2ETGJFkJBp
cOoqFdf2zm2XPcIXTO4W8rBByC4A+LGluE6udYzu/a/gZwWVFV0mV4LgjHsZCSnf
iwpQq8JQzC8CqxPYJeEjLIIGQTEeJOYVMPBgynWhvP3+BUkmF4PfRPVXDcSRBYiv
+P4wZCyF9dBeT7F9jvLuNyKRPYuox6PLOIKRwFF1v9fXrJ1d2isiKoPJWWXcI/n9
UNvQb4letOZbOvgQhYGm24xj2HWMGlmSR+eLzTIgioeR6e1jHZfOug0Z02BQ2KiQ
sl70E9VnkUHIJqHd0PzY5gNn+aRNSdy3FlCTRvcra5suHjyF6hE=
=Eme0
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--
