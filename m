Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282D8C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 05:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E112067D
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 05:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oFrFjzqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E112067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hshTm-0004jw-2X
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 01:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36140)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hshT6-0004CO-IH
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 01:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hshT5-0007Ur-7z
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 01:48:08 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:45499)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hshSw-0006mc-Ib; Wed, 31 Jul 2019 01:48:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45z2Wp1JgXz9sBF; Wed, 31 Jul 2019 15:47:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564552070;
 bh=oGsplCAdBOMa679rb9YPeAihpYC+mr4lyv24NKaSaF0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oFrFjzqQYRDiGaNowZmZXmvYHhyUfy+ROcpm+zuIjNYg2c9T1Kw/grBdemWwwNpSo
 AunkcWIMnellrpf8ufj9GA/+9QS0U9irmqtV4dZ6LgsJtjYygVem5sRv5mPPGOVY6V
 V5cuVk2X0U/9WOpN4RR3B6b2ucxI7fiQ0ThQ//5Y=
Date: Wed, 31 Jul 2019 15:46:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <20190731054612.GA2032@umbus.fritz.box>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-2-damien.hedde@greensocs.com>
 <20190730154209.2049f10a.cohuck@redhat.com>
 <CAFEAcA-rwBiXkDEDuT-=KQVJ2A2ob16=P0obbZBPUfZeYXy+dQ@mail.gmail.com>
 <20190730155547.7b201f5e.cohuck@redhat.com>
 <CAFEAcA_BU3DECLVv2QD_RshR0OL3=GqGwsm0YAmEAE6_SpW=HA@mail.gmail.com>
 <34a216b0-0067-8627-599c-6a67622c4bd2@greensocs.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <34a216b0-0067-8627-599c-6a67622c4bd2@greensocs.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v3 01/33] Create Resettable QOM interface
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, Hannes Reinecke <hare@suse.com>,
 Qemu-block <qemu-block@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2019 at 04:08:59PM +0200, Damien Hedde wrote:
>=20
> On 7/30/19 3:59 PM, Peter Maydell wrote:
> > On Tue, 30 Jul 2019 at 14:56, Cornelia Huck <cohuck@redhat.com> wrote:
> >>
> >> On Tue, 30 Jul 2019 14:44:21 +0100
> >> Peter Maydell <peter.maydell@linaro.org> wrote:
> >>
> >>> On Tue, 30 Jul 2019 at 14:42, Cornelia Huck <cohuck@redhat.com> wrote:
> >>>> I'm having a hard time figuring out what a 'cold' or a 'warm' reset =
is
> >>>> supposed to be... can you add a definition/guideline somewhere?
> >>>
> >>> Generally "cold" reset is "power on" and "warm" is "we were already
> >>> powered-on, but somebody flipped a reset line somewhere".
> >>
> >> Ok, that makes sense... my main concern is to distinguish that in a
> >> generic way, as it is a generic interface. What about adding something
> >> like:
> >>
> >> "A 'cold' reset means that the object to be reset is initially reset; =
a 'warm'
> >> reset means that the object to be reset has already been initialized."
> >>
> >> Or is that again too generic?
> >=20
> > I think it doesn't quite capture the idea -- an object can have already
> > been reset and then get a 'cold' reset: this is like having a powered-on
> > machine and then power-cycling it.
> >=20
> > The 'warm' reset is the vaguer one, because the specific behaviour
> > is somewhat device-dependent (many devices might not have any
> > difference from 'cold' reset, for those that do the exact detail
> > of what doesn't get reset on warm-reset will vary). But every
> > device should have some kind of "as if you power-cycled it" (or
> > for QEMU, "go back to the same state as if you just started QEMU on the
> > command line"). Our current "reset" method is really cold-reset.
> >=20
>=20
> Exactly. In the following patches, I've tried to replace existing reset
> calls by cold or warm reset depending on whether:
> + it is called through the main system reset -> cold
> + it is called during normal life-time       -> warm
>=20
> But I definitely can add some docs/comments to better explain that.

Hrm, that helps, but it still seems pretty vague to me.

It's not really my call, but building the concept of warm versus cold
resets into such a generic interface seems pretty dubios to me.  While
it's moderately common for things to have a notion of warm versus cold
reset it's certainly not universal.  There are many devices where
there's no meaningful difference between the two.  There are some
devices where there are > 2 different types of reset suitable for
various different situations.

Is there any way this could work with it usually just presenting the
cold reset (which is the closest to a universal concept), and any warm
or additional resets are handled buy a different instance of the
Resettable interface?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1BKyEACgkQbDjKyiDZ
s5J7Fg/+If0wZcHwkyO/Gfc6jm7q4clR5PkknL3flknnadM3Q+a0qSVSudI12YBY
cHMsYASW89HIAQLdaWAuztEOST1j/2dmLoCfV7zKZxW8Go4xeSIV4xcvDmoM7be6
vYdA3Fp1Xl5xA/6IEd2Ti1uuJesAR7Ek+/OX9Xgl/RsGscH7kw84rjqhRUl+B0EX
TrIrJ20+hag1pApuc/jwjh/evwRJQji3nTMTHE7Uhqq4PO/zFUaNX/VOtdmEyI9s
cYUcTzcqWCsERyMKKVROUSVesdanofXo6+6m2I96MU9MzhpvFdY6E7Qg76CrRUUq
myeEligXs03oLXQTXNoQAQUj0Ujc7eQ4vUy69Pw3hf3/smxho1sQ5DTjJxzb2glP
0K+/uDjahi58wl/yqgkBno38kzl17EfOZlzfj7TF5m5TMwsJ4nW5M265lHKxqDTB
wj2UvBk2K3HHzM2E2h/JeebP6Iwnpi8glbfL9lkgIrWR0g6hbTAqORTsvdImz09t
Jm/YvI0UyIaEhOkyuwGTEYoJCLAl6VaGmIF1MamNkkhVZoISm2KHN2wqxYOr1onb
fZTE5nJcqukQF5PDS7eV4jw1b8X1TFYeLxOPiBefxNu5PqFQI7UeuEf2UaF3nzAV
SlwDum5aCwv1psOud/eOQbWI/hRUS37/Hz+iUE3LouVR815BEQg=
=VnA+
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--

