Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3362C3F2C0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 21:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8965E2469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 21:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IB7Mu3Z3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8965E2469F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7R6q-00053D-ON
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 16:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j7R5m-0003XP-HI
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:53:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j7R5k-0008Ae-QQ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:53:14 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:33367)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j7R5j-00086F-ST; Thu, 27 Feb 2020 16:53:12 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48T5y74088z9sPk; Fri, 28 Feb 2020 08:53:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582840383;
 bh=CsQPRnvH51ysLyXAcf7xdvunjew1HAWW7Nhv7lCHBQ0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IB7Mu3Z3Ae5kp7KEA7NCMeJWrfjLu0VC8Sx7WiActw6FYW69AKm1f8RgmF7B2ZAWI
 ePLSzFGmnErV35Ef9DcQQ0tysLf6nKYv60iMK+V8L7/yr1i565Tt2f9+5+3gOd2GCf
 6MvxegEdx/xV/oPYUlDZYzktGJampncMyklsEEss=
Date: Thu, 27 Feb 2020 15:25:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v6 09/18] target/ppc: Streamline calculation of RMA limit
 from LPCR[RMLS]
Message-ID: <20200227042516.GK41629@umbus.fritz.box>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
 <20200224233724.46415-10-david@gibson.dropbear.id.au>
 <20200225180531.6551ce59@bahia.home>
 <20200225234725.22f268f1@bahia.home>
 <20200226010413.GH41629@umbus.fritz.box>
 <20200226085640.6320d9de@bahia.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vbzKE9fGfpHIBC6T"
Content-Disposition: inline
In-Reply-To: <20200226085640.6320d9de@bahia.home>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--vbzKE9fGfpHIBC6T
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2020 at 08:56:40AM +0100, Greg Kurz wrote:
> On Wed, 26 Feb 2020 12:04:13 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Feb 25, 2020 at 11:47:25PM +0100, Greg Kurz wrote:
> > > On Tue, 25 Feb 2020 18:05:31 +0100
> > > Greg Kurz <groug@kaod.org> wrote:
> > >=20
> > > > On Tue, 25 Feb 2020 10:37:15 +1100
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >=20
> > > > > Currently we use a big switch statement in ppc_hash64_update_rmls=
() to work
> > > > > out what the right RMA limit is based on the LPCR[RMLS] field.  T=
here's no
> > > > > formula for this - it's just an arbitrary mapping defined by the =
existing
> > > > > CPU implementations - but we can make it a bit more readable by u=
sing a
> > > > > lookup table rather than a switch.  In addition we can use the Mi=
B/GiB
> > > > > symbols to make it a bit clearer.
> > > > >=20
> > > > > While there we add a bit of clarity and rationale to the comment =
about
> > > > > what happens if the LPCR[RMLS] doesn't contain a valid value.
> > > > >=20
> > > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > > Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
> > > > > ---
> > > > >  target/ppc/mmu-hash64.c | 71 ++++++++++++++++++++---------------=
------
> > > > >  1 file changed, 35 insertions(+), 36 deletions(-)
> > > > >=20
> > > > > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > > > > index 0ef330a614..4f082d775d 100644
> > > > > --- a/target/ppc/mmu-hash64.c
> > > > > +++ b/target/ppc/mmu-hash64.c
> > > > > @@ -18,6 +18,7 @@
> > > > >   * License along with this library; if not, see <http://www.gnu.=
org/licenses/>.
> > > > >   */
> > > > >  #include "qemu/osdep.h"
> > > > > +#include "qemu/units.h"
> > > > >  #include "cpu.h"
> > > > >  #include "exec/exec-all.h"
> > > > >  #include "exec/helper-proto.h"This tool was originally developed=
 to fix Linux CPU throttling issues affecting Lenovo T480 / T480s / X1C6 as=
 described here.
