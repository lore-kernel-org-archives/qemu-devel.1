Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA40FC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A54FA20833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MWAWjXzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54FA20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53339 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFAx-0005MI-BI
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:07:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hRF9Z-0004Wb-0U
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:06:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hRF9V-0003iA-VZ
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:06:28 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:52359 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hRF9U-0003Jo-Gh; Thu, 16 May 2019 08:06:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 454VWZ1Dhzz9s9T; Thu, 16 May 2019 22:06:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558008378;
	bh=46Y9rgnsGPRWkqU7O2JjFmjaDEfqdpYkWBvHGESUcfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MWAWjXzLKMV2tEhPMNzIzuscS8hfFVdJQZc4llObXpgqwwz1RBq2nJ4gYZ7fPsVf1
	twNYAs3wMS76ds1PRzgmHiuS2TVeikIZOBCMEse6aEN+Pq+Q8K6D0WMyyPMuDsHlsB
	Yk7I8U6Uu33IO1fY0FSr+nrSYmVbrAvRdfnM+xcs=
Date: Thu, 16 May 2019 21:46:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190516114601.GG3207@umbus.fritz.box>
References: <155793986451.464434.12887933000007255549.stgit@bahia.lan>
	<20190516063957.GA25414@sathnaga86>
	<20190516085814.022ef4b1@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sClP8c1IaQxyux9v"
