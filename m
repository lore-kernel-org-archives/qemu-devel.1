Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF88C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D6F21556
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D6F21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6rZi-0004mg-Sx
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 02:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j6rZ3-0004Ek-D7
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:57:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j6rZ1-0001X8-O8
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:57:05 -0500
Received: from 6.mo6.mail-out.ovh.net ([87.98.177.69]:56465)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j6rZ1-0001QM-Fn
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:57:03 -0500
Received: from player731.ha.ovh.net (unknown [10.108.54.94])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 3CB79201D9A
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 08:57:01 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player731.ha.ovh.net (Postfix) with ESMTPSA id 86747F92AD85;
 Wed, 26 Feb 2020 07:56:42 +0000 (UTC)
Date: Wed, 26 Feb 2020 08:56:40 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v6 09/18] target/ppc: Streamline calculation of RMA
 limit from LPCR[RMLS]
Message-ID: <20200226085640.6320d9de@bahia.home>
In-Reply-To: <20200226010413.GH41629@umbus.fritz.box>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
 <20200224233724.46415-10-david@gibson.dropbear.id.au>
 <20200225180531.6551ce59@bahia.home>
 <20200225234725.22f268f1@bahia.home>
 <20200226010413.GH41629@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j4uV/Dyz4VYfDj1gAKIifyg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 2651494281713129958
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrleefgdduudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucffohhmrghinhepghhnuhdrohhrghenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.177.69
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru, farosas@linux.ibm.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/j4uV/Dyz4VYfDj1gAKIifyg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Feb 2020 12:04:13 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Feb 25, 2020 at 11:47:25PM +0100, Greg Kurz wrote:
> > On Tue, 25 Feb 2020 18:05:31 +0100
> > Greg Kurz <groug@kaod.org> wrote:
> >=20
> > > On Tue, 25 Feb 2020 10:37:15 +1100
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >=20
> > > > Currently we use a big switch statement in ppc_hash64_update_rmls()=
 to work
