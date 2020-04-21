Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757D4C54FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 00:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44F9020782
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 00:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="p17xB/zw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F9020782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQh9B-0006dZ-Fj
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 20:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jQh7w-00062d-4s
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 20:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jQh7u-0003ti-T1
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 20:51:03 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54309 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jQh7k-0003iQ-NO; Mon, 20 Apr 2020 20:51:02 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 495lNk6Lfvz9sSK; Tue, 21 Apr 2020 10:50:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1587430246;
 bh=NtbyNGjjWdO1uDzNOLhwX8iW1OHUXK2k4N9D2rAfiOI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=p17xB/zwdj7FJzWy4lPFe/zLAOVNBfSPMkSzvpmwH7qBhktOEnSGcLaxncaHZdUVO
 5hda/YfJTaez9SR0RTgDiKe1czFQFJSmSa2+q8ZlpwIBb6Z3n3YLu3yw0tIfxcpcJ1
 6qj97Zzj2mSu8KqX4MsI+cbMw5wB5Bv09wTjDNOE=
Date: Tue, 21 Apr 2020 10:49:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dennis Clarke <dclarke@blastwave.org>
Subject: Re: [PATCH-for-5.0?] target/ppc: Fix TCG temporary leaks in
 gen_slbia()
Message-ID: <20200421004946.GB52174@umbus.fritz.box>
References: <20200417090749.14310-1-f4bug@amsat.org>
 <CAFEAcA-aj77=19d+8jmoWYXBDdm=U8eV8CsHpovMN8bE9uNSvg@mail.gmail.com>
 <dcf67e87-da27-68ee-0dd8-5b94edb84291@blastwave.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <dcf67e87-da27-68ee-0dd8-5b94edb84291@blastwave.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/20 20:50:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Nicholas Piggin <npiggin@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2020 at 10:53:48PM +0000, Dennis Clarke wrote:
> On 4/20/20 6:56 PM, Peter Maydell wrote:
> > On Fri, 17 Apr 2020 at 10:08, Philippe Mathieu-Daud=E9 <f4bug@amsat.org=
> wrote:
> > >=20
> > > This fixes:
> > >=20
> > >    $ qemu-system-ppc64 \
> > >    -machine pseries-4.1 -cpu power9 \
> > >    -smp 4 -m 12G -accel tcg ...
> > >    ...
> > >    Quiescing Open Firmware ...
> > >    Booting Linux via __start() @ 0x0000000002000000 ...
> > >    Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
> > >    Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
> > >    Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
> > >=20
> > > [*] https://www.mail-archive.com/qemu-discuss@nongnu.org/msg05400.html
> > >=20
> > > Fixes: 0418bf78fe8 ("Fix ISA v3.0 (POWER9) slbia implementation")
> > > Reported-by: Dennis Clarke <dclarke@blastwave.org>
> > > Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> >=20
> > I propose to apply this patch for 5.0 rc4 (as well as the
> > ppc pullreq already sent), since the iscsi bugfix means
> > we need an rc4 anyway. Any objections?
> >=20
>=20
> I have been running rc3 with this patch fine for some days now.  Both with
> and without a debug enabled build wherein the performance difference betw=
een
> the two is obvious.
>=20
> However, I do see warnings from 5.0.0-rc3 that worry me :
>=20
> $ /usr/local/bin/qemu-system-ppc64 \
> > -machine pseries-4.1 -cpu power9 -smp 4 -m 12G -accel tcg \
> > -drive file=3D/home/ppc64/ppc64le.qcow2 \
> > -device virtio-net-pci,netdev=3Dusernet \
> > -netdev user,id=3Dusernet,hostfwd=3Dtcp::10000-:22 \
> > -serial stdio -display none -vga none
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-cfpc=3Dworkaround
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-sbbc=3Dworkaround
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-ibs=3Dworkaround

These are completely unrelated to the slbia patch.

[snip]
> etc etc etc
>=20
> What shall I do with "TCG doesn't support requested feature,
> cap-cfpc=3Dworkaround" ??

Ignore them, probably.  It means your TCG guest is insecure against
Spectre attacks, but it was always going to be one way or another.

You can suppress them with:
    -machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken

That doesn't make anything more secure, it just lets qemu know that's
what you intended, and in turn it will tell the guest that these
mitigations are not available.

These are enabled by default, because they're very important for
production KVM guests.  However, doing equivalent Spectre mitigation
for TCG is essentially infeasible.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6eQycACgkQbDjKyiDZ
s5LkDQ//cvjChRCdKHFmxkx3gbZzCP2ejP9QzKFr8LhOyFJg+HPmNLLx+7FiLrMb
hsfQy1vo+ioDaUSecAhoinduNMgWKSJzHxRv7u7xgR2lxLAzHQWK7zbIQH68WzkK
Td80a7aW0polH9HY3jIkLnuM/PRPlxmQJrVU+MkSIqV+qPJkjwJJ0dQM0yaEUi0r
1VfdEnFFMwTCBjYE+f/Q3f5sWdWmIe3AbqFlESlwX4YpVAyBY12kMbprZ8+G0SCz
HMqvzB/rX6NFcacvrcGbupEinBppz0MLrviFMEysY4AwBtx/xUJ328pU0c/xpcRW
g11GFvL35oq3+Urh8PbMy/hyAFeD7xNhGmBpeYU1cC1CTpieYOblq7/knqtbF3iy
z5ijyP0DOedxbOroDxalbBUyCRPvRkd87sKtoMahXlOYn1oRG6ZoNpene1a9sNUY
RKtZ9vY6TlbPnWdkSI5aSeqPa/76Hve2qRawXB4tR3261+ktm3aOxsyzFGDHVeLs
j6ZLXv/OOEwDDjMoRrdJua0xCrTklvoiiO0q/6rQSW7rVoNVGcvAq5e5DjbLBw/u
k3HyPSbixt+xs+yghQqBoP3LpxhEO3u8pqUuz7xSwoKVeJuIFDp1l4OzRATlBbbw
fWAI8sH1yvJIqnXc1jPy8qu3fMJi8HUqkA93fBPlXhhcgpvlL2Q=
=b8Vd
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--

