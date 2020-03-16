Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BADAC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 23:11:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD3C20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 23:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gcl8Xa8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD3C20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDytN-0006P4-2g
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 19:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jDys6-0004c3-7w
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 19:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jDys4-0003y7-N8
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 19:10:10 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49207 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jDys3-0003Tu-Qf; Mon, 16 Mar 2020 19:10:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hBph5qBmz9sPR; Tue, 17 Mar 2020 10:10:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584400204;
 bh=mKyrRkGmD5er8pxeIUVrebzFtL6es3/pf0OAc8+6f9g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gcl8Xa8wh9dAmd7OoysHmc/sRyAkBUAWz+3FppifPQ3VwhvDzHfiDIZdUTsc3whBP
 wkbKR4qRPLJGkT+j4tC0QOwH/F46Fbr5w0rvFAXKP7AjLdopxQDX3BGDm9f9avMsXW
 8c5692ftvbJiBrSBE91SZON94jOzNaV7XOhLQS7M=
Date: Tue, 17 Mar 2020 09:41:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH qemu] spapr/rtas: Reserve space for RTAS blob and log
Message-ID: <20200316224150.GN2013@umbus.fritz.box>
References: <20200316011841.99970-1-aik@ozlabs.ru>
 <20200316171056.0389b72c@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FX+Db2fp7WJhXKrW"
Content-Disposition: inline
In-Reply-To: <20200316171056.0389b72c@bahia.lan>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--FX+Db2fp7WJhXKrW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2020 at 05:10:56PM +0100, Greg Kurz wrote:
> On Mon, 16 Mar 2020 12:18:41 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
> > At the moment SLOF reserves space for RTAS and instantiates the RTAS bl=
ob
> > which is 20 bytes binary blob calling an hypercall. The rest of the RTAS
> > area is a log which SLOF has no idea about but QEMU does.
> >=20
> > This moves RTAS sizing to QEMU and this overrides the size from SLOF.
> > The only remaining problem is that SLOF copies the number of bytes it
> > reserved (2KB for now) so QEMU needs to reserve at least this much;
> > SLOF will be fixed separately to check that rtas-size from QEMU is
> > enough for those 20 bytes the H_RTAS hcall.
>=20
> 20 bytes >for< the H_RTAS hcall ?

Adjusted in my tree, thanks.

>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> >=20
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> >  include/hw/ppc/spapr.h | 1 +
> >  hw/ppc/spapr.c         | 1 +
> >  2 files changed, 2 insertions(+)
> >=20
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index 2015e37ac5c8..35b489a54929 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -736,6 +736,7 @@ void spapr_load_rtas(SpaprMachineState *spapr, void=
 *fdt, hwaddr addr);
> >  #define SPAPR_IS_PCI_LIOBN(liobn)   (!!((liobn) & 0x80000000))
> >  #define SPAPR_PCI_DMA_WINDOW_NUM(liobn) ((liobn) & 0xff)
> > =20
> > +#define RTAS_SIZE               2048
> >  #define RTAS_ERROR_LOG_MAX      2048
> > =20
> >  /* Offset from rtas-base where error log is placed */
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 64bc8b83e91e..d3db3ec56e9c 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -967,6 +967,7 @@ static void spapr_dt_rtas(SpaprMachineState *spapr,=
 void *fdt)
> >      _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
> >                       maxdomains, sizeof(maxdomains)));
> > =20
> > +    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size", RTAS_SIZE));
> >      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-error-log-max",
> >                            RTAS_ERROR_LOG_MAX));
> >      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-event-scan-rate",
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FX+Db2fp7WJhXKrW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5wAK4ACgkQbDjKyiDZ
s5K0ig//W6+CmDElq/v65Eup018XWpqdGoSlJfpC9qYkODQ41BNkJczt08oxlz/3
grsshmh1eKZarSJRZ5m9QUkABf13TvIUUdbTirRAwlSZY/H0fYJazsAOUuaiUWJn
ZMGZXvIbttc2+gYc8v7V/2Ge5PDBiNZWauIK4RwAnifH+x7rLnQx84oH5KoLqvv1
I2BmCuRanljxDT3pRD+PAkkwLsQpyTvCLOfDgc9gAUWkmpNHJI9kreIUMlVBxchS
VUJto5C8cv2/R5yjzEzL8jX1AE63RnRdigDJl/PItvpN+QsJYtM6cRZ5Lgp3A1wl
gbfbxRtDyvAvvjB8Ql9SyoT7e54nvgzd2CLY3K99i7Tn/JEUSDAviSb70tg2Ioi1
DlzLse1gCYZIHsEeUCOf469wOyQ7wUXok/5ZXWnBwfQ9yG+cemQDq39oLQ3cQqPd
EWE9Vq1k1yMhLpitQ4DOcqgmJBH/w4hS7kotkU0mqkozL3CBlYgLyVuHLqM07nmv
thanvYnA3/9c+uTIiFhC/CAXdXGiv9m1izgS5neiMFv2EPvb/W4s20xKvfQLE43P
q9uUuFiRXTP6Qtl2WAu+fBGN2Pmzp4P43JVsp3BLk0ff2qs7XubFLrgIkhKknAqJ
DYK/aljRIMd9hG9QMA3nqJ9T4o4f/HxSKDoo+iC8PaiE98Bw8sQ=
=JBFf
-----END PGP SIGNATURE-----

--FX+Db2fp7WJhXKrW--

