Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266E4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 05:08:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7FA2075F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 05:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nJLrgRQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7FA2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd5Lu-0003sD-SN
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 01:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jd5LJ-00031o-DE; Mon, 25 May 2020 01:08:05 -0400
Received: from ozlabs.org ([203.11.71.1]:43925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jd5LH-00047f-H0; Mon, 25 May 2020 01:08:05 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49VlTk5wmcz9sSd; Mon, 25 May 2020 15:07:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1590383274;
 bh=OyrMB+ZgEs812hRtFwLa+CjTxebcLfWN8wvoEJkzqFo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nJLrgRQWCD2f//Vm58RzJVliR3HHobq6u01cOPVQSKZcMK8wGoAzTXpwnjzAlMzVQ
 /AKk5TerEFd61dP0/SSePWnCWV6Zic7h2+UlqgugzOU6SE4+zPAkpFadQVBeta/CcI
 kQCFExgSLqWsfA7+9Z+/JDU6YJdifargdrYibjJc=
Date: Mon, 25 May 2020 15:06:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Reza Arbab <arbab@linux.ibm.com>
Subject: Re: [PATCH v3] spapr: Add a new level of NUMA for GPUs
Message-ID: <20200525050607.GB23110@umbus.fritz.box>
References: <1590177213-4513-1-git-send-email-arbab@linux.ibm.com>
 <20200522200856.d26ilw5zcswoggj4@arbab-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
In-Reply-To: <20200522200856.d26ilw5zcswoggj4@arbab-vm>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:07:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Daniel Henrique Barboza <danielhb@linux.ibm.com>,
 Leonardo Augusto Guimaraes Garcia <lagarcia@linux.ibm.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2020 at 03:08:56PM -0500, Reza Arbab wrote:
> On Fri, May 22, 2020 at 02:53:33PM -0500, Reza Arbab wrote:
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -889,10 +889,16 @@ static int spapr_dt_rng(void *fdt)
> > static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
> > {
> >     MachineState *ms =3D MACHINE(spapr);
> > +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(ms);
> >     int rtas;
> >     GString *hypertas =3D g_string_sized_new(256);
> >     GString *qemu_hypertas =3D g_string_sized_new(256);
> > -    uint32_t refpoints[] =3D { cpu_to_be32(0x4), cpu_to_be32(0x4) };
> > +    uint32_t refpoints[] =3D {
> > +        cpu_to_be32(0x4),
> > +        cpu_to_be32(0x4),
> > +        cpu_to_be32(0x2),
> > +    };
> > +    uint32_t nr_refpoints =3D 3;
>=20
> Gah, I soon as I hit send I realize this should be
>=20
>     uint32_t nr_refpoints =3D ARRAY_SIZE(refpoints);
>=20
> Can you fixup or should I send a v4?

I had one other comment that needs addressing, so you might as well
send a v4.

>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7LUj4ACgkQbDjKyiDZ
s5KySg//SWWMGGKv8tdYl/dEdcigk8cBWA5U7hzSj8M3i/nC7DC4lU9MBOVihW9p
Kh6yngV9WortNYA0aO4xIIaTw7f85n9tPKxKv8gW15lPNPAuOAM9rqRDfrtLf9mP
AxxgI87Om4mbmoHNu7bpH5sxoELynB9wf8713axKhG4J9WNBHQN/eTZoKIyPQPb0
QhDe8NCA4+v2u+dybLbE+Whr9jf4pGHOVH63T3iMoTJcwDB7L92Yk2sWOVsgsfpk
j1aznEuhS24Uj3+y0fSbQjtbOAU16zjd4MQZl2LBRzZm7fKapcnHquVmkNOTBBRD
+aEnt3jE3tGh+eWvjay0Jqso/VyTMJStUBnkYcXWMEhLebpcovtxBtVAp1NcG1NJ
uZkEMu3/nGRgptOnbo3qd1UcBJxrIYON5ZEYGxA5pSGSHvfhfeWm3od+KXUz3v5M
1202xTzQxARobWQR1K9gedWMp1yZjvcRdD/KL2AfRTdjWJ44xSXBl7zYd0ZpW2x9
seAXk8x0fK04+t6QmF2sUohqZDFc2XNZquDbgZKa0l8f18Jo2v9J8A/QPhHMks2k
nywL8vqnT6k0LmPXjucbSzaozVL0Wd03r5+TkNdwAEa2lVRBtnmRKuEnOGKqlpnH
2NHcOdVQJM9++QLbWrmRC9TxiATRouw4sRjRIhQIPwGRmitBuVU=
=GwFS
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--

