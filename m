Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F729C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 07:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485CC2080A
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 07:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OfTNhRa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485CC2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kM50n-0007GR-9P
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 03:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kM506-0006Wc-Ba; Sat, 26 Sep 2020 03:52:11 -0400
Received: from ozlabs.org ([203.11.71.1]:50711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kM503-0007dy-St; Sat, 26 Sep 2020 03:52:10 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Bz1Ff2LBlz9sSJ; Sat, 26 Sep 2020 17:51:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1601106710;
 bh=i2rkpQ/95M0krRBahXsOsPFK9zZ+jxZeT87+HZiHbuY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OfTNhRa1Nxxm8WlnQdwpjapx1mqAi7UkdF7CatsksR9aOtH1/SVl+IkgvuDOyq9Q2
 7r3sKwvTMvvqCxLWBxd69HIRyh2n2XkX945YAMDFFiISZEmHQmQtDr+ejFNWKVRf+W
 6VJW6coU/0yXFG1R3bDWsSE+Xw08rSUpteo2cyhs=
Date: Sat, 26 Sep 2020 17:49:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 2/6] spapr_numa: forbid asymmetrical NUMA setups
Message-ID: <20200926074916.GC2298@yekko.fritz.box>
References: <20200924195058.362984-1-danielhb413@gmail.com>
 <20200924195058.362984-3-danielhb413@gmail.com>
 <20200925034816.GV2298@yekko.fritz.box>
 <f787466e-0f39-fb2e-c36f-59a6bc2dde00@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gVoQHMRaLt/xBMav"
Content-Disposition: inline
In-Reply-To: <f787466e-0f39-fb2e-c36f-59a6bc2dde00@gmail.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/26 03:51:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--gVoQHMRaLt/xBMav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2020 at 09:41:02AM -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 9/25/20 12:48 AM, David Gibson wrote:
> > On Thu, Sep 24, 2020 at 04:50:54PM -0300, Daniel Henrique Barboza wrote:
> > > The pSeries machine does not support asymmetrical NUMA
> > > configurations. This doesn't make much of a different
> > > since we're not using user input for pSeries NUMA setup,
> > > but this will change in the next patches.
> > >=20
> > > To avoid breaking existing setups, gate this change by
> > > checking for legacy NUMA support.
> > >=20
> > > Reviewed-by: Greg Kurz <groug@kaod.org>
> > > Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> >=20
> > Having read the rest of the series, I realized there's another type of
> > configuration that PAPR can't represent, so possibly we should add
> > logic to catch that as well.  That's what I'm going to call
> > "non-transitive" configurations, e.g.
> >=20
> > Node	0	1	2
> > 0	10	20	40
> > 1	20	10	20
> > 2	40	20	10=09
> >=20
> > Basically the closeness of 0 to 1 and 1 to 2 forces them all to be in
> > the same domain at every PAPR level, even though 0-2 is supposed to be
> > more expensive.
>=20
> Yes, this is correct. I'm not sure how to proceed in this case
> though. Should we error out?

Given that we're already erroring on asymmetric configurations, I
think it makes sense to error for these as well.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gVoQHMRaLt/xBMav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9u8noACgkQbDjKyiDZ
s5I3DBAAyb5WjlRti9pkVkPulCbWoMtAIg9VQrj2R5WA9/m9bxusivsWxGP0A2b2
CY4XYuiZ/qh8giW6u3zCwR6X+RQZcULEgAuGgU5bdcDRV0FXjdUNIpoCJzx9nF+F
Yiv5DyDdQXmIVLixbjbSp+tAi3ZpzsEPxSQPISBJ4jM9+MAjmuA+RSFuI+IiTryJ
WbihUKdUgvSCdBv21VV5elTOmQMrtHBgV/GGb3MOWndgM1P7U1ECYl0M8NhA8fCj
oRVG9AjhQENybqRLODeHdX60MzSZ6MMG/MNhzYTsUxT+11OP/QbxwL5dDcgEL6P0
+1XNhWQN7NLxVQAwPUoN+tJoKOI9lRq1Qr2XcpzFD6KCPzOJ1BMncZD7A/p66wIb
mWND/5dTcbOwzpAlOff5V2JTVe6CC+05E+zEX16D7Wcwi1oiiXiZoFeiG60Ieip7
+nVvYLcvskWRW6BkNHvqhOEf6wAu5CjXV3BH7bz7Ond80OY8/J3t4x6b7mvMm7wg
Zgc3gK+CchlzgEoSvGPivkNqoIPMfzE3M9DykysF5Ax2NxK51aJO9NqXiOJSp9xE
hSKlN0qtB4/mgRr8OI1eY1MLsWsBYdMqb26Dp6xQ7oYfTCDjx+pubx/xvtBZLsWR
GtbwHNDEOCzjkOWhM1N/Ifwjhs/hOdGiJaokwNlaecfqZmoAvYQ=
=OqX+
-----END PGP SIGNATURE-----

--gVoQHMRaLt/xBMav--

