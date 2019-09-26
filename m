Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C2BC432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 07:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D7B6206E0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 07:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7B6206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDO7D-00015z-GS
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 03:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDO6F-0000Q3-SY
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:22:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDO6C-0006Xn-EC
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:22:01 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:36748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDO6C-0006U8-7v
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:22:00 -0400
Received: from player770.ha.ovh.net (unknown [10.109.160.87])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id B2FF91AE09D
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:21:53 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player770.ha.ovh.net (Postfix) with ESMTPSA id 29FFBA405DEC;
 Thu, 26 Sep 2019 07:21:42 +0000 (UTC)
Date: Thu, 26 Sep 2019 09:21:41 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 11/20] spapr: Fix indexing of XICS irqs
Message-ID: <20190926092141.66158590@bahia.lan>
In-Reply-To: <20190926013148.GU17405@umbus>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-12-david@gibson.dropbear.id.au>
 <20190925221746.7b497c8c@bahia.lan> <20190926013148.GU17405@umbus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=vnKrevK6F5xYEM.0UHozJg"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 7426717261815060966
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeefgdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.52.147
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
 clg@kaod.org,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/=vnKrevK6F5xYEM.0UHozJg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Sep 2019 11:31:48 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Sep 25, 2019 at 10:17:46PM +0200, Greg Kurz wrote:
> > On Wed, 25 Sep 2019 16:45:25 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > spapr global irq numbers are different from the source numbers on the=
 ICS
> > > when using XICS - they're offset by XICS_IRQ_BASE (0x1000).  But
> > > spapr_irq_set_irq_xics() was passing through the global irq number to
> > > the ICS code unmodified.
> > >=20
> > > We only got away with this because of a counteracting bug - we were
> > > incorrectly adjusting the qemu_irq we returned for a requested global=
 irq
> > > number.
> > >=20
> > > That approach mostly worked but is very confusing, incorrectly relies=
 on
> > > the way the qemu_irq array is allocated, and undermines the intention=
 of
> > > having the global array of qemu_irqs for spapr have a consistent mean=
ing
> > > regardless of irq backend.
> > >=20
> > > So, fix both set_irq and qemu_irq indexing.  We rename some parameter=
s at
> > > the same time to make it clear that they are referring to spapr global
> > > irq numbers.
> > >=20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > ---
> >=20
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> >=20
> > Further cleanup could be to have the XICS backend to only take global
> > irq numbers and to convert them to ICS source numbers internally. This
> > would put an end to the confusion between srcno/irq in the frontend
> > code.
>=20
> Yeah, maybe.  But the local srcnos do actually make sense from within
> the perspective of ICS, so I'm not all that keen to do that.
>=20

Not sure to understand what you mean by "within the perspective of ICS".

My concern is actually to get rid of ics->offset users in spapr_irq.c.

eg,

static void spapr_irq_set_irq_xics(void *opaque, int irq, int val)
{
    SpaprMachineState *spapr =3D opaque;
    uint32_t srcno =3D irq - spapr->ics->offset;

    ics_set_irq(spapr->ics, srcno, val);
}

It looks like we should do something like:

static void spapr_irq_set_irq_xics(void *opaque, int irq, int val)
{
    SpaprMachineState *spapr =3D opaque;

    ics_set_irq(spapr->ics, irq, val);
}

and have ics_set_irq() do:

    uint32_t srcno =3D irq - spapr->ics->offset;

Are you inferring that it is better to keep the irq to srcno conversions
in spapr_irq.c ?

--Sig_/=vnKrevK6F5xYEM.0UHozJg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl2MZwUACgkQcdTV5YIv
c9ZzFxAAohV7O/LsJCbSiPH3irxOFaQw/C7+ifXaYCYYVphuI7KUQaqc7rEWFQn/
hmJqjmfPJkxz0wPsL+Sp7CkrwZ6Jsc6zCnhN3PCcrP50xnq+yvdPBz0oBMs0nHeW
NE4XBJ2Mz6MMhDB3EpmZ2daBF7t+kTCTzlJ1UZCj+6UWySa11/fPSOcy74syoQ+I
5i62w4TU/pyepwObdMlyS4CGOaFIXVSV7iWgpAfBUDiQI4nTSQWcfJxT7UcnXIB7
n1B5o/HYUarZOAvKdwKPlLV5UjNjIvdzSCQhjZUKHsYuTsWqNT4/kG6RgTnbfw+/
nAuIkomiPm8JRBbKuagJb4xJNDElxIZHLLgUOn9IcmfRXCHBCifiUvbr/tDPVlVs
Viy/J46WJOue0BV5f8KHMAjAK49v4l7l3FLTG5TbVyWbtEsG08uYIVV+UV9jaQXv
/k/jfsyh11omxm2ePi9X8OAwxjzxsZGpY0/Z4ZvkntC58xgFwGFDHS8hcbY2yolK
mXBdi9EiHgap4/tlyuUC0ThDXXHfyt2jJs4R8bfbQsp9OgaZY/B70nSy5lUyRzJw
EagK7WsPxekA8okF9aMCdbvMgYBIXdFPMvWEBBtZGllhsLXCzbRhrIasep3PxvdF
W8I2xEeDaACXTbYsfxOACsuSNR9Zfgo3pqqH7JyGZ5Y5NB/4Onc=
=Etsz
-----END PGP SIGNATURE-----

--Sig_/=vnKrevK6F5xYEM.0UHozJg--

