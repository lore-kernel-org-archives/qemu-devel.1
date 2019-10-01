Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666E6C32792
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 01:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C8772075C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 01:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="QYuVDmxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C8772075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF7Ry-0000a0-Ct
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 21:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iF7RH-00008F-8p
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 21:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iF7RF-0007cR-Nc
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 21:58:55 -0400
Received: from ozlabs.org ([203.11.71.1]:44789)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iF7RE-0007ZC-Jy; Mon, 30 Sep 2019 21:58:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46j2Vq574Gz9sP7; Tue,  1 Oct 2019 11:58:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569895123;
 bh=P/1PDf8fbIs/fE8BpE68TkgyDm74UDFo92Rno9dgRRs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QYuVDmxxx5zAC9/n89e+2q/YSGEfYFZ9KQP2i6xg5HIz6B0TLLwwx7Wmp+hGAMszA
 q8aOmsBKmPnnpmBjhqV+yO3gezuUdE8agCCTQV/rDgG+bEapOEGXofndTbuLcWFihC
 pD6JuYEgY/saVY3PFUuJtp9WjW9Qo1drnXT46+Ac=
Date: Tue, 1 Oct 2019 11:45:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 06/20] xics: Create sPAPR specific ICS subtype
Message-ID: <20191001014507.GM11105@umbus.fritz.box>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-7-david@gibson.dropbear.id.au>
 <20190925104050.072877f1@bahia.lan>
 <86d6fe0c-28ab-89a1-fa5f-dbc1d1c024ed@kaod.org>
 <20190926005646.GP17405@umbus> <20190927180556.6e600342@bahia.lan>
 <20190930084530.GK11105@umbus.fritz.box>
 <20190930190043.5e9b51ed@bahia.w3ibm.bluemix.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dp9QYJgVRVEW2bsm"
Content-Disposition: inline
In-Reply-To: <20190930190043.5e9b51ed@bahia.w3ibm.bluemix.net>
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
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--dp9QYJgVRVEW2bsm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2019 at 07:00:43PM +0200, Greg Kurz wrote:
> On Mon, 30 Sep 2019 18:45:30 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Sep 27, 2019 at 06:05:56PM +0200, Greg Kurz wrote:
> > > On Thu, 26 Sep 2019 10:56:46 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >=20
> > > > On Wed, Sep 25, 2019 at 10:55:35AM +0200, C=E9dric Le Goater wrote:
> > > > > On 25/09/2019 10:40, Greg Kurz wrote:
> > > > > > On Wed, 25 Sep 2019 16:45:20 +1000
> > > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > > >=20
> > > > > >> We create a subtype of TYPE_ICS specifically for sPAPR.  For n=
ow all this
> > > > > >> does is move the setup of the PAPR specific hcalls and RTAS ca=
lls to
> > > > > >> the realize() function for this, rather than requiring the PAP=
R code to
> > > > > >> explicitly call xics_spapr_init().  In future it will have som=
e more
> > > > > >> function.
> > > > > >>
> > > > > >> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > > >> ---
> > > > > >=20
> > > > > > LGTM, but for extra safety I would also introduce a SpaprIcsSta=
te typedef
> > > > >=20
> > > > > why ? we have ICS_SPAPR() for the checks already.
> > > >=20
> > > > Eh.. using typedefs when we haven't actually extended a base type
> > > > isn't common QOM practice.  Yes, it's not as typesafe as it could b=
e,
> > > > but I'm not really inclined to go to the extra effort here.
> > >=20
> > > I'll soon need to extend the base type with a nr_servers field,
> >=20
> > Uh.. nr_servers doesn't seem like it belongs in the base ICS type.
>=20
> Of course ! I re-used the wording "extended a base type" of your sentence,
> that I understand as "a subtype extends a base type with some more data".
> I'm talking about the sPAPR ICS subtype here, not the base ICS type.

Ah, ok.

> > That really would conflict with the pnv usage where the ICS is
> > supposed to just represent the ICS, not the xics as a whole.  If you
> > need nr_servers information here, it seems like pulling it via a
> > method in XICSFabric would make more sense.
> >=20
> > > and while here with an fd field as well in order to get rid of
> > > the ugly global in xics.c. I'll go to the extra effort :)
> >=20
> > That could go in the derived type.  We already kind of conflate ICS
> > and XICS-as-a-whole for the PAPR subtype, and the KVM xics is PAPR
> > only anyway.
> >=20
>=20
> Exactly, so that's why I was thinking about adding nr_servers there,
> but it could go to XICSFabric as well I guess.



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dp9QYJgVRVEW2bsm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2Sr6MACgkQbDjKyiDZ
s5Ja/hAAlHQSONlCeiyUabuNnEexaszgQBJ/70nvfmipBLZVVNaqBjMoAqypUZD+
zTh5WcKwVPvteKQl/xlel1c/CLNE51G/75WP2asHa+11ifUwPbmhzqP6tQPcBIwO
2yKNqnpQ2afkkGhreXzZ2Rh8C2Ux1bmqfTbE+PPZKkzRH2Z49d/NjcATOq+gOWvh
kQn5FFBL8Hn7eIO2cyM51Bgr4XVL92M9ayDgMgfwv05f0B5aJ3JSd1ntD35wMJ4t
r1deRGpAF4ogzkQBBmbBG7JyM3zQiC7eybAAaCIrsDwE1qL64df9C3j5+ZdVq2xx
h/uRfIsMKXHPeJaN/HwOHViUe9BsFlgp6nllBOj/c+gzKIx6aH36M9TZRh4F1gyg
YkF2+NYzzh2EzA7Ef+mREGznhgCmd7bZtYQcnyisYNFOunQuu3glbQtCN9jrX5Gx
0yLErjZzp5nhVKrBa2PZKucMGDnl8l74is66F/yd9hERKJKYGTM9NffSeeB3qUJ/
a232ZXZpa19YLyc3k9pNm5UaSusqJRwz0npmM2by/ZvkVTXB7zFwtGmygb+eSQuI
heX4PDZxZJeiCr6q7X2ZUJ2KHGNj27jOWZlBALK13oXxZq6UfAvy44qTBZbE0Hlc
WANSX9rVrQqt7YF1aWcGBHYwQv0swev74AvhpszWcFVtTtRNB+w=
=WMgl
-----END PGP SIGNATURE-----

--dp9QYJgVRVEW2bsm--

