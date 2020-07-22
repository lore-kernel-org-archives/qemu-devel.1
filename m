Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F9DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 10:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7848F20656
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 10:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PdwdP4Ob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7848F20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyC5x-0006AS-Ph
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 06:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jyC57-0005d8-Ql
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 06:34:38 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:40203 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jyC55-0000j5-Fy
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 06:34:37 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BBWzh4WJRz9sSt; Wed, 22 Jul 2020 20:34:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595414064;
 bh=TJlTv8HxAQZhlCpSNziEro0u1Rfto/shKtNeqZQ8kaQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PdwdP4ObOYdnsc7QrtJyjZdJ2pwp1nICMSrGVeN2eHtrgnufzia3OSECufn3uJ4+u
 apw/bqNpnZSjZxhAWVqlq5Ramf6HOPdd3QOdk27lLvoCo+4CUi67AQINLXu0aD2YdG
 jRF0YThFLkrF+Y8u50eI1xG0rAjZk1zOlOTnPH7Y=
Date: Wed, 22 Jul 2020 20:33:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 2/4] error: Strip trailing '\n' from error string
 arguments (again)
Message-ID: <20200722103303.GC5513@umbus.fritz.box>
References: <20200722084048.1726105-1-armbru@redhat.com>
 <20200722084048.1726105-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline
In-Reply-To: <20200722084048.1726105-3-armbru@redhat.com>
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
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2020 at 10:40:46AM +0200, Markus Armbruster wrote:
> Tracked down with scripts/coccinelle/err-bad-newline.cocci.
>=20
> Cc: Peter Xu <peterx@redhat.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

ppc part
Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/i386/intel_iommu.c   | 6 +++---
>  target/ppc/mmu-hash64.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index c56398e991..8cd9ed8d3b 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2356,7 +2356,7 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState =
*s, VTDInvDesc *inv_desc)
>      if ((inv_desc->lo & VTD_INV_DESC_IOTLB_RSVD_LO) ||
>          (inv_desc->hi & VTD_INV_DESC_IOTLB_RSVD_HI)) {
>          error_report_once("%s: invalid iotlb inv desc: hi=3D0x%"PRIx64
> -                          ", lo=3D0x%"PRIx64" (reserved bits unzero)\n",
> +                          ", lo=3D0x%"PRIx64" (reserved bits unzero)",
>                            __func__, inv_desc->hi, inv_desc->lo);
>          return false;
>      }
> @@ -2377,7 +2377,7 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState =
*s, VTDInvDesc *inv_desc)
>          am =3D VTD_INV_DESC_IOTLB_AM(inv_desc->hi);
>          if (am > VTD_MAMV) {
>              error_report_once("%s: invalid iotlb inv desc: hi=3D0x%"PRIx=
64
> -                              ", lo=3D0x%"PRIx64" (am=3D%u > VTD_MAMV=3D=
%u)\n",
> +                              ", lo=3D0x%"PRIx64" (am=3D%u > VTD_MAMV=3D=
%u)",
>                                __func__, inv_desc->hi, inv_desc->lo,
>                                am, (unsigned)VTD_MAMV);
>              return false;
> @@ -2387,7 +2387,7 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState =
*s, VTDInvDesc *inv_desc)
> =20
>      default:
>          error_report_once("%s: invalid iotlb inv desc: hi=3D0x%"PRIx64
> -                          ", lo=3D0x%"PRIx64" (type mismatch: 0x%llx)\n",
> +                          ", lo=3D0x%"PRIx64" (type mismatch: 0x%llx)",
>                            __func__, inv_desc->hi, inv_desc->lo,
>                            inv_desc->lo & VTD_INV_DESC_IOTLB_G);
>          return false;
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index e5baabf0e1..c31d21e6a9 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -859,7 +859,7 @@ static int build_vrma_slbe(PowerPCCPU *cpu, ppc_slb_t=
 *slb)
>      }
> =20
>      error_report("Bad page size encoding in LPCR[VRMASD]; LPCR=3D0x"
> -                 TARGET_FMT_lx"\n", lpcr);
> +                 TARGET_FMT_lx, lpcr);
> =20
>      return -1;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8YFdwACgkQbDjKyiDZ
s5LgrA/+Ol6zQ36lPW5ZAgwX118cAn/wf8YydzxMSSYSRC7taaGC48ol+yKndafe
SS6XaYI+jx7kqm1mKCea2Ll4+4OiVz/p4U1hd1zVY8EwBzcvz0QenVcw34N5uVZh
9DMZrY+JDy2z+geO3Z7+t4mdhpRETXi1I6Wgp6jDAPoQZXq+rmszsmHYHO3s0ohX
k5u2tQ/gNL2fb79t53w+HBP2S2/zTuwV5awwTI6CPqM0KXscoqrVMjmVyTU/xH+1
5vEf8jH61RIToJX1re70IzNlTHV7U95zvq7Nspvh7738QTVna2+XN11l2o5E3l2J
C0Hcxst1MQgHNi9SUoqVi+5NPfXoV2OX/mgHsiUGgP7bpigKPm3LGMZTyLwO6RmQ
XrfSulDrxARlYoZVCCaB8hPGV2MnBXQYyDW2+3T4FH2MdAB4uIQLOjoII+02GNfd
j/JiCXl0GWCEnFw2Wz2GoRCEJ8J5p7Gysjf62gXJaOiqgIp9uw0x0myzSByc0V4b
VHVixFdhJe/9GTw4DVh8pVn27vJu2UgsvuWxK32re3PmmpGdmM1xKAlmppJy8G/t
Yf3k0my6fN8081IwAvAZcvWazER8aL+SdW7POJNyRtYJvOm3OXGxl57ugj+WFp2p
4m5eppKfBuqqOIL74prZs90G7nuQtLO/5fOGst6lSjfmONB7lf4=
=NXaY
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--

