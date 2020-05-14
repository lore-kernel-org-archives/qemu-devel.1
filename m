Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81757C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:48:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4813D205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="n4UPjK5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4813D205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ7fd-0002Tf-ED
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jZ7es-0001bY-DN; Thu, 14 May 2020 02:47:54 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:41443)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jZ7er-0004ja-CO; Thu, 14 May 2020 02:47:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49N2D64T8rz9sSs; Thu, 14 May 2020 16:47:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1589438870;
 bh=xJZspF2f/y360d+Ue0XO5C9ABAWPuiuQWAvQtUh1rTQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n4UPjK5rgu8moxUH9GxAEgwr6n5ApeWQ6+Ss/u5qU6xRCxr5cukHjlJe/mzKsy+q1
 XK2Yt9HqnVtMVs2RFn/vxKzLxsq9ePpjVlipF4UzYINJLlYufBH2zSneeRg2wWvcZh
 xVfwAr74PNpoDF46/GSjd/56cI2IcFld7U/XQTGY=
Date: Thu, 14 May 2020 16:46:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [RESEND PATCH v3 1/1] ppc/spapr: Add hotremovable flag on DIMM
 LMBs on drmem_v2
Message-ID: <20200514064628.GB2183@umbus.fritz.box>
References: <20200511200201.58537-1-leobras.c@gmail.com>
 <20200512034109.GX2183@umbus.fritz.box>
 <f8b3daef-960f-3e74-0b10-00d30acef00a@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jIdBwf7/i7YThJrI"
Content-Disposition: inline
In-Reply-To: <f8b3daef-960f-3e74-0b10-00d30acef00a@kaod.org>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Cc: Leonardo Bras <leobras.c@gmail.com>, qemu-devel@nongnu.org,
 Bharata B Rao <bharata@linux.ibm.com>, Bharata B Rao <bharata.rao@in.ibm.com>,
 qemu-ppc@nongnu.org, Leonardo Bras <leonardo@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--jIdBwf7/i7YThJrI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2020 at 08:05:17AM +0200, C=E9dric Le Goater wrote:
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -446,7 +446,8 @@ static int spapr_dt_dynamic_memory_v2(SpaprMachine=
State *spapr, void *fdt,
> >>          g_assert(drc);
> >>          elem =3D spapr_get_drconf_cell(size / lmb_size, addr,
> >>                                       spapr_drc_index(drc), node,
> >> -                                     SPAPR_LMB_FLAGS_ASSIGNED);
> >> +                                     (SPAPR_LMB_FLAGS_ASSIGNED |
> >> +                                      SPAPR_LMB_FLAGS_HOTREMOVABLE);
>=20
>=20
> This is missing a ')'

So it is.  I've corrected this in my tree, but please do compile test
your patches before sending.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jIdBwf7/i7YThJrI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl686UEACgkQbDjKyiDZ
s5KfsxAA0bVArU7mIziy5lQ/UcYl89R2PuUGZJyQ3thWGuSjcTNsNA+5nQbazOMz
4/OE0EvNJVZPcsoQiNmD7f7KKWYaLr+0VEKKKd9OBEkhyZP3eGTTKtxTLqDmFuip
8KpEmfDsgf831zLu4vFSxnzj3yfdUvZrr3rmv3GiytN6jryxBsSFVJOvqcwyrMex
C0C0D00P4rjCv/WhNe9RUegQcMD1s3Gts5CKkRAPMDl5BF2cQ+lV4iur66rycA7J
p+3zN6F4CYd2NQ5L8buBmY4QMObji3ECIpUs5Z+EgtkteA0YT1jiHum5gLjxq9Gu
oRBhmh7Rtj22sDFQ2xVVAKmX2700eRosJIZnCBx1gDp3ZA9r2Ql46drTmUq2D0Ng
EP+I68uKHnF0Ga5LtnnCiRVKuiP+/Q5HBV6BAj2yn/N8zrWlMb0HhRYpQAQXiX7D
qcCvXsCjgcDMXRtgQPr8GGX/MW+DDiHnzjrGIMQBchofAZO65MyJP/nsi2Tm5p3Q
bi4rn0OhyZfIiEvP8vUJqm3cEpT2SWnbZsI66B/F/BA23H5xEYAOZuvwwxMFWmb8
2G2y5kTy+CAddqHgTUdwT8MQ02D/SJqO36MLsHprvCQEbQE7GaiEvUAv8MY8dcMb
OzHZFJf+9b32teCTHZFuJyd7V5YcSetyZvr8Dm7ndNUOr7ABQS0=
=a2LR
-----END PGP SIGNATURE-----

--jIdBwf7/i7YThJrI--

