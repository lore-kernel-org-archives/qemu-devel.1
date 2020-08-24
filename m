Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C113C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 03:11:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF062207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 03:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GkoDcEe0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF062207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAPMi-0002Yj-2C
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 23:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kAPLP-0001tw-AC; Mon, 24 Aug 2020 23:09:56 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:32797 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kAPLL-0007y6-Mk; Mon, 24 Aug 2020 23:09:55 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BbDVn30lWz9sTY; Tue, 25 Aug 2020 13:09:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1598324977;
 bh=cd5RPfu73PiVpl9SnCf/8IuOO53129pq/DYqc7EtygU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GkoDcEe0tNSMoP2LPu4q7FxveqFh9yNfYaWVG3DliNPGDwxX+PLvz4cTDe8Rlg4X+
 f1mPz3YEkL4DZ5xxM4KkZYifgc5XFTJB71Dd+Vk8ABYYkhvbMmXI4VzA6FVpC7zkIU
 tx8RuTjo2Y7uDSVdUf2ph50dMB/rT6cy+xTo+g5I=
Date: Tue, 25 Aug 2020 09:49:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 02/10] numa: introduce
 MachineClass::forbid_asymmetrical_numa
Message-ID: <20200824234917.GF4734@yekko.fritz.box>
References: <20200814205424.543857-1-danielhb413@gmail.com>
 <20200814205424.543857-3-danielhb413@gmail.com>
 <20200820011726.GF271315@yekko.fritz.box>
 <20200820021128.GC642093@habkost.net>
 <20200820041504.GN271315@yekko.fritz.box>
 <20200820165103.GD642093@habkost.net>
 <20200821105538.6f6b46c8@redhat.com>
 <e007c59f-9533-48f0-a08a-6745a29b6600@gmail.com>
 <20200824060839.GE4734@yekko.fritz.box>
 <f936f3a7-78d1-dd1f-511b-1705c165fc06@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WlEyl6ow+jlIgNUh"
Content-Disposition: inline
In-Reply-To: <f936f3a7-78d1-dd1f-511b-1705c165fc06@gmail.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 23:09:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--WlEyl6ow+jlIgNUh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2020 at 08:45:12AM -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 8/24/20 3:08 AM, David Gibson wrote:
> > On Fri, Aug 21, 2020 at 09:47:47AM -0300, Daniel Henrique Barboza wrote:
> > >=20
> > >=20
> > > On 8/21/20 5:55 AM, Igor Mammedov wrote:
> > > > On Thu, 20 Aug 2020 12:51:03 -0400
> > > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > > >=20
> > > > > On Thu, Aug 20, 2020 at 02:15:04PM +1000, David Gibson wrote:
> > > > > > On Wed, Aug 19, 2020 at 10:11:28PM -0400, Eduardo Habkost wrote:
> > > > > > > On Thu, Aug 20, 2020 at 11:17:26AM +1000, David Gibson wrote:
> > > > > > > > On Fri, Aug 14, 2020 at 05:54:16PM -0300, Daniel Henrique B=
arboza wrote:
> > > > > > > > > The pSeries machine does not support asymmetrical NUMA
> > > > > > > > > configurations.
> > > > > > > >=20
> > > > > > > > This seems a bit oddly specific to have as a global machine=
 class
> > > > > > > > property.
> > > > > > > >=20
> > > > > > > > Would it make more sense for machines with specific NUMA co=
nstraints
> > > > > > > > to just verify those during their initialization?
> > > > > > >=20
> > > > > > > This would be much simpler.  However, I like the idea of
> > > > > > > representing machine-specific configuration validation rules =
as
> > > > > > > data that can eventually be exported to management software.
> > > > > >=20
> > > > > > Ah, ok, so basically the usual tradeoff between flexibility and
> > > > > > advertisability.
> > > > > >=20
> > > > > > So, in that case, I guess the question is whether we envisage "=
no
> > > > > > assymmetry" as a constraint common enough that it's worth creat=
ing an
> > > > > > advertisable rule or not.  If we only ever have one user, then =
we
> > > > > > haven't really done any better than hard coding the constraint =
in the
> > > > > > manageent software.
> > > > > >=20
> > > > > > Of course to complicate matters, in the longer term we're looki=
ng at
> > > > > > removing that constraint from pseries - but doing so will be de=
pendent
> > > > > > on the guest kernel understanding a new format for the NUMA
> > > > > > information in the device tree.  So qemu alone won't have enough
> > > > > > information to tell if such a configuration is possible or not.
> > > > >=20
> > > > > Requiring both QEMU (and possibly management software) to be
> > > > > patched again after the guest kernel is fixed sounds undesirable.
> > > > If we drop this restriction, then we don't need to touch QEMU when
> > > > guest kernel is ready.
> > > >=20
> > > > Btw, what spapr spec says about the matter?
> > >=20
> > > LOPAPR support a somewhat asymmetrical NUMA setup in its current
> > > form,
> >=20
> > Huh, I didn't even realize that.  What's the mechanism?
>=20
> LOPAPR mentions that a single resource/node can have multiple associativi=
ty
> arrays. The idea is to contemplate the situations where the node has
> more than one connection with the board.
>=20
> I say "somewhat" because, right after mentioning that, the spec also says=
 that
