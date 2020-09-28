Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD07C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 06:34:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB45F21941
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 06:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="csmWu5y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB45F21941
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMmkK-0007Hg-LK
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 02:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kMmjD-0006Qh-NH; Mon, 28 Sep 2020 02:33:39 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:47211 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kMmj9-0008Ry-CF; Mon, 28 Sep 2020 02:33:39 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C0CQ800Kmz9sPB; Mon, 28 Sep 2020 16:33:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1601274800;
 bh=G+dB8/W5mho7wtfOrxPq/Dw0yvOIxEjy6n5nQ7tmOPM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=csmWu5y3CQFhtgJMpC0fTHJYoFxZSnoOs6uK1QEMhAvLfViy1DSgZp6aztDP8Z1/a
 XjTiM2V0cSjXsoC2WidhKv2mS1FA0CrPzmeILfr4Yrq/Tbz4UyHO6uFSqmLaN59zC1
 aqF2UJRr2v3tXQv2IwqDvlH5lnjTWwTMr48YZy38=
Date: Mon, 28 Sep 2020 16:25:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 2/6] spapr_numa: forbid asymmetrical NUMA setups
Message-ID: <20200928062522.GB501872@yekko.fritz.box>
References: <20200924195058.362984-1-danielhb413@gmail.com>
 <20200924195058.362984-3-danielhb413@gmail.com>
 <20200925034816.GV2298@yekko.fritz.box>
 <f787466e-0f39-fb2e-c36f-59a6bc2dde00@gmail.com>
 <20200926074916.GC2298@yekko.fritz.box>
 <5097b6b6-bd8a-fbac-af11-5e9c1e054559@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <5097b6b6-bd8a-fbac-af11-5e9c1e054559@gmail.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.078,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2020 at 08:41:30AM -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 9/26/20 4:49 AM, David Gibson wrote:
> > On Fri, Sep 25, 2020 at 09:41:02AM -0300, Daniel Henrique Barboza wrote:
> > >=20
> > >=20
> > > On 9/25/20 12:48 AM, David Gibson wrote:
> > > > On Thu, Sep 24, 2020 at 04:50:54PM -0300, Daniel Henrique Barboza w=
rote:
> > > > > The pSeries machine does not support asymmetrical NUMA
> > > > > configurations. This doesn't make much of a different
> > > > > since we're not using user input for pSeries NUMA setup,
> > > > > but this will change in the next patches.
> > > > >=20
> > > > > To avoid breaking existing setups, gate this change by
> > > > > checking for legacy NUMA support.
> > > > >=20
> > > > > Reviewed-by: Greg Kurz <groug@kaod.org>
> > > > > Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> > > >=20
> > > > Having read the rest of the series, I realized there's another type=
 of
> > > > configuration that PAPR can't represent, so possibly we should add
> > > > logic to catch that as well.  That's what I'm going to call
> > > > "non-transitive" configurations, e.g.
> > > >=20
> > > > Node	0	1	2
> > > > 0	10	20	40
> > > > 1	20	10	20
> > > > 2	40	20	10=09
> > > >=20
> > > > Basically the closeness of 0 to 1 and 1 to 2 forces them all to be =
in
> > > > the same domain at every PAPR level, even though 0-2 is supposed to=
 be
> > > > more expensive.
> > >=20
> > > Yes, this is correct. I'm not sure how to proceed in this case
> > > though. Should we error out?
> >=20
> > Given that we're already erroring on asymmetric configurations, I
> > think it makes sense to error for these as well.
>=20
> Thing is that asymmetrical configurations is an easy concept to enforce
> to the user - distance from A to B can't be different from B to A.
>=20
> In the example you gave above, with 3 NUMA nodes, is easy to spot where
> the non-transitivity rule would hit. I'm afraid that if we add 2-3 more
> NUMA nodes in the mix this will stop being straightforward, with more and
> more combinations hitting the 'non-transitivity' rule, and erroring out
> will end up being frustrating to the user.
>=20
> I'd say that we should report this in the documentation as one more
> limitation of the implementation (and PAPR). I wouldn't oppose with
> throwing a warning message either, letting the user know that the
> approximation will be less precise than it already would be in this
> case.

Hmm... yes, I see your point.  Ok, let's go with your suggestion.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9xgdIACgkQbDjKyiDZ
s5L23A/8D6K2jyvZ9fCl42Elfz6S+K+wGNlTSw3rz4SuP2Ey+Nv8W9qPaQ5jWvRk
A6sYh4O/P+bj0JsFHOhEExwtLePMVCr7JNgyFoTVULTnaVOtgIGqVT9ERCVeP9gl
DnGoaGSCPmEo1KgINhet27xZFMbcfvfiT+RdBAtxrkyjHsDf8jUWNngw7MZE2oP7
g/0AMt6ku9vRbo5vDW66iS73UrRJp9GMtPHmV5t/yI6MCmXILhEvlnF/dUNGjQdR
5o19K2hCFl7lvUPv3oIiv/sevhz9qM7IBzYb81WeUYdUE6w1dF6MzY16mprS//3U
ekZF3jW+fxFKEOQYCUWO9yZQh61K3Bth1GMIJcL62L3beSGNRmYKAlCBcTKeQm74
womU1XN2k93P17K+hYrWL1KDt9IFukkxeda3wOMQVu8nuljrDWOAEFlAINdmj9oN
rsCnRs1/2SQBO3vkWtcrbKQ+Ww6Z96ef7d22OjpB5BAEKT3jiRHD2Ppjy2oQfiXl
HwK95nadOnsERkbNfRRk+motavp0bh2+tBRn15zODr9IupWPBNLdmE0i6wGs4+9V
OxEvKGxHQpJrzwuqAkRJFPWbRBLR3L8/1TgDs7Dh8XHjF9jjvDB5oQ3YJtKTgTOj
M3UG0H9EP/4PqHcje1Rtzvh1Ntbn0/LJzJO8w31+arEVd88Ux/c=
=B5T5
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--

