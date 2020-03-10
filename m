Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5D2C10F25
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 02:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE4E2467D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 02:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="l4pqsMbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE4E2467D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBV3m-0005JP-JX
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 22:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jBV2Y-0003ra-98
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 22:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jBV2X-0003Ft-12
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 22:54:42 -0400
Received: from ozlabs.org ([203.11.71.1]:48495)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jBV2W-0003EE-Ld; Mon, 09 Mar 2020 22:54:40 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48c06g2nSMz9sRN; Tue, 10 Mar 2020 13:54:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1583808859;
 bh=eufysI/sMpM+VDDRDDMmxO7XK+LfwitqdkUwlbY0Tjs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l4pqsMbcyk+OrJDTqEp/yAmsk/6FsUR2MQAZqkE1Q/Hu7GDt3QG+HfxuhcCbvr9WY
 9M5rw92zozs/4K/P2RntlXbT2y0Amq2+2j2DvGUckLzfRgbBbWv7aB/3Q9N8UxlD2F
 FgAVqCrtEy6dleGl9TnX9iwsnhSxznc9IE3KtnP0=
Date: Tue, 10 Mar 2020 13:39:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Leonardo Bras <leonardo@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] ppc/spapr: Add hotplugged flag on DIMM LMBs on
 drmem_v2
Message-ID: <20200310023943.GH660117@umbus.fritz.box>
References: <20200306002202.176732-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WIIRZ1HQ6FgrlPgb"
Content-Disposition: inline
In-Reply-To: <20200306002202.176732-1-leonardo@linux.ibm.com>
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
Cc: bharata.rao@in.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--WIIRZ1HQ6FgrlPgb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2020 at 09:22:02PM -0300, Leonardo Bras wrote:
> On reboot, all memory that was previously added using object_add and
> device_add is placed in this DIMM area.
>=20
> The new SPAPR_LMB_FLAGS_HOTPLUGGED flag helps Linux to put this memory in
> the correct memory zone, so no unmovable allocations are made there,
> allowing the object to be easily hot-removed by device_del and
> object_del.
>=20
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
>=20
> ---
> The new flag was already proposed on Power Architecture documentation,
> and it's waiting for approval.
>=20
> I would like to get your comments on this change, but it's still not
> ready for being merged.

This looks reasonable to me - at the very least it doesn't look like
it could do much harm.

>=20
> Matching Linux change is here:
> http://patchwork.ozlabs.org/patch/1249917/
> ---
>  hw/ppc/spapr.c         | 3 ++-
>  include/hw/ppc/spapr.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index cc10798be4..01611b7953 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -699,7 +699,8 @@ static int spapr_populate_drmem_v2(SpaprMachineState =
*spapr, void *fdt,
>          g_assert(drc);
>          elem =3D spapr_get_drconf_cell(size / lmb_size, addr,
>                                       spapr_drc_index(drc), node,
> -                                     SPAPR_LMB_FLAGS_ASSIGNED);
> +                                     (SPAPR_LMB_FLAGS_ASSIGNED |
> +                                      SPAPR_LMB_FLAGS_HOTPLUGGED);
>          QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
>          nr_entries++;
>          cur_addr =3D addr + size;
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 09110961a5..64a138d4d4 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -870,6 +870,7 @@ int spapr_rtc_import_offset(SpaprRtcState *rtc, int64=
_t legacy_offset);
>  #define SPAPR_LMB_FLAGS_ASSIGNED 0x00000008
>  #define SPAPR_LMB_FLAGS_DRC_INVALID 0x00000020
>  #define SPAPR_LMB_FLAGS_RESERVED 0x00000080
> +#define SPAPR_LMB_FLAGS_HOTPLUGGED 0x00000100
> =20
>  void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WIIRZ1HQ6FgrlPgb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5m/e8ACgkQbDjKyiDZ
s5Isww/+OHPVhVoZb5Z3iGLrJ9CCd/bgAnRk+sJZ15YAV8oh953h7ZIC0umXtCIz
nQVSuhhYkH20u65BBeW6xP4oYaMsKCN+5uemJYfHeOnxxM5WbWMOzyH45UGEA5yS
sEKowPfgkO8tf43vkp32HkJZVp+pppIzgS/3GPNDDPNG/cOrWfwyXC0MNjJ85rNm
UzlZ+UUtBlILeTbVszX/dmO2JZk0ggG4CLzDGuVBTe+ZsHBbjlTmYwZxhrD9WcN9
sAg2sce70IzwlvkCRZN/eSfLtB+S+vJ3ptOThs1tgKzhmpsSCPQ4hL3/9kw0fxxC
D4WN+pHVIuZtEtWYYNOFZ9dIvOFkC81vczvfiBRiKVYsPpF+4vfJgA4oNCQOPdko
ord+MIVCOlYIhKZoPWZcROutLEAoQoFU0vC1ADen5zaQKmVyRmjr5pWtMXfGyaaR
mqckgKJy5abt+e9/TkExEWhUCm2L5YyFuHW1HZgxVNudlz2lk+B/xO/uvSgXzoqm
ou6iFcFmRCXnhHrDFi/XzBC6RTxYUh1dES3PJ2Ye4cvcXI8xRuottK8Wif2cKtjD
HPbBXmrPCn4AAbc4nMbsNSj7yIGbkTaicNaXMoEq16QGpe9k2jRrxLLIGR2rCwZ6
PdVsL9rP5oF0vDkJZ+GQX2A9mVTZ5cYfXcCse+tTnZrx3XpLIF4=
=vNrG
-----END PGP SIGNATURE-----

--WIIRZ1HQ6FgrlPgb--

