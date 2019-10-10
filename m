Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA7CC47404
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 02:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55CA720B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 02:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mx+mxcwH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CA720B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iINr5-00069d-5I
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 22:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iINpH-0004uC-Tk
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 22:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iINpG-0003pG-A5
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 22:05:11 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57101 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iINpF-0003na-Dt; Wed, 09 Oct 2019 22:05:10 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46pZCw4y1mz9sPd; Thu, 10 Oct 2019 13:05:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570673100;
 bh=SEBTGwcqOgFUeQKFQIgzM1k/N945vi3PtbA8R0cv6aQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mx+mxcwHJx/p3zHNJOAaEDzLH8gy9DtPIhLFNA6/kZQuiSFhKwPOcecq032jznpgP
 oilC2f807tr1jD7hnnPUgjUibtfetpDZMYF11Die+8r7hEJfLBkhgWpTBlvWGUyOEJ
 qkIHh7sMvocfpj/RB8jgT2+zLnHSmeTigfaXBW6M=
Date: Thu, 10 Oct 2019 13:02:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 19/19] spapr: Work around spurious warnings from vfio
 INTx initialization
Message-ID: <20191010020239.GD28552@umbus.fritz.box>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-20-david@gibson.dropbear.id.au>
 <20191009103738.01bc146a@bahia.lan>
 <20191009085259.GA5035@umbus.fritz.box>
 <20191009191639.4055f811@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Content-Disposition: inline
In-Reply-To: <20191009191639.4055f811@bahia.lan>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Jason Wang <jasowang@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 clg@kaod.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2019 at 07:16:39PM +0200, Greg Kurz wrote:
> On Wed, 9 Oct 2019 19:52:59 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Oct 09, 2019 at 10:37:38AM +0200, Greg Kurz wrote:
> > > On Wed,  9 Oct 2019 17:08:18 +1100
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >=20
> > > > Traditional PCI INTx for vfio devices can only perform well if using
> > > > an in-kernel irqchip.  Therefore, vfio_intx_update() issues a warni=
ng
> > > > if an in kernel irqchip is not available.
> > >=20
> > > Can you elaborate on what doesn't "perform well" without an
> > > in-kernel irqchip ?
> >=20
> > Not really, no, but Alex Williamson tells me it is soo.
> >=20
> > > Is it a matter of performance or is it
> > > actually broken or something else ?
> >=20
> > I believe it's a matter of performance, but such a big one that it
> > makes using it without kernel irqchip infeasible in many cases.
> >=20
> > > What is the impact on -machine accel=3Dkvm,kernel-irqchip=3Doff which
> > > always spit this warning ?
> >=20
> > It should still spit that warning.
> >=20
>=20
> Yeah of course it does, but it is expected that we cannot setup
> the irqfd since we deliberately don't have an in-kernel irqchip,
> isn't it ? Why spit a warning in this case ? Or is it just a not
> very user friendly way of saying "you will have poor performance
> if the VFIO device uses PCI INTx" ?

The last thing, AIUI.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2ekT8ACgkQbDjKyiDZ
s5L1yRAAyDLQ2mtRSuaYYXS+7txIbQ18DffN56rqSVAd39j4OpX7Zb5Im5QFmSfw
PphmxQ0yhNWSlaqFr+CTyaE3DFHHRqTtswfIchqDR8Eqr0zKHq4FvBJpXyapEdel
PiqTI6eR1/wtbna2Q/q5UMGOF9A+ACcS6CQMlZFJpueRDTqQMVx+zlmduUC3ohLR
57IfDI6pkP7+M6tXzZX+UEz2LY7dSRiJNo4Is6I3NJGbKDqkFRMLJSCFwmXwrNLB
DA5qBdDRBdttZ5cRxc2NGlaNQ6n0RIaVFykQ5W7u5XyxUXrUUYQxVUZQoXfSVwO/
KrOpwG7246Sq/Rk0/o+xryXeptIZOPxbs+9uIDAmxiYfJzjNE7qdO1VJ+Yflo/yY
fll0cvtR5XKeTmJZRig1SLst7N/Up8hhBMwJgV8AIrzYMAJu84mB5DNDPwHHVmHo
sRvA+PWGE4UCNqrXl1eZYIuO2g3wceBCb7KE1aDjJskKOPAw4XFwCVDckfN9w5vj
Wghne9pnlwtAYFvSSca0LD+01/SKBAlaTOvKHEl1PkdLjdz+Z4UocfWlePGN2k0O
XqYp0nxjtad4RQNlonzEX08kkWL/ADPOTPmiawdQnSXnePuaB1vuAFJm+ccQGLl0
rCBbfDjK3AxlzGwQA0GlgzLNEeO07Rori/UjVVQ9fNeWFQ6RhUc=
=q2Gm
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--

