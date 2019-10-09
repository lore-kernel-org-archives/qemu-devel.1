Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7BAC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:35:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7673206C0
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XBagI/iI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7673206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIGoF-0006Vf-Cz
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 14:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iIAUG-0001mh-NU
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 07:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iIAUE-0005qO-VL
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 07:50:36 -0400
Received: from ozlabs.org ([203.11.71.1]:59351)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iIAUC-0005pU-MX; Wed, 09 Oct 2019 07:50:34 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46pCFt5fPPz9sDQ; Wed,  9 Oct 2019 22:50:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570621826;
 bh=JXWc6a/C+W21ABulzleeiUgqp48sc/AIJaxqxu3aXKQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XBagI/iIYBCQgDrssy+Aav0cxsi3jghekOXFBz1gHk9ZKXu5y9uiDQ43oVzk6pEsT
 fqK2RiBFLDVykBw+LqBE361Fn/dhaJYTdS+57QWUTNs7rVKpyQeRfq6/Mr9QRxKRjl
 heP8kn3IqAXkD7iFFz1mB1OFVacGW/WiFEF2XphY=
Date: Wed, 9 Oct 2019 22:38:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v4 07/19] spapr: Formalize notion of active interrupt
 controller
Message-ID: <20191009113812.GG5035@umbus.fritz.box>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-8-david@gibson.dropbear.id.au>
 <62e5263d-be23-bd45-51eb-c13853341844@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FwyhczKCDPOVeYh6"
Content-Disposition: inline
In-Reply-To: <62e5263d-be23-bd45-51eb-c13853341844@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--FwyhczKCDPOVeYh6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2019 at 11:19:26AM +0200, C=E9dric Le Goater wrote:
> On 09/10/2019 08:08, David Gibson wrote:
> > spapr now has the mechanism of constructing both XICS and XIVE instance=
s of
> > the SpaprInterruptController interface.  However, only one of the inter=
rupt
> > controllers will actually be active at any given time, depending on fea=
ture
> > negotiation with the guest.  This is handled in the current code via
> > spapr_irq_current() which checks the OV5 vector from feature negotiatio=
n to
> > determine the current backend.
> >=20
> > Determining the active controller at the point we need it like this
> > can be pretty confusing, because it makes it very non obvious at what
> > points the active controller can change.  This can make it difficult
> > to reason about the code and where a change of active controller could
> > appear in sequence with other events.
> >=20
> > Make this mechanism more explicit by adding an 'active_intc' pointer
> > and an explicit spapr_irq_update_active_intc() function to update it
> > from the CAS state.  We also add hooks on the intc backend which will
> > get called when it is activated or deactivated.
> >=20
> > For now we just introduce the switch and hooks, later patches will
> > actually start using them.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> Btw, we will need an extra xive2 pointer for the Power10 interrupt=20
> controller.

Yeah, I figured.  I think it should be easier to add more irq backends
with the new structure.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FwyhczKCDPOVeYh6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2dxqIACgkQbDjKyiDZ
s5KJCQ//Si6erEyBps7otNwC0+DRu8z3A5wWvoeJ62qMvfXk4Z3HiGPhsTZ+nb1Q
n8DcGVRPIRUG5Ovk3Vy4BXkG9jhYRinLRJdYJZd+LhpWG3eIQ4e/rnYTiYHggJSb
7m2iURQBNGlFMMwf0f8VqQEIH89sdXz4RMoT0zLB3ucKIF+4LyYp8rJLfhGXbDnT
O88JbtgIWEeEjZhM24RHpDSZ3DhMCiFbv3emLPRN44tVK98NJjOxi6TXkE0+bcIt
O1LKiaMA8iJPGSipQpevBiUllJjRARsi22Z+VPMJV06meNGRlsczbAiAqmHH3MFH
nx7/lMgW7lBQDmdeeWgAXjwQcpLSInG6MaTaBLb5dyP6Pdrff18s2rZkG6lGkpru
7NiwJRu7d9CY+k3jgV42enPxgW9RTMhC7uY91gWGkidjVFUGHFH0f3HwqxAVzUHP
xUuDG+royzumNupsIgx9O3M2SPSMFmwkKYs1EtQYLBs2xnRK+JoY75M9vLYhAhnr
xBAgPrLp0rST6VglHsErxjD0eahKnXpO9m88bXxlL+QYSWHDqqI0WNlOtdN5KUMX
HSpCQqN6ysmM91vUZmUz4l3TnGbUJr4kAYsD4ylwgJAU4spqiK6o+W4Wo9IcfreB
2eN3YRRgVwvlmQkP6KI5HYKINnOriDz+TBPf0/hxBqT6XmWKErs=
=/8G8
-----END PGP SIGNATURE-----

--FwyhczKCDPOVeYh6--

