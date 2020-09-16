Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F257C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A707C206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Qq0j5mnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A707C206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kISrP-000883-Ko
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 04:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kISig-0004if-HO; Wed, 16 Sep 2020 04:23:14 -0400
Received: from ozlabs.org ([203.11.71.1]:47475)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kISid-0005FG-LI; Wed, 16 Sep 2020 04:23:14 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BrtQG6rPwz9sTp; Wed, 16 Sep 2020 18:23:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1600244582;
 bh=r3LZGOrymuLOPAgEFhVPSGqG3IUTXKJrXfMKnmTa5a8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Qq0j5mnSRz74m2/1wSvEllbMfQKxvfmxrJlJWvF/i5jbnctHMY9T/ttmANljyAmpN
 YYSxCnR2epLXpNj9pRkddeVMKEsy5HdsOstlnx2dSNWzhkQWIHhVvKIbzwCAo/I6GM
 SnBx3uzqxYe4alJOLNd07JBAMfX13K7fLygtNMPs=
Date: Wed, 16 Sep 2020 12:49:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 00/15] spapr: Error handling fixes and cleanups (round 2)
Message-ID: <20200916024938.GD5258@yekko.fritz.box>
References: <20200914123505.612812-1-groug@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline
In-Reply-To: <20200914123505.612812-1-groug@kaod.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 04:23:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 02:34:50PM +0200, Greg Kurz wrote:
> Yet another round of sanitizing the error handling in spapr. I've
> identified locations that needed fixing with the errp-guard.cocci
> coccinelle script. It turns out that a better result is achieved
> by fixing manually, especially by converting some void functions
> to indicate success/failure with a return value.

1..4 applied to ppc-for-5.2, I'll look at the rest in due course.

>=20
> Greg Kurz (15):
>   spapr: Fix error leak in spapr_realize_vcpu()
>   ppc: Add a return value to ppc_set_compat() and ppc_set_compat_all()
>   ppc: Fix return value in cpu_post_load() error path
>   spapr: Simplify error handling in callers of ppc_set_compat()
>   spapr: Get rid of cas_check_pvr() error reporting
>   spapr: Simplify error handling in do_client_architecture_support()
>   spapr: Simplify error handling in spapr_vio_busdev_realize()
>   spapr: Add a return value to spapr_drc_attach()
>   spapr: Simplify error handling in prop_get_fdt()
>   spapr: Add a return value to spapr_set_vcpu_id()
>   spapr: Simplify error handling in spapr_cpu_core_realize()
>   spapr: Add a return value to spapr_nvdimm_validate()
>   spapr: Add a return value to spapr_check_pagesize()
>   spapr: Simplify error handling in spapr_memory_plug()
>   spapr: Simplify error handling in spapr_memory_unplug_request()
>=20
>  include/hw/ppc/spapr.h        |  4 +-
>  include/hw/ppc/spapr_drc.h    |  2 +-
>  include/hw/ppc/spapr_nvdimm.h |  4 +-
>  target/ppc/cpu.h              |  4 +-
>  hw/ppc/spapr.c                | 76 ++++++++++++-----------------------
>  hw/ppc/spapr_caps.c           |  7 +++-
>  hw/ppc/spapr_cpu_core.c       | 24 +++++------
>  hw/ppc/spapr_drc.c            | 17 ++++----
>  hw/ppc/spapr_hcall.c          | 34 +++++++---------
>  hw/ppc/spapr_nvdimm.c         | 24 +++++------
>  hw/ppc/spapr_pci.c            |  5 +--
>  hw/ppc/spapr_vio.c            | 12 +++---
>  target/ppc/compat.c           | 26 +++++++-----
>  target/ppc/machine.c          |  9 +++--
>  14 files changed, 108 insertions(+), 140 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9hfUIACgkQbDjKyiDZ
s5LG1Q//TaM5mQFlipCASNhIEWNHvec9684paDAnv8Fi0ZLzgWb11YuH0KWYhJjx
qPA2JE2nllNMgx2eOTs/YEqHcksPwmNpEldLzJdiCpAoPBMzbRnqdCCIW5sJjZsp
0H8wL4HJZuKhDB6FrLJhpR2zu9dpPGYjoNX9JHT1+Eccif1wU4wCHX8g1+GrXk9G
F5fsIMLjhtaN0lCLhqVYjndYnZp828Z0yzJLpYf2zgAXfdlzApGvH2x+1TlBcPlH
0zK5F3MiKgxf9a4XbXZQfOFtjQS5/4L1Wx/+uAurAVivGLCLckdM8tF17fFNT4PR
tndhB+jpXb7q9YVFIwmUdaqAUICexXef0OZI02YYrJqkwW1MyBEh8bvbamJ2fHeB
msm31uqzYmSPlNCGFHEJ8GxYXY4uDS5dB+bF8WtfwWXT4yEvn2AEIvKQXXBUL2+X
0Di4/yx3DfYofbsUeFSirSbHuhIiFrwmclRMj0Afmvv2lcLvlIvifu26f1KuGkl5
F35JnViyBulCshK3xzmxizEV6AQ+PE7yUTnTo9/z5qTQjTX9zXAHYQ0tNiDO8XMh
3HhxaP1Lafo4/MUikhBUdIpkqiMt9CQmnArUjzb5czK9n644UOWCVVsmxpAxynnV
xeDve/U04LaHeVXdT9DfeRYNtyaLwmpWqW+DdZVXs5CATSJFkBk=
=Vrdi
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--