> > > > > @@ -757,6 +758,39 @@ static void ppc_hash64_set_c(PowerPCCPU *cpu=
, hwaddr ptex, uint64_t pte1)
> > > > >      stb_phys(CPU(cpu)->as, base + offset, (pte1 & 0xff) | 0x80);
> > > > >  }
> > > > > =20
> > > > > +static target_ulong rmls_limit(PowerPCCPU *cpu)
> > > > > +{
> > > > > +    CPUPPCState *env =3D &cpu->env;
> > > > > +    /*
> > > > > +     * This is the full 4 bits encoding of POWER8. Previous
> > > > > +     * CPUs only support a subset of these but the filtering
> > > > > +     * is done when writing LPCR
> > > > > +     */
> > > > > +    const target_ulong rma_sizes[] =3D {
> > > > > +        [0] =3D 0,
> > > > > +        [1] =3D 16 * GiB,
> > > > > +        [2] =3D 1 * GiB,
> > > > > +        [3] =3D 64 * MiB,
> > > > > +        [4] =3D 256 * MiB,
> > > > > +        [5] =3D 0,
> > > > > +        [6] =3D 0,
> > > > > +        [7] =3D 128 * MiB,
> > > > > +        [8] =3D 32 * MiB,
> > > > > +    };
> > > > > +    target_ulong rmls =3D (env->spr[SPR_LPCR] & LPCR_RMLS) >> LP=
CR_RMLS_SHIFT;
> > > > > +
> > > > > +    if (rmls < ARRAY_SIZE(rma_sizes)) {
> > > >=20
> > > > This condition is always true since the RMLS field is 4-bit long...=
=20
> > >=20
> > > Oops my mistake, I was already thinking about the suggestion I have
> > > for something that was puzzling me. See below.
> > >=20
> > > > I guess you want to check that RMLS encodes a valid RMA size instea=
d.
> > > >=20
> > > >     if (rma_sizes[rmls]) {
> > > >=20
> > > > > +        return rma_sizes[rmls];
> > > > > +    } else {
> > > > > +        /*
> > > > > +         * Bad value, so the OS has shot itself in the foot.  Re=
turn a
> > > > > +         * 0-sized RMA which we expect to trigger an immediate D=
SI or
> > > > > +         * ISI
> > > > > +         */
> > >=20
> > > It seems a bit weird to differentiate the case where the value is bad
> > > because it happens to be bigger than the highest supported one, compa=
red
> > > to values that are declared bad in rma_sizes[], like 0, 5 or 6. They'=
re
> > > all basically the same case of values not used to encode a valid
> > > size...
> >=20
> > Right, but the result is the same either way - the function returns
> > 0.  This is basically just a small space optimization.
> >=20
> > >=20
> > > What about :
> > >=20
> > >     static const target_ulong rma_sizes[16] =3D {
> > >         [1] =3D 16 * GiB,
> > >         [2] =3D 1 * GiB,
> > >         [3] =3D 64 * MiB,
> > >         [4] =3D 256 * MiB,
> > >         [7] =3D 128 * MiB,
> > >         [8] =3D 32 * MiB,
> > >     };
> >=20
> > Eh, I guess?  I don't see much to pick between them.
> >=20
>=20
> This is what I had in mind actually.
>=20
> static target_ulong rmls_limit(PowerPCCPU *cpu)
> {
>     CPUPPCState *env =3D &cpu->env;
>     /*
>      * This is the full 4 bits encoding of POWER8. Previous
>      * CPUs only support a subset of these but the filtering
>      * is done when writing LPCR.
>      *
>      * Unsupported values mean the OS has shot itself in the
>      * foot. Return a 0-sized RMA in this case, which we expect
>      * to trigger an immediate DSI or ISI
>      */
>     static const target_ulong rma_sizes[16] =3D {
>         [1] =3D 16 * GiB,
>         [2] =3D 1 * GiB,
>         [3] =3D 64 * MiB,
>         [4] =3D 256 * MiB,
>         [7] =3D 128 * MiB,
>         [8] =3D 32 * MiB,
>     };
>     target_ulong rmls =3D (env->spr[SPR_LPCR] & LPCR_RMLS) >> LPCR_RMLS_S=
HIFT;
>=20
>     return rma_sizes[rmls];
> }

Yeah, I guess that is a little neater.  I've made the change.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vbzKE9fGfpHIBC6T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5XRKoACgkQbDjKyiDZ
s5JFtg/+I47+BW5rKB0Q6gY/eIv9U1zuhwUN2cTgPVFxY5iET9X2AWA5/icJvK26
WyrhwSHadN37q3EzB77a2dQcFkJiQNnzW34ZBNyZCOV2nWE5ucRIDiVTIz5IZjj0
C7dhSiaR7nGmiR2jXDQcocANY1qHFLhPmE1/S2KRbycAThMjb0WuIPkHvoPtk8kt
Vqe9p+W8ULP3sc+fvzNrITKz8SGFIeNdjnolowtWOTtJ8E94J4ficAxPS7u2e08F
pvOqOytQ2YN3x9liflnxzEqKtlGW1yEIAuvGOZH1HJThGPyj14IPoeXcmRLwUyaa
8m/R6j9q5c6/5AL48KAIuoA/hlDjklUjZEYDwFCw60aXdp6MNZCv5KdwTrqvYcO5
vp4qIrvW+RjOkUjvmhyu0Fb3z4rEPVQ3+HszPLsb19GDbiBU6GwJp3P5anyKrDnm
bG2+MLs4wwmVBDs+dk4kldLesKKgiAYl61R/V3dSiGLzJ2Xs58N260ZGJUwCMJfc
eEaNXEQA4T2DoiW9yJUpdkx+p1UN1//LcFXWVYegMVy/R21p1xhmphIRZjDoAqA5
lbv8YNR5gxL84SljnWlMRiQrchsOeJzNMPDU8QmmAEfNmH5Ef+tzgmSUSo9mJu8z
G5p8p6IcMzIVWzYnyrMF/e1m8WHAe6n4WkZlFQfuRJkYQzDtRz0=
=DWyp
-----END PGP SIGNATURE-----

--vbzKE9fGfpHIBC6T--

