Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C42AC388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 04:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 708E2223C7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 04:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aHSmVIfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708E2223C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVS7P-0007NY-FM
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 00:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kVS2v-0003DK-HR; Thu, 22 Oct 2020 00:17:50 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:37019 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kVS2s-0000Ec-Ax; Thu, 22 Oct 2020 00:17:49 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CGvGP4BtTz9sVL; Thu, 22 Oct 2020 15:17:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603340253;
 bh=f0lrXbEkm7W9rbLNzXhHJpsktJtewaAbnFC2o15VGS0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aHSmVIfSsYmpGePhTaeh37Q5FkR6bLQAVaxt05qXk1LL1spc1gDMjG+pprGeI7H12
 hJR1lDTsDT5vjeqsHOeA8mf2SCV3kr16P3okcYuBqgmeKKPzLAJgPMvo7OM+a7uySJ
 qxQEWJA5gy9BdiZkUT2zfMSkz/VyD2DOFnhBhPbo=
Date: Thu, 22 Oct 2020 15:11:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 0/5] spapr: Error handling fixes and cleanups (round 3)
Message-ID: <20201022041142.GG1821515@yekko.fritz.box>
References: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VACxsDaSTfeluoxK"
Content-Disposition: inline
In-Reply-To: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--VACxsDaSTfeluoxK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2020 at 10:47:52AM +0200, Greg Kurz wrote:
> Hi,
>=20
> This is a followup to a previous cleanup for the sPAPR code:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg04860.html
>=20
> The last two patches had to be dropped because they were wrongly assuming
> that object_property_get_uint() returning zero meant failure. This led to
> a discussion in which arose a consensus that most of the time (not to say
> always) object property getters should never fail actually, ie. failure
> is very likely the result of a programming error and QEMU should abort.
>=20
> This series aims at demonstrating a revelant case I've found while auditi=
ng
> object property getters (this is patch 4 that I've isolated from a huge
> 50-patch series I haven't dared to post yet). The sPAPR memory hotplug co=
de
> is tailored to support either regular PC DIMMs or NVDIMMs, which inherit
> from PC DIMMs. They expect to get some properties from the DIMM object,
> which happens to be set by default at the PC DIMM class level. It thus
> doesn't make sense to pass an error object and propagate it when getting
> them since this would lure the user into thinking they did something wron=
g.
>=20
> Some preliminary cleanup is done on the way, especially dropping an unused
> @errp argument of pc_dimm_plug(). This affects several platforms other th=
an
> sPAPR but I guess the patch is trivial enough to go through David's tree
> if it gets acks from the relevant maintainers.

Since this series mostly affects ppc, I've applied it to ppc-for-5.2.

It would be nice to have an acked-by from Igor or Michael for the
first patch, though.

>=20
> ---
>=20
> Greg Kurz (5):
>       pc-dimm: Drop @errp argument of pc_dimm_plug()
>       spapr: Use appropriate getter for PC_DIMM_ADDR_PROP
>       spapr: Use appropriate getter for PC_DIMM_SLOT_PROP
>       spapr: Pass &error_abort when getting some PC DIMM properties
>       spapr: Simplify error handling in spapr_memory_plug()
>=20
>=20
>  hw/arm/virt.c                 |    9 +-------
>  hw/i386/pc.c                  |    8 +------
>  hw/mem/pc-dimm.c              |    2 +-
>  hw/ppc/spapr.c                |   48 +++++++++++++++--------------------=
------
>  hw/ppc/spapr_nvdimm.c         |    5 +++-
>  include/hw/mem/pc-dimm.h      |    2 +-
>  include/hw/ppc/spapr_nvdimm.h |    2 +-
>  7 files changed, 25 insertions(+), 51 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VACxsDaSTfeluoxK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+RBn4ACgkQbDjKyiDZ
s5LNzRAAqZbv1akSrktSILJwjJrS6/IPo8nINXXyMKVPKpBcE2m4qg6PyyEY7w98
8qft/j8DGIhio4d1TmYRqKlrG0JFQTCKKc959oIgo3T9lX9cRLTjfmKGOeJYo/uD
Gv1PHs5EfEH6qG05un/3SaPU8UEcfzH1r0IMREJMy1xoAQkU6277BZVB/UVf1dzS
/Fj9Lg8Puy58qlhf0wtlLtXoIW/p88sREjbmDe3accgPdyVmRHp/uLZ/W+Zssah3
Ps4wmIgWKEcCPF7IPULz69w8qdossVRY4URRFnu6fpD4+tbG2lWCnTKyai3BEpu3
AAMgTDrSdfAjT3HRimBLtCjWApERCjSDs4QU90Iz3SlE5GMp+1mvGu+8adW+VloT
eGx5mURQNqNUYK1T68A4UtgJXZrJvUUv1gC86AUg9MWaq6vpxXIbNe/qfecYhELP
srJgWxob04iHAwrdJhhXV5oW5MZZpEmrk+5d1bBDwfpQ/bADNbcnDk0DlZLSA5YL
S+sOsSOJ26Xkj8vxmPxQX1XKsjiv66Un7uWerolsegNcdjrUyTLAvL0AbAmeyXD2
3FSYN2Ypicc1nnDjPcTjwLq4HsbUILQKyisVk+ZkWq1AEpQQ0s9QapSYNgQgAjPh
Uf9ek0jtJk4TJv515rYnVLQQtsgzFrNTCoOgMyluJJUSh4QgJm0=
=Jk27
-----END PGP SIGNATURE-----

--VACxsDaSTfeluoxK--

