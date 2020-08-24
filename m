Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350D7C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 07:30:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1ECC2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 07:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PNu9eA7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1ECC2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA6vj-000464-9v
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 03:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kA6uv-0003Yc-8m; Mon, 24 Aug 2020 03:29:21 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:37649 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kA6ur-0004i1-Bb; Mon, 24 Aug 2020 03:29:20 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BZkJl1mVRz9sSG; Mon, 24 Aug 2020 17:29:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1598254151;
 bh=epDzA1AtayYmrT+ypWhqnuFbwyZtwwO4wgXfXWqgEb4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PNu9eA7X7Zq0/rFMxh37Ch5DdLslsaSx0DaD18BMOixQ8lLpm9vTxV036c4WUGYIS
 Z9XI/5/BYtdOU33Qi7JUkGyrQjJIT9kRWDK8t6uy4EohKmYGM66CCoCzabMzGFVtrU
 KRN+f6uWHDCVuQ9OstDxqzDaHVyhn5nO6XDWt+VE=
Date: Mon, 24 Aug 2020 16:08:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 02/10] numa: introduce
 MachineClass::forbid_asymmetrical_numa
Message-ID: <20200824060839.GE4734@yekko.fritz.box>
References: <20200814205424.543857-1-danielhb413@gmail.com>
 <20200814205424.543857-3-danielhb413@gmail.com>
 <20200820011726.GF271315@yekko.fritz.box>
 <20200820021128.GC642093@habkost.net>
 <20200820041504.GN271315@yekko.fritz.box>
 <20200820165103.GD642093@habkost.net>
 <20200821105538.6f6b46c8@redhat.com>
 <e007c59f-9533-48f0-a08a-6745a29b6600@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ytoMbUMiTKPMT3hY"
Content-Disposition: inline
In-Reply-To: <e007c59f-9533-48f0-a08a-6745a29b6600@gmail.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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


--ytoMbUMiTKPMT3hY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2020 at 09:47:47AM -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 8/21/20 5:55 AM, Igor Mammedov wrote:
> > On Thu, 20 Aug 2020 12:51:03 -0400
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >=20
> > > On Thu, Aug 20, 2020 at 02:15:04PM +1000, David Gibson wrote:
> > > > On Wed, Aug 19, 2020 at 10:11:28PM -0400, Eduardo Habkost wrote:
> > > > > On Thu, Aug 20, 2020 at 11:17:26AM +1000, David Gibson wrote:
> > > > > > On Fri, Aug 14, 2020 at 05:54:16PM -0300, Daniel Henrique Barbo=
za wrote:
> > > > > > > The pSeries machine does not support asymmetrical NUMA
> > > > > > > configurations.
> > > > > >=20
> > > > > > This seems a bit oddly specific to have as a global machine cla=
ss
> > > > > > property.
> > > > > >=20
> > > > > > Would it make more sense for machines with specific NUMA constr=
aints
> > > > > > to just verify those during their initialization?
> > > > >=20
> > > > > This would be much simpler.  However, I like the idea of
> > > > > representing machine-specific configuration validation rules as
> > > > > data that can eventually be exported to management software.
> > > >=20
> > > > Ah, ok, so basically the usual tradeoff between flexibility and
> > > > advertisability.
> > > >=20
> > > > So, in that case, I guess the question is whether we envisage "no
> > > > assymmetry" as a constraint common enough that it's worth creating =
an
> > > > advertisable rule or not.  If we only ever have one user, then we
> > > > haven't really done any better than hard coding the constraint in t=
he
> > > > manageent software.
> > > >=20
> > > > Of course to complicate matters, in the longer term we're looking at
> > > > removing that constraint from pseries - but doing so will be depend=
ent
> > > > on the guest kernel understanding a new format for the NUMA
> > > > information in the device tree.  So qemu alone won't have enough
> > > > information to tell if such a configuration is possible or not.
> > >=20
> > > Requiring both QEMU (and possibly management software) to be
> > > patched again after the guest kernel is fixed sounds undesirable.
> > If we drop this restriction, then we don't need to touch QEMU when
> > guest kernel is ready.
> >=20
> > Btw, what spapr spec says about the matter?
>=20
> LOPAPR support a somewhat asymmetrical NUMA setup in its current
> form,

