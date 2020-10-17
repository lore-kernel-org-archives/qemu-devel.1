Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F54C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 06:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47DCB206E5
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 06:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LgZC93se"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47DCB206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTg0K-0004cs-Ag
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 02:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kTfyb-0003Lw-9u; Sat, 17 Oct 2020 02:46:01 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48623 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kTfyY-00036u-Ct; Sat, 17 Oct 2020 02:46:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CCtnj1tWzz9sT6; Sat, 17 Oct 2020 17:45:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602917145;
 bh=aKnb7theXUwAXAPfeLl4uDFakqMXb4FhRESAwFtVGe0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LgZC93sek2lxDZ7aB5dtPf63IXsSpqc7RQ/oexOZaRmgwIWNdkEYUHEb3V4Jmn2UO
 9SgUvnBriNBNZcDRe4QiaBVnjaRLDYfp40gqSavLX75CI9K/x1rDvym6nHg8xgFM+t
 AaVeT+hl2LL8ZQEFnBUSPU5Cr067i5L4JQbu5iJE=
Date: Sat, 17 Oct 2020 17:21:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 1/3] macio: don't reference serial_hd() directly
 within the device
Message-ID: <20201017062124.GB285896@yekko.fritz.box>
References: <20201013114922.2946-1-mark.cave-ayland@ilande.co.uk>
 <20201013114922.2946-2-mark.cave-ayland@ilande.co.uk>
 <20201016001614.GB7078@yekko.fritz.box>
 <b73997ec-b1fc-0d1a-408f-f69e59dbbfc4@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <b73997ec-b1fc-0d1a-408f-f69e59dbbfc4@ilande.co.uk>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 02:45:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2020 at 08:00:06AM +0100, Mark Cave-Ayland wrote:
> On 16/10/2020 01:16, David Gibson wrote:
>=20
> > On Tue, Oct 13, 2020 at 12:49:20PM +0100, Mark Cave-Ayland wrote:
> > > Instead use qdev_prop_set_chr() to configure the ESCC serial chardevs=
 at the
> > > Mac Old World and New World machine level.
> > >=20
> > > Also remove the now obsolete comment referring to the use of serial_h=
d() and
> > > the setting of user_creatable to false accordingly.
> > >=20
> > > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >=20
> > Applied to ppc-for-5.2, thanks.
>=20
> Ah okay, I was planning to send a separate qemu-macppc pull request myself
> with these patches plus some cherry-picks from Zoltan's patchset after so=
me
> more testing. Does this mean you would prefer to take the patches directly
> yourself?

Not really.  I sent a PR recently, so I probably won't do another for
a little while.  So go ahead and send yours, and mine should rebase
easily enough.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+KjWQACgkQbDjKyiDZ
s5IMnw//cjcXpOrBqNhIc1JnHvrW9aUJo1/SDtQbwp6TMUqNH0eAEXWs4wNrMIPp
jkFruyviOBtC5RgXMFCei12ECE3BK/ZMEcJieA39fTI1gkxdBbPJ4qMChmt0SfAz
bmI68JsvfVhNVmAE0N00Yx853oTHzJdajthm/EA0UBA6HoBXWnLF860jYwXiWYkD
/1hux6D+68iXxbku7J7dd1pkTjRsAYcvIy/1fJXilAm6ZVX2w/+PfWwhl3WDgeEC
TJiOyNBbwlyCJmUzgn/uWffNjztQOZ+JXcxJKYG/50k6TRfF/ei7c81VBqo/KCDr
eIA9TlK8g4c7tPeV+g/qMuRPa1FAaHj3wWQXcnJHXksqStJLpSBDN9bdr+6ae6dh
NPk3S09uFIYhD4QnEy87/BVp0xPHtNMOleTTtcU78U9/ihVjYKAZWTxmHXcWEsQY
M9WP93Ej4+Ud1YRLlOhh43/1QwS5S/xaM/HjRJBy7qtmNPrw+Acxl9YtebwSfsXG
Kvt1OgWJHIbdXs0RWuEYFN/ACk5vOxSjko0on61HyFVRAerJjwwH7hxBs0F3pjFf
wfdkL/WhW9AywxBzDvrgclPCG8kbVm/8XOXQlMRn20aaEzPhF6jgoEB3oTijRsUL
IpSkTYyNJal/v7Edo+yumqtcDsjFsTOMtghzAeM5VtF/VkPh3Ig=
=w092
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--

