Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1429C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:02:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6143207ED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="krvd+2BQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6143207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jissb-0008Th-RO
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 01:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jisjJ-0002ZT-TD; Wed, 10 Jun 2020 00:52:49 -0400
Received: from ozlabs.org ([203.11.71.1]:32969)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jisjI-0004ec-3H; Wed, 10 Jun 2020 00:52:49 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49hZFC1mt1z9sSF; Wed, 10 Jun 2020 14:46:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591764367;
 bh=GcrZ2bo9JXzoBwffO7M8WF0qoOU1c9mkyt0UHk5oGSU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=krvd+2BQXK5AnDK0PSKE7jD7mtk1nz7TIT0g/Od0Xrn0V5njP2aH/cUMTmnkosmIF
 NG6HKKqN5XhHDie3fVJ16DTlwO/vPsOi2b2MLTBBpq0RIQXBvXl+PZ+9ZPjFU6iqPe
 QKhn3JynjyyptLOXjKxZQP8FEmLmaSFML307Ado4=
Date: Wed, 10 Jun 2020 14:25:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
 if PV
Message-ID: <20200610042554.GD494336@umbus.fritz.box>
References: <20200514221155.32079-1-pasic@linux.ibm.com>
 <20200520121507-mutt-send-email-mst@kernel.org>
 <20200606013217.2cffa3ed.pasic@linux.ibm.com>
 <20200608181428.3c6f127c.cohuck@redhat.com>
 <20200608190045.319dd68b.pasic@linux.ibm.com>
 <20200609084402.35d317ec.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
Content-Disposition: inline
In-Reply-To: <20200609084402.35d317ec.cohuck@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2020 at 08:44:02AM +0200, Cornelia Huck wrote:
> On Mon, 8 Jun 2020 19:00:45 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
>=20
>=20
> > > I'm also not 100% sure about migration... would it make sense to
> > > discuss all of this in the context of the cross-arch patchset? It see=
ms
> > > power has similar issues.
> > >  =20
> >=20
> > I'm going to definitely have a good look at that. What I think special
> > about s390 is that F_ACCESS_PLATFORM is hurting us because all IO needs
> > to go through ZONE_DMA (this is a problem of the implementation that
> > stemming form a limitation of the DMA API, upstream didn't let me
> > fix it).=20
>=20
> My understanding is that power runs into similar issues, but I don't
> know much about power, so I might be entirely wrong :)

Sort of, but not to the same extent, I think.

[snip]
> > > (Can we disallow transition to pv if it is off? Maybe with the machine
> > > property approach from the cross-arch patchset?) =20
> >=20
> > No we can't disallow transition because for hotplug that already
> > happened.
>=20
> I mean, can a virtio devices without IOMMU_PLATFORM act as a transition
> blocker (i.e. an attempt by a guest to move to pv would fail?)

This might be possible, but I suspect having to explicitly say you
want pv support, then having it validate virtio (and anything else it
needs) will give a better UX.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7gYNIACgkQbDjKyiDZ
s5Jb3RAAwqLhoaTkTMvKuU+Ar73Y2DMpDqaI91ZzA6bvPuN/RaYaCp1PaiVPx0Gx
+Gp6JQBdP2vUAfrVCv0L/5dnUOPrpcQWuuHVyre3Lx0106m1e0f9afAV3luLtjeV
0Gh1Ney1UdhKfOu0MN83B8npOZGqj9zXqeR8D8UX6Jkv+qb9/5OVkZFzH6uMRt1l
st/r2JXakTR6Li5fFKlCuWInUMDtm2xrsYqlehl8bwF3FChawZenwZVoY2bH9qnw
XALfGRnSYgGqyc+5zWy3GVljP8eatSNUdm8pM0NwD/gQ55643SFQB6CF+ny4Mh+t
tDMDBVut2KUuuOE1SaNsJgPwH/2I61hvty4/QF2Y3dBqSj9QJSPZRZrrlqqyFI9c
NItJjWf1LKT83Nh1lt57bKz/OeRHBq1h05ONULdZQIEh3Mw4HMlTC0acwJuCC76K
QsdvCpBNoaPReAPRkcsPZ1Sm29lW6molDTzFsdCORx+kO2oWwHFD75pCNfHne0wQ
3Jh16x8NXLkNO3LtxwZ4G3GtANmgC3HfxjXBsQkp8SplZMSezo9uh8eci1DGhVHf
noqWTqSJQPms/UU7CcaPpC/GLvwC07LPheaL4K0tAFDUTy21C8iTJ9I2Kkj24BGJ
LkSwDiOQgKV3eDCuMouAIlHX3AUPo2laY3JiPG8PGQDFPF8RECw=
=9/xA
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--

