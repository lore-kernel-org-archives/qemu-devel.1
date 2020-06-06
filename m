Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398A9C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:47:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016C3207F9
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YpAscJI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016C3207F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhUUP-0005Lg-Gl
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 04:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jhUSs-0003hF-ES; Sat, 06 Jun 2020 04:46:06 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:46375 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jhUSp-0005F3-Op; Sat, 06 Jun 2020 04:46:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49fClj0HNYz9sSf; Sat,  6 Jun 2020 18:45:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591433153;
 bh=Sd1rxSYGaP/J1oZ2u/d2cFpFgkmQrMVEQoAFgYu76HU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YpAscJI43jEHPiq4ciauynv+Q5emKXaXV6ZFjtWi3vePEyjmZOZ/g5tYnNO/Kg88p
 D/jhV+qnPMCZtin2mFPEfIPL/5RRyAtY96iVVWkDZIgz5IWrtmH+UlJ397hGAE8/oy
 P35K7WaCEn+hhFeknkNhuXahEMd223UntiqSxOto=
Date: Sat, 6 Jun 2020 18:45:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [RFC v2 00/18] Refactor configuration of guest memory protection
Message-ID: <20200606084545.GM228651@umbus.fritz.box>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <87tuzr5ts5.fsf@morokweng.localdomain>
 <20200604064414.GI228651@umbus.fritz.box>
 <20200604105228.2cb311d3@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="egxrhndXibJAPJ54"
Content-Disposition: inline
In-Reply-To: <20200604105228.2cb311d3@kaod.org>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 dgilbert@redhat.com, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 mdroth@linux.vnet.ibm.com, Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--egxrhndXibJAPJ54
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2020 at 11:08:21AM +0200, Greg Kurz wrote:
> On Thu, 4 Jun 2020 16:44:14 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Jun 04, 2020 at 01:39:22AM -0300, Thiago Jung Bauermann wrote:
> > >=20
> > > Hello David,
> > >=20
> > > David Gibson <david@gibson.dropbear.id.au> writes:
> > >=20
> > > > A number of hardware platforms are implementing mechanisms whereby =
the
> > > > hypervisor does not have unfettered access to guest memory, in order
> > > > to mitigate the security impact of a compromised hypervisor.
> > > >
> > > > AMD's SEV implements this with in-cpu memory encryption, and Intel =
has
> > > > its own memory encryption mechanism.  POWER has an upcoming mechani=
sm
> > > > to accomplish this in a different way, using a new memory protection
> > > > level plus a small trusted ultravisor.  s390 also has a protected
> > > > execution environment.
> > > >
> > > > The current code (committed or draft) for these features has each
> > > > platform's version configured entirely differently.  That doesn't s=
eem
> > > > ideal for users, or particularly for management layers.
> > > >
> > > > AMD SEV introduces a notionally generic machine option
> > > > "machine-encryption", but it doesn't actually cover any cases other
> > > > than SEV.
> > > >
> > > > This series is a proposal to at least partially unify configuration
> > > > for these mechanisms, by renaming and generalizing AMD's
> > > > "memory-encryption" property.  It is replaced by a
> > > > "guest-memory-protection" property pointing to a platform specific
> > > > object which configures and manages the specific details.
> > > >
> > > > For now this series covers just AMD SEV and POWER PEF.  I'm hoping =
it
> > >=20
> > > Thank you very much for this series! Using a machine property is a ni=
ce
> > > way of configuring this.
> > >=20
> > > >From an end-user perspective, `-M pseries,guest-memory-protection` in
> > > the command line already expresses everything that QEMU needs to know,
> > > so having to add `-object pef-guest,id=3Dpef0` seems a bit redundant.=
 Is
> > > it possible to make QEMU create the pef-guest object behind the scenes
> > > when the guest-memory-protection property is specified?
> > >=20
> > > Regardless, I was able to successfuly launch POWER PEF guests using
> > > these patches:
> > >=20
> > > Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > >=20
> > > > can be extended to cover the Intel and s390 mechanisms as well,
> > > > though.
> > > >
> > > > Note: I'm using the term "guest memory protection" throughout to re=
fer
> > > > to mechanisms like this.  I don't particular like the term, it's bo=
th
> > > > long and not really precise.  If someone can think of a succinct way
> > > > of saying "a means of protecting guest memory from a possibly
> > > > compromised hypervisor", I'd be grateful for the suggestion.
> > >=20
> > > Is "opaque guest memory" any better? It's slightly shorter, and sligh=
tly
> > > more precise about what the main characteristic this guest property c=
onveys.
> >=20
> > That's not a bad one, but for now I'm going with "host trust
> > limitation", since this might end up covering things other than just
> > memory protection.
>=20
> Any idea what these other things might be ? It seems a bit hard to
> decide of a proper name without a broader picture at this point.

Well, at the very least there needs to be protection of the guest's
register state from the hypervisor (which may be indirectly implied by
protection of memory).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--egxrhndXibJAPJ54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7bV7kACgkQbDjKyiDZ
s5LoOhAAzTkZg8vVkil2pKGjEcyQt9TxyqYc5VBTeUAd9jKS7wsD/03CgiFRu4iG
fHf+0q0ric0CCUFs8U82v5mvAOZrcAmzGu1JgpPxa7qXWk/TBrd94jvTUgcX5lb9
yJ4Mv5xLlFwaorVYywkKYP0Ry1VrQWQ0DbZ6T9wFTvjC49C0+quWb1IBJgyXR25j
QZZV6RPGkW5WsEd/ixLXzNkU4DPIJlb8t+3RLe8EWCMZ1hExqTmHqsYMhzUJ3/or
/DIyoLhrSyTQdIqIpgwH9BWJIK8/zpijho2wuVxzlh4EfGM6qLTVTapF1tW3OQBl
QlPyYCl7wIOc0to+AuJgZgecm4f0m2JQdHj9h/hCrVgZr6SdLzfsCnhxnA1JaCkV
j2cpyqNSeMcPr8ZHRAwsPZ4+DeP+fs1MBR/6cIzna8x1FUUekQP3xpHvAxYRjRUr
iQ+i2BTf775684gk80bdbVf2JmhNt0DAdoSPtDQG0mkeDDNnvVexTeHY+DE7T0O4
vjU8mjmhuWFnncOc2K6UpqE0iARBstto1QLgOdKM9jsPw2GzGyrNrbilDZrBciHY
nvllZdfQlY9Rx8VTD625iMTSm/jKoEqu7VxeiyeyraZyqnBzTvIF7DWwJKRT8g+r
75Uk6ebYh7TYPvKQOSa8bn4uqM2CYZJyu0LP73rQNIiJuoKGOyM=
=0hIP
-----END PGP SIGNATURE-----

--egxrhndXibJAPJ54--

