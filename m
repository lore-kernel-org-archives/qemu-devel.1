Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B04BC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 06:04:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C65120684
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 06:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cHwZ/Qgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C65120684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZqQo-0002IH-7P
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 01:04:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iZqPy-0001As-2X
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 01:03:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iZqPw-0003Vp-FH
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 01:03:13 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:52135 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iZqPv-0003Iq-5T; Wed, 27 Nov 2019 01:03:12 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47N9DV71QDz9sSw; Wed, 27 Nov 2019 17:03:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574834586;
 bh=sgcHE5ZixYgXaifxhnowhHGFrJYbvzsjfjBUkTPjnpA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cHwZ/Qgyq0NufxEGktCjda+CyLe2Kma3zCDzHYShyWa73y8Im9vWLqEVLYSpLixgp
 Eqtb7pe4s6+vikxOk6EE9ziu2Lzz3sNypuNWKQ2nAQ9zsCwoeUPbuVbwn7tmI7CSJ7
 LXGGvmeozaAovSgGr0zdUgqr2pO6QaqoIr92aRFc=
Date: Wed, 27 Nov 2019 16:41:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [for-5.0 PATCH v2 0/4] spapr: Use less XIVE HW resources in KVM
Message-ID: <20191127054150.GT5582@umbus.fritz.box>
References: <157478677206.67101.11965554900825793694.stgit@bahia.tlslab.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RWwYAm6PHzOoZjya"
Content-Disposition: inline
In-Reply-To: <157478677206.67101.11965554900825793694.stgit@bahia.tlslab.ibm.com>
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--RWwYAm6PHzOoZjya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2019 at 05:46:12PM +0100, Greg Kurz wrote:
> On POWER9 systems, the XICS-on-XIVE and XIVE KVM devices currently
> allocate a bunch of VPs in the XIVE HW to accomodate the highest
> VCPU id that may be possibly used in a VM. This limits the number
> of VMs that can run with an in-kernel interrupt controller to 63
> per POWER9 chip, irrespectively of its number of HW threads, eg.
> up to 96 on a POWER9 Nimbus socket. This is an unfortunate waste
> of scarce HW resources since a typical VM doesn't need that much
> VPs to run.
>=20
> This series exploits new attributes of the XICS-on-XIVE and XIVE
> KVM devices that allow userspace to tune the numbers of VPs it
> really needs. Support for this attributes has just reached linux
> mainline.
>=20
> In combination with recent commit 29cb4187497d "spapr: Set VSMT to
> smp_threads by default" which makes VCPU ids contiguous, it is
> possible to start more than 200 VMs instead of 127 on an AC922
> system (two sockets, 144 HW threads).
>=20
> Changes in v2:
> - add an nr_servers argument to the activate() handler instead of
>   a QOM property for XIVE and a XICSFabric method for XICS-on-XIVE.
> - even if the last two patches haven't changed much, the code base
>   itself has, so I've deliberately dropped Cedric's R-b tags

Applied to ppc-for-5.0, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RWwYAm6PHzOoZjya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3eDJsACgkQbDjKyiDZ
s5Ix4BAAlewqDT7GSyOO8JOM2Ace14C31doT+b9Qq4s5XTlWWFJEZMneIGMCN0O/
Qw6xu+u5y7kQGNod6QhtEdZdaUNARZEzrBGUe7NiIS2u6uhLabeYIUklg5qC5ije
M7dFe1wl/Q/Oj7d666kimcOMoZyvkCSerIGaBD47v2FkOgC1szLKpdZb2Gzpz604
7+hHlpi6/KwsYcNOsc+Ij9rjsx1lbnBwle/u3TdeJTtVSi4+G40FZYFwkq1L9Wfa
ids+hPmaSfkr4XGn1weqB3EpjlPuDFG2HgYrzopEkgq108QbfQTgQOeIYKwl2aky
1ft2qjk//3y5gm3MVwVZnah0wUYA/81+uv95h55wUnctLWzRvkUArkvphI4chzWh
B62RMyM4zyAG8gMy9y0jPCsHXfoyRNEzpIhat3m3Rm4oN1OkKmFXt5HapRfH2C7I
ELZIAmrRmIXVIdOuwiaVrDItJU+bWYOBSgdlkWdBooSpjI1sQElW7Nzq6oPS2hkj
f9KvKV7WL2+LsCEs9w4HOUjGDPG5FXfMqEe3vdO203SHlGN6FSGXtAmbxwDxJNI6
gffByKxmYS7QVwGrfz77+JKnnJwK+Q0XUuALxTbmHXUHpWgXWorWW55CBNLoV3RN
n0qqIgvX4d7dpHlNuZuWp1Pd2SO4pE2ogSFvbgK3gmBxWgfV3qs=
=DpCL
-----END PGP SIGNATURE-----

--RWwYAm6PHzOoZjya--

