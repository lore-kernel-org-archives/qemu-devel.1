Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6D2C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 01:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F9621D91
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 01:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="etnHL5sN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F9621D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZOIt-0000ei-Uj
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 20:06:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kZOHf-0008EU-J9; Sun, 01 Nov 2020 20:05:19 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:49657 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kZOHc-0007LT-LQ; Sun, 01 Nov 2020 20:05:18 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CPZT823nDz9sVH; Mon,  2 Nov 2020 12:05:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1604279100;
 bh=b7HomrenV/FFWQpqN7r9WFMdvcv/rU/8LMX1lHNBhNo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=etnHL5sNt4KjdXFqeUIugO4YPpBHn4PnosYhLfkD1dPhAxN8Ez8J+4C+ka3yL+mYI
 tayIQf+ISThuiPdu8K4oiB+40f1HuZKrtwhI79sw6Ek8mMsqq/UnESUEFx7S/Rwfdr
 7xHdCOduUBlH4FUFv1EVmY0s6ChLY6KA1mQ4U4Q0=
Date: Mon, 2 Nov 2020 11:57:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 4/5] spapr: Pass &error_abort when getting some PC DIMM
 properties
Message-ID: <20201102005756.GB143651@yekko.fritz.box>
References: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
 <160309732180.2739814.7243774674998010907.stgit@bahia.lan>
 <20201023211509.5c316c01@redhat.com>
 <20201025162444.0fdec88a@bahia.lan>
 <20201027125424.13833af8@redhat.com>
 <20201027161858.590329a7@bahia>
 <20201028162216.0f33e0ef@redhat.com>
 <20201030142542.3051b508@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
In-Reply-To: <20201030142542.3051b508@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 20:05:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 02:25:42PM +0100, Greg Kurz wrote:
> On Wed, 28 Oct 2020 16:22:16 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> > On Tue, 27 Oct 2020 16:18:58 +0100
> > Greg Kurz <groug@kaod.org> wrote:
> >=20
> [...]
> > >=20
> > > It might require some more code refactoring because the way regular
> > > PC-DIMMs are broken down into a set of logical memory blocks (LMBs),
> > > each one having its own DRC but it's certainly doable. Probably for
> > > QEMU 6.0 though since we're entering soft freeze and David already
> > > fired a PR today.
> >=20
> > as far as it's not forgotten, it can be done later.
> >=20
>=20
> David,
>=20
> Can you create a ppc-for-6.0 branch ?

Done.

>=20
> Cheers,
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+fWZQACgkQbDjKyiDZ
s5J8VRAAqxjdOqdkW7ubsTScSWIm1KPwKXkdZ1VXxvMmsFfskfimH5rgOCz+/z8n
XNBc0rdYTxZYhBEYsPevIg2cc6Oj8kqPikhB2V8voHI7ryQxxgaM3buDAujQrPFp
9J1A3Bz29lGQ5ry6rwtUI+/NGp5FB2kw8EjtOYL3OFu97yHDaB4QEzVF5CS7TTgO
8XDuaFnURjkgT4gvEeQ408xGmVKQV5KjwWvyJ6b6B2wyLYhX6N0wrLOipFQdaUNY
DVm4AMldCc+aGG5PcjYPSOja2yL630p5iptIkeGjbmzOgq4lMlRRHAndYCxO/APj
KGaGf/9oWib2zObhQAOHdoMWrEXK4vvg2CPwH7jilXrQ5Me6YsxcbrlI6AlijQj0
Hi3npgFyopZRIzEksb9BNz9boMhhu8xw+ydqLSlWXkdJogl8kbhcPXkB55NHW2ER
CtBrlJq4Fn0JMmbKZzKqDWAygfqyYI0JiL30Z1VdNDa6Xtnv9CooV7ILQZweNIyy
M96tjPHpujt5N0yVQyTNe+eP0BzEb0ebqG2N5cnigfy+Cn2lI6PlFdEHDGSNEsgE
qVxK1CvMmEI1cHyGTpDnlqWBI3R3fPjrhAhcZkammucgiZkeufGAxNVUP2JSP8Ak
KkSQDA01PGk1hU2nzBOoUyBND9cEs4PqV/sVBCLxtcBWJy+FIlI=
=ssRw
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--

