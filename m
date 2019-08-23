Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF47EC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 06:04:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08CE22CEC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 06:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ai2AYBHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08CE22CEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i12gz-00022h-NX
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 02:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i12eQ-0000kN-0s
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 02:02:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i12eO-0004c9-Ld
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 02:02:17 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:47873 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i12eN-0004SC-HY; Fri, 23 Aug 2019 02:02:16 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46F9lg3HMhz9sDQ; Fri, 23 Aug 2019 16:02:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566540127;
 bh=8ZTHtF+ugZBKjfJdgjp9FYzrY8pjIjS01p9713FeAC0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ai2AYBHcS4CVcgMGfpqLq4hhaAV17xm8apqmHe1418W1p353WNBOssqKhyUi7VFVR
 0gJP02Jo+GiYKIGMe0zSvMYF86sB62Cyp3Slaliegb5prqDAsz9v0f8/1vzTWB8js4
 u/7ILrFdrotfMPIP6XKA03TTdK4t7lb1Cf+bgQSk=
Date: Fri, 23 Aug 2019 15:29:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190823052903.GA3027@umbus.fritz.box>
References: <20190822195918.3307-1-danielhb413@gmail.com>
 <63a2fef4-3e9d-5dfc-9ccb-2924bb1fe808@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <63a2fef4-3e9d-5dfc-9ccb-2924bb1fe808@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v1 1/1] spapr_pci: remove all child
 functions in function zero unplug
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2019 at 04:11:45PM -0500, Eric Blake wrote:
> On 8/22/19 2:59 PM, Daniel Henrique Barboza wrote:
> > There is nothing wrong with how sPAPR handles multifunction PCI
> > hot unplugs. The problem is that x86 does it simpler. Instead of
> > removing each non-zero function and then removing function zero,
> > x86 can remove any function of the slot to trigger the hot unplug.
> >=20
>=20
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1700,11 +1700,13 @@ static void spapr_pci_unplug_request(HotplugHan=
dler *plug_handler,
> >                  state =3D func_drck->dr_entity_sense(func_drc);
> >                  if (state =3D=3D SPAPR_DR_ENTITY_SENSE_PRESENT
> >                      && !spapr_drc_unplug_requested(func_drc)) {
> > -                    error_setg(errp,
> > -                               "PCI: slot %d, function %d still presen=
t. "
> > -                               "Must unplug all non-0 functions first.=
",
> > -                               slotnr, i);
> > -                    return;
> > +                    /*
> > +                     * Attempting to remove function 0 of a multifunct=
ion
> > +                     * device will will cascade into removing all child
> > +                     * functions, even if their unplug weren't request=
ed
>=20
> s/weren't/wasn't/

Actually, I think this is technically a subjunctive, which would make
it "were" rather than "was".  Modern English usage doesn't really do
the subjunctive, though.
</more-pedantic-than-thou>

With my maintainer hat on, rather than pedant hat, the meaning is
clear so I really don't care, especially from a contributer whose
first language isn't English.

>=20
> > +                     * beforehand.
> > +                     */
> > +                    spapr_drc_detach(func_drc);
> >                  }
> >              }
> >          }
> >=20
>=20




--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1feZ0ACgkQbDjKyiDZ
s5KuvxAAlRktcrWR8T2LO+DmWexVPNGsEd8Sf/HhWcQIi7rrPmpjTU/ulZV7S0bg
2/VmGlSdK6RL5a/lwQ4MiMXsrR/wXov2w26UhstPWrl/1NeuxaOeqmIH2uT6AZr+
/jTt9bnxuDBo8ryWFP3NKuIoSrmsO36NNO58mvYVeB1jxGzjBbpfLJoJu8QrHTTb
X9E+9/T5DK8LzHs2gUrkPmqMATjXZJXGWDPW/PjeQUCWlBqjntzkkp/gZAOLAGug
ZUiV94suBgeva3aSL8NOI2z4hbR3RgETn07jRZI0GPQvZBARypLrpRnXj7uDDD/R
0LMNG0e41axdzvk7RduRynZeX/L6wAKAg7dimk35M8EWp6r3GKQm4huBnwmDxAnw
oZGKwxwRLzbP7rR2VJDHaXY8TShAe/w/oPWq59xibRrHxdlv7WfpSR6jQ9lNIX3B
8QMoZwznnKpPFToPpOuzr34dt0nzle17e6ABO+sDM1hr8r5yEbQ12sbBWle7mCUY
XE/zRnWFlG7+6VIe2TD2046vQZANklvstdqAecdY0UBrZvoeQhb+yy5CZ5gUclo/
UJwZdZYK/ruLR1/+61fg/eWj8cFhupRCqUJNKulk0H6IKZeBy0WHdtRA7T7XT0Zy
wVJkvRLy3ru9CyRzK4ALMqskVTQzezLVdhY3yyn16V34Td8j6Dg=
=L63N
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--

