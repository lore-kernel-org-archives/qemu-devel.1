Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B9AC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 13:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3818206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 13:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JkJnkQPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3818206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxAov-0003u3-8j
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 09:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57935)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hxAmT-0006i4-Bj
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 09:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hxAmR-00006H-W3
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 09:54:37 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:42879 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hxAmL-0008Qe-Ai; Mon, 12 Aug 2019 09:54:29 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 466cld6Gltz9sPT; Mon, 12 Aug 2019 23:54:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565618061;
 bh=tKnTgyRCBNKAnh8b/kQeMf1LC/KBplYmexfkIol1Q18=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JkJnkQPozU6oKm591JMGPmTO5p1NnFQ1IGJtym+rC9oGhkTq1g0Z5Y6imujmQX/Fk
 /GBwwVH6LYhzfq2qWVUC/wxrVU9MPteIiplXHgGSX7J9DuMHl/SIKl/evKqAydEcmb
 mZYGYA6l6yhjN/P2zr/9RGM2S7xo13np1WlgupAI=
Date: Mon, 12 Aug 2019 20:34:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190812103419.GK3947@umbus.fritz.box>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-6-damien.hedde@greensocs.com>
 <20190731060533.GD2032@umbus.fritz.box>
 <51aa7e6d-3568-8485-4b67-a598a24a1f3d@greensocs.com>
 <e7b05c24-ecd1-a437-7d97-07d69ab759ec@redhat.com>
 <20190808064712.GD5465@umbus.fritz.box>
 <CAFEAcA-6GfpYPpafai1XX3u7d3RdTweEUqVwafcX+p6PvQJQpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2feizKym29CxAecD"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-6GfpYPpafai1XX3u7d3RdTweEUqVwafcX+p6PvQJQpw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v3 05/33] Switch to new api in qdev/bus
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
Cc: Fam Zheng <fam@euphon.net>, Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, Hannes Reinecke <hare@suse.com>,
 Qemu-block <qemu-block@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Damien Hedde <damien.hedde@greensocs.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2feizKym29CxAecD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2019 at 12:08:43PM +0100, Peter Maydell wrote:
> On Fri, 9 Aug 2019 at 01:10, David Gibson <david@gibson.dropbear.id.au> w=
rote:
> >
> > On Wed, Jul 31, 2019 at 01:31:28PM +0200, Philippe Mathieu-Daud=E9 wrot=
e:
> > > On 7/31/19 11:29 AM, Damien Hedde wrote:
> > > > On 7/31/19 8:05 AM, David Gibson wrote:
> > > >> On Mon, Jul 29, 2019 at 04:56:26PM +0200, Damien Hedde wrote:
> > > >>> @@ -922,7 +906,7 @@ static void device_set_realized(Object *obj, =
bool value, Error **errp)
> > > >>>              }
> > > >>>          }
> > > >>>          if (dev->hotplugged) {
> > > >>> -            device_legacy_reset(dev);
> > > >>> +            device_reset(dev, true);
> > > >>
> > > >> So.. is this change in the device_reset() signature really necessa=
ry?
> > > >> Even if there are compelling reasons to handle warm reset in the n=
ew
> > > >> API, that doesn't been you need to change device_reset() itself fr=
om
> > > >> its established meaning of a cold (i.e. as per power cycle) reset.
>=20
> So, I don't think that actually is the established meaning of
> device_reset(). I think our current semantics for this function are
> "reset of some sort, probably cold, but in practice called in
> lots of places which really wanted some other kind of reset,
> because our current reset semantics are not well-defined".
>=20
> For instance in s390-pci-inst.c the handling of CLP_SET_DISABLE_PCI_FN
> calls device_reset() on a device. I bet that's not really intentionally
> trying to model "we powered it off and on again".
> hw/scsi/vmw_pvscsi.c uses device_reset() in its handling of
> the guest "reset the SCSI bus" command. I know that isn't literally
> powering off the SCSI disks and powering them on again.
>=20
> The advantage of an actual API change here is that it means we go
> and look at all the call sites and find out what the semantics
> they actually wanted were, and hopefully that then feeds into the
> design of the new API and we make sure we can handle those
> semantics in a non-confused way.

That's a fair point.

> > > >> Warm resets are generally called in rather more specific circumsta=
nces
> > > >> (often under guest software direction) so it seems likely that use=
rs
> > > >> would want to engage with the new reset API directly.  Or we could
> > > >> just create a device_warm_reset() wrapper.  That would also avoid =
the
> > > >> bare boolean parameter, which is not great for readability (you ha=
ve
> > > >> to look up the signature to have any idea what it means).
> > >
> > > If the boolean is not meaningful, we can use an enum...
> >
> > That's certainly better, but I'm not seeing a compelling reason not to
> > have separate function names.  It's just as clear and means less churn.
>=20
> One advantage of an enum is that we have an extendable API,
> so we could say something like "all devices support reset types
> 'cold' and 'warm', but individual devices or families of devices
> can also support other kinds of reset". So the relevant s390
> devices could directly support the kinds of reset currently
> enumerated by the enum s390_reset, and then if you know you're
> dealing with an s390 device you can ask it to reset with the
> right semantics rather than fudging it with one of the generic ones.
> Or devices with "if I'm reset by the guest writing to a register then
> I reset less stuff than a reset via external reset line" have a
> way to model that.

Ok, I can see the value in that.  I guess the way I'd prefer to
approach it though, is to start out with just a single-value enum for
(roughly) a cold reset.  Then when we find a subset of devices for
which we can consistently define a warm reset of some type, we add an
enum value for it.

I guess we'd also need some way of introspecting what reset types are
supported by a device.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2feizKym29CxAecD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1RQKoACgkQbDjKyiDZ
s5IaYA/+ObLrZrONrkHDDwV2qNfslLhBNVDM0aO7u1wp1M9oUUwxcTsqKq44wVAU
GfFox0WIjUCRiKRo+wVo85s2pfn7JnBq0Bro09QczDLJSWcImb4rPvJDmDkppZ/x
gakLSOiONlth7Ku8tbvduDcfUmMAHk78YMf+UcfBuB5aBZ28TRbgZvaqWzwjMkpo
OQOUyMNTqtRRZzjzqNOXKXZ5z8nNBUSOrEUZ7uXyQDTgthFNMYeoTFoXP76yY+xY
dtcMGEnH5ZaPioS0n2W+h+s/7kwhrE8Cg1nNtQhnQA+q0jgGMftQg1SFVID6bOVs
hqyn1BjB1SC0POgaeoOdoEaXJD0emRnIG2VWgkrLT7H8Dww9k/TkBGIoB+UYBNqj
2AQ4DlYSbsgBrkDbOnLk1Wi6En10f3VImGQz1p2TsUVfX7PnakEj72dLZVha8Gzu
6tBtukEX5BwhdXJ+QHairZ9Gtc9lt9jHyoEGzLDdyVm77CzINbaeeDPWVM1b+slY
lUw3VUUbUYsFzoLOuQqtYGUBrfmvFz/wLMFz9WgcJF7pixZZhP1pVeOaNHj3MYLV
0gfu0pIzwOwBx0aPF3mr6EuSrirFYw7ySSaREixCewoLGJMmVU5VA+EV1eLCbO0w
4svUEbCt9nZwojrULjVqp/uoC3veExgQz+pJzBrpWj0pzvmFq70=
=VoXt
-----END PGP SIGNATURE-----

--2feizKym29CxAecD--

