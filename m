Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE0BC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 11:01:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F00B20726
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 11:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F00B20726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieGn8-0003gb-Dc
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 06:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ieGlq-0002pf-K8
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:00:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ieGll-0007Hv-JZ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:00:06 -0500
Received: from 10.mo173.mail-out.ovh.net ([46.105.74.148]:32817)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ieGll-0007Fn-BK
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:00:01 -0500
Received: from player688.ha.ovh.net (unknown [10.109.146.19])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 3FA42125608
 for <qemu-devel@nongnu.org>; Mon,  9 Dec 2019 11:59:59 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id B9248CFA6F68;
 Mon,  9 Dec 2019 10:59:49 +0000 (UTC)
Date: Mon, 9 Dec 2019 11:59:47 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [for-5.0 PATCH 0/4] ppc: Fix interrupt controller emulation
Message-ID: <20191209115947.2fb92760@bahia.w3ibm.bluemix.net>
In-Reply-To: <20191209011428.GE2482@umbus.fritz.box>
References: <157548861171.3650476.14824062174573272058.stgit@bahia.lan>
 <20191209011428.GE2482@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oFphr_KlpW15DPoGg++c/8R";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 2967309204854905318
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeltddgvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.74.148
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
Cc: Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/oFphr_KlpW15DPoGg++c/8R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Dec 2019 12:14:28 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Dec 04, 2019 at 08:43:31PM +0100, Greg Kurz wrote:
> > Guest hangs have been observed recently on POWER9 hosts, specifically L=
C92x
> > "Boston" systems, when the guests are being rebooted multiple times. The
> > issue isn't POWER9 specific though. It is caused by a very long standin=
g bug
> > when using the uncommon accel=3Dkvm,kernel-irqchip=3Doff machine config=
uration
> > which happens to be enforced on LC92x because of a host FW limitation. =
This
> > affects both the XICS and XIVE emulated interrupt controllers.
> >=20
> > The actual fix is in patch 1. Patch 2 is a followup cleanup. The other
> > patches are unrelated cleanups I came up with while investigating.
> >=20
> > Since this bug always existed and we're already in rc4, I think it is b=
etter
> > to fix it in 5.0 and possibly backport it to stable and downstream if n=
eeded.
>=20
> Applied to ppc-for-5.0.
>=20
>=20

According to Cornelia's comments, it seems I need to respin this against
the s390-next branch to avoid conflicts.

--Sig_/oFphr_KlpW15DPoGg++c/8R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl3uKSMACgkQcdTV5YIv
c9aKwA//RIoJ1A9HYWkERQRxIEPPzBYNh1y/3BYb1Qigzq3IFXN3VOEua/OgEPXe
mGXMmljm4HRHwBYiWETR9M8QxwEN0pI8B7ZjOfx8LV1iJobnQbGiljtx8TRYTtOJ
h+OxPSEwJQqrlM9xREnzoTIMGFTrs37af7FJasMc/F6sKLpGIEq4V/iBBotZub9A
DjEKL8Psg/IOJCu0cxynkAtAzAG+X5BRf/tzHMt2EITi8R8PKJhYav+kwNoqTGRX
Gb/9PqibO8y/BQH1JphbMIBLenzV/stZkzieBxwP/XkCvparhjDYH4grAL2dS+9h
DBFXkDZQJfNP0XR/pldSkQq7PCK19qCFtPQT2SHBsCzwNO0yqbFfsokXDBUn4jcc
TTjlnlXS56i01CXrcwP65QthUf0y+bsyAa5N7dmpZiv+krwNQmQ7XguL2HTtGgM8
1TIgXZxaW/3ANlgvZNwkuSP8FhLwU6feqhPWeCIRPJ9R8ZYA5N6Zx5cF6ArPbMM0
k3CD4OF5apWOu6H/7p9dLGyTUQPOrloFywFhwQl/S0qqhS5TfDBMcoIIS4j3Tix6
4zx0dG2YbOQJ4kpMvdAPucWf7eiF+bhYAzehl9mU/OR9tDRd7hmbH1D2rVeF8YKz
KeppUA823tmLldVlDYsWWvzVc6whC/KrKkJbck+uSzih6g48In4=
=cJK+
-----END PGP SIGNATURE-----

--Sig_/oFphr_KlpW15DPoGg++c/8R--