> > > > out what the right RMA limit is based on the LPCR[RMLS] field.  The=
re's no
> > > > formula for this - it's just an arbitrary mapping defined by the ex=
isting
> > > > CPU implementations - but we can make it a bit more readable by usi=
ng a
> > > > lookup table rather than a switch.  In addition we can use the MiB/=
GiB
> > > > symbols to make it a bit clearer.
> > > >=20
> > > > While there we add a bit of clarity and rationale to the comment ab=
out
> > > > what happens if the LPCR[RMLS] doesn't contain a valid value.
> > > >=20
> > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > > > ---
> > > >  target/ppc/mmu-hash64.c | 71 ++++++++++++++++++++-----------------=
----
> > > >  1 file changed, 35 insertions(+), 36 deletions(-)
> > > >=20
> > > > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > > > index 0ef330a614..4f082d775d 100644
> > > > --- a/target/ppc/mmu-hash64.c
> > > > +++ b/target/ppc/mmu-hash64.c
> > > > @@ -18,6 +18,7 @@
> > > >   * License along with this library; if not, see <http://www.gnu.or=
g/licenses/>.
> > > >   */
> > > >  #include "qemu/osdep.h"
> > > > +#include "qemu/units.h"
> > > >  #include "cpu.h"
> > > >  #include "exec/exec-all.h"
> > > >  #include "exec/helper-proto.h"This tool was originally developed t=
o fix Linux CPU throttling issues affecting Lenovo T480 / T480s / X1C6 as d=
escribed here.
> > > > @@ -757,6 +758,39 @@ static void ppc_hash64_set_c(PowerPCCPU *cpu, =
hwaddr ptex, uint64_t pte1)
> > > >      stb_phys(CPU(cpu)->as, base + offset, (pte1 & 0xff) | 0x80);
> > > >  }
> > > > =20
> > > > +static target_ulong rmls_limit(PowerPCCPU *cpu)
> > > > +{
> > > > +    CPUPPCState *env =3D &cpu->env;
> > > > +    /*
> > > > +     * This is the full 4 bits encoding of POWER8. Previous
> > > > +     * CPUs only support a subset of these but the filtering
> > > > +     * is done when writing LPCR
> > > > +     */
> > > > +    const target_ulong rma_sizes[] =3D {
> > > > +        [0] =3D 0,
> > > > +        [1] =3D 16 * GiB,
> > > > +        [2] =3D 1 * GiB,
> > > > +        [3] =3D 64 * MiB,
> > > > +        [4] =3D 256 * MiB,
> > > > +        [5] =3D 0,
> > > > +        [6] =3D 0,
> > > > +        [7] =3D 128 * MiB,
> > > > +        [8] =3D 32 * MiB,
> > > > +    };
> > > > +    target_ulong rmls =3D (env->spr[SPR_LPCR] & LPCR_RMLS) >> LPCR=
_RMLS_SHIFT;
> > > > +
> > > > +    if (rmls < ARRAY_SIZE(rma_sizes)) {
> > >=20
> > > This condition is always true since the RMLS field is 4-bit long...=20
> >=20
> > Oops my mistake, I was already thinking about the suggestion I have
> > for something that was puzzling me. See below.
> >=20
> > > I guess you want to check that RMLS encodes a valid RMA size instead.
> > >=20
> > >     if (rma_sizes[rmls]) {
> > >=20
> > > > +        return rma_sizes[rmls];
> > > > +    } else {
> > > > +        /*
> > > > +         * Bad value, so the OS has shot itself in the foot.  Retu=
rn a
> > > > +         * 0-sized RMA which we expect to trigger an immediate DSI=
 or
> > > > +         * ISI
> > > > +         */
> >=20
> > It seems a bit weird to differentiate the case where the value is bad
> > because it happens to be bigger than the highest supported one, compared
> > to values that are declared bad in rma_sizes[], like 0, 5 or 6. They're
> > all basically the same case of values not used to encode a valid
> > size...
>=20
> Right, but the result is the same either way - the function returns
> 0.  This is basically just a small space optimization.
>=20
> >=20
> > What about :
> >=20
> >     static const target_ulong rma_sizes[16] =3D {
> >         [1] =3D 16 * GiB,
> >         [2] =3D 1 * GiB,
> >         [3] =3D 64 * MiB,
> >         [4] =3D 256 * MiB,
> >         [7] =3D 128 * MiB,
> >         [8] =3D 32 * MiB,
> >     };
>=20
> Eh, I guess?  I don't see much to pick between them.
>=20

This is what I had in mind actually.

static target_ulong rmls_limit(PowerPCCPU *cpu)
{
    CPUPPCState *env =3D &cpu->env;
    /*
     * This is the full 4 bits encoding of POWER8. Previous
     * CPUs only support a subset of these but the filtering
     * is done when writing LPCR.
     *
     * Unsupported values mean the OS has shot itself in the
     * foot. Return a 0-sized RMA in this case, which we expect
     * to trigger an immediate DSI or ISI
     */
    static const target_ulong rma_sizes[16] =3D {
        [1] =3D 16 * GiB,
        [2] =3D 1 * GiB,
        [3] =3D 64 * MiB,
        [4] =3D 256 * MiB,
        [7] =3D 128 * MiB,
        [8] =3D 32 * MiB,
    };
    target_ulong rmls =3D (env->spr[SPR_LPCR] & LPCR_RMLS) >> LPCR_RMLS_SHI=
FT;

    return rma_sizes[rmls];
}

--Sig_/j4uV/Dyz4VYfDj1gAKIifyg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl5WJLgACgkQcdTV5YIv
c9aS/Q/9EnMyFx+9cvHcRSEOAcRM7ffLuPJIjXsSBTlcLAylmaPomrojfIlpdN+w
N3FckahCFnx/ju3KDVQvUyShB9EgMRuRdy01AZuFvG+a7JIEO24yN0kSFrKqHZrP
91jNBOMXvipMb0ntphTmosW6OpZCGL9mPgriBXPb/RJ6AHq/twr4au398QONHUGE
npzYY/GLy8/KxpqsJPvWIltguJ0ilGN4/kI0ByhLuJJRYGEg4o4rSJTlml8hVTFK
GxNICXI+v9Lwf3XW+9nB/Fz9PMZpi0nIIwJUrIs52WL+AoPBJhJmcvqmpfjxWpat
yo+1qseLXauiDqOM9Uw5Kvbu6+19xjKxVA8/6tWlmnwG9GbsMlHb3jWDgkeSwfhq
oaOPKX7MGynnkKfeNEg8AIK/Ome8GxXX6lj0e+tEPYWCiz2A2A+dVoiOITrqbAPk
8cu1WS//7X6GoiaXQZmGxgZ+38YRK1DreNtXEHQfPWd+ro8fhL004vrq5o1czjAZ
+7kTUFe+A7wCNxkP0TtzwQsSdEQbL9Lld4g7pDB6n3mRv+dw/wuDmw4mGehLSmgZ
XM8GzfV+8g64tiFgHLQinom5IHmFX+2hUguUz1BMZ/o6UMJ0gC26pzuogsAXPZKv
sf/qvc/S+DsvFpvdCnDBWA4NncBEJFU9jsndyKmIMRCaE3GGtVA=
=h0Uf
-----END PGP SIGNATURE-----

--Sig_/j4uV/Dyz4VYfDj1gAKIifyg--