Huh, I didn't even realize that.  What's the mechanism?

> but
> the Linux kernel doesn't support it. The effort to implement it in the cu=
rrent
> spapr machine code, given that Linux wouldn't mind it, is not worth it. T=
his
> is why I chose to invalidate it for pseries.

Igor,

It's kind of difficult to answer that question - PAPR doesn't
specifically describe limitations, it's just that the representation
it uses is inherently limited.  Instead of the obvious, simple and
pretty much universal method (used in the generic kernel and qemu) of
having a matrix of distance between all the nodes, it instead
describes the hierarchy of components that give rise to the different
distances.

So, for each NUMA relevant object (cpu, memory block, host bridge,
etc.) there is a vector of IDs.  Each number in the vector gives one
level of the objects location in the heirarchy.

So, for example the first number might be the physical chip/socket.
the second one which group of cores & memory interfaces sharing an Ln
cache, the third one the specific core number.  So to work out how far
objects are from each other you essentially look at how long a prefix
of their vector they share, which tells you how far above in the
hierarchy you have to go to reach it.

There's a bunch of complicating details, but that's the gist of it.

> > > Perhaps a warning would be better in this case?
> > >=20
> > > In either case, it sounds like this won't be a common constraint
> > > and I now agree with your original suggestion of doing this in
> > > machine initialization code.
> > Agreed, if it goes to spapr specific machine code I will not object muc=
h.
> > (it will burden just spapr maintainers, so it's about convincing
> > David in the end)
>=20
> I believe he's ok with it given that he suggested it in his first reply.
>=20
> I'll move this verification to spapr machine_init in the next version.
>=20
>=20
>=20
> Thanks,
>=20
> DHB
>=20
>=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ytoMbUMiTKPMT3hY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9DWWUACgkQbDjKyiDZ
s5IMbhAArZ8fKj1CDV5uQ+xv05gklks+rcumkFx4NQh3ZhjbJ3xh4EKiZHel5BG5
DZZrJjpFzph3NL1yZZv8RZ+KpkCUHZjrOdk3y7GM5/Jy2Y56tDNUuDno2Wn2Tk7I
yZH9BJhbZQtsGyxg0n4boKXJvX1IVl5neR+PkKtYcP9vb9L+uLb48nARotCrK+xH
GNTYTTkbag8itiPE0ndtDxCS54dq4u/P+k5uc5lcNnIIlm1h8htU3kaA+bF218s9
YekJdM8Uo6NdZHhdfRs6oFQ7m5J+6mjZjYYkplSX8pLFO2IQ1H4UUNoCq5pqLFdZ
2ijGUUru3tHR46XKdJnGS/1FJxZWOSupBSZCC+7GmdA2yQ+Id0GGXr/Z5Y9fF6r5
canqvWqCQl63b+SrwuodSVRGRlHUB3DfUCtX7hkD/BTrnkr+XQHIPrFbGI8UJ89B
HmleQ8tuCrtsYylopvG5K+fQnSlKFxYGGdGmOrxkv8iW/lyL7hH1iHKbOm6iSH7o
qMRx3+i5LquHab258ywRb4+dNLx6ITgW/+e9LIj9ezmtTDYIPXlHpr545E5pKlvB
f/+8tI+e6pDI3bQIeFo9z1dhCJnlQ6AX7v4Uup+7OwsTnWTF1XatYmCDAiGkp8uo
PHuELtxKFFl1IyaXc8jlFGK13weM7/Rz5cO+b28fCDMtXBPHJDs=
=OYxI
-----END PGP SIGNATURE-----

--ytoMbUMiTKPMT3hY--

