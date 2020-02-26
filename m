Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5237C4BA09
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 01:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 938CE20658
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 01:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XM+dSgBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938CE20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6lUy-0006WZ-Pk
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 20:28:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j6lTy-0005WK-Ql
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 20:27:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j6lTx-0001TF-E0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 20:27:26 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:34937 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j6lTw-0001Bg-Mt; Tue, 25 Feb 2020 20:27:25 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48RypB0DfXz9sPK; Wed, 26 Feb 2020 12:27:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582680434;
 bh=7nPgSTTplJRFOptXYJdlFI5AFvWGj0UR5dD8KvDcH1E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XM+dSgBsXSRmgYRpyMPSvik506aFVu0VKqv/fPEyVYpxRow9aANbh5Pfn0cpXO+g5
 zq+3qm0cHZqml5hIZ9DhCPzV/oaLrF+E+wYgfKzVOuhmTB2J+9JB0D2hcNPMkLF5/V
 W/9kj+/S23sohsrBwzSMn/b95/ryrE0dT/DyO0Hs=
Date: Wed, 26 Feb 2020 12:04:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v6 09/18] target/ppc: Streamline calculation of RMA limit
 from LPCR[RMLS]
Message-ID: <20200226010413.GH41629@umbus.fritz.box>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
 <20200224233724.46415-10-david@gibson.dropbear.id.au>
 <20200225180531.6551ce59@bahia.home>
 <20200225234725.22f268f1@bahia.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bygAmIonOAIqBxQB"
Content-Disposition: inline
In-Reply-To: <20200225234725.22f268f1@bahia.home>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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


--bygAmIonOAIqBxQB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2020 at 11:47:25PM +0100, Greg Kurz wrote:
> On Tue, 25 Feb 2020 18:05:31 +0100
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Tue, 25 Feb 2020 10:37:15 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > Currently we use a big switch statement in ppc_hash64_update_rmls() t=
o work
> > > out what the right RMA limit is based on the LPCR[RMLS] field.  There=
's no
> > > formula for this - it's just an arbitrary mapping defined by the exis=
ting
> > > CPU implementations - but we can make it a bit more readable by using=
 a
