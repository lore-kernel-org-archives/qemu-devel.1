Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE34C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9BC22086A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="RqrpoSFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BC22086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyPU8-00078c-0z
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 20:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jyPT4-0005yx-2B; Wed, 22 Jul 2020 20:52:14 -0400
Received: from ozlabs.org ([203.11.71.1]:57371)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jyPT1-0006Gs-1H; Wed, 22 Jul 2020 20:52:13 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BBv1L1SP3z9sRW; Thu, 23 Jul 2020 10:52:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595465526;
 bh=n9Bis+XWaULeEyeUeeb5YTiZc8WiEHk+WS6RkQi+52E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RqrpoSFVWhLxdtsghHU25zrUH4Yw5w8N0pGpvKFBF8vjlWzZY03Xmd1c6wlT2x2dm
 ExqUcPXlvYnc7HsYm/DBIJ0IN8J8KKx/KtCCi2k/W66Am3mUDipQlOnCT4p2sdUX25
 nl4TzDwF5fV3F0CyehoMC+7CI9oZ+aILFiuD4G8A=
Date: Thu, 23 Jul 2020 10:45:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Gustavo Romero <gromero@linux.ibm.com>
Subject: Re: [PATCH] ppc/xive: Fix some typos in comments
Message-ID: <20200723004545.GF5513@umbus.fritz.box>
References: <1595461434-27725-1-git-send-email-gromero@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sDKAb4OeUBrWWL6P"
Content-Disposition: inline
In-Reply-To: <1595461434-27725-1-git-send-email-gromero@linux.ibm.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 20:52:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--sDKAb4OeUBrWWL6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2020 at 07:43:54PM -0400, Gustavo Romero wrote:
> Fix some typos in comments about code modeling coalescing points in the
> XIVE routing engine (IVRE).
>=20
> Signed-off-by: Gustavo Romero <gromero@linux.ibm.com>

Applied to ppc-for-5.2.

> ---
>  hw/intc/xive.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 9a16243..9b55e03 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1502,7 +1502,7 @@ static bool xive_presenter_notify(XiveFabric *xfb, =
uint8_t format,
> =20
>  /*
>   * Notification using the END ESe/ESn bit (Event State Buffer for
> - * escalation and notification). Profide futher coalescing in the
> + * escalation and notification). Provide further coalescing in the
>   * Router.
>   */
>  static bool xive_router_end_es_notify(XiveRouter *xrtr, uint8_t end_blk,
> @@ -1581,7 +1581,7 @@ static void xive_router_end_notify(XiveRouter *xrtr=
, uint8_t end_blk,
> =20
>      /*
>       * Check the END ESn (Event State Buffer for notification) for
> -     * even futher coalescing in the Router
> +     * even further coalescing in the Router
>       */
>      if (!xive_end_is_notify(&end)) {
>          /* ESn[Q]=3D1 : end of notification */
> @@ -1660,7 +1660,7 @@ do_escalation:
> =20
>      /*
>       * Check the END ESe (Event State Buffer for escalation) for even
> -     * futher coalescing in the Router
> +     * further coalescing in the Router
>       */
>      if (!xive_end_is_uncond_escalation(&end)) {
>          /* ESe[Q]=3D1 : end of notification */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sDKAb4OeUBrWWL6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8Y3bgACgkQbDjKyiDZ
s5IraxAAqyz/LzFpttN5jQZVBKO5Du6SFP2CrWNFEW8yMWOeGozZQKPmu/ZQfsOD
vsl1O8WOoR69pUmcqeEyMIOacAAaHCctiMck/vYU9DLZZP5w5BfYIXNIKXXsbkZs
Ycdx9vN9xL8EXl+qFxXTNKjzBZddHu1rvaQKDOlltaqKGS4aFJVk5SsPL3tZrL4q
LK/40Uh7eeYNxWpL1/4DSPocaWWNa96EwLCfEXnErDbY9UE6Ru5VnbPptYUCqpUy
jTBqFEAaHdMp9SFXTO9eZIk/p5aGpkhFT+fzK4BH/c7kp3mRDPv3iUDh1ikwEyjU
58aX+15bLnAm+zGOFvvWE/BAXl1OzBFPPuTxpqKVfyfzh9dBSUoUvm3jdUHETyvy
kunoxwwpPmZBcXbs31y55NsTn8u+bDFM/17fXkQy3RZn2CUnBFf3QoxEMKXutRWY
uZUe5YjAz1d0TyGvkiP+UazC5mcdVDxsVJqIjoUGfc0ybfq3qg5uV9DD+JuVDuWg
GrmMhC9rV89zCOYSdPkDfGSU9s2sV7B0F9o8XxtCXEMSdNvssHGLjDas77jWsR8U
VrwuZYnWZB6IXP/uf1S9F7RfLqGUaUbxg7BtD2WZp8rDrZKY+cHYTtMDO6RGc2bk
XczALctAGjNqyBJgkqpBj+b6Ky5tMZl9m6CN6GJX6ES73vlPME0=
=SyhT
-----END PGP SIGNATURE-----

--sDKAb4OeUBrWWL6P--

