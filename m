Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17344C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 05:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BD420709
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 05:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="g6i56Vsc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BD420709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joKpd-0001aC-4H
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 01:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joKjf-0000kn-Lb; Thu, 25 Jun 2020 01:47:43 -0400
Received: from ozlabs.org ([203.11.71.1]:41177)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joKjd-0004VB-HF; Thu, 25 Jun 2020 01:47:43 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49spv50fKWz9sTC; Thu, 25 Jun 2020 15:47:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1593064049;
 bh=EEmTbZZVcmzkrdOgtIVLfWGut2RQOlCho8VlMoYE5zc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g6i56VscgZX7GjhhX4rwun/gt9BfGwz8rULD0Of1Yem9eSAGCD3JRxQRsSr5sVy/g
 X9Ep7Sk9lIPTiKxUZL+a6lanNLJh4cSOHUNYI7ik7dCI2AkjbPRa7XZvj+MwgsOSWU
 XyIoT5MaDytwjMhjY9W3lO6E4vtXtMHY8Glrh7T0=
Date: Thu, 25 Jun 2020 15:47:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 0/9] Generalize memory encryption models
Message-ID: <20200625054723.GG172395@umbus.fritz.box>
References: <20200619020602.118306-1-david@gibson.dropbear.id.au>
 <2fa7c84a-6929-ef04-1d61-f76a4cac35f5@de.ibm.com>
 <20200624090648.6bdf82bd.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Fnm8lRGFTVS/3GuM"
Content-Disposition: inline
In-Reply-To: <20200624090648.6bdf82bd.cohuck@redhat.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 22:09:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, mst@redhat.com, david@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, pasic@linux.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>,
 mdroth@linux.vnet.ibm.com, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Fnm8lRGFTVS/3GuM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2020 at 09:06:48AM +0200, Cornelia Huck wrote:
> On Mon, 22 Jun 2020 16:27:28 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>=20
> > On 19.06.20 04:05, David Gibson wrote:
> > > A number of hardware platforms are implementing mechanisms whereby the
> > > hypervisor does not have unfettered access to guest memory, in order
> > > to mitigate the security impact of a compromised hypervisor.
> > >=20
> > > AMD's SEV implements this with in-cpu memory encryption, and Intel has
> > > its own memory encryption mechanism.  POWER has an upcoming mechanism
> > > to accomplish this in a different way, using a new memory protection
> > > level plus a small trusted ultravisor.  s390 also has a protected
> > > execution environment.
> > >=20
> > > The current code (committed or draft) for these features has each
> > > platform's version configured entirely differently.  That doesn't seem
> > > ideal for users, or particularly for management layers.
> > >=20
> > > AMD SEV introduces a notionally generic machine option
> > > "machine-encryption", but it doesn't actually cover any cases other
> > > than SEV.
> > >=20
> > > This series is a proposal to at least partially unify configuration
> > > for these mechanisms, by renaming and generalizing AMD's
> > > "memory-encryption" property.  It is replaced by a
> > > "host-trust-limitation" property pointing to a platform specific
> > > object which configures and manages the specific details.
> > >=20
> > > For now this series covers just AMD SEV and POWER PEF.  I'm hoping it
> > > can be extended to cover the Intel and s390 mechanisms as well,
> > > though. =20
> >=20
> > Let me try to summarize what I understand what you try to achieve:
> > one command line parameter for all platforms that=20
> >=20
> > common across all platforms:
> > - disable KSM
> > - by default enables iommu_platform
> >=20
> >=20
> > per platform:
> > - setup the necessary encryption scheme when appropriate
> > - block migration
> > -....
> >=20
> >=20
> > The tricky part is certainly the per platform thing. For example on
> > s390 we just have a cpumodel flag that provides interfaces to the guest
> > to switch into protected mode via the ultravisor. This works perfectly
> > fine with the host model, so no need to configure anything.  The platfo=
rm
> > code then disables KSM _on_switchover_ and not in general. Because the=
=20
> > guest CAN switch into protected, but it does not have to.
> >=20
> > So this feels really hard to do right. Would a virtual BoF on KVM forum
> > be too late? We had a BoF on protected guests last year and that was
> > valuable.
>=20
> Maybe we can do some kind of call to discuss this earlier? (Maybe in
> the KVM call slot on Tuesdays?) I think it would be really helpful if
> everybody would have at least a general understanding about how
> encryption/protection works on the different architectures.

Yes, I think this would be a good idea.  KVM Forum is probably later
than we want, plus since it is virtual, I probably won't be shifting
into the right timezone to attend much of it.

I don't know when that Tuesday KVM call is.  Generally the best
available time for Australia/Europe meetings this time of year is 9am
CET / 5pm AEST.  As a once off I could go somewhat later into my
evening, though.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Fnm8lRGFTVS/3GuM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl70OmsACgkQbDjKyiDZ
s5LT1A/+IwaLiZZ3b7YhAaur+c0t0DHFTO6Kc2RYpqJrHL1qEhm794BeLB7FyFzb
mi1sQs3TzS3fXAzO3Smjd3hJLDXTdz6Ffi8efAI/ftRxzi2Llhd9qaO8u8y+d1Kg
dziTxoe9doUU4Y2WNz+cNKxcNYC/+N3Zv7WurDuQ0lutKs1YE3NN7wcebiZf4RRv
aL1XIyHpBRe827Om1gsNBICkFxzvkXk0vg8IO5KttISNEUMMJly5JC9szcCOTX6h
x1DUKdWS/JK3YNc2M7PN5rwupy1ws9iW9LEIyWwAQXHU7PL3MVrHTUjOJNlhGxUl
tPsPL+SteLhhgmwQVxB3D2WskmJsJ2i37e7TzlbCaZXiO3eiBvz+6pQQ1LVz2/++
bdlHNKlLl7iaHjnIaUtqgamCCy4AXnPJI83IuQGY9spdJHd4PMrqDBiPo3m2xSe3
U4C3KD+Bz5LsfqACaN8HGr91QrIAXIE3ajUf6zqHuTdP9BUeps9rArV64cJ/vhYE
I86ixvvO0Bfyy9eu0AXtG+rupjLvFdF9mWhQ8kIK98+QXYCh8FuN8OEZ6A+eAT04
pRlRFqyx5AJy2CHW1ik0XEw68jY/A404+N5b4GABMjDxdQ0C52j5xDQiuycTUkGJ
vAjWg8x2UrQP3v7qmunRTQnDY6X2pfXbPetCJftbv9ZDQ86UevA=
=CtJc
-----END PGP SIGNATURE-----

--Fnm8lRGFTVS/3GuM--

