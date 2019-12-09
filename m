Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BDDC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 01:18:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F07920663
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 01:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HvVEqlzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F07920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie7gq-0004oR-8u
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 20:18:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ie7dO-0003HE-R9
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 20:14:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ie7dN-0004eN-LW
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 20:14:46 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:44755 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ie7dN-0004bs-Ak; Sun, 08 Dec 2019 20:14:45 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47WQG76yR3z9sR0; Mon,  9 Dec 2019 12:14:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575854079;
 bh=SmU+A/EQZW3Cj+pThx7T3dOS4zpCDCyBFxzSDHQxaJo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HvVEqlzogf9NU7VkznaK316hUEsy8TIfI1XXmw5qqPZMvoRMFHs4JixggMCrMrUJs
 kIVd/gAVywiRLNi0uEK0PpcbGeMdJV/tFsW6rXea4O2duMDlNjo3MD+Ox/Ue4itWFa
 ooOiw5HsgwyZtUlQDP6xyQR/cFreAurWU3D0sbPI=
Date: Mon, 9 Dec 2019 12:14:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [for-5.0 PATCH 0/4] ppc: Fix interrupt controller emulation
Message-ID: <20191209011428.GE2482@umbus.fritz.box>
References: <157548861171.3650476.14824062174573272058.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+SfteS7bOf3dGlBC"
Content-Disposition: inline
In-Reply-To: <157548861171.3650476.14824062174573272058.stgit@bahia.lan>
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--+SfteS7bOf3dGlBC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 04, 2019 at 08:43:31PM +0100, Greg Kurz wrote:
> Guest hangs have been observed recently on POWER9 hosts, specifically LC9=
2x
> "Boston" systems, when the guests are being rebooted multiple times. The
> issue isn't POWER9 specific though. It is caused by a very long standing =
bug
> when using the uncommon accel=3Dkvm,kernel-irqchip=3Doff machine configur=
ation
> which happens to be enforced on LC92x because of a host FW limitation. Th=
is
> affects both the XICS and XIVE emulated interrupt controllers.
>=20
> The actual fix is in patch 1. Patch 2 is a followup cleanup. The other
> patches are unrelated cleanups I came up with while investigating.
>=20
> Since this bug always existed and we're already in rc4, I think it is bet=
ter
> to fix it in 5.0 and possibly backport it to stable and downstream if nee=
ded.

Applied to ppc-for-5.0.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+SfteS7bOf3dGlBC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3tn/IACgkQbDjKyiDZ
s5Lqow//YAoXnYcnL2dL1tihx69hUeNlmnD/bgQ0INFjNb0P4R7+LXeIQdGyCXPN
xc/bEcCdnKiKmDihn6d5t5Z/l0KtpUscTrumfaJF7a7MmnkNUoq9WOevf5TTRr3J
fSDA62aYqOElJY2iKLJ/dPQw6kGEw9m0WoO3Lib/DJLZBGpK+T89G9zr2HbjI3gO
p8SE45rNFF17Xohcnzl/dRFHDxpaEAG5mQkhD5Sp5ISGmif8prjGTvbRbAvNW2R8
+MUaWWZ5nK9CIUIdn8+WJVqi6WcDSIFJhwuayT5lWg/UPFmDdTzHpesIDBqFTee9
neF1TYRn3kZ5/Rufp0mnffmesVxE9/fANoqTYCQ16hcZNZpnNwc71HsGvv4cWfoz
XdPBSGLAB1vmbh9f/WUzLAtL1DsoR9N7jXJyNRze2uUKTBuZAzi6+z5YIsF31hT6
w+FsTemAXG3qSWs2r4G6iaKcln9Mic2YzvwITfh7Vs9KK3ckYuLMBk1QCgs19mVZ
qFgzGZ5A6OQ8fympnwTSY/p0yiTne+M2EZLs22gQ+X8bIVoOUxhFoQxIxssTkdA9
WvS7YS+xqablv0cAPlWTfOBw5SHmwzIsBNOVvqqDdSGtYVA+T2izusy/EIiZ+JQH
phv8SaP7uBvKLby5O7ssEP19t4o9AT7pfjLAeyfsokh4ZRmOUqs=
=9xss
-----END PGP SIGNATURE-----

--+SfteS7bOf3dGlBC--