> > > lookup table rather than a switch.  In addition we can use the MiB/GiB
> > > symbols to make it a bit clearer.
> > >=20
> > > While there we add a bit of clarity and rationale to the comment about
> > > what happens if the LPCR[RMLS] doesn't contain a valid value.
> > >=20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
> > > ---
> > >  target/ppc/mmu-hash64.c | 71 ++++++++++++++++++++-------------------=
--
> > >  1 file changed, 35 insertions(+), 36 deletions(-)
> > >=20
> > > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > > index 0ef330a614..4f082d775d 100644
> > > --- a/target/ppc/mmu-hash64.c
> > > +++ b/target/ppc/mmu-hash64.c
> > > @@ -18,6 +18,7 @@
> > >   * License along with this library; if not, see <http://www.gnu.org/=
licenses/>.
> > >   */
> > >  #include "qemu/osdep.h"
> > > +#include "qemu/units.h"
> > >  #include "cpu.h"
> > >  #include "exec/exec-all.h"
> > >  #include "exec/helper-proto.h"This tool was originally developed to =
fix Linux CPU throttling issues affecting Lenovo T480 / T480s / X1C6 as des=
cribed here.
> > > @@ -757,6 +758,39 @@ static void ppc_hash64_set_c(PowerPCCPU *cpu, hw=
addr ptex, uint64_t pte1)
> > >      stb_phys(CPU(cpu)->as, base + offset, (pte1 & 0xff) | 0x80);
> > >  }
> > > =20
> > > +static target_ulong rmls_limit(PowerPCCPU *cpu)
> > > +{
> > > +    CPUPPCState *env =3D &cpu->env;
> > > +    /*
> > > +     * This is the full 4 bits encoding of POWER8. Previous
> > > +     * CPUs only support a subset of these but the filtering
> > > +     * is done when writing LPCR
> > > +     */
> > > +    const target_ulong rma_sizes[] =3D {
> > > +        [0] =3D 0,
> > > +        [1] =3D 16 * GiB,
> > > +        [2] =3D 1 * GiB,
> > > +        [3] =3D 64 * MiB,
> > > +        [4] =3D 256 * MiB,
> > > +        [5] =3D 0,
> > > +        [6] =3D 0,
> > > +        [7] =3D 128 * MiB,
> > > +        [8] =3D 32 * MiB,
> > > +    };
> > > +    target_ulong rmls =3D (env->spr[SPR_LPCR] & LPCR_RMLS) >> LPCR_R=
MLS_SHIFT;
> > > +
> > > +    if (rmls < ARRAY_SIZE(rma_sizes)) {
> >=20
> > This condition is always true since the RMLS field is 4-bit long...=20
>=20
> Oops my mistake, I was already thinking about the suggestion I have
> for something that was puzzling me. See below.
>=20
> > I guess you want to check that RMLS encodes a valid RMA size instead.
> >=20
> >     if (rma_sizes[rmls]) {
> >=20
> > > +        return rma_sizes[rmls];
> > > +    } else {
> > > +        /*
> > > +         * Bad value, so the OS has shot itself in the foot.  Return=
 a
> > > +         * 0-sized RMA which we expect to trigger an immediate DSI or
> > > +         * ISI
> > > +         */
>=20
> It seems a bit weird to differentiate the case where the value is bad
> because it happens to be bigger than the highest supported one, compared
> to values that are declared bad in rma_sizes[], like 0, 5 or 6. They're
> all basically the same case of values not used to encode a valid
> size...

Right, but the result is the same either way - the function returns
0.  This is basically just a small space optimization.

>=20
> What about :
>=20
>     static const target_ulong rma_sizes[16] =3D {
>         [1] =3D 16 * GiB,
>         [2] =3D 1 * GiB,
>         [3] =3D 64 * MiB,
>         [4] =3D 256 * MiB,
>         [7] =3D 128 * MiB,
>         [8] =3D 32 * MiB,
>     };

Eh, I guess?  I don't see much to pick between them.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bygAmIonOAIqBxQB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5VxA0ACgkQbDjKyiDZ
s5LPdRAAklPOjEtGgnFX8AX44SyJa/0QCgJBc7m8/2M2iUIkQSwzekihuMzZ6dfr
LCnncxX5zhzV+EyEB9lRVcnNpo072Izuql+FxLrlRe+kG2Xat1avwvsRU3GEwew+
baFoG0xX9aquhl0Jyi6EDObaFI4S/ZTP5buqZfTm88RTxtHCniJqCQXe6zRPHL9G
u5vR/SKYikOF9OdoWHmdOVX0gtJL1BOZOTZ9G3UHcypy5TPuhwUp305B+5u+LOui
c6gs7ueJRKqJYlL6Ah6GJ22jz2NtUz7fzhPg8Js7EaNmV2/ss/Bmqewu+kdAqLrp
vHFSmCtpK/GhyO4BT+m1yRV7q0SC77hDPB+JcNliFLKhvbKvSqeyAYfWrYJe9TOc
1PSjCGut8K0dWueX4xvuAMMG28OB2DR3lv/Bwd0Ra1nIeQ4hlhIBVZuSVNkTP4y6
1tipbOcEIeU1JousFDcVzE2bRc/1yQQ48j3fckp3yQFBYsbA+dKU52aWfnoSDJx5
c+3nF/MNnOB7ePVY7TWKyzeLr2vq9EYd6pS8z48qFNxX7od/NPdEaDOLg5683EW4
XC7gOYDcP6rBjeWMSuKg88xzwbzmhgbTka4fLzZ/JXgsrW3TJlFzOjLTfjnZrOA9
wpViwBZzvlAYEIeCnj2SsVdCd0On7zKk220OgsqtLsVQyyZy4Yg=
=cEql
-----END PGP SIGNATURE-----

--bygAmIonOAIqBxQB--

