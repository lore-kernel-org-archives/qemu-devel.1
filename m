Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001D8C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 13:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2EDE206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 13:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="QdvOCA9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EDE206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxAox-00040k-3J
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 09:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57832)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hxAmP-0006Ul-GX
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 09:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hxAmO-0008Ue-8N
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 09:54:33 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53173 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hxAmH-0008N6-5y; Mon, 12 Aug 2019 09:54:26 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 466cld39L0z9sP8; Mon, 12 Aug 2019 23:54:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565618061;
 bh=p0zKZ0oqRCQOxt10uMnafHngiiXzV6qoJ9pUWo6KwL0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QdvOCA9UkgWMuQl7qg0T4BAxuQbhEt6XJkqwY76EeygqAlMZK8XFA/gt4MGR5J197
 +KdP5z1J7aRCyjzXRhMe+xjCI4JkCdStGN4Ret8YC9JUeZ+3q8li07sTWrAM5jaKeT
 hTsaSmVBYBQoZDOP6FMALlTjkvm4h0In0r3kHXI8=
Date: Mon, 12 Aug 2019 20:15:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190812101512.GG3947@umbus.fritz.box>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-10-damien.hedde@greensocs.com>
 <20190731063044.GG2032@umbus.fritz.box>
 <CAFEAcA97PbDP3XrtHCXuiwZorC7B8hY_EGL+iRLsJeC=L=kekw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/Zw+/jwnNHcBRYYu"
Content-Disposition: inline
In-Reply-To: <CAFEAcA97PbDP3XrtHCXuiwZorC7B8hY_EGL+iRLsJeC=L=kekw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v3 09/33] add doc about Resettable interface
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


--/Zw+/jwnNHcBRYYu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2019 at 05:01:42PM +0100, Peter Maydell wrote:
> On Wed, 31 Jul 2019 at 07:33, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> >
> > On Mon, Jul 29, 2019 at 04:56:30PM +0200, Damien Hedde wrote:
> > > Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> > > +For Devices and Buses there is also the corresponding helpers:
> > > +void device_reset(Device *dev, bool cold)
> > > +void bus_reset(Device *dev, bool cold)
> >
> > What's the semantic difference between resetting a bus and resetting
> > the bridge device which owns it?
>=20
> We should definitely explain this in the documentation, but
> consider for instance a SCSI controller. Resetting the
> SCSI controller puts all its registers back into whatever
> the reset state is for the device, as well as resetting
> everything on the SCSI bus. Resetting just the SCSI bus
> resets the disks and so on on the bus, but doesn't change
> the state of the controller itself, which remains programmed
> with whatever state the guest has set up.
>=20
> PCI has a similar distinction between resetting the controller
> and resetting the bus.
>=20
> Note that we have this distinction in the current APIs too:
> qbus_reset_all() vs qdev_reset_all().

Yeah, sorry, I didn't express my concern very well... and now I've
kind of forgotten the details of it.  I think the oddities you also
pointed out with the state saving made me think the two were
sorta equivalent in this patchset, but the interface suggested otherwise.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/Zw+/jwnNHcBRYYu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1RPDAACgkQbDjKyiDZ
s5KNphAAt7gS5uzipD+JYovvdN+zvCpyBahjgREC+PpQfUg67snMTvJh1KNRlYA4
muZlHe/paQDCEMWDp+XbfpAr0mKbyQvwPVZXoll2a4Zh6wFnhP8glulq+s7nB9bo
e716vPs+vrhZPWfpcrqd4+1wb3VJr8TUvEZf7g568ll9b+5v67BTDLdibSGbq5OU
iIHmL4seY4DiaitPPqaCW4ahFeK5qAwsYGPiPrNE5jT8huLPNZl/zkU2VBNtzPgh
COdUOaa8sSsu3/ocxnQ1IPBodAvvqTtI6WJvwQJIoqenwyq0pyy6zURMUlJHCxhy
FlMDmhGLBuw7lyv8utegH/VoSuglkmlYOdIoyXKQkXm50kJJoo8KOyAi5olIAiLD
B9EI+lpcU2VPshWBHsFETdEoSsg5VHEJsY3h7TAO7zyHzfp1/avL2MnAjijx5WWJ
/iHwh4G/zTVxB2Nxiw+aieVTB2LQKZAPKOeUH93BAeWLmyBRsmlXZLnqGOAOtqTx
e8JJvhlLTsTa2CZlZv/lgbNys2R0xPp8WtLiZ6sujO8AKIlyXvXFdSjNjlpD3XdZ
RKG0V8dvZlvJP12gK2tj9Wc6xDeIRTnjNZYk2yCz2IQ9z7aY4avMb9nMsFthgU37
v4Y/5aoeejZzA81K4ZPjk8JsT/YpWwQysQtIgfOGefuGl8W74+M=
=pC2r
-----END PGP SIGNATURE-----

--/Zw+/jwnNHcBRYYu--

