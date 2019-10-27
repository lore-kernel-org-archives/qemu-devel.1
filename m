Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02622CA9EBC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 17:30:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E8721726
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 17:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="FhzbEGkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E8721726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOmNC-0005D9-1d
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 13:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iOmJs-0004N5-NT
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 13:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iOmJo-0006i4-7s
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 13:27:12 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:46079)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iOmJn-0006a4-Bi; Sun, 27 Oct 2019 13:27:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 471Psv5fJLz9sP3; Mon, 28 Oct 2019 04:26:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1572197219;
 bh=rOoE9TqBIv3sJNJ3GGZVf3WcBT5XI/i6bd73X71SYIQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FhzbEGkZ2jgTEfwNjqOecATsxtPEFQ4fyXsLMGyF50nVZWRmp+n/Hh2zLKzuMJ0Sr
 9Y51be1V7R6goLTcBC9dA8qx0AE4r5gmPMDU8uPF6n9bnQ+1ML2RFJhtaPEX/NNtCd
 GIlMRhT5usedag4hST/l0cjjP1DK8Xs/NTZcgh5g=
Date: Sun, 27 Oct 2019 17:52:39 +0100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v5 4/7] ppc/pnv: Add a PnvChip pointer to PnvCore
Message-ID: <20191027165239.GB3552@umbus.metropole.lan>
References: <20191022163812.330-1-clg@kaod.org>
 <20191022163812.330-5-clg@kaod.org>
 <20191024023812.GO6439@umbus.fritz.box>
 <ed3b2931-7836-058d-6b93-d35eed3ff859@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <ed3b2931-7836-058d-6b93-d35eed3ff859@kaod.org>
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 11:57:05AM +0200, C=E9dric Le Goater wrote:
> On 24/10/2019 04:38, David Gibson wrote:
> > On Tue, Oct 22, 2019 at 06:38:09PM +0200, C=E9dric Le Goater wrote:
> >> We will use it to reset the interrupt presenter from the CPU reset
> >> handler.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> Reviewed-by: Greg Kurz <groug@kaod.org>
> >> ---
> >>  include/hw/ppc/pnv_core.h | 3 +++
> >>  hw/ppc/pnv_core.c         | 3 ++-
> >>  2 files changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> >> index bfbd2ec42aa6..55eee95104da 100644
> >> --- a/include/hw/ppc/pnv_core.h
> >> +++ b/include/hw/ppc/pnv_core.h
> >> @@ -31,6 +31,8 @@
> >>  #define PNV_CORE_GET_CLASS(obj) \
> >>       OBJECT_GET_CLASS(PnvCoreClass, (obj), TYPE_PNV_CORE)
> >> =20
> >> +typedef struct PnvChip PnvChip;
> >> +
> >>  typedef struct PnvCore {
> >>      /*< private >*/
> >>      CPUCore parent_obj;
> >> @@ -38,6 +40,7 @@ typedef struct PnvCore {
> >>      /*< public >*/
> >>      PowerPCCPU **threads;
> >>      uint32_t pir;
> >> +    PnvChip *chip;
> >=20
> > I don't love having this as a redundant encoding of the information
> > already in the property, since it raises the possibility of confusing
> > bugs if they ever got out of sync.
>=20
> Indeed.
>=20
> > It's not a huge deal, but it would be nice to at least to at least
> > consider either a) grabbing the property everywhere you need it (if
> > there aren't too many places)=20
>=20
> We need the chip at core creation and core reset to call the=20
> interrupt chip handlers. These are not hot path but the pointer
> seemed practical.
>=20
> > or b) customizing the property
> > definition so it's written directly into that field.
>=20
> OK. That is better than just a link.

I guess.  If there are only two non hot path callers, it seems like it
might be simpler to just pull it out of the property at those places.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl21y1cACgkQbDjKyiDZ
s5Is9xAA2wvMGMetnYe4/8rk19KQkbyd06Y4xr6RtGq6HOB5/aggeMJ4maqt3JSv
F+PL+Tc6ri3oqeQVgWXQ4L9xyiiceLy/9rmFUwBd03dJaMIcck/tgGs1rsJ51EwK
aKOBEGRXLD3nyyEz+f3ozBhGY1RyCRlqRxY40grPiD8itTNcUWM+uh76PPwCcufT
FoO+Kf/kwicrRA2ui2NaFsYyuT9L7aFS+Z6CJqEZvWAD7qWlDwtOJ8yHuK+v+/+r
Cxwod31PEb3ChZn13p9tpyDRM5BwtXaq3BVqhYQayrruN9RgRVGnjBvMLLDh1g0H
WMxJ2ldrJgiOCC4ZWAWfxyc9SZ7ZFNtv9SFYuzWDuSU0MRi/xomAIf2V3eryBopl
Erd9lfLy4BguHFecUoAXRTXqXuYAy55FsDLFGNe6GqcoxxN3daZjoPUbBdU9a7Fr
yKDLP9NVQ98kRg9mo39siNeGNna8/0pOMy35ttggZHwYi9NLnakphllC9FILJOKE
unDINmrm2GPgD5f/ir9QSwMm7TwoztvuSBvfbgch7R94eyB+dxmrZx3ngEr7hdJY
IbnvIExM2I/+D3bjfJnpsDUdXR9Arvd1JhUiqi9DFSe4DWDkbbL8LsmfAAlJAlB0
P3VW5Gz7ccJ195cLZ2DHrBJUvloCs6wRVRLR7YDNWM//ItZd5HA=
=/3/5
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--

