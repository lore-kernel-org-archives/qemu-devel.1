Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F41C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 08:01:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B455620673
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 08:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="NQXPVNzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B455620673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhrFy-0002bg-QC
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 04:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58728)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hhrDz-0001vf-LF
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 03:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hhrDy-0006K1-2r
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 03:59:43 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:49991 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hhrDt-0006Ea-Th; Mon, 01 Jul 2019 03:59:39 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45cfsc3ZSGz9s4V; Mon,  1 Jul 2019 17:59:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561967972;
 bh=uQMAU6HvlW/Nmw43WyAF100tZWxmcyZLplMvIg+wzgw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NQXPVNzJfnT6BXzEGkaMoTufQb75rnIBwD2pQU8oBEBt+efW2HQ6Rld9eq2tQF/2j
 Kw95BNRd7B8Mv8jQLIv0rhBZT5eZkw6E8LK6lCM1u9jVd9oCNIv+x+sEsnGQ7+U8VW
 yoOtQFtLPiJxnLsUJAR7Gtm45loXAhe9zPGSC0j4=
Date: Mon, 1 Jul 2019 17:56:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190701075645.GA6779@umbus.fritz.box>
References: <156112873945.115975.15513090884722011930.stgit@bahia.lan>
 <dad9ca85-4849-bfb0-0e09-8082ed64ecbc@kaod.org>
 <20190701050715.GJ2138@umbus.fritz.box>
 <49091393-008a-2e58-1d0d-a47d1389678c@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <49091393-008a-2e58-1d0d-a47d1389678c@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] spapr/xive: H_INT_ESB is used for LSIs only
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


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2019 at 07:55:03AM +0200, C=E9dric Le Goater wrote:
> On 01/07/2019 07:07, David Gibson wrote:
> > On Fri, Jun 21, 2019 at 05:05:45PM +0200, C=E9dric Le Goater wrote:
> >> On 21/06/2019 16:52, Greg Kurz wrote:
> >>> As indicated in the function header, this "hcall is only supported for
> >>> LISNs that have the ESB hcall flag set to 1 when returned from hcall()
> >>> H_INT_GET_SOURCE_INFO". We only set that flag for LSIs actually.
> >>>
> >>> Check that in h_int_esb().
> >>
> >> Indeed. H_INT_ESB should work on any IRQ, but I think it's better=20
> >> to check that the HCALL is only used with the IRQ requiring it.
> >=20
> > I'm not so convinced.  It seems to me that specifically limiting this
> > to certain things limits our options if we ever need future
> > workarounds for problems with ESB mapping.
> >=20
> > In addition using H_INT_ESB for non-LSIs could be useful for minimal
> > guests (e.g. kvm-unit-tests) where mapping memory might be awkward.
>=20
> Ah yes. This is true. There is no real reason for enforcing this
> restriction in QEMU as H_INT_ESB should work on any irq. We can
> keep it that way I guess. It would be a small deviation from PAPR.

True, but "unexpectedly working" is a form of variation exceedingly
unlikely to break anything.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0ZvLsACgkQbDjKyiDZ
s5LdWhAAs/h0X27aI6zdQYco8Ucc/juuHaKKKuBGCtkYLyXvvXdit37YvlfqsIXm
dRpdeUjqWFiKubnqX7rTk+i9JNZ8W0Q5h0MF/fT1ompacJZGE00exINtDywGZ1QU
MgDpOSDnpZLowJF0S8z+SFGu2Z+july7QP3PZDvmoB3pMXXCu8dAhAhFKACipALb
S3b8A4CZrnFa/1LSp4TZ1Zhgj71J8qkdXcoDuP4XBwUuc9nq6gTwmZhJ0Mw/NJBP
SbsGjdKkZlmmUE5J1PaeQQOW4R6AVS3e8zmIauT+etkNvF2dyLkfxgODgRMR4ucJ
4B1ictfhTKpWq/cWXDl0ekZE1WP4bjwVJAEfr9mGOQf4uCYXoX8Ve6QtqROEdN/L
AMbxyqRvqk6t4Vf2D4u4AyNwDsaQCwTOAseBUhb6vvsfNxXmCNa0IqDCQPakebVo
xywUn9HnkXToUgjGmbqRwWXgzi7hOyhGSSzOrYHatPC3XWrF9rO4jUurjsI3tFaw
LuZqSJYehMhyF5ThLjrQYrMmDq6du9cGxyMMFrruTxejMS5Kns56HN6PnrrijhhQ
hn/jzJNoekL02jQaMngphe2j6u3cHudnFf3EX7krKKn/aHPPSG9k+KavmRL44PBr
dTo0sekAmsDD2uXhGPeA3AIKgakyNd+e+PLTBjcknihm3mG5Sl4=
=Bggt
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

