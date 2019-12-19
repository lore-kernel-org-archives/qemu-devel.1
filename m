Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FD0C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 01:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA022072B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 01:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mbqHWKtf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA022072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihl1y-0003dm-CU
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 20:55:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ihl1H-0002ma-GG
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 20:54:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ihl1F-0007a9-SG
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 20:54:27 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:47733 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ihl1F-0007V0-11; Wed, 18 Dec 2019 20:54:25 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47dZgK4ZgXz9sPh; Thu, 19 Dec 2019 12:54:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576720461;
 bh=Avr8Aoh7KspcQ0ZcczQlY0smkIoUvCXEsgEDxwwkzJ4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mbqHWKtfqMBJJ1/EaTKeYEAPiiuAI7j31+2+cNxp6pJB2vjxdjy5+2hHRo50il+ZX
 iP1e9ZqBr+6IPhxbPNA/GB6FWinyqP5htyzaF/PkD8hUBmquqx18t8z9wxeLle9CAn
 9ROV7rNiywNzdxsIIQwbVuqgQWZU008KXTrOq+UI=
Date: Thu, 19 Dec 2019 12:54:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v5 1/5] tpm_spapr: Support TPM for ppc64 using CRQ based
 interface
Message-ID: <20191219015414.GC2321@umbus.fritz.box>
References: <20191212202430.1079725-1-stefanb@linux.vnet.ibm.com>
 <20191212202430.1079725-2-stefanb@linux.vnet.ibm.com>
 <20191213053453.GD207300@umbus.fritz.box>
 <75fd3e95-d72f-069b-22ce-f354e1c34660@linux.ibm.com>
 <20191217002954.GH6242@umbus.fritz.box>
 <1efef315-cb85-79ea-9c46-ff318e05a543@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline
In-Reply-To: <1efef315-cb85-79ea-9c46-ff318e05a543@linux.ibm.com>
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
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2019 at 02:44:04PM -0500, Stefan Berger wrote:
> On 12/16/19 7:29 PM, David Gibson wrote:
> > On Fri, Dec 13, 2019 at 08:03:36AM -0500, Stefan Berger wrote:
> > > On 12/13/19 12:34 AM, David Gibson wrote:
> > >=20
> > > The existing one looks like this:
> > >=20
> > > typedef struct SpaprVioCrq {
> > >  =A0=A0=A0 uint64_t qladdr;
> > >  =A0=A0=A0 uint32_t qsize;
> > >  =A0=A0=A0 uint32_t qnext;
> > >  =A0=A0=A0 int(*SendFunc)(struct SpaprVioDevice *vdev, uint8_t *crq);
> > > } SpaprVioCrq;
> > >=20
> > > I don't seem to find the fields there that we need for vTPM support.
> > Yeah, I can see the difference in the structures.  What I'm after is
> > what is the difference in purpose which means they have different
> > content.
> >=20
> > Having read through the whole series now, I *think* the answer is that
> > the tpm specific structure is one entry in the request queue for the
> > vtpm, whereas the VioCrq structure is a handle on an entire queue.
> >=20
> > I think the tpm one needs a rename to reflect that a) it's vtpm
> > specific and b) it's not actually a queue, just part of it.
>=20
>=20
> v6 has it as TpmCrq. It's local to the file, so from that perspective it's
> specific to (v)TPM.

Ok.

> > > This is a 1:1 copy from the existing TIS driver.
> > Hm, right.  Probably not a bad idea to move that out as a helper
> > function then.
>=20
>=20
> In V7 then.

Ok.

> > > > > +static void tpm_spapr_update_deviceclass(SpaprVioDevice *dev)
> > > > > +{
> > > > > +    SPAPRvTPMState *s =3D VIO_SPAPR_VTPM(dev);
> > > > > +    SpaprVioDeviceClass *k =3D VIO_SPAPR_DEVICE_GET_CLASS(dev);
> > > > > +
> > > > > +    switch (s->be_tpm_version) {
> > > > > +    case TPM_VERSION_UNSPEC:
> > > > > +        assert(false);
> > > > > +        break;
> > > > > +    case TPM_VERSION_1_2:
> > > > > +        k->dt_name =3D "vtpm";
> > > > > +        k->dt_type =3D "IBM,vtpm";
> > > > > +        k->dt_compatible =3D "IBM,vtpm";
> > > > > +        break;
> > > > > +    case TPM_VERSION_2_0:
> > > > > +        k->dt_name =3D "vtpm";
> > > > > +        k->dt_type =3D "IBM,vtpm";
> > > > > +        k->dt_compatible =3D "IBM,vtpm20";
> > > > > +        break;
> > > > Erk.  Updating DeviceClass structures on the fly is hideously ugly.
> > > > We might need to take a different approach for this.
> > > Make a suggestion... Obviously, we can hard-initialize dt_name and dt=
_type
> > > but dt_compatible can only be set after we have determined the versio=
n of
> > > TPM.
> > As you say name and type can just be put into the class statically.
>=20
>=20
> I did this in v6.
>=20
>=20
> > Since you need to change compatible based on an internal variable,
> > we'd need to replace the static dt_compatible in the class with a
> > callback.
>=20
>=20
> Why can we not initialize it once we know the version of TPM? From the
> perspective of SLOF at least this seems to be building the device tree fi=
ne
> since it sees the proper value...

Because it's a serious layering / isolation violation.  You're
modifying QOM type information from the runtime code of a specific
instance.  You get away with it (now) because there's only one
instance and the ordering of things happens to let it work, but that's
assuming way too much about QOM's implementation details.

As a rule, once the QOM classes are set up with their class_init
function, they should never be modified.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl362EQACgkQbDjKyiDZ
s5LGrBAA4sZIJsoSQofpPcPud+uJmR6XLUxWV6ArcFnX2PEYODgKnp16Fp/dsqay
wL+BBvgBK7DuXCWpI1x+/MGOhmvwgM72iaIghUTv+PYkboASv28tgYg4nmWxJVNS
yZmJra4DB9hnLHpPQJpdAJy7tOI9YfUO3UUSzZolgzR2z2/q0GgZiAfjqHzmUmr+
cODNYCspRRj4HLCk7zrOwLawgzaE4bQDVCLkYQkQUk8M6cusFVx2PdOO1SjVIlaG
+bPRkK0q/jsguNZmb/AEsAfuUYcuBz8ea1krNTED0R2MBwi+iysTv9FiBg+LzmIH
Wuo635bsNZtDWQJO76Xqy1R0hXE3BcC3WUX4x6+rSWXQHjh7FLqHW+ZoPAJsqXtm
SCVfxBz6PiKmJDwRpaW7Y/mmsSckLm83rEIWK6W8/z7ibI9UnGxvtXvchMr+lqsS
qdtuykTlT2FDzezxnyr98C4zC5AyNQ5xDJCYNC1HU40ab+pXgSraRAtNrh4MuCKt
Czudk4DdtfMa+m7Bv6ydVw7Q3ov64eF9FUNrwNq1jWmjmqg2yWdeu1goWdZ9kUjt
HwaMYaVuRpGSmw3T3bd7vgbWrXBN+dLRYIiK/od2/LmILdB1+QqLNfWkrLYJmSyA
cD4Zff5O7LEMR5L+fcoTqAxoOFPClZqMxg02CfVc+mnf4qGsN6s=
=D3Vs
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--

