Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C345BC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 05:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C702238E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 05:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UVMSyb6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C702238E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpnD3-0001x1-2v
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 01:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39678)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hpnCd-0000s1-DY
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:19:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hpnCc-0003mT-86
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:19:07 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:36561)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hpnCb-0003gH-2l; Tue, 23 Jul 2019 01:19:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45t6G82Vydz9sDQ; Tue, 23 Jul 2019 15:18:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563859136;
 bh=W4HwjTJ1FXqL/lEQe4qRTNCbItb8cWlxKRm6Nhe3RBg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UVMSyb6DJfQ9WFGoXyUjxrOZ+iUlLFMZ5FnxGllUcAXM9EUCoEpEyVV2yMcLsE4/1
 YmKoRzeqj7/Kw0t1+UbGs15T5sMiFIpXt2YFFY4YNyiiaGnLhIWLgviDx53qPQt0CA
 3JUT1ne3Hv3E/MTvc9f57Gatw5Xjq8PjgAksf9Fg=
Date: Tue, 23 Jul 2019 13:40:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190723034041.GN25073@umbus.fritz.box>
References: <20190722053215.20808-1-npiggin@gmail.com>
 <20190722083939.GG25073@umbus.fritz.box>
 <585a8a2b-6ed2-dd44-bc38-7669f0357528@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4Y142/9l9nQlBiaj"
Content-Disposition: inline
In-Reply-To: <585a8a2b-6ed2-dd44-bc38-7669f0357528@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Series to implement suspend for
 ppc/spapr
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
Cc: Liu Jinsong <jinsong.liu@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Luiz Capitulino <lcapitulino@redhat.com>,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--4Y142/9l9nQlBiaj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2019 at 01:20:08PM +0200, Paolo Bonzini wrote:
> On 22/07/19 10:39, David Gibson wrote:
> > On Mon, Jul 22, 2019 at 03:32:12PM +1000, Nicholas Piggin wrote:
> >> Hi, this series is rebased on top of the qmp event fix, and takes
> >> Paolo's suggestion to implement ->wakeup for i386 before adding
> >> ppc, which makes it much nicer.
> >>
> >> If the first two patches can be agreed on initially and merged, I
> >> can take the third patch through the ppc list after that.
> >=20
> > LGTM.  Now, what tree(s) do we merge this through?
>=20
> I have just spotted a volunteer!
>=20
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

I've put this in the ppc-for-4.2 tree.

>=20
> Paolo
>=20
> >>
> >> Thanks,
> >> Nick
> >>
> >> Nicholas Piggin (3):
> >>   machine: Add wakeup method to MachineClass
> >>   i386: use machine class ->wakeup method
> >>   spapr: Implement ibm,suspend-me
> >>
> >>  hw/i386/pc.c           |  8 ++++++++
> >>  hw/ppc/spapr.c         |  7 +++++++
> >>  hw/ppc/spapr_rtas.c    | 32 ++++++++++++++++++++++++++++++++
> >>  include/hw/boards.h    |  1 +
> >>  include/hw/ppc/spapr.h |  3 ++-
> >>  vl.c                   | 16 +++++++++++++++-
> >>  6 files changed, 65 insertions(+), 2 deletions(-)
> >>
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4Y142/9l9nQlBiaj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl02gbcACgkQbDjKyiDZ
s5KdPhAA0Gqf8MFmfbyb4RNUsNrXwGT3ullt0IHlC7rp+Lxf3TKj3DzXObUSCrcL
eEokmKAx4GBDriHxACDY1zSrIPC++y3wSDFAldk7Z72KKiOFHyJA7ZbDyHwRNg9H
GeIy7IRTMe5nAvvFAOWilRdF8yAAUtwtHaSf/w1OECF+uxvVUmKpteZ9Fq+cgqaz
bgzLpz8S9u2XCH0um2+aIOU4qSY3Qge6nBuvZ6Kni6GIXgsHmbAL6e8om6WirCM7
21uD7LHcMhD/sVuFMGpFb03y/kl51Jiil5Cx57xzr+96ZcxKzA1/dDCS20QFRNZN
w331NSriYtHp1FTqy4kSbJIP1xpHBIncVIfH2R/6BoI9MCQzA6DtOyy89QAC/JXN
sKXQeDDNfGIbIeUvC/a1UvF0p9IA5jTomskgs7OkE4FlnSo5dC1k58an08NZL3lS
io597JHPzYc488cPwuUaszoCLP7W97AI2/AHWBkkYXk7spySAKRqaAdQ3t7c+g4V
peqdQ9pXYbc2BFedbNUohqXYehAOXr6J/FtXoWWnY4XZ43Wu+zwuo710KpuBaH4I
t2dg+vZqn9f4IDGLx5bUBYMPlOgaij85vEqcVxB/aEfmMCLYaemQZwcWwZf/ZHPI
UK/wJB25rIOQteaz8yT61dYvZBW9P20VhMJ/J5iwlYXxD8rfH44=
=nnv/
-----END PGP SIGNATURE-----

--4Y142/9l9nQlBiaj--

