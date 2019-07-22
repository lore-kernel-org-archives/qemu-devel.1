Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8705AC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 552C621926
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lUiLQAzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552C621926
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpW0X-0002eX-8h
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 06:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40786)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hpW09-0001XD-7n
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:57:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hpW07-0007Sw-R1
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:57:05 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:55471)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hpW06-0007MI-Aw; Mon, 22 Jul 2019 06:57:03 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45sdpf6YdYz9sBF; Mon, 22 Jul 2019 20:56:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563793018;
 bh=gLx+WM88l15EyGyPTo+NgYD0U1Jz2gZ2dZW0I+1ZJfE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lUiLQAzECII+NRbY0gtlgWn9AIjnDbVRRvSGuBoUrAZVUAn0y6l5RC+NmN+FwVcnF
 qolTz/C4ehzBJue1vlM92PydCgA74sISY7uHqdYfxLFAQnKU6t3BTTaLfv+FiL9b6p
 oSS0y5sKVO1Ndb3CnfSZUOLgqVTVHCv66Zu0mhVo=
Date: Mon, 22 Jul 2019 18:27:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190722082706.GA25073@umbus.fritz.box>
References: <20190718115420.19919-1-clg@kaod.org>
 <20190718115420.19919-8-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20190718115420.19919-8-clg@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v2 07/17] ppc/xive: Provide silent
 escalation support
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


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2019 at 01:54:10PM +0200, C=E9dric Le Goater wrote:
> When the 's' bit is set the escalation is said to be 'silent' or
> 'silent/gather'. In such configuration, the notification sequence is
> skipped and only the escalation sequence is performed. This is used to
> configure all the EQs of a vCPU to escalate on a single EQ which will
> then target the hypervisor.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/xive_regs.h | 2 ++
>  hw/intc/xive.c             | 8 ++++++++
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> index 5d02ccfeff16..69af326ebf2c 100644
> --- a/include/hw/ppc/xive_regs.h
> +++ b/include/hw/ppc/xive_regs.h
> @@ -209,6 +209,8 @@ typedef struct XiveEND {
>  #define xive_end_is_escalate(end) (be32_to_cpu((end)->w0) & END_W0_ESCAL=
ATE_CTL)
>  #define xive_end_is_uncond_escalation(end)              \
>      (be32_to_cpu((end)->w0) & END_W0_UNCOND_ESCALATE)
> +#define xive_end_is_silent_escalation(end)              \
> +    (be32_to_cpu((end)->w0) & END_W0_SILENT_ESCALATE)
> =20
>  static inline uint64_t xive_end_qaddr(XiveEND *end)
>  {
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index c2e7e2d4c9a9..8ea97ac231a4 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1463,6 +1463,13 @@ static void xive_router_end_notify(XiveRouter *xrt=
r, uint8_t end_blk,
>          xive_router_write_end(xrtr, end_blk, end_idx, &end, 1);
>      }
> =20
> +    /*
> +     * When the END is silent, we skip the notification part.
> +     */
> +    if (xive_end_is_silent_escalation(&end)) {
> +        goto do_escalation;

I don't love this use of goto, but I'll take it for now.

> +    }
> +
>      /*
>       * The W7 format depends on the F bit in W6. It defines the type
>       * of the notification :
> @@ -1542,6 +1549,7 @@ static void xive_router_end_notify(XiveRouter *xrtr=
, uint8_t end_blk,
>           */
>      }
> =20
> +do_escalation:
>      /*
>       * If activated, escalate notification using the ESe PQ bits and
>       * the EAS in w4-5

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl01c1cACgkQbDjKyiDZ
s5ImrRAAmZODugaTihvRWBC02Uy/PkKAUOIHcAv/bfctqATKakSj34OJt3HUInXj
c4p+F+mYuAS40yR2pz7tui6k/5b1RV3NI6kGqFrCxtllC4iAovgbEaMMuQ9yakpu
iNwvI5WrcihLpSZWha3TxUtsNZEp3hhGsRVcdNx0wzx5MzznF/3rDxfOzpAM4B35
oiViLKKmORgYDaWBiWvTmKQzOMx90xqD3OFRe7ozKK7ypH7O7siPuz48o0E9n3KO
ocLOhEvGCoJi5bAlgCOl5x2lpVxRc2Rozt9RIqHAjVyFmuCDsLk0QGXOR63GXisP
N4EjNjBgbzzuKrupy525qGinQONoGEC7nrQfKUZI8USnHOcp0XcOxnriPqCB8AMt
zMCBzh2tXaIWslSWNl4cpN98nTi4k4xPlztBcJ2yDYGxLccRr0kQN1llIm/7FEQR
Akq9m1b60JxiWi5p3vpC5t0Dg4pKZYkg7TqrSSzW/dV6DRcpGJmmIqO8OxxpMEjD
hsQUa8CEMGdY2jqRe7g37P/z5ZtVgUQ4C9gnkqFFgvv6CwbHNlISUICT+5rFWgWf
MD9VF8CW3QNOfJVyLrkeQfUzeQm2u2KPFKQGcLrGjufzUQokyCjsgDFROWX2k0HQ
iRtQJ1dnM76k0xzHMGY49vAchtsJcKlKENNFHBA4yfKMreBMIVQ=
=yNoL
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--

