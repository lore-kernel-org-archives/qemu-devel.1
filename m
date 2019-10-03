Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D58C4360C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 02:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D965421D81
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 02:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oZS3Cib2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D965421D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFrBs-0005bW-IK
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 22:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFr5M-00007n-LA
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 22:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFr5K-0000yA-Ve
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 22:43:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45761 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFr5K-0000wp-9X; Wed, 02 Oct 2019 22:43:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46kHPB2k0Yz9sPh; Thu,  3 Oct 2019 12:43:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570070590;
 bh=h2MMpDmBrgbXfzhn6sRqy3nLm/+RksZ/9+FnSJihtm4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oZS3Cib2Hrs15pP+sFFG3c449zros4BkLbSzfP0g7Vv7O6LWmHl+WlnHr0qIMavE2
 9Rk9k1cZVeaoLNqEgmggWkj7aaljmHjxHiMv4wweRvFNVZXYxFtH3NiqiLOG0DuApC
 37fOZyQ8M+r2FD1C/P69V2MAAp0DaD0C2reUW3nU=
Date: Thu, 3 Oct 2019 12:11:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v4 13/25] ppc/xive: Introduce a xive_tctx_ipb_update()
 helper
Message-ID: <20191003021137.GK11105@umbus.fritz.box>
References: <20190918160645.25126-1-clg@kaod.org>
 <20190918160645.25126-14-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NrP+m7YXMSGlHqXH"
Content-Disposition: inline
In-Reply-To: <20190918160645.25126-14-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NrP+m7YXMSGlHqXH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 06:06:33PM +0200, C=E9dric Le Goater wrote:
> We will use it to resend missed interrupts when a vCPU context is
> pushed a HW thread.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/xive.h |  1 +
>  hw/intc/xive.c        | 15 +++++++++++----
>  2 files changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index f35ff3b64791..a461753f5da5 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -467,6 +467,7 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveT=
CTX *tctx, hwaddr offset,
> =20
>  void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
>  Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp);
> +void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb);
> =20
>  static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_i=
dx)
>  {
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 68d3361d1c3f..5f7c37b091a7 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -135,6 +135,15 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8=
_t ring, uint8_t cppr)
>      xive_tctx_notify(tctx, ring);
>  }
> =20
> +void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb)
> +{
> +    uint8_t *regs =3D &tctx->regs[ring];
> +
> +    regs[TM_IPB] |=3D ipb;
> +    regs[TM_PIPR] =3D ipb_to_pipr(regs[TM_IPB]);

You're opencoding the existing ipb_update() here, but not eliminating
it.  That doesn't seem like a good idea.

> +    xive_tctx_notify(tctx, ring);
> +}
> +
>  static inline uint32_t xive_tctx_word2(uint8_t *ring)
>  {
>      return *((uint32_t *) &ring[TM_WORD2]);
> @@ -336,8 +345,7 @@ static void xive_tm_set_os_cppr(XivePresenter *xptr, =
XiveTCTX *tctx,
>  static void xive_tm_set_os_pending(XivePresenter *xptr, XiveTCTX *tctx,
>                                     hwaddr offset, uint64_t value, unsign=
ed size)
>  {
> -    ipb_update(&tctx->regs[TM_QW1_OS], value & 0xff);
> -    xive_tctx_notify(tctx, TM_QW1_OS);
> +    xive_tctx_ipb_update(tctx, TM_QW1_OS, priority_to_ipb(value & 0xff));
>  }
> =20
>  static uint64_t xive_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
> @@ -1382,8 +1390,7 @@ static bool xive_presenter_notify(uint8_t format,
> =20
>      /* handle CPU exception delivery */
>      if (count) {
> -        ipb_update(&match.tctx->regs[match.ring], priority);
> -        xive_tctx_notify(match.tctx, match.ring);
> +        xive_tctx_ipb_update(match.tctx, match.ring, priority_to_ipb(pri=
ority));
>      }
> =20
>      return count;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NrP+m7YXMSGlHqXH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2VWNkACgkQbDjKyiDZ
s5JCEg//fMlQGIN48kUga9cXSyiPj3jGDmGYMDTBOKBj0/1zja06iBdW+gD8txjk
6XUgMZdeEKW1NL6NQU24uR8dHlm0igsfrW/424ZWiC+2BzCbe6eBtb7rQxYdgyoS
/dweR1mCBxFy1qa7DPvkwSkLR025Zbule8DRKZD6uqCtEY7OlvoPuZHROQbIAnY/
SkzyCZRsA3ot2smtLQR95FWaH7KxrYMn0s0mlV2RberwOWw6H1X4yIGewQo+4jAr
4AvD9Zgl1YqFa+ulTwxg842e4/blCerITjkoZnZtwfBPxC9m4IQGQBTxjtRceMMj
BhlNf9dlDJ4aR36LMNp14egXhQknA8jM83iKeYDrxZBqCjbR/DhZgHi/rJ+zAblY
vldDCexFZWrUe/bttHivRxVWesmJ9I7QYueSuUJFxbVlC/x5xm/0wgK5bYJ9Bxoe
PuYR01Mp1yMJlW1CLPSoffV+pJNOW/dIc+LbjCnT0Taj1uax0my+oYRLsyU+BiH8
PynfwvYC17O+YeSEGeJT4JunG++s3Z1VS6CsYGSoLD36H38MplJFoYrPKZKsXFre
7xKYlQYJBnSQCcM/BPTw7dWGV7dFkkRMptIosEytOz8ZXTsTruFHT0Fcwor5btCR
5fqAnoERVyTFytA3HqTmRbogJeyL6XMEahxZg/RhupRVWyuWNjA=
=Ssys
-----END PGP SIGNATURE-----

--NrP+m7YXMSGlHqXH--