> the OS should consider that the distance between two nodes must always be
> the shortest one of all available arrays. I'll copy/paste the except here
> (end of section 15.2, "Numa Resource Associativity":

Ah.  I didn't think that's what "asymmetric NUMA" meant... but come to
think of it, I'm not very sure about that.

> -----
>=20
> The reason that the =E2=80=9Cibm,associativity=E2=80=9D property may cont=
ain multiple associativity
> lists is that a resource may be multiply connected into the platform. Thi=
s resource
> then has a different associativity characteristics relative to its multip=
le connections.
> To determine the associativity between any two resources, the OS scans do=
wn the two
> resources associativity lists in all pair wise combinations counting how =
many domains
> are the same until the first domain where the two list do not agree. The =
highest such
> count is the associativity between the two resources.
>=20
> ----
>=20
>=20
> DHB
>=20
>=20
> >=20
> > > but
> > > the Linux kernel doesn't support it. The effort to implement it in th=
e current
> > > spapr machine code, given that Linux wouldn't mind it, is not worth i=
t. This
> > > is why I chose to invalidate it for pseries.
> >=20
> > Igor,
> >=20
> > It's kind of difficult to answer that question - PAPR doesn't
> > specifically describe limitations, it's just that the representation
> > it uses is inherently limited.  Instead of the obvious, simple and
> > pretty much universal method (used in the generic kernel and qemu) of
> > having a matrix of distance between all the nodes, it instead
> > describes the hierarchy of components that give rise to the different
> > distances.
> >=20
> > So, for each NUMA relevant object (cpu, memory block, host bridge,
> > etc.) there is a vector of IDs.  Each number in the vector gives one
> > level of the objects location in the heirarchy.
> >=20
> > So, for example the first number might be the physical chip/socket.
> > the second one which group of cores & memory interfaces sharing an Ln
> > cache, the third one the specific core number.  So to work out how far
> > objects are from each other you essentially look at how long a prefix
> > of their vector they share, which tells you how far above in the
> > hierarchy you have to go to reach it.
> >=20
> > There's a bunch of complicating details, but that's the gist of it.
> >=20
> > > > > Perhaps a warning would be better in this case?
> > > > >=20
> > > > > In either case, it sounds like this won't be a common constraint
> > > > > and I now agree with your original suggestion of doing this in
> > > > > machine initialization code.
> > > > Agreed, if it goes to spapr specific machine code I will not object=
 much.
> > > > (it will burden just spapr maintainers, so it's about convincing
> > > > David in the end)
> > >=20
> > > I believe he's ok with it given that he suggested it in his first rep=
ly.
> > >=20
> > > I'll move this verification to spapr machine_init in the next version.
> > >=20
> > >=20
> > >=20
> > > Thanks,
> > >=20
> > > DHB
> > >=20
> > >=20
> > > >=20
> > >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WlEyl6ow+jlIgNUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9EUfkACgkQbDjKyiDZ
s5JZEw/+PfNwre1zOHi2TDH4IEf3qFJPeCzqFQrgVfBrIQWLTorCzgWNHb18nuVA
I3dIYsvOv0FGllyn62aT97rllchBS/NHPp2i4Vp2kCemGIVANZf08mXb7KyZo5KK
rf2puxT7NSUT3OyJR1hWAdXkjdRjsewN4FZej+RIeN/mh48kBLI5x9rMp6nM9wYP
G/7sbzTYAFjzX3sl5j4GhU6B3WeWtuliyY/ZBd0AOd6gWdSjUx5Jq+m87Cg2XJHz
9J7/0lmRqNq2WaYfNtwYIw3hRRnnL5iSaDphQdcDI2j5tjZElBcqsQQMbdMcrS0g
cCtKAZ4Gvw3FZrV94HC7N1QPVJx+3VQBvlpyt52GWvnQJMsNQlD8F2KPfcZBvfsa
PxvPh6VVsU68xVGMBCeQuKnP1egYPcrBccJ7IfcXUpIVnlGT1fYTIZ4Nqb7jQ8Y2
U1i2edJRj0IgaRQhbE7etAKfYlhA4gmp9G7LM7goit0bd2+B1AC8JRsnwJ4Gat/g
a0WdcKWU42z0VDGLJNepKI5mbNW36/bfe3dh/Qz32ZwaFkFuoEuY8qMygD1SOBzS
0DkA1FlH0w0xtsSNJlY5bFsOx+M4GVt5mLU0oLvBWpvFHFqQjuC71W/rB7RhTLb9
Xodfx8G1aYwhqr2t0Zr7Wrs/tOsLgeAN2uuR7mRoZRVvIjSZS6A=
=Nx2y
-----END PGP SIGNATURE-----

--WlEyl6ow+jlIgNUh--