Content-Disposition: inline
In-Reply-To: <20190516085814.022ef4b1@bahia.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] spapr/xive: Sanity checks of OV5 during CAS
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--sClP8c1IaQxyux9v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2019 at 08:58:14AM +0200, Greg Kurz wrote:
> On Thu, 16 May 2019 12:09:57 +0530
> Satheesh Rajendran <sathnaga@linux.vnet.ibm.com> wrote:
>=20
> > On Wed, May 15, 2019 at 07:04:24PM +0200, Greg Kurz wrote:
> > > If a machine is started with ic-mode=3Dxive but the guest only knows
> > > about XICS, eg. an RHEL 7.6 guest, the kernel panics. This is
> > > expected but a bit unfortunate since the crash doesn't provide
> > > much information for the end user to guess what's happening.
> > >=20
> > > Detect that during CAS and exit QEMU with a proper error message
> > > instead, like it is already done for the MMU.
> > >=20
> > > Even if this is less likely to happen, the opposite case of a guest
> > > that only knows about XIVE would certainly fail all the same if the
> > > machine is started with ic-mode=3Dxics.
> > >=20
> > > Also, the only valid values a guest can pass in byte 23 of OV5 during
> > > CAS are 0b00 (XIVE legacy mode) and 0b01 (XIVE exploitation mode). Any
> > > other value is a bug, at least with the current spec. Again, it does
> > > not seem right to let the guest go on without a precise idea of the
> > > interrupt mode it asked for.
> > >=20
> > > Handle these cases as well.
> > >=20
> > > Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >  hw/ppc/spapr_hcall.c |   24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > >=20
> > > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > > index 6c16d2b12040..63a55614b83d 100644
> > > --- a/hw/ppc/spapr_hcall.c
> > > +++ b/hw/ppc/spapr_hcall.c
> > > @@ -1513,6 +1513,7 @@ static target_ulong h_client_architecture_suppo=
rt(PowerPCCPU *cpu,
> > >      bool guest_radix;
> > >      Error *local_err =3D NULL;
> > >      bool raw_mode_supported =3D false;
> > > +    bool guest_xive;
> > >=20
> > >      cas_pvr =3D cas_check_pvr(spapr, cpu, &addr, &raw_mode_supported=
, &local_err);
> > >      if (local_err) {
> > > @@ -1545,10 +1546,17 @@ static target_ulong h_client_architecture_sup=
port(PowerPCCPU *cpu,
> > >          error_report("guest requested hash and radix MMU, which is i=
nvalid.");
> > >          exit(EXIT_FAILURE);
> > >      }
> > > +    if (spapr_ovec_test(ov5_guest, OV5_XIVE_BOTH)) {
> > > +        error_report("guest requested an invalid interrupt mode");
> > > +        exit(EXIT_FAILURE);
> > > +    }
> > > +
> > >      /* The radix/hash bit in byte 24 requires special handling: */
> > >      guest_radix =3D spapr_ovec_test(ov5_guest, OV5_MMU_RADIX_300);
> > >      spapr_ovec_clear(ov5_guest, OV5_MMU_RADIX_300);
> > >=20
> > > +    guest_xive =3D spapr_ovec_test(ov5_guest, OV5_XIVE_EXPLOIT);
> > > +
> > >      /*
> > >       * HPT resizing is a bit of a special case, because when enabled
> > >       * we assume an HPT guest will support it until it says it
> > > @@ -1632,6 +1640,22 @@ static target_ulong h_client_architecture_supp=
ort(PowerPCCPU *cpu,
> > >                                            ov5_updates) !=3D 0);
> > >      }
> > >=20
> > > +    /*
> > > +     * Ensure the guest asks for an interrupt mode we support; other=
wise
> > > +     * terminate the boot.
> > > +     */
> > > +    if (guest_xive) {
> > > +        if (spapr->irq->ov5 =3D=3D SPAPR_OV5_XIVE_LEGACY) {
> > > +            error_report("Guest requested unavailable interrupt mode=
 (XIVE)");
> > > +            exit(EXIT_FAILURE);
> > > +        }
> > > +    } else {
> > > +        if (spapr->irq->ov5 =3D=3D SPAPR_OV5_XIVE_EXPLOIT) {
> > > +            error_report("Guest requested unavailable interrupt mode=
 (XICS)"); =20
> >=20
> > Looks like there is a typo in the error msg reported, instead it should=
 be something like below
> >=20
> > "Guest requested unavailable interrupt mode(XIVE), please use supported=
 interrupt mode(ic-type=3Dxics)"
> >=20
>=20
> Hmm... Agreed that it may be worth adding some hint for the user to proce=
ed but...
>=20
> > Same for the previous check aswell.
> >=20
> > Coz, I booted 3.10(kernel) guest with ic-type=3Dxive and got a below er=
ror, which seems wrong
> >=20
> > 2019-05-16T06:24:58.713261Z qemu-system-ppc64: Guest requested unavaila=
ble interrupt mode (XICS)
> >=20
>=20
> ... this message is ok: the 3.10 kernel based guest _does_ ask for XICS,
> which isn't available because of ic-mode=3Dxive.

I won't be sending a pull request for a little while yet, so if you
want to send a followup improving the messages I can fold it into the
original patch in my tree.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sClP8c1IaQxyux9v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzdTXcACgkQbDjKyiDZ
s5IdohAAlQX16uz7N8m268apL3USQBREYuJGMnOsfs8535bL7nsRpVcZfncW7jRZ
rlFbATdSuDA7vVQdk6TKb/zpbUA1kxzGZvRVHaQyReMrahpjnJSdENNAJxrSODMV
NwIDTlwKuf7sbOLyMNNpVsEZQPoOx80is3enO2gwneHifJhOukx2wN51OXhOpZk4
Eq2BceHNEPEX8PBiBGxlk5Vdx42CjZiKXDmbQKlvXR+NxtfUSVWeFAViS6rjkP+X
WKY/NEnJ5CAs3+bqL7t5yTldscZNLyXWLii1lAQnYnHk5nNZLL6HDtRY7mhmrN6s
ZTN5ifQLvIiKM0YeICBEdjkPh/04NgbuM8WMsQmdn5OfkyPMtNjtvxeL8bpFc0TS
cuE2GFMTNi6A83YZJeDjDJ3fm6M4Tv+rvaMepAkM292Y6PMkZhUVOuOE0NnTowWO
J9bBdAwEQq6ldlRIMDQxlW5mOb11+K/WlKfKWt8B9/KYEURDiIKYekEN8sTcpblW
ET+JWOzPcK2S4ijyoabETc/YvjowDYGrMb76faX96/lof8HtM5p3Q3bQyXLmvNTg
TIt+5q+A9nPFEeOv0SWZfr//I8ARX8Zrp1UYbbBElauxBDdYMNu+5XifVoMB7Jg4
E0x5fHs9YjmlvcnozUeB0oYLh8PlY+LhWI4DQd/qdrMs3J7q+gE=
=QfYp
-----END PGP SIGNATURE-----

--sClP8c1IaQxyux9v--

