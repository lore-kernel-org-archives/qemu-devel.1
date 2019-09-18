Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871E9C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 05:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 513D5214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 05:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dac9nHQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513D5214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iASnW-0002Ov-7U
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 01:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iASls-0001c8-Rj
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 01:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iASlr-00018h-4z
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 01:44:56 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:38641)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iASlp-00013b-J7; Wed, 18 Sep 2019 01:44:55 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46Y87g2p5Jz9sNf; Wed, 18 Sep 2019 15:44:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568785487;
 bh=iVEqO8W5FVfGbJxtTdGkvq3y8guHqadQEdwfH1vREHQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dac9nHQpWAFtZ4VGtmMU8WAGwq5lX1p+mF67oqUHNk0gPPRk/5139vUI36yucaKv6
 Ze6zy0TZXKyT86ssgZOhBdTIFZ92gjC7edwIJqoW4krnSC64LuEiDcKVHaSh2a6OFa
 upBKk7wVbChpKDa+YOMZfCsP5PDShxr3A0uaZBlw=
Date: Wed, 18 Sep 2019 15:44:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190918054426.GI2440@umbus.fritz.box>
References: <20190731141233.1340-1-clg@kaod.org>
 <1a52b8c6-b29a-d223-0dfb-8aa24bf1d5aa@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sl5MdczEF/OU2Miu"
Content-Disposition: inline
In-Reply-To: <1a52b8c6-b29a-d223-0dfb-8aa24bf1d5aa@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v3 00/18] ppc/pnv: add XIVE support for KVM
 guests
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


--sl5MdczEF/OU2Miu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2019 at 01:54:24PM +0200, C=E9dric Le Goater wrote:
> On 31/07/2019 16:12, C=E9dric Le Goater wrote:
> > Hello,
> >=20
> > The QEMU PowerNV machine emulates a baremetal OpenPOWER system and
> > acts as an hypervisor (L0). Supporting emulation of KVM to run guests
> > (L1) requires a few more extensions, among which guest support for the
> > XIVE interrupt controller on POWER9 processor.
> >=20
> > The following changes add new per-CPU PowerNV machines and extend the
> > XIVE models with the new XiveFabric and XivePresenter interfaces to
> > provide support for XIVE escalations and interrupt resend. This
> > mechanism is used by XIVE to notify the hypervisor that a vCPU is not
> > dispatched on a HW thread. Tested on a QEMU PowerNV machine and a
> > simple QEMU pseries guest doing network on a local bridge.
> >=20
> > The XIVE interrupt controller offers a way to increase the XIVE
> > resources per chip by configuring multiple XIVE blocks on a chip. This
> > is not currently supported by the model. However, some configurations,
> > such as OPAL/skiboot, use one block-per-chip configuration with some
> > optimizations. One of them is to override the hardwired chip ID by the
> > block id in the PowerBUS operations and for CAM line compares. This
> > patchset improves the support for this setup. Tested with 4 chips.
>=20
> David,
>=20
> Do you want me to resend this patchset ? or you just didn't have time
> to look at it ? =20

Mostly, I just haven't had time.  I'm also finding the patches pretty
difficult to read and review.  I don't think that's an indication
they're bad, just that what they're doing is necessarily complex, but
it's still made it hard to tackle them.

> Patch 16 has changed a little since. The get_block_id() handler has=20
> moved to the XiveRouterClass.

You, might as well repost, so I'm looking at the latest stuff.  I
can't promise I'll be able to look at the new set terribly soon
though.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sl5MdczEF/OU2Miu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2BxDgACgkQbDjKyiDZ
s5IGQRAAibMKjsrsupI88D/TtsinyUDwys3ONSiqv2ASjUVGYS6EBcCFyASGqQC1
jLEgpTOhKnE8lFSlUoiAMrpj073AG0R7xbq87BG2efUoOUxCpELO3juvXwRHt2Wu
q8+5F5SqL/Az/MBv4Pd5YnVs0WTXvGX33KGErtuVmUXT3ny1XNJK5/aeBdZBoyv0
jcTd6ykm9el/F0OYX8mtU5O+ccZFY8DRSmEL0sKKBfxH+ub9OGW3I/qgzBExU+KT
mRwlZe0RO7+14+o1zDw19Su9QxN5f+2/1hF8x704LqtrUNL6RzWQvo3tzcFBDfsB
m6jNpVjHNTtW0UpCCpXj973qs+n2IeQ+SQnsKmnAwaEc0wbJP86N3d4oROvRyiHt
l1eIjMQfBRqqydBU+k8fN66XQUkhIucobCp/R3vkrNTsYe/ZYG/gT2OFM3MruCfn
yGmH2ZMAj87leWPHRTg9Fjz/ZRx7y6XUNU75sh+/0C0s19iJUGWRW9A9T4aQSO5z
feaAObWjSfocStJOpAM1rgivJ2IYBxDt4WKH/U2hBEAbtmdxi7GIzAkgTxiwZwnK
LWDZPyawipMF60w9eF/sj3uiZMe8czuXmHtovJj1YrjU4/ZnXEdq6BxFmIohTQFE
jwmNLrSMwENp4JfNz3y+DXle7pevv7aZNXrp4jmwEPf1Ip99HT4=
=Vj1F
-----END PGP SIGNATURE-----

--sl5MdczEF/OU2Miu--

