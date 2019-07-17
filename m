Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48ADC7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:03:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C3D217D9
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WlcwwrhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C3D217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnZHY-0005nK-DU
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 22:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44997)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnZG9-00011a-SW
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnZG7-0008D6-L1
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:01:33 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:50637 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hnZG5-000878-CE; Tue, 16 Jul 2019 22:01:31 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45pL901xnwz9sNF; Wed, 17 Jul 2019 12:01:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563328884;
 bh=2ftxnbDHmzUoQ2yf6EO2KtlTfbVmVOQ0t5hEdw5fkbE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WlcwwrhQcK9wmaWcGrPLnfI/JTL16hFvKnUrnPNJQ8Ojl+nbsshCC533NBrfeGhub
 Tm8N8Pu7SPvTbq8fYz+HHxKzhGtrR7rNA2htpvcW7a/CMVBGUT11qzpr68qiWXP/8Y
 l1F6rHMUYaPOfepYVpUQbOKzTM1NP4Kv64T+6ajw=
Date: Wed, 17 Jul 2019 11:51:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190717015115.GA9123@umbus.fritz.box>
References: <20190716024726.17864-1-npiggin@gmail.com>
 <20190716024726.17864-2-npiggin@gmail.com>
 <20190716073433.GC7525@umbus.fritz.box>
 <1563269012.r4tmfz9h7z.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <1563269012.r4tmfz9h7z.astroid@bobo.none>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v4 1/5] spapr: Implement dispatch counter
 and prod bit on tcg
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2019 at 07:27:22PM +1000, Nicholas Piggin wrote:
> David Gibson's on July 16, 2019 5:34 pm:
> > On Tue, Jul 16, 2019 at 12:47:22PM +1000, Nicholas Piggin wrote:
> >> Implement cpu_exec_enter/exit on ppc which calls into new methods of
> >> the same name in PPCVirtualHypervisorClass. These are used by spapr
> >> to implement these splpar elements, used in subsequent changes.
> >>=20
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> ---
> >>  hw/ppc/spapr.c                  | 25 +++++++++++++++++++++++++
> >>  hw/ppc/spapr_cpu_core.c         |  5 ++++-
> >>  hw/ppc/spapr_hcall.c            |  5 -----
> >>  include/hw/ppc/spapr.h          |  7 +++++++
> >>  include/hw/ppc/spapr_cpu_core.h |  2 ++
> >>  target/ppc/cpu.h                |  2 ++
> >>  target/ppc/translate_init.inc.c | 25 +++++++++++++++++++++++++
> >>  7 files changed, 65 insertions(+), 6 deletions(-)
> >=20
> > Mostly LGTM.  Please do address the style issues that the bot
> > reported.
>=20
> Will do.
>=20
> > In addition, do the dispatch_counter and prod values need to be
> > migrated?
>=20
> I was thinking no, it should be just a blip. But could the guest
> be reading the dispatch counter in the vpa for some other reason?
> There are other (unimplemented) dispatch statistics in there AFAIKS.
> Linux doesn't, but others might.

Right, I guess it's a question of whether a guest would get confused
if the dispatch count suddenly resets.

> And what about KVM, does any of the VPA data get migrated for=20
> KVM guests?

Well, the stuff that's actually written into the VPA is implicitly
migrated, since it's part of guest memory.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0ufxAACgkQbDjKyiDZ
s5JwjxAAnVciuzwbuZjexZo+qX942oDIT/NNhzXgj9APyhcVJFN2A/YYhVrIzBWV
UY30kKY4HXPDGbHUedAMAqFc4XkjmPpbgTJkL7f0KvXtfh3JMrpejxD036MrpJMm
UINxRPSsIuRPgxYwzDnc89Jg3sz9EWb0rBgVM6VcVGSVbAskFVICIcpixMclwq7Y
21q2ZcJOnaCaE+cU3WvoeUalI2iOQAZ/5X09/uJv4eeA7Y1pt8h289DCuGW2ph20
6JunlVNrdN1j9fkhzmB98mK2b6xgtbfTp0Qg0z0ackpkpQguzKArsebylGTgNz1e
cVtEmHpAH6uzy1BuNtovr8AEmOVCjSWvsMJr3zVw54L9xBsmg721wTgbIISGmom7
6qXtZXl7nLrLCj1rGWmzjYtnx2pOyp6DNPbKGvfJmc+3ubhnuVZrMji4HCmVn6v7
6Y8cehyUBvN9mTeD7CSbXLpi2Lx5RifKIL/BCGBHb/J4N4EhPqn+U9Uq5Cw8Gv66
q/CumtGunTNqgkKiXdB0gQQSnoFG0y82VCqgQOsEaJzAxMf+fYay6ZtPceRS49xd
RAt5chy7VOsPcjLmQkMRiEhzUskLxhVRiwigNS9fNq5OYntjAtPazTvKoizrPey9
ZxwMORYtq570q2oqvx2jLPb9s9dsOr9suZvGEXyoRfJcfBfQFFs=
=zIUt
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

