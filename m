Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CC6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 11:19:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C9F820706
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 11:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PjxOJqmy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C9F820706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAWzT-0003nc-Ol
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 07:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kAWwU-00072U-FX; Tue, 25 Aug 2020 07:16:43 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:41845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kAWwS-00053w-55; Tue, 25 Aug 2020 07:16:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BbRJc2dthz9sTm; Tue, 25 Aug 2020 21:16:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1598354192;
 bh=EQPdCzGXEohFL8bGkVDNx+u+KUy8Mwb8RMIjqXsIKOE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PjxOJqmyPQNZQDdgru4qmelsmeO6iJ1MGo6YTFn9kbyN7oCcgrTmTjwneDk/K0l46
 oZC59MdlvrThAQvUy2LGLd/uw8ofTn87CDWYyhQd8ExqHLugmUf1qDtwRnBqcC1AS+
 Tc6otrfuSjIKH5RkvybhcNEFRo7nj4HKi6mZvPik=
Date: Tue, 25 Aug 2020 21:12:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 02/10] numa: introduce
 MachineClass::forbid_asymmetrical_numa
Message-ID: <20200825111208.GH4734@yekko.fritz.box>
References: <20200820011726.GF271315@yekko.fritz.box>
 <20200820021128.GC642093@habkost.net>
 <20200820041504.GN271315@yekko.fritz.box>
 <20200820165103.GD642093@habkost.net>
 <20200821105538.6f6b46c8@redhat.com>
 <e007c59f-9533-48f0-a08a-6745a29b6600@gmail.com>
 <20200824060839.GE4734@yekko.fritz.box>
 <f936f3a7-78d1-dd1f-511b-1705c165fc06@gmail.com>
 <20200824234917.GF4734@yekko.fritz.box>
 <98728fe4-1262-6be2-8dd1-1b38ffbe81e9@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YrlhzR9YrZtruaFS"
Content-Disposition: inline
In-Reply-To: <98728fe4-1262-6be2-8dd1-1b38ffbe81e9@gmail.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--YrlhzR9YrZtruaFS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2020 at 06:56:46AM -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 8/24/20 8:49 PM, David Gibson wrote:
> > On Mon, Aug 24, 2020 at 08:45:12AM -0300, Daniel Henrique Barboza wrote:
> > >=20
> > >=20
>=20
> [...]
>=20
> > > > > LOPAPR support a somewhat asymmetrical NUMA setup in its current
> > > > > form,
> > > >=20
> > > > Huh, I didn't even realize that.  What's the mechanism?
> > >=20
> > > LOPAPR mentions that a single resource/node can have multiple associa=
tivity
> > > arrays. The idea is to contemplate the situations where the node has
> > > more than one connection with the board.
> > >=20
> > > I say "somewhat" because, right after mentioning that, the spec also =
says that
> > > the OS should consider that the distance between two nodes must alway=
s be
> > > the shortest one of all available arrays. I'll copy/paste the except =
here
> > > (end of section 15.2, "Numa Resource Associativity":
> >=20
> > Ah.  I didn't think that's what "asymmetric NUMA" meant... but come to
> > think of it, I'm not very sure about that.
>=20
>=20
> This was a poor attempt of my part to cut PAPR some slack.
>=20
> TBH, even if current PAPR allows for some form of NUMA asymmetry, I don't=
 think
> it's worth implementing at all. It'll be more complexity on top of what I
> already added here, and the best case scenario will be the kernel ignorin=
g it
> (worst case - kernel blowing it up because we're adding more associativity
> arrays in each CPU and so on).

Yes, I agree.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YrlhzR9YrZtruaFS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9E8gYACgkQbDjKyiDZ
s5I3DRAAtF8dcAIIEBRolOFiMVxR+78skl5PnuCMJ4zasQNedouQEg2KL6HjMgX4
0tgEpAea8UCw/yRRjzev+Gze0Onk6Veadmtb+LF4B4DNKuDaWFXDbqFHvKq5gz+2
Mcpw1PL6ui8Qmh50DN1oQ07w/OVEQFco6tIJ5eop2cPS+P222DtCQ0+QegIAggL8
6k+TjnoGwCqFlYbymPuC8p1wFTAFPo/PKTOHAFETpJJ4QQOzfjdYu1lhl5dTAVRi
lz+wimWwXw8dwJbmEDzWpe7pDEm5791gQ4MCwZO4ZhGqoAT/ScObFAu0Zz1z+4uL
UqQVnUmZ9TuX0kdM93GT6Ecyz08fCRJZ+SkVSrs/2DC6DRaN7yXfZqfvB1pWUdKA
zcxcd54bn0V57ToIW3Q3AbfPea18WnOLua8e3yGqFOOXAjHZhEORRYVeFa6HdySE
QLLkKWuw6iUR/AXQsySbx0KoxN/RiJL1lGrIINR/sCbU8WEp3voJDJC/nGPPTbAD
17qriPebXLDH9EOiD4rzyTqWbBQphHg65tUpkae3GHyvHr9b3dZNaKA/tcWrizPs
46E7kMRZD8BCVKKsVo3mdvr1xziX6548SohrkJO42ZYPN3G3D9WHpq/zfcgUL85k
lOIIOHmg/6FHXGheBqaSGNuGZFZq1aNlOIBKIuLig7JxlJHxAIc=
=lp04
-----END PGP SIGNATURE-----

--YrlhzR9YrZtruaFS--

