Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38448C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 22:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F36982072E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 22:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="S7PWwVsa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36982072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK8iT-00078W-4E
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 18:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jK8hf-0006Zl-6y
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jK8hd-0003C0-KP
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:52:50 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46561 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jK8hb-0002vg-9v; Thu, 02 Apr 2020 18:52:49 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48tdcp5b0hz9sSJ; Fri,  3 Apr 2020 09:52:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585867962;
 bh=D/pIqfMYJZ9PtLyp+peMCTOb4nURRi0jaXcgzAviOuM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S7PWwVsa0mQPuBut9RqFVYB73oZiVE8St8V9kZNZdn8J9w1FQ0Pg5F/chUT7rAow8
 FX8lfB8iqirnVZ2ARAX81yPLTj52Dj28QZgLB5F4R8x2jYa0/2o0lShKryW9BIAHnJ
 QleH+sgST16aKncpIEjtc+OiJLktpRi/QUbrPix8=
Date: Fri, 3 Apr 2020 09:49:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Leonardo Bras <leonardo@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] ppc/spapr: Add hotremovable flag on DIMM LMBs on
 drmem_v2
Message-ID: <20200402224925.GN47772@umbus.fritz.box>
References: <20200402172339.622720-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hNG1vEeyG8BCaHbQ"
Content-Disposition: inline
In-Reply-To: <20200402172339.622720-1-leonardo@linux.ibm.com>
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
Cc: Bharata B Rao <bharata.rao@in.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--hNG1vEeyG8BCaHbQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2020 at 02:23:40PM -0300, Leonardo Bras wrote:
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
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> Reviewed-by: Bharata B Rao <bharata@linux.ibm.com>

The change looks reasonable.  Is there a PAPR RFC I can see describing
the new bit, though?

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

--hNG1vEeyG8BCaHbQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6Ga/IACgkQbDjKyiDZ
s5I9ug/+JxNTTMdw/Qpir47eKNDf/QmJPiqBKtGufk/xw+x1w63doYnpYIZpohj3
Y1G6E2eUWP0lHuUWmSvLwrP6Qh7e95F3vrKNlZA0xfMU4j2xp2oLM+n3usFNaKfd
7rRfXA+G4fBN7wZBeRQjF5m0klHsgLgzg2hI/L90diMcuz4DYZWoxBFLWJ1ky9Uy
48DoQ2POZJqBy/5nHA1ebvluQpeBvjnjOH2ICzDvAnNWoTNDXx9B3xxdxm0sEgB3
zis8WVA1PQdiKn6gG/wyKvnhlL4sScdpqOWlmQxsOG/SYvm2II4Yef4MVzs8ke/l
KKq+ZBoaIntgtl2NaA4hXp9eDL97DxLijVcyUAyH6uJrhJdGWwSNfvaIWGMA7dTz
Xk88kJiY2UtloWwvpHux9bbsYGTUtDYFR/qh1UXP0QJNfyQq50fkD4Kf5JSZylqG
QePtgu/edC/NITMp2mgDGeshGLXR+bir4LpEA/BVJEilv6ttTNngwbt1vX8o8BVM
QDvY+YExs2PxIYVfVcreStcclhTB/QDFomop/brqvqHpvxeD/7tvEiUlg7Tvx7kA
U08WqNAwOSahu63qTiz+OPVmrgkonT9uhjqgqQZHbWeq63qG1KkzXfa9iJxkviQ7
G3zHhI01zqh+cBrEjXzLp3vuMtR0IEmfuQxOsQTzG2qov0bfW1k=
=flO2
-----END PGP SIGNATURE-----

--hNG1vEeyG8BCaHbQ--

