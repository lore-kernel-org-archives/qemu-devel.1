Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48F8CA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 17:35:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CF4B20679
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 17:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lTiqi/Ue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF4B20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOmSJ-0005FC-JG
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 13:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iOmJt-0004Mj-BY
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 13:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iOmJq-0006kl-Pc
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 13:27:12 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:44333)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iOmJq-0006iS-DU; Sun, 27 Oct 2019 13:27:10 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 471Psw5Yyxz9sPh; Mon, 28 Oct 2019 04:27:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1572197220;
 bh=0dsz3R0RRWo/ci+oWuYi/xKJ3pFL8rvRme7zLAeXa+s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lTiqi/Ue4Lny3dJ5nywgOhoaHLAmVSoH6qZ13WV07UHmJHLJ1XZkxpsg1dKQTczxa
 V6Hu8GoIEb6eEuP3Kb82Ogg+d3JbkAbpwUbIxX88lNjMDJWoDWFVJMLjzue/+Y23J8
 wsqKULoS3bFjb3nePRHKsEgp5lN6gO66DVr6kJmI=
Date: Sun, 27 Oct 2019 18:10:42 +0100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 0/3] ppc: Fix 'info pic' crash
Message-ID: <20191027171042.GI3552@umbus.metropole.lan>
References: <157192723646.3146912.1271674896169655201.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CD/aTaZybdUisKIc"
Content-Disposition: inline
In-Reply-To: <157192723646.3146912.1271674896169655201.stgit@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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


--CD/aTaZybdUisKIc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 04:27:16PM +0200, Greg Kurz wrote:
> The interrupt presenters are currently parented to their associated
> VCPU, and we rely on CPU_FOREACH() when we need to perform a specific
> task with them. Like exposing their state with 'info pic', or finding
> the target VCPU for an interrupt when using the XIVE controller.
>=20
> We recently realized that the latter could crash QEMU because CPU_FOREACH=
()
> can race with CPU hotplug. This got fixed by checking the presenter point=
er
> under the CPU was set (commit 627fa61746f7), but I'm not that sure that
> this is enough since the presenter pointers also get stale at some point
> during CPU unplug. And we still have other users of CPU_FOREACH(), namely
> 'info pic' with both XICS and XIVE, that have the very same problem:
>=20
> With XIVE:
>=20
> Thread 1 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
> 0x00000001003d2848 in xive_tctx_pic_print_info (tctx=3D0x101ae5280,=20
>     mon=3D0x7fffffffe180) at /home/greg/Work/qemu/qemu-spapr/hw/intc/xive=
=2Ec:526
> 526         int cpu_index =3D tctx->cs ? tctx->cs->cpu_index : -1;
> (gdb) p tctx
> $1 =3D (XiveTCTX *) 0x101ae5280
> (gdb) p tctx->cs
> $2 =3D (CPUState *) 0x2057512020203a5d <-- tctx is stale
> (gdb) p tctx->cs->cpu_index
> Cannot access memory at address 0x205751202020bead
>=20
> With XICS:
>=20
> Thread 1 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
> 0x00000001003cc39c in icp_pic_print_info (icp=3D0x10244ccf0, mon=3D0x7fff=
ffffe940)
>     at /home/greg/Work/qemu/qemu-spapr/hw/intc/xics.c:47
> 47          int cpu_index =3D icp->cs ? icp->cs->cpu_index : -1;
> (gdb) p icp
> $1 =3D (ICPState *) 0x10244ccf0
> (gdb) p icp->cs
> $2 =3D (CPUState *) 0x524958203220 <-- icp is stale
> (gdb) p icp->cs->cpu_index
> Cannot access memory at address 0x52495820b670
>=20
> It may be worth finding a way to address this globally instead of
> open-coding the check of the presenter pointer everywhere because
> this is fragile. I gave a try with this series:
>=20
> 	[0/6] ppc: Reparent the interrupt presenter
>=20
> 	https://patchwork.ozlabs.org/cover/1182224/
>=20
> but it requires some more reflexion. Also, we're about to enter
> softfreeze, and it seems better to come up with a simpler fix.
>=20
> Let's forget the reparenting and check the presenter pointers
> where needed instead. Patch 1 from the previous series was changed
> to also NULLify presenter pointers, so that they can be used to
> filter out unwanted vCPUs in patch 3. I've kept patch 2 because
> it's a fix in the same area, but it isn't related to the QEMU
> crashes.

Applied to ppc-for-4.2, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CD/aTaZybdUisKIc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl21z5IACgkQbDjKyiDZ
s5LhvA/+PpIuDYuISAW4DZLWwTRcQWPNUCSP/b8DupGAZB+RsGrTmClXlFTNhpQf
m+Fu5Eg8irqEZi2gK8/KV349hZAsQPXWUmQ/DKco2Vp0WxE7JRZrLwYZrFI4ywow
eTnBWbIZnQgbNxAL40lUcw9gjZAu3NvSLWlmftkLMQrtI08fU6fNK8E33thnTJAR
oyNqrtbeKhPigNUb/sNW7I/WEW4EwYsR9b8r4Kbl6F2HIEsrhdCYt2QyGgf3J78/
+9spiX41kv3OJWXe9o83xcP2NuG0q1JKKpdVy57H5m23RlqQhjtGTKl+xWcd8cny
ZMCvoi6fDEd2LLka0nhS2Mcb4s/1ohjK0dOlrsrZjpnqGW8V4x5kKA8ty+DTTwtF
4ZPK3isIMd/y/Wx4Hha0J3ZUx8PPNoKgNbK/mnXakshjHKBWxHSn30/UARAOvOod
WUgTtGUFYL73aKOAuuTVSryPjJkpLOJvhyPKT7o05q2nGEQnS/1HiAtvz4xWcmLb
V2zZ+Tu7H0DVRVtjpL8yS7mnAxOGwN8vHmaRpVeeu9IrEieDOHWizE+blCbkGfkk
LIbGBenc8/JDZWX9u2LZaD414PKnFxAsw5YF2P1nqcNKA8D9wTonCnJzKWMPMs+v
l+ZfjgClCO9maba98DnLLMCOR/lzC3A5p3U0iIxJWdl04m+qETk=
=b+TY
-----END PGP SIGNATURE-----

--CD/aTaZybdUisKIc--

