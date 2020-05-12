Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E93C54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 04:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 809E12098B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 04:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Kjy8BYNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809E12098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYMkZ-0006Bg-Ma
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 00:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jYMjn-0005UG-8j; Tue, 12 May 2020 00:41:51 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40233 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jYMjk-0000Z8-Co; Tue, 12 May 2020 00:41:50 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49LlWT4d14z9sSw; Tue, 12 May 2020 14:41:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1589258501;
 bh=6xk3mG1IlArMMGVReMjxkkXMhTt87S6aGM15FJy/3L0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Kjy8BYNY+kQfTSWfRtNZRHk9KRnvuN/lRGznri7pqkN9CgR2ISSTorbTyXswsIts0
 PU5Zl80ZvE3v1qV1avPfZYoQS2JEWftRVc2HIMExxROCWkSRnDKe4Up52qS9ceLOQa
 OTef52ROZ33oG1xeG6TQMXpCT7wWInW5HpzeK9oE=
Date: Tue, 12 May 2020 13:41:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Leonardo Bras <leobras.c@gmail.com>
Subject: Re: [RESEND PATCH v3 1/1] ppc/spapr: Add hotremovable flag on DIMM
 LMBs on drmem_v2
Message-ID: <20200512034109.GX2183@umbus.fritz.box>
References: <20200511200201.58537-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ahZICQ7iXVM/oLYH"
Content-Disposition: inline
In-Reply-To: <20200511200201.58537-1-leobras.c@gmail.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 23:34:36
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
Cc: Bharata B Rao <bharata.rao@in.ibm.com>,
 Bharata B Rao <bharata@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Leonardo Bras <leonardo@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ahZICQ7iXVM/oLYH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2020 at 05:02:02PM -0300, Leonardo Bras wrote:
> From: Leonardo Bras <leonardo@linux.ibm.com>
>=20
> On reboot, all memory that was previously added using object_add and
> device_add is placed in this DIMM area.
>=20
> The new SPAPR_LMB_FLAGS_HOTREMOVABLE flag helps Linux to put this memory =
in
> the correct memory zone, so no unmovable allocations are made there,
> allowing the object to be easily hot-removed by device_del and
> object_del.
>=20
> This new flag was accepted in Power Architecture documentation.
>=20
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> Reviewed-by: Bharata B Rao <bharata@linux.ibm.com>

Applied to ppc-for-5.1, thanks.

>=20
> ---
> Changes since v1:
> - Flag name changed from SPAPR_LMB_FLAGS_HOTPLUGGED to
> 	SPAPR_LMB_FLAGS_HOTREMOVABLE
> ---
>  hw/ppc/spapr.c         | 3 ++-
>  include/hw/ppc/spapr.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9a2bd501aa..fe662e297e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -446,7 +446,8 @@ static int spapr_dt_dynamic_memory_v2(SpaprMachineSta=
te *spapr, void *fdt,
>          g_assert(drc);
>          elem =3D spapr_get_drconf_cell(size / lmb_size, addr,
>                                       spapr_drc_index(drc), node,
> -                                     SPAPR_LMB_FLAGS_ASSIGNED);
> +                                     (SPAPR_LMB_FLAGS_ASSIGNED |
> +                                      SPAPR_LMB_FLAGS_HOTREMOVABLE);
>          QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
>          nr_entries++;
>          cur_addr =3D addr + size;
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 42d64a0368..93e0d43051 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -880,6 +880,7 @@ int spapr_rtc_import_offset(SpaprRtcState *rtc, int64=
_t legacy_offset);
>  #define SPAPR_LMB_FLAGS_ASSIGNED 0x00000008
>  #define SPAPR_LMB_FLAGS_DRC_INVALID 0x00000020
>  #define SPAPR_LMB_FLAGS_RESERVED 0x00000080
> +#define SPAPR_LMB_FLAGS_HOTREMOVABLE 0x00000100
> =20
>  void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ahZICQ7iXVM/oLYH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl66GtMACgkQbDjKyiDZ
s5I4iRAAgHcx0V1joEa5DMeI5VLxLX8fw+D/xTQEV6PNEn5U1jpF6EqcPD2OVCh3
61I4+MVHquzSADAPk+sB2Eik/4u2P7b35H0xSe0KbI6znvFYsm9pwlYijZn6U3qF
Gp86Xg55OdeMrGBGUP9ejmhHRHkooypx2c6sN+9TRyoYea3Vp3gipdvHSoVSzm4P
gUxTKH18zNLGSxMXYEynMWWi2xunsscRcxPcYH7H0fpjRBFVt6R3E1Dsdyq4GAiu
0KL68tEiNnnfOz66UeYgJfNFQ6eELKdBb6bzJHDdukXO+urpFc08V5KKE7Xa1U0h
GhfArBWwxVUuGEodBSguo3F7kQVKtT81cJXieB/mdNXL+Ypem1exZncHgyMYjXZ6
fGqVUWoWJM/8EklF4IYdwjOnBMkwxIOydAYwdQ02agzLxxbJbxwbVqpNGcwZo6hb
nfjzGsPdYHJzdf4HQ80j5U5SufsrYMJccbB/p1A8jByCGxVYAlgHF7JDGUmtcjOU
97ksIS+2uhdMuAC/Qrs6j/uZdthuIjzm0qFmPHkko8oayH+pW0aoqxKBAyLcO5KR
I79S8PGz/+m6XVCM7u47RuwWdH1GP0APtZQvDbPR6q5+VYJ6HwUXb/DiV2dgEic6
0t7fgZBa3BcSwY36hw20b3ppBO4PgbXjJK3N12bhmwFoH4UQEMw=
=U4bp
-----END PGP SIGNATURE-----

--ahZICQ7iXVM/oLYH--

