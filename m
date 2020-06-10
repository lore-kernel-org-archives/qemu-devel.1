Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFC0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC4482074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KtdYgiZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC4482074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisza-00045f-36
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 01:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jisjJ-0002YG-Li; Wed, 10 Jun 2020 00:52:49 -0400
Received: from ozlabs.org ([203.11.71.1]:37171)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jisjH-0004ea-33; Wed, 10 Jun 2020 00:52:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49hZFC4Sfcz9sSf; Wed, 10 Jun 2020 14:46:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591764367;
 bh=xI1LVAdzVfoGGosUupL+fXC/IP9TGBExUdIO9fFVnoI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KtdYgiZb6/73I23C6hrE3AE0lmCS3luNtylhenXUxlgz2QP1oPt00hjQFWgW5TR9G
 mdkpOtXRr2mm09VJ9Cyi6sOLtieKKnhQN+GI+BYiou8Wk81BNYho0xfsa6psU4p0x7
 3iE7KqvfF1IEP3chCj4CAIUx8tvjd9OY0vQ7j7dY=
Date: Wed, 10 Jun 2020 14:36:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC v2 00/18] Refactor configuration of guest memory protection
Message-ID: <20200610043621.GH494336@umbus.fritz.box>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200605125505.3fdd7de8.cohuck@redhat.com>
 <20200606084409.GL228651@umbus.fritz.box>
 <20200609121105.50588db9.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zhtSGe8h3+lMyY1M"
Content-Disposition: inline
In-Reply-To: <20200609121105.50588db9.pasic@linux.ibm.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 00:46:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, dgilbert@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, mdroth@linux.vnet.ibm.com,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--zhtSGe8h3+lMyY1M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2020 at 12:11:05PM +0200, Halil Pasic wrote:
> On Sat, 6 Jun 2020 18:44:09 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Jun 05, 2020 at 12:55:05PM +0200, Cornelia Huck wrote:
> > > On Thu, 21 May 2020 13:42:46 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >=20
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
> > > > "guest-memory-protection" property pointing to a platform specific
> > > > object which configures and manages the specific details.
> > > >=20
> > > > For now this series covers just AMD SEV and POWER PEF.  I'm hoping =
it
> > > > can be extended to cover the Intel and s390 mechanisms as well,
> > > > though.
> > >=20
> > > For s390, there's the 'unpack' cpu facility bit, which is indicated i=
ff
> > > the kernel indicates availability of the feature (depending on hardwa=
re
> > > support). If that cpu facility is available, a guest can choose to
> > > transition into protected mode. The current state (protected mode or
> > > not) is tracked in the s390 ccw machine.
> > >=20
> > > If I understand the series here correctly (I only did a quick
> > > read-through), the user has to instruct QEMU to make protection
> > > available, via a new machine property that links to an object?
> >=20
> > Correct.  We used to have basically the same model for POWER - the
> > guest just talks to the ultravisor to enter secure mode.  But we
> > realized that model is broken.  You're effectively advertising
> > availability of a guest hardware feature based on host kernel or
> > hardware properties.  That means if you try to migrate from a host
> > with the facility to one without, you won't know there's a problem
> > until too late.
> >=20
>=20
> Sorry, I don't quite understand the migration problem described here. If
> you have this modeled via a CPU model facility, then you can't migrate
> from a host with the facility to one without, except if the user
> specified CPU model does not include the facility in question. Or am I
> missing something?

Ah, sorry, my mistake.  If it's all based on a cpu model facility that
must be explicitly selected by the user (not based on host
capbilities) then that's ok as well.

The problem comes if you base guest availability on host availability,
which early proposals for the POWER version did involve.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zhtSGe8h3+lMyY1M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7gY0UACgkQbDjKyiDZ
s5IejRAAtjMH9eFvNDqgz5oCfKYEzNSAqc3CD8MHrKOQ23blnzfRbVdMcVr9apii
CuKm4FBmpluNAdj+5QOjqyHIpVqzY/Xn5xhJJp8TE2GGEyUVVWFRcCt6ga/XThTg
e/IOlC/K4dzHJ10pIhfKf4Dmmyyo2FQxxZbjmc6vtQkElELv5+q4WABn6+4puF3s
TMlpK6qtlO/onDNXpypk0c+b3yltKK7UUaJGw0yCVGbOT05yDbYOHHmmTDnlsd3j
3di7VGUNC5pta5EiwrxZWbpw/lVAtPe9VSCScPdZOhjYb431WUuPHc3JRHEy8ABF
dfbs1VBM2abQSXDxoh+x3RDZtv3uAtEJUhVW7TQe4ixQ3RANbE2aBHV+tV2LVUt5
c/mmSVr4ij/CqNdirH8QMC9jBW6+gmzrsh9Assu0MU7scPn3sdn4GVz/PEtw+R9D
Dki3l3BsHJHVVeVb/j1nERmTI9sqmSwI0TIkgD8XhMYEyLAEVJLDCoODZrKfVmny
IuyUH4PsSQ1bWR/I+k85x1C5k8vy/C2YNxsQXSmDNRwBB4j9Gn1feRI0P6gSlWgH
eOPpUTi8LVS+29FSbDwq10I5vwQMIjpjgoBvz6bLn15ON5ShX0/r9JBMdsudMEFF
vtIHo/c97gLkQN72/Q9Uv7uUj5WuZQiRCh4T4Erq5IwgDope8B0=
=3eJu
-----END PGP SIGNATURE-----

--zhtSGe8h3+lMyY1M--

