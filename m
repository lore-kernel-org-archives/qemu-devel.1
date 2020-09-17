Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB1CC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 01:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB05720715
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 01:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gPHw6j5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB05720715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIia6-0002ss-Up
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 21:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kIiXf-0008Sm-Dd; Wed, 16 Sep 2020 21:16:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53717 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kIiXb-0002Rs-O8; Wed, 16 Sep 2020 21:16:55 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BsJvx5WL3z9sVM; Thu, 17 Sep 2020 11:16:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1600305405;
 bh=/ykHoG68zyxz4r8AP8iRd7NBsXrdAHAeBSMPe6NAEKc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gPHw6j5ei5+oKdHY/JW70ru27c9JAx/wzz52cpI6g9/7FfnYNyaliF+k0Jr7JkVjY
 qqCIWsWHhr2Awfpn7/6EX7yM6Zs3//ytndUdDvUyrUelsSlWOwZLvkKhbtTjMtAYLM
 izRr/nFCNVwHUfma2VdWvNTh472rCTRLRnE4zSV8=
Date: Thu, 17 Sep 2020 11:08:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 00/15] spapr: Error handling fixes and cleanups (round 2)
Message-ID: <20200917010852.GH5258@yekko.fritz.box>
References: <20200914123505.612812-1-groug@kaod.org>
 <20200916024938.GD5258@yekko.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PW0Eas8rCkcu1VkF"
Content-Disposition: inline
In-Reply-To: <20200916024938.GD5258@yekko.fritz.box>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 21:16:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--PW0Eas8rCkcu1VkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 12:49:38PM +1000, David Gibson wrote:
> On Mon, Sep 14, 2020 at 02:34:50PM +0200, Greg Kurz wrote:
> > Yet another round of sanitizing the error handling in spapr. I've
> > identified locations that needed fixing with the errp-guard.cocci
> > coccinelle script. It turns out that a better result is achieved
> > by fixing manually, especially by converting some void functions
> > to indicate success/failure with a return value.
>=20
> 1..4 applied to ppc-for-5.2, I'll look at the rest in due course.

5..13 now applied as well.

>=20
> >=20
> > Greg Kurz (15):
> >   spapr: Fix error leak in spapr_realize_vcpu()
> >   ppc: Add a return value to ppc_set_compat() and ppc_set_compat_all()
> >   ppc: Fix return value in cpu_post_load() error path
> >   spapr: Simplify error handling in callers of ppc_set_compat()
> >   spapr: Get rid of cas_check_pvr() error reporting
> >   spapr: Simplify error handling in do_client_architecture_support()
> >   spapr: Simplify error handling in spapr_vio_busdev_realize()
> >   spapr: Add a return value to spapr_drc_attach()
> >   spapr: Simplify error handling in prop_get_fdt()
> >   spapr: Add a return value to spapr_set_vcpu_id()
> >   spapr: Simplify error handling in spapr_cpu_core_realize()
> >   spapr: Add a return value to spapr_nvdimm_validate()
> >   spapr: Add a return value to spapr_check_pagesize()
> >   spapr: Simplify error handling in spapr_memory_plug()
> >   spapr: Simplify error handling in spapr_memory_unplug_request()
> >=20
> >  include/hw/ppc/spapr.h        |  4 +-
> >  include/hw/ppc/spapr_drc.h    |  2 +-
> >  include/hw/ppc/spapr_nvdimm.h |  4 +-
> >  target/ppc/cpu.h              |  4 +-
> >  hw/ppc/spapr.c                | 76 ++++++++++++-----------------------
> >  hw/ppc/spapr_caps.c           |  7 +++-
> >  hw/ppc/spapr_cpu_core.c       | 24 +++++------
> >  hw/ppc/spapr_drc.c            | 17 ++++----
> >  hw/ppc/spapr_hcall.c          | 34 +++++++---------
> >  hw/ppc/spapr_nvdimm.c         | 24 +++++------
> >  hw/ppc/spapr_pci.c            |  5 +--
> >  hw/ppc/spapr_vio.c            | 12 +++---
> >  target/ppc/compat.c           | 26 +++++++-----
> >  target/ppc/machine.c          |  9 +++--
> >  14 files changed, 108 insertions(+), 140 deletions(-)
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PW0Eas8rCkcu1VkF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9ityQACgkQbDjKyiDZ
s5J+SQ//Wjq/HTR0XlVJkKt6naCjZs90pgDrAI18iAzpI0JSByt7OmAbZV1pUjLN
nsIU/WxBf4ihNbAuyUdoDPCp1K+Ib5JkjQym8KOo0wSySKVuhN6EinX8rnIweZnB
3VxJml/M83qa+odL29K3vnHJfLeBYo3VhI0TYz9ljTbmeewiwq3RgWsC5Nq/T9kr
CjrC2cAg9hCFxc5cd/I4UVPID5kR1Xd6VWVoXl1hdR/p8h1MOJ4XwOt5Hfp7r6i+
Oe1nPMfKXKTQz6Lmzpw6gJcIy87tYld4mqhx0sSdoY2YsnpArxd8bdMNaSD0zrsD
YuPslsRRuCy84qd4IWwY2JL/n+hPIAN454zRtPVivFMn0UGLQZ9AEa50ZKP0XhOL
EpsozAFMd9Zi5/CC1KvTdpMSQf1qxoNK40ZUW+Hht9eOucs0qpJFya3O8ki1eyQX
ScOIPLl7MadZg8b7Fvpl4fDU/iG57iaAAu2VdethmKeK6bANu2PHzSVxhMmOid62
L9B5c7VIgGcWqHVUq7u/7xsEyLREQDHLkuJAenDVai5ZIoNyJ4EGgoPX5zagO4+q
fDI7MKRTOp7uZuSAT/QylpNgtcwmxk/NcCRZdJ0hdkwRIdWJmApljd+j5hslY3hu
BcrBGtKyVrbO+wvfdyHiIS3U8yXk1FmsxdR1zZPtCKz+5bQxrm8=
=a8+I
-----END PGP SIGNATURE-----

--PW0Eas8rCkcu1VkF--

