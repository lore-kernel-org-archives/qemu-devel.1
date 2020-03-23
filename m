Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C5BC1975A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 03:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E53720724
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 03:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eEmu59gz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E53720724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGDio-0006PZ-O8
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 23:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jGDiB-0005ve-Kc
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 23:25:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jGDiA-0008Q4-BQ
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 23:25:11 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:49333)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jGDi9-0008MR-Uk; Sun, 22 Mar 2020 23:25:10 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48m0BB3ZtRz9sR4; Mon, 23 Mar 2020 14:25:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584933906;
 bh=XRiDcKEBSkBHxUm6z/dqkmgzA7/Pr2EaS/CQEEayEX4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eEmu59gzwDfRxGAXLl2U8GmtrVQcPMmRZMgjQnfoJpqZjBIiz4K5TMD1AiMxexgVJ
 DQwdkAnVZyvNnhCR1QjRUwtYSCQZT5tortENzvaI11GAwX6IgrfqviGAiWatZZsGGj
 y3l5RioqDbl8nB2IgfLpQC8Z6FCRelj9hDh75BHw=
Date: Mon, 23 Mar 2020 14:24:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Leonardo Bras <leonardo@linux.ibm.com>
Subject: Re: [PATCH 1/1] spapr/rtas: Add MinMem to ibm,get-system-parameter
 RTAS call
Message-ID: <20200323032457.GE2213@umbus.fritz.box>
References: <20200321003921.434620-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+SfteS7bOf3dGlBC"
Content-Disposition: inline
In-Reply-To: <20200321003921.434620-1-leonardo@linux.ibm.com>
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
Cc: ricardom@linux.ibm.com, danielhb@linux.ibm.com, lagarcia@linux.ibm.com,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--+SfteS7bOf3dGlBC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2020 at 09:39:22PM -0300, Leonardo Bras wrote:
> Add support for MinMem SPLPAR Characteristic on emulated
> RTAS call ibm,get-system-parameter.
>=20
> MinMem represents Minimum Memory, that is described in LOPAPR as:
> The minimum amount of main store that is needed to power on the
> partition. Minimum memory is expressed in MB of storage.

Where exactly does LoPAPR say that?  The version I'm looking at
doesn't describe MinMem all that clearly, other than to say it must be
<=3D DesMem, which currently has the same value here.

> This  provides a way for the OS to discern hotplugged LMBs and
> LMBs that have started with the VM, allowing it to better provide
> a way for memory hot-removal.

This seems a bit dubious.  Surely we should have this information from
the dynamic-reconfiguration-memory stuff already?  Trying to discern
this from purely a number seems very fragile - wouldn't that mean
making assumptions about how qemu / the host is laying out it's fixed
and dynamic memory which might not be justified?


>=20
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
>  hw/ppc/spapr_rtas.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 9fb8c8632a..0f3fbca7af 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -276,10 +276,12 @@ static void rtas_ibm_get_system_parameter(PowerPCCP=
U *cpu,
> =20
>      switch (parameter) {
>      case RTAS_SYSPARM_SPLPAR_CHARACTERISTICS: {
> -        char *param_val =3D g_strdup_printf("MaxEntCap=3D%d,"
> +        char *param_val =3D g_strdup_printf("MinMem=3D%" PRIu64 ","
> +                                          "MaxEntCap=3D%d,"
>                                            "DesMem=3D%" PRIu64 ","
>                                            "DesProcs=3D%d,"
>                                            "MaxPlatProcs=3D%d",
> +                                          ms->ram_size / MiB,
>                                            ms->smp.max_cpus,
>                                            ms->ram_size / MiB,
>                                            ms->smp.cpus,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+SfteS7bOf3dGlBC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl54LAkACgkQbDjKyiDZ
s5Kjow/+N72RuzfgXBoRgvGjIZ5yhmSTze+RxlbKxV2x32e/wROq3D4m5npLkKh2
tpuhOQdlpT8KNOCdSr0Nru68z+0z0K4hLglg6qtVxf8LWvTO6j+H4clQNXu113Pw
WFIY0RcHMEyR+RWmjqrWYTaE+DXYPeBJYvGhmu0VAkdRf0aEXEWDgS3TRFHwrFFe
ck4o1NbhfRh6DA8j13SsBOxnn2GIf82KoUDdS3TnIJcon/x38XoEhrTNL0OLFyCK
xYC05e8wx+ijq6jPcNJTq4xdnpHlMEowBUMLMhVfU4fdLvni4g0CHZRQgRdZuhDf
li6IrCIAZXLwj4q632pP5w9jnjonaoat5Rn4XNfl+X3bNnxiwFvmg2Rztbf8Q6CI
lVKcHeCmsskwWyzf+dxeJ7qyv6Fyf6ojIw+1aG8iAJJPDSD86d41erF6sAGpzMMZ
W220LKF7JjEBTxHShggJWYQSLMh0elQMJLiMbPMqq8tiO1zNfgI1/4LnwwsIo92h
/NRwWRyT37zKULnm+KcNSKEkX238vNbh/7K9xaW+tpY1nNfdP5zMVROhXYa5FJLn
LcFT5sojNoM9buqElsOUZDzqtofN1MfyrfiKftA31/A2Dm02XjpRtXOHdvRVi8yj
Jv51P/puxDkI4vr9bl8dcUy5kd9fyT1tjEEt3LSqnsOfAiGlung=
=VjWI
-----END PGP SIGNATURE-----

--+SfteS7bOf3dGlBC--

