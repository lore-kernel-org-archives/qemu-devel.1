Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E605C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:51:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A5FD216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oMI3OMLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5FD216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49173 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOcuL-0002pe-Jc
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 02:51:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOctQ-0001wd-QH
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOctP-0004tC-F7
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:51:00 -0400
Received: from ozlabs.org ([203.11.71.1]:45665)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hOctO-0004qf-I8; Thu, 09 May 2019 02:50:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 4503rt3Rdsz9s9y; Thu,  9 May 2019 16:50:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557384654;
	bh=Zc7Wx41gNVsu4UIO2bNtwUUB2PGZoZGLgh9t4YnRnJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oMI3OMLZOPmcgfKV54DK/SUNaS48J9NHMaeJ1B4ib8ERscTWVPG+YotQozPKe+mbU
	nYetQ4+5xvNENPBC2BP6K7Lox6aCNYxLdqfrDm5t8zk0T8QbvQgo8jPzUx3HIE/0th
	M9QBMh6uiHrhmMtGb9NaVzpntmLMQMBWmD/2ywUI=
Date: Thu, 9 May 2019 16:45:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190509064534.GW7073@umbus.fritz.box>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
	<20190503055316.6441-3-sjitindarsingh@gmail.com>
	<20190506061534.GH6790@umbus.fritz.box>
	<1557192484.6435.8.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mz5eWKkhz39mMVQV"
Content-Disposition: inline
In-Reply-To: <1557192484.6435.8.camel@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 02/13] target/ppc: Work [S]PURR
 implementation and add HV support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--mz5eWKkhz39mMVQV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2019 at 11:28:04AM +1000, Suraj Jitindar Singh wrote:
> On Mon, 2019-05-06 at 16:15 +1000, David Gibson wrote:
> > On Fri, May 03, 2019 at 03:53:05PM +1000, Suraj Jitindar Singh wrote:
> > > The Processor Utilisation of Resources Register (PURR) and Scaled
> > > Processor Utilisation of Resources Register (SPURR) provide an
> > > estimate
> > > of the resources used by the thread, present on POWER7 and later
> > > processors.
> > >=20
> > > Currently the [S]PURR registers simply count at the rate of the
> > > timebase.
> > >=20
> > > Preserve this behaviour but rework the implementation to store an
> > > offset
> > > like the timebase rather than doing the calculation manually. Also
> > > allow
> > > hypervisor write access to the register along with the currently
> > > available read access.
> > >=20
> > > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> >=20
> > Hm.  How will this affect migration of the PURR and SPURR?
>=20
> So as it turns out, the PURR isn't acutually migrated. We rely on the
> fact that the QEMU_CLOCK_VIRTUAL is migrated and that the PURR can
> never change value. Since it just counts at the same rate as the time
> base we get away with it.

Ah, ok.

> For this to work we will need to add PURR, and VTB for the later patch
> which adds it to the migration stream. I suggest me just migrate by
> value meaning the internal representation can infact change in future
> without breaking migration.

Yes, that sounds good, and we even already have a spot for it in the
sprs array.

At first I was thinking we'd need to fiddle about with adjusting it
afterwards to account for the migration downtime (as we do for tb),
but then I realised that it probably makes more sense *not* to count
the migration downtime against purr and spurr, which makes it even
easier.
>=20
> What this means is that this patch changing the internal representation
> if fine given migration is broken anyway. When I resend this series
> I'll add the purr and vtb to the migration stream.

Ok, sounds good, therefore:

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mz5eWKkhz39mMVQV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzTzI4ACgkQbDjKyiDZ
s5JjohAAvZsyb8+kXl2lKwzpe5bPttofEGOGmj2L0L+XoUKF8cqddMXqzItr2AeY
o6KsC23RVgOY5w5RwlURU5S0faBTXouJM+tC4T2zbhCQK5SAMjIA0pWbFgLIAmPx
pP6cdFG9ZMgelnKn2EEwDhiqJay7HcHdrT3SONuBhGFguUok0ZCc7y/S4W2p00MG
PkYX22Yud0cB69kfjHvWA+rKbv7NoObwUBAktYX/W7iCZNhopVw2+hzlKEwS+bPI
AH0DYa2BolPoBqyY+K8oBd+c+I2qxHI8yYGlGZdLH/7rkhu6w0fjAeIizXy/yY9e
XAcDN34iRgW4hpu0eaByZFfe7T2ca4RbbgVhz5CXWWGXQv+MVeL4PNmUNeaEeb/y
dhzUhOWm52xmQXqNzR0MBHHfgF+kwYM6Xt2tMriarosUbVsAaE8kzuSMjDxmYUai
K1qSGTYI9Ulko/5pQ7zzYeQfyks4/DCWOXM9CXsw4PVISastEZikZD5ioT5iXpwZ
Er1z/6GDvc11nTeejpWS1/kSf7FWBuidCe3B1XSFffmnj0J/pslQCxnEJtgiCyHw
Jv8waxYxMFtefChrjDIPsw7u2c+ue0Ii3YiPyBJAAVMgtmvwd3+YOYrc9O3Dw6Gy
Qpcu+92i80wAyrlyEmZgIy24kUu9pOfIyLEnBqlzyFoKvszwdvg=
=zsB+
-----END PGP SIGNATURE-----

--mz5eWKkhz39mMVQV--

