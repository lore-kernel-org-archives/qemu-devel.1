Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC77BC433E6
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 11:26:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7E692063A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 11:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Fepi7GMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E692063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvfYn-00056n-0G
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 07:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jvfYC-0004bM-H2; Wed, 15 Jul 2020 07:26:12 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:50887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jvfY9-0005df-B1; Wed, 15 Jul 2020 07:26:12 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B6FSW16xYz9sV5; Wed, 15 Jul 2020 21:26:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594812363;
 bh=DjtzffX7SwWoJxcBavUlPZWSMO9+8NUFODl6FiBv5E0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Fepi7GMaZ5BxAskZG0vdccjDO26BRCMEBUFT9K6ADr7dWW8zREze44+juSdaRWnv4
 JGA53ktqm13mDbzNjOOaFF1sT7PnADpsryhfj3V9WwgHiwLcC4xUdxdnfNBCbUTzAh
 tr8z4fUXtRCVLD8l706hi+EWEDn5jXwlwsFLJnz0=
Date: Wed, 15 Jul 2020 20:38:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Blanchard <anton@ozlabs.org>
Subject: Re: [PATCH] ppc/spapr: Fix 32 bit logical memory block size
 assumptions
Message-ID: <20200715103815.GI93134@umbus.fritz.box>
References: <20200715004228.1262681-1-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DesjdUuHQDwS2t4N"
Content-Disposition: inline
In-Reply-To: <20200715004228.1262681-1-anton@ozlabs.org>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: aik@ozlabs.ru, nathanl@linux.ibm.com, qemu-ppc@nongnu.org, groug@kaod.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--DesjdUuHQDwS2t4N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2020 at 10:42:28AM +1000, Anton Blanchard wrote:
> When testing large LMB sizes (eg 4GB), I found a couple of places
> that assume they are 32bit in size.
>=20
> Signed-off-by: Anton Blanchard <anton@ozlabs.org>

Applied to ppc-for-5.2.

> ---
>  hw/ppc/spapr.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a1b06defe6..0ba2526215 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -558,7 +558,8 @@ static int spapr_dt_dynamic_reconfiguration_memory(Sp=
aprMachineState *spapr,
>      int nb_numa_nodes =3D machine->numa_state->num_nodes;
>      int ret, i, offset;
>      uint64_t lmb_size =3D SPAPR_MEMORY_BLOCK_SIZE;
> -    uint32_t prop_lmb_size[] =3D {0, cpu_to_be32(lmb_size)};
> +    uint32_t prop_lmb_size[] =3D {cpu_to_be32(lmb_size >> 32),
> +                                cpu_to_be32(lmb_size & 0xffffffff)};
>      uint32_t *int_buf, *cur_index, buf_len;
>      int nr_nodes =3D nb_numa_nodes ? nb_numa_nodes : 1;
>      MemoryDeviceInfoList *dimms =3D NULL;
> @@ -899,7 +900,8 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, v=
oid *fdt)
>      uint32_t lrdr_capacity[] =3D {
>          cpu_to_be32(max_device_addr >> 32),
>          cpu_to_be32(max_device_addr & 0xffffffff),
> -        0, cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE),
> +        cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE >> 32),
> +        cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE & 0xffffffff),
>          cpu_to_be32(ms->smp.max_cpus / ms->smp.threads),
>      };
>      uint32_t maxdomain =3D cpu_to_be32(spapr->gpu_numa_id > 1 ? 1 : 0);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DesjdUuHQDwS2t4N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8O3JQACgkQbDjKyiDZ
s5LPixAAuoG58OXpCY3zBZjzovtrBq7fRtlll1eoaKaSq5AdxOUXxxkwtfvkvtgc
fCE9lQ5KCcfWiMun0hs0h1lbGNY08PNjA10Xc064CV0R2eG6kZF87JD374xz077j
4WwdW1dy71HoNzxbCsY/86EEO6Ey/klz03peHaoPN9a/lXEdEusYtl29DdHHjy3W
O3E/RClJDs0RPRyXfBR0byaG55ALdGkEmfkbGHFKda70W8Z0K7CHl3eKowoBLLNv
/gs1Iidggif3azyXXl4OsiLa59FxfpY/WqSQN/Nk55Eh9UB4XqadgSZqHOs12Q6E
JY3Ks7xhsE2EVlXRqaMYuJD8LsL2AeiEY8W2pMIJmtW2aEjwF9UqMmkJbOaNQzAm
xDGkQ1ywW6eRckDXDdQhe7CaC1uhbpzczKaYol5AGUj1ajfy8yLR99Nc6U5/e6IT
m4gwttOByd6KPZ25BQBMOqco5X+l7VMbfppvTGt+NBTWB6ivT5v3Z7W+DOtch8Xz
4559aDPykCjOrG7hGzH84+UPJt5LcVHhy5OBYy6YmneF8FFknecTkEakfkdgGu6d
8dqZ1geswEQAWIny0Gzn6yrdug1/GG1WpXZT24K0VqTDSYD+SzjFi7ty3VIqC4Tt
8hEv0vplBMUILtBD3lDBK0aw/4EYmNapYP9A3d9MydKJ1KW54QU=
=BYiz
-----END PGP SIGNATURE-----

--DesjdUuHQDwS2t4N--

