Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E883C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 05:51:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F3120709
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 05:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hFF+QDfX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F3120709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joKnG-0006Sh-8m
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 01:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joKkI-0001oU-Je; Thu, 25 Jun 2020 01:48:22 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:52493)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joKkG-0004hD-NR; Thu, 25 Jun 2020 01:48:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49spw14jNRz9sSt; Thu, 25 Jun 2020 15:48:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1593064097;
 bh=NJ28wOH7hosAT259+yC/BIdJrW+PJTn7qShwkkuzS4U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hFF+QDfXJgw5xoEaDG9aH69IFgyYnxCRTdA+4yJdqkfUcwyq+xg+0EURZgQYn9EV/
 +nL9bSiET9vcwRJVZGtWBoug8XO4LlmzKiBQ/ogZNxe5kt+uNGiL/p8GN73JluUrNo
 1nBhxPGNm7zXXW5p/bFPET1VdHID88IMmKvDaqkA=
Date: Thu, 25 Jun 2020 15:48:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 0/9] Generalize memory encryption models
Message-ID: <20200625054809.GH172395@umbus.fritz.box>
References: <20200619020602.118306-1-david@gibson.dropbear.id.au>
 <2fa7c84a-6929-ef04-1d61-f76a4cac35f5@de.ibm.com>
 <20200624090648.6bdf82bd.cohuck@redhat.com>
 <20200625054723.GG172395@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Hlh2aiwFLCZwGcpw"
Content-Disposition: inline
In-Reply-To: <20200625054723.GG172395@umbus.fritz.box>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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


--Hlh2aiwFLCZwGcpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 03:47:23PM +1000, David Gibson wrote:
> On Wed, Jun 24, 2020 at 09:06:48AM +0200, Cornelia Huck wrote:
> > On Mon, 22 Jun 2020 16:27:28 +0200
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >=20
> > > On 19.06.20 04:05, David Gibson wrote:
> > > > A number of hardware platforms are implementing mechanisms whereby =
the
> > > > hypervisor does not have unfettered access to guest memory, in order
> > > > to mitigate the security impact of a compromised hypervisor.
> > > >=20
> > > > AMD's SEV implements this with in-cpu memory encryption, and Intel =
has
> > > > its own memory encryption mechanism.  POWER has an upcoming mechani=
sm
> > > > to accomplish this in a different way, using a new memory protection
> > > > level plus a small trusted ultravisor.  s390 also has a protected
> > > > execution environment.
> > > >=20
> > > > The current code (committed or draft) for these features has each
> > > > platform's version configured entirely differently.  That doesn't s=
eem
> > > > ideal for users, or particularly for management layers.
> > > >=20
> > > > AMD SEV introduces a notionally generic machine option
> > > > "machine-encryption", but it doesn't actually cover any cases other
> > > > than SEV.
> > > >=20
> > > > This series is a proposal to at least partially unify configuration
> > > > for these mechanisms, by renaming and generalizing AMD's
> > > > "memory-encryption" property.  It is replaced by a
> > > > "host-trust-limitation" property pointing to a platform specific
> > > > object which configures and manages the specific details.
> > > >=20
> > > > For now this series covers just AMD SEV and POWER PEF.  I'm hoping =
it
> > > > can be extended to cover the Intel and s390 mechanisms as well,
> > > > though. =20
> > >=20
> > > Let me try to summarize what I understand what you try to achieve:
> > > one command line parameter for all platforms that=20
> > >=20
> > > common across all platforms:
> > > - disable KSM
> > > - by default enables iommu_platform
> > >=20
> > >=20
> > > per platform:
> > > - setup the necessary encryption scheme when appropriate
> > > - block migration
> > > -....
> > >=20
> > >=20
> > > The tricky part is certainly the per platform thing. For example on
> > > s390 we just have a cpumodel flag that provides interfaces to the gue=
st
> > > to switch into protected mode via the ultravisor. This works perfectly
> > > fine with the host model, so no need to configure anything.  The plat=
form
> > > code then disables KSM _on_switchover_ and not in general. Because th=
e=20
> > > guest CAN switch into protected, but it does not have to.
> > >=20
> > > So this feels really hard to do right. Would a virtual BoF on KVM for=
um
> > > be too late? We had a BoF on protected guests last year and that was
> > > valuable.
> >=20
> > Maybe we can do some kind of call to discuss this earlier? (Maybe in
> > the KVM call slot on Tuesdays?) I think it would be really helpful if
> > everybody would have at least a general understanding about how
> > encryption/protection works on the different architectures.
>=20
> Yes, I think this would be a good idea.  KVM Forum is probably later
> than we want, plus since it is virtual, I probably won't be shifting
> into the right timezone to attend much of it.
>=20
> I don't know when that Tuesday KVM call is.  Generally the best
> available time for Australia/Europe meetings this time of year is 9am
> CET / 5pm AEST.  As a once off I could go somewhat later into my
> evening, though.

Oh.. plus I'm on holiday next week and the one after (27 Jun - 12 Jul).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Hlh2aiwFLCZwGcpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl70OpkACgkQbDjKyiDZ
s5IeyRAAwVEArjMO0O/eMYFSBMS46vT0Xspoz5OiR9m897fYy5ZzN2MNjgzSSCU4
IUDAgStKS/X2GkToNDl9nyn3VHZB7X6zuS9wfbCrdBg4ZY1snVcPZlT/QIFvTV2g
keNXzW7Qb40nWFFxI+4tWglwPmXv8+npvbtPXxZhTaukbX+P+FDEdUAWz9mqjDN7
IW0uk2EqE6ZwjxVLcKhGAqVQktrduQTzqjmqFBoDraLxM8OQwaH96XPd+cnFvQKL
h13g6sX1olxGHx2HYCpuCrCjORmSMBkn5HeteqmA16XxsLZgetDg7xvK1GZvj10R
DXaWsjjif72PUhxpItzv/C4+uk2UC29ZVajKPZig09oHaUUROS2+BYCYzTtcBs0n
06p0uDpJKHfDgXEBK44o5yS6Fr5Pk3jBOPnZaMrkzwVIJhuGoh2yV/tOmjm5kGay
ElHFWuNqnX+Fm/H1usCPs2xIHjN5lOuggPwNdt1a94EginlLy4K7aHU7n7zvUu2G
hZ7vFalOUt50ELWiiEPpvr/lJoqivX6cOuEU1SQCAbfEjkVhD6d6++DBm1snw/WQ
DmU6XoturVHY1xQzog34NHTfUym7nQ7g1v1JsGFGS66cAxXW/4TMcVGTu8I16Q/W
sFcXSZQCfcZIWpE+g14e8ngEMxSUSL3MqwezCJe339EQemVmocY=
=pFq4
-----END PGP SIGNATURE-----

--Hlh2aiwFLCZwGcpw--

