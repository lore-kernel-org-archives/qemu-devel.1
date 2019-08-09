Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6CDC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 06:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C36208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 06:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="QiGJa6ET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C36208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvy5z-0002wq-P5
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 02:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39751)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hvy5X-0002Hk-8H
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hvy5W-0004EQ-6w
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:09:19 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58483 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hvy5Q-00045H-Lg; Fri, 09 Aug 2019 02:09:13 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 464ZZD0P3Cz9sBF; Fri,  9 Aug 2019 16:09:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565330948;
 bh=BJnhFgwWjf7MPkKsmVjfo3l7uUOX+9Duc5sGDkStrDA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QiGJa6ETG8j/OljNoX8SgJkVVEq+KDaCpXxezE+wcpPhODb2yPYm8ZV1v8dY9Reul
 nr7HymWW0uNPUoGnYl+IDpPRXB7N0CzKQZpy265hCbxdAz4DJpxjNNvH6LYJdZk3GH
 xtOxfwRZ0WxUekAB/ZLf7ehb1ZO4I0N371h+rj74=
Date: Fri, 9 Aug 2019 15:51:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190809055132.GT5465@umbus.fritz.box>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-9-damien.hedde@greensocs.com>
 <20190731061108.GF2032@umbus.fritz.box>
 <CAFEAcA-dSBpAVfjn7VnCRgnZabBP226ZVuSJYW1bwzEr5mNktw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nDmTXYS4kVhtHHfR"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-dSBpAVfjn7VnCRgnZabBP226ZVuSJYW1bwzEr5mNktw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v3 08/33] Add function to control reset
 with gpio inputs
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


--nDmTXYS4kVhtHHfR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2019 at 11:37:51AM +0100, Peter Maydell wrote:
> On Wed, 31 Jul 2019 at 07:33, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> >
> > On Mon, Jul 29, 2019 at 04:56:29PM +0200, Damien Hedde wrote:
> > > It adds the possibility to add 2 gpios to control the warm and cold r=
eset.
> > > With theses ios, the reset can be maintained during some time.
> > > Each io is associated with a state to detect level changes.
> > >
> > > Vmstate subsections are also added to the existsing device_reset
> > > subsection.
> >
> > This doesn't seem like a thing that should be present on every single
> > DeviceState.
>=20
> It's a facility that's going to be useful to multiple different
> subclasses of DeviceState, so it seems to me cleaner to
> have base class support for the common feature rather than
> to reimplement it entirely from scratch in every subclass
> that wants it.

Hm, I suppose so.  Would it really have to be from scratch, though?
Couldn't some suitable helper functions make adding such GPIOs to a
device pretty straightforward?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nDmTXYS4kVhtHHfR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1NCeQACgkQbDjKyiDZ
s5LALQ/9GC9HcolEmg7IRCZUguKfriab9vtzEkNKxO/k00LBjcGWnMp/hdA1kVBS
a/gexj5zW4F+/7CmGVkau4YMKXw9t5RFlCHAlTy4zjk3ayTBsU65E9M7T9Wl0hcW
uHG4MO2/5VVedLmC3PJ1+jtXl70e+eVUXzNixH2gYjijfIzCRCWIPuP1YSH8nFLW
o/7VvsIpI42BOgGwfLowGH6m30Yi+C6Mj9rdJHMxKSnECqHj7e80k3EzfHf1qtA7
4KJEgs6oFn1aHnlBbquT2MZKD60cXyFXWhXz62bZmK80B7sVGe0kRYZn1AGqGm9b
XZdso+pOinz8X+/RxR/8/WYCx3Waeh5+pgc3xJ7XnCMabIOUAEvtj/IFOMRDzCiS
Fzlh0YIbGprNuO/tXXFMNJ3cbOzZvLH3rENl9H66AeZf6Jt/R56dlLhfpAJAOy4L
CpX0nqIgvnezS7kyjvnOLzbilKonDbv/95Wp6GZ9smwC+F73/laSc8WXoM990tfo
1/0z5ZaB7d1Dchiw2lAiqTxShLAKLzWupvOWO0vzqOhi4nW82Eni4cpysxGFOu9u
8KXmZsmlttIVIbK1BgXHmF+4b22AN27f8Up9oPioJO96jfXoSP3ICGM0SNGSssLE
gMGH5wwNGkpR5HP0B1Z86pezpu1/NvxaNqtJ8MS9h/Cil/f5l64=
=/2DK
-----END PGP SIGNATURE-----

--nDmTXYS4kVhtHHfR--

