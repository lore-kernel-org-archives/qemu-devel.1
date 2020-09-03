Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A563DC10DAA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 23:32:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643552078E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 23:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ds43lpys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643552078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDyiv-0001Jm-Hr
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 19:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDyhw-0007yW-12; Thu, 03 Sep 2020 19:31:56 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:44035 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDyhs-0000h5-F4; Thu, 03 Sep 2020 19:31:55 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BjHBq6h6xz9sVB; Fri,  4 Sep 2020 09:31:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599175907;
 bh=n5050eBgqzhhTL0Rgq0lt0KtjcMOthFeDru5DchQRmQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ds43lpysY6ff58LzVEXzEa08T2VETgn5FpMT7pnC3YjRGMne0oiI80gokdfMw53TR
 5vOZoaI6BE0R2WKn72EdquIO+zNECg/GzbT26Br97guLKzeWx1z/RH6R0LouJ8ykWz
 xNeVryUYNkmGnVt3fQu+pj5x5fs4ckaF/2jSNmLE=
Date: Fri, 4 Sep 2020 09:23:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v3 0/7] pseries NUMA distance rework
Message-ID: <20200903232300.GA341806@yekko.fritz.box>
References: <20200903220639.563090-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20200903220639.563090-1-danielhb413@gmail.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2020 at 07:06:32PM -0300, Daniel Henrique Barboza wrote:
> Hi,
>=20
> This spin attempts to cover all suggestions and concerns pointed
> out by David Gibson in the v2 review.
>=20
> The patches were rebased with David's ppc-for-5.2 at 615ae3763144.
> They can also be cloned from
> https://github.com/danielhb/qemu/tree/spapr_numa_v3.
>=20
> Changes from v2:
> - patches 1 and 2 from v2 -> already pushed to ppc-for-5.2
> - patch 1 (former 3):
>     * numa_assoc_array moved to SpaprMachineState
> - patch 3 (former 5):
>     * use memcpy
>     * fix index increment to use MAX_DISTANCE_REF_POINTS
> - patch 4 (former 6):
>     * revamped. NVLink2 associativity is now calculated in
> spapr_numa_associativity_init(). GPU code will use the same
> helper everyone but vcpus uses to write the associativity DT
> - patch 5 - new
> - patch 6 - new
> - patch 7:
>     * no more brazilian portuguese notes in the commit message
>     * change the code to handle an arbitrary vcpu associativity
> array, retrieved with a new helper added by patch 6.
>=20
> v2 link:
> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg00261.html

I've applied 1..4, though I will comment on some nits that could be
cleaned up later on.  I have some bigger comments on the remainder.

>=20
>=20
> Daniel Henrique Barboza (7):
>   spapr: introduce SpaprMachineState::numa_assoc_array
>   spapr, spapr_numa: handle vcpu ibm,associativity
>   spapr, spapr_numa: move lookup-arrays handling to spapr_numa.c
>   spapr_numa: move NVLink2 associativity handling to spapr_numa.c
>   spapr: move h_home_node_associativity to spapr_numa.c
>   spapr_numa: create a vcpu associativity helper
>   spapr_numa: use spapr_numa_get_vcpu_assoc() in home_node hcall
>=20
>  hw/ppc/spapr.c                |  65 +++---------
>  hw/ppc/spapr_hcall.c          |  37 +------
>  hw/ppc/spapr_numa.c           | 184 ++++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_nvdimm.c         |  19 ++--
>  hw/ppc/spapr_pci.c            |   9 +-
>  hw/ppc/spapr_pci_nvlink2.c    |  20 +---
>  include/hw/ppc/spapr.h        |  12 +++
>  include/hw/ppc/spapr_numa.h   |  19 ++++
>  include/hw/ppc/spapr_nvdimm.h |   2 +-
>  9 files changed, 242 insertions(+), 125 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9RetIACgkQbDjKyiDZ
s5KLoRAA38+4zXHtUp7/YxszxsVDE0lfFLhgZgggfqxm9pnZRGsSy+mStuYJMbU6
4ys9UcjDp6L4QWe8YurReOMyN/8nASvJZlOqV4d4D8ud1ghD3YurTn4jzNSq9EDJ
rglaGxsyB53+57xdIp2LpJO2JA8kSJFdK2XvlEyZT5qoCVMHac/+CORTMqiJEf0o
gXzYyY4VNryfqrygug5CE9+lD8JvNAkm775T576NUQApqeeW1M005Lnwzwm4hCCL
Li/micnrsyvNJF+srDMhrs3AyYZoG9DBb8HLdgwoLBpEaToDZMHTVwwTb3BBoIUd
oyro1GlOPjqoARhjhgv1yTHAibwCOnT3x5I/55AjkuxnVXNyRpZ73ZJGZtQwhdMf
RKCfmFofUaQF45DXo8XHwF5Fcn2but3veFMb+F5Ji4cFJRhKV1gLys+BQMEqT5cg
Qt4X+LaocWmPXc3Vp4r88nJNytaete1bwdpMWv7/iIf0K+cppeR89Bhlubq5F83Z
ZwBNDZH9PsIj7Xx1/zhih4kkzTGi7+ZOXVzOIqDMuG3dQb7P3C62mPl7Wk8XM+V+
7ZUuUwkWanf1kP28quyuem4LJ23swFtxQfJTqgU+4N4aMLkoFxvS3+cxhhai54Ob
bRPSWwLUAINhbj1GflNbIsws5B5L0B79KCnhJaDVpv/uXxiZJPw=
=GiEe
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--

