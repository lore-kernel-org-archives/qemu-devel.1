Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B98FC432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 03:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6867D22302
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 03:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="T4l/QQh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6867D22302
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWuDR-0002WJ-Dm
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 22:30:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iWuCL-0001Hv-24
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:29:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iWuCJ-0005Vq-El
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:29:00 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:50187 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iWuCJ-0005U8-3u; Mon, 18 Nov 2019 22:28:59 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47HBBH0hPvz9sR6; Tue, 19 Nov 2019 14:28:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574134135;
 bh=b99ihFeLcMB/NisNk1TI61hrPWf0vS003WUhVtB+kx0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T4l/QQh5MxD06u8VQG6kLIiE6vP5/PRAQK0zmadI5nSb3QlyHF+9ncLZWskyLLb7/
 KBmvXZai/4W6CbknzH0lN4QnkaJt7AIrDOPqI5o7JBRsYcQ9vUtPims11uoMRDacHR
 REBrbutR58rbqy/w3lfRol4H0hqHJZuf2ajn8tDw=
Date: Tue, 19 Nov 2019 14:18:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 v5 01/23] ppc/xive: Record the IPB in the
 associated NVT
Message-ID: <20191119031828.GQ5582@umbus.fritz.box>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Eu9PQ+LfZADlAtIa"
Content-Disposition: inline
In-Reply-To: <20191115162436.30548-2-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Eu9PQ+LfZADlAtIa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2019 at 05:24:14PM +0100, C=E9dric Le Goater wrote:
> When an interrupt can not be presented to a vCPU, because it is not
> running on any of the HW treads, the XIVE presenter updates the
> Interrupt Pending Buffer register of the associated XIVE NVT
> structure. This is only done if backlog is activated in the END but
> this is generally the case.
>=20
> The current code assumes that the fields of the NVT structure is
> architected with the same layout of the thread interrupt context
> registers. Fix this assumption and define an offset for the IPB
> register backup value in the NVT.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-5.0, thanks.

> ---
>  include/hw/ppc/xive_regs.h |  1 +
>  hw/intc/xive.c             | 11 +++++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> index 55307cd1533c..530f232b04f8 100644
> --- a/include/hw/ppc/xive_regs.h
> +++ b/include/hw/ppc/xive_regs.h
> @@ -255,6 +255,7 @@ typedef struct XiveNVT {
>          uint32_t        w2;
>          uint32_t        w3;
>          uint32_t        w4;
> +#define NVT_W4_IPB               PPC_BITMASK32(16, 23)
>          uint32_t        w5;
>          uint32_t        w6;
>          uint32_t        w7;
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 3d472e29c858..177663d2b43e 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1607,14 +1607,21 @@ static void xive_router_end_notify(XiveRouter *xr=
tr, uint8_t end_blk,
>       * - logical server : forward request to IVPE (not supported)
>       */
>      if (xive_end_is_backlog(&end)) {
> +        uint8_t ipb;
> +
>          if (format =3D=3D 1) {
>              qemu_log_mask(LOG_GUEST_ERROR,
>                            "XIVE: END %x/%x invalid config: F1 & backlog\=
n",
>                            end_blk, end_idx);
>              return;
>          }
> -        /* Record the IPB in the associated NVT structure */
> -        ipb_update((uint8_t *) &nvt.w4, priority);
> +        /*
> +         * Record the IPB in the associated NVT structure for later
> +         * use. The presenter will resend the interrupt when the vCPU
> +         * is dispatched again on a HW thread.
> +         */
> +        ipb =3D xive_get_field32(NVT_W4_IPB, nvt.w4) | priority_to_ipb(p=
riority);
> +        nvt.w4 =3D xive_set_field32(NVT_W4_IPB, nvt.w4, ipb);
>          xive_router_write_nvt(xrtr, nvt_blk, nvt_idx, &nvt, 4);
> =20
>          /*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Eu9PQ+LfZADlAtIa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3TXwQACgkQbDjKyiDZ
s5KUmw/+IIQbAX9OKvMFYpXCNXAEMzzeENhxBrargnN6O9ZXyo5aR40Kfxtth0Md
P+zInIRBHoKiWirivUfdz/mxZc1rz47yWijGgy7MMoECEBh5OZYr5hkMaCaq85XE
mW/9PyHd76+dar/Xp/qpfSZCpZSHIFqQ+hgk/fM2SF0Ryzktxvv1jM7ZMBcjpcjW
UTRJI/CYWu42R3fy00kzv4v1falDTAh/EWCSHAIudDeOicoOlXI9hneRiK1XGYXi
/Dk5tIKj3PPvE5wOPxO2yKmg1qNNLwxsj5SjIBQKi0JNb4Kmh/SJcYS6Fx+h/9Fy
D26/t0qg8YwH7NuudVKr8RXgC5Spl/r2eUF3j7L/Y0YGrIcGJLmAm50E6eJzuTjw
uF9npFd/tFwG83cTr7QcDfI/Y0Y1ocLQ8PBxh0qSjQC6cFZY6YPjwY7Sx3dpKcMp
QVkkqd35X37xrAw6SgHVoeF/4nkaWfJFnI/uTJRKKARMUpUFWDKaCHwyM/Mau8PT
DWraUfIv83shfF0IIynFUHw3MGs/SOR2VWu5OLzSW03nXiD8y95Qgw235zh4rilL
UocQjCDHAeJ6quo3zIEr/AHbzHYakEH2iEXxsARShXsGP2ql/ucIDd66dTo2xBvD
D8dmc7/dKnqtTTPnSZynAcRB2hfOmRum4WBeM3f2SCWL4+oz1f4=
=DAzS
-----END PGP SIGNATURE-----

--Eu9PQ+LfZADlAtIa--

