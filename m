Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A4CC4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 09:06:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FDCE2086A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 09:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eWblE4vO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDCE2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iErdx-0001em-Jv
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 05:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iErco-00014i-Cj
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 05:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iErcm-0007u6-Qs
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 05:05:45 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:34239)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iErcl-0007qs-Vr; Mon, 30 Sep 2019 05:05:44 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46hc1w2DSGz9sP7; Mon, 30 Sep 2019 19:05:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569834340;
 bh=znQSArq75pVK6O3/ThCH6quFdmISXYZqbP1kdQvk4J8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eWblE4vOXql4UG3F0NgMCFlaghRAkvpSIdLJ+WFpUgUGJfGUemhk9UZXVz7lA92oD
 GQyk/f2wKEgi/zxCRfLUhjNr+59b3LL5E4ynXdWMVXV6mAslJVUFo0bAhnMzsYsM6a
 LJS3zICm5YMx0oT9xVmB/zNkEP3ziuRN0QpeoJAU=
Date: Mon, 30 Sep 2019 18:45:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 06/20] xics: Create sPAPR specific ICS subtype
Message-ID: <20190930084530.GK11105@umbus.fritz.box>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-7-david@gibson.dropbear.id.au>
 <20190925104050.072877f1@bahia.lan>
 <86d6fe0c-28ab-89a1-fa5f-dbc1d1c024ed@kaod.org>
 <20190926005646.GP17405@umbus> <20190927180556.6e600342@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="C7Ke/meiCZutM6I/"
Content-Disposition: inline
In-Reply-To: <20190927180556.6e600342@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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


--C7Ke/meiCZutM6I/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 06:05:56PM +0200, Greg Kurz wrote:
> On Thu, 26 Sep 2019 10:56:46 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Sep 25, 2019 at 10:55:35AM +0200, C=E9dric Le Goater wrote:
> > > On 25/09/2019 10:40, Greg Kurz wrote:
> > > > On Wed, 25 Sep 2019 16:45:20 +1000
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >=20
> > > >> We create a subtype of TYPE_ICS specifically for sPAPR.  For now a=
ll this
> > > >> does is move the setup of the PAPR specific hcalls and RTAS calls =
to
> > > >> the realize() function for this, rather than requiring the PAPR co=
de to
> > > >> explicitly call xics_spapr_init().  In future it will have some mo=
re
> > > >> function.
> > > >>
> > > >> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > >> ---
> > > >=20
> > > > LGTM, but for extra safety I would also introduce a SpaprIcsState t=
ypedef
> > >=20
> > > why ? we have ICS_SPAPR() for the checks already.
> >=20
> > Eh.. using typedefs when we haven't actually extended a base type
> > isn't common QOM practice.  Yes, it's not as typesafe as it could be,
> > but I'm not really inclined to go to the extra effort here.
>=20
> I'll soon need to extend the base type with a nr_servers field,

Uh.. nr_servers doesn't seem like it belongs in the base ICS type.
That really would conflict with the pnv usage where the ICS is
supposed to just represent the ICS, not the xics as a whole.  If you
need nr_servers information here, it seems like pulling it via a
method in XICSFabric would make more sense.

> and while here with an fd field as well in order to get rid of
> the ugly global in xics.c. I'll go to the extra effort :)

That could go in the derived type.  We already kind of conflate ICS
and XICS-as-a-whole for the PAPR subtype, and the KVM xics is PAPR
only anyway.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--C7Ke/meiCZutM6I/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2RwKoACgkQbDjKyiDZ
s5JbehAAz+I3IoYrAKaDe4hZczMpfLnXFrGB2eObhXdujMpP8xwaabWQ2a8Bx3qg
u+jSO92DbvYaPFXm4pQ7s432YmkreSm9SwkGLMtXCWPxEkga9EWoY1km4ynJNSBw
68y7EcJsSISyWQCHA/dg4Yk4utwWSJlSB/dQCk2w9JHmqjVHj+qV8/bcEwfjcQha
ohX+aoYkcidO8ujPc846MYVQW7ygef6R1b2uZDkQJAS2aOIVt0MlGFwVg8l9mmek
D5RzKt/erXarEU5lQA4FrzGfM6LsM93qO1/rVVtorUcYzsYx+Mj2nfA2TkH3TTjQ
RiFUkltjrKyEcDj2+QuKZCS6AU0gp+vro5PEuWUA/7LFdF9bypEmVqiu9lzlM1qO
kO0W+Xqp+GqKL+aEcaNXXYqwpQoG/FXjcAtFyQfPTPReOxdfgyb0bdtvQh+X3j+d
hL/V2BHB3gqE6X4GkQd0z1EAgL7Qqkb664W0RjNQdyno7N5dctydBOiYxaSZkRPn
CZ/B2AtNEpJHh0LoGV0enxhjebz62yibHiEQExoab6HbRp7Aj0JP5t7WzhGnMrid
RCxiZqVTlV1S4m9tki/OA9gcI9S5qrFdsv1MGHC9fYbVgtMudtGbkVC5EFwtm2du
lkc3Rkkk92v12tGELw7uEh9/b8KltUU2sNxh7UHC9t0GRo3UAGE=
=i/fz
-----END PGP SIGNATURE-----

--C7Ke/meiCZutM6I/--

