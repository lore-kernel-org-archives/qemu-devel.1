Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE9DC33C99
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 02:06:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49E5120692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 02:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZT7uS/Qx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E5120692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip0k7-0004Wv-Tl
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 21:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip0ie-0002dC-AG
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 21:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip0ic-0007gE-VC
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 21:05:12 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:45097 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ip0ic-0007er-A6; Tue, 07 Jan 2020 21:05:10 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47ssyV2Dpjz9sP6; Wed,  8 Jan 2020 13:05:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578449106;
 bh=DmMS/4+MWqhgQbtFx7WWFE2qbNMnHLtZSsiPfKWcSGg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZT7uS/Qx2aLJk6jSchULTjN2HeNgMe28Cqm2tSGmy5pQx3tKS4VMW9XlIBjM6YY9+
 R7d/7zmQJOseWtE2o6Nf9mGux5zPJZvPBD2yGqozqFbLlJb5DaISeoOXr1ZTJcmJ5K
 3yQINlDmVKbsa4VG9y5FFHlub/wXvsxMgHt3vezY=
Date: Wed, 8 Jan 2020 12:06:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 09/10] target/ppc: Correct RMLS table
Message-ID: <20200108010604.GI2137@umbus.fritz.box>
References: <20200107044827.471355-1-david@gibson.dropbear.id.au>
 <20200107044827.471355-10-david@gibson.dropbear.id.au>
 <b4f4b0f9-759d-637d-9b40-d0fd3c0c21f6@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VkqCAaSJIySsbD6j"
Content-Disposition: inline
In-Reply-To: <b4f4b0f9-759d-637d-9b40-d0fd3c0c21f6@kaod.org>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 groug@kaod.org, qemu-ppc@nongnu.org, paulus@samba.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--VkqCAaSJIySsbD6j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 03:21:42PM +0100, C=E9dric Le Goater wrote:
> On 1/7/20 5:48 AM, David Gibson wrote:
> > The table of RMA limits based on the LPCR[RMLS] field is slightly wrong.
> > We're missing the RMLS =3D=3D 0 =3D> 256 GiB RMA option, which is avail=
able on
> > POWER8, so add that.
>=20
> Where is this defined ?

It's in the Book4, so not easily available, unfortunately :(.

> > The comment that goes with the table is much more wrong.  We *don't* fi=
lter
> > invalid RMLS values when writing the LPCR, and there's not really a
> > sensible way to do so.  Furthermore, while in theory the set of RMLS va=
lues
> > is implementation dependent, it seems in practice the same set has been
> > available since around POWER4+ up until POWER8, the last model which
> > supports RMLS at all.  So, correct that as well.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  target/ppc/mmu-hash64.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > index bb9ebeaf48..e6f24be93e 100644
> > --- a/target/ppc/mmu-hash64.c
> > +++ b/target/ppc/mmu-hash64.c
> > @@ -760,12 +760,12 @@ static target_ulong rmls_limit(PowerPCCPU *cpu)
> >  {
> >      CPUPPCState *env =3D &cpu->env;
> >      /*
> > -     * This is the full 4 bits encoding of POWER8. Previous
> > -     * CPUs only support a subset of these but the filtering
> > -     * is done when writing LPCR
> > +     * In theory the meanings of RMLS values are implementation
> > +     * dependent.  In practice, this seems to have been the set from
> > +     * POWER4+..POWER8, and RMLS is no longer supported in POWER9.
> >       */
> >      const target_ulong rma_sizes[] =3D {
> > -        [0] =3D 0,
> > +        [0] =3D 256 * GiB,
> >          [1] =3D 16 * GiB,
> >          [2] =3D 1 * GiB,
> >          [3] =3D 64 * MiB,
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VkqCAaSJIySsbD6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4VKvwACgkQbDjKyiDZ
s5JQxA/+LI6wK0mezttiQuuoVA2eDN3yFiG9TuvE68jraz0ameeYfknfZ+i2qcEJ
BoHWc0KzLf9uFgUirvZ/8KgKFxsbkCG/e4i5SWgpKJI7MUGIFGEjZ4bcO0kaa8xt
dyPfrXbAc0RkOMieNZQQ5T6N/58dg8OuWP1oLFvJoI9UD5OtYcgtN7I9q462jgrB
IknRvyjprfsHCTXvORH+eCVtLoC+WxbbLHdxAEnxNBq0Kdh/rdfTYIMthSvjB72d
Zg5viulaIfRhYvNdW56HLx9mG3yHUxNp3i3j4au8xo6ewDSHh3QTy5t749ajQ5sz
a97h310DkZ5ZuhxURU7IfpV5faeKjJyrjgebBfgkqQ4m/4Vanzway+gTx3cmHlQr
tM3H+AVvbDyBwXTx4hoW7spMysKV7+L2OqsS56FrD5Bw5weLUty7VT62KfahpIzs
6j4Rd0Txffv+p7+1Cpf/zPan5nqmsYVqsRqGB1+lBC/2NWSVPIRkplTxfTa1JJz2
itsALSOUneBCsLIRGckOgHCiznl7IRK32OOl+RHd88SUYP/6ds1zuH61XlZ48Ldp
2FutiMC9tmUtNI1IZmM8AxuOsNSYJBHhhK312hhwMHejXIP91gp+/dWNXr1Wz4JJ
Bq4c1r7DJ8XR/sTXRMbb0hTmDJRlX8jhvFu0Hjq8zeISgd2jHlY=
=jix6
-----END PGP SIGNATURE-----

--VkqCAaSJIySsbD6j--

