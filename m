Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CC8C32793
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 03:44:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31BF20842
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 03:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hzk4V10J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31BF20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF95G-0001U7-V3
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 23:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iF93c-0000uQ-MJ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 23:42:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iF93b-0007yJ-5g
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 23:42:36 -0400
Received: from ozlabs.org ([203.11.71.1]:44271)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iF93a-0007xq-0Y; Mon, 30 Sep 2019 23:42:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46j4pY38cdz9sPK; Tue,  1 Oct 2019 13:42:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569901349;
 bh=h0S3TGYOd6DAa/fHcE51oK8mvMnuTPZg2veDoQ408qs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hzk4V10JbN8+b6UEuJsHHdJdUXhzj4zFcaSExSddsXKAn4ldcMVOE57KPUR87yJO7
 JjX5mZ30+vVljMDFZJXL8jCm0NwNAHLADJHLhwjU7VsbP69wOpDKNDlUgrtlzQEHaC
 iPDD3aTfRbRZNKEQmDVAqpJuVW4IAe6DPc5ImdKw=
Date: Tue, 1 Oct 2019 13:07:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 29/33] spapr, xics, xive: Move SpaprIrq::reset hook
 logic into activate/deactivate
Message-ID: <20191001030747.GO11105@umbus.fritz.box>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-30-david@gibson.dropbear.id.au>
 <f64cc1b3-95b1-08e8-8059-35cdf2e5153b@kaod.org>
 <20190930082543.GH11105@umbus.fritz.box>
 <9cbf05e4-c404-589f-e03f-9808f964a762@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="96dIhm/ZjrNld+BP"
Content-Disposition: inline
In-Reply-To: <9cbf05e4-c404-589f-e03f-9808f964a762@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--96dIhm/ZjrNld+BP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2019 at 09:29:14PM +0200, C=E9dric Le Goater wrote:
> On 30/09/2019 10:25, David Gibson wrote:
> > On Mon, Sep 30, 2019 at 08:11:56AM +0200, C=E9dric Le Goater wrote:
> >> On 27/09/2019 07:50, David Gibson wrote:
> >>> It turns out that all the logic in the SpaprIrq::reset hooks (and som=
e in
> >>> the SpaprIrq::post_load hooks) isn't really related to resetting the =
irq
> >>> backend (that's handled by the backends' own reset routines).  Rather=
 its
> >>> about getting the backend ready to be the active interrupt controller=
 or
> >>> stopping being the active interrupt controller - reset (and post_load=
) is
> >>> just the only time that changes at present.
> >>
> >> This is a 'critical' part which impacts all the migration cases:=20
> >>
> >> ic-mode=3Dxics,xive,dual + kernel_irqchip=3Don/off + TCG
> >=20
> > Yes... and?
>=20
> and it's fragile.

How so?  Explicitly having logic for when an intc becomes active or
inactive, and having a single callsite which does that and updates the
active controller seems less fragile to me.  At least compared to
having the update to the active controller (implicit in changing the
CAS vector) and the logic to get the controllers ready for being
active/inactive in totally different places and relying on the fact
they both only happen at reset for them to travel together.

>=20
> >>> To make this flow clearer, move the logic into the explicit backend
> >>> activate and deactivate hooks.
> >>
> >> I don't see where the hooks are called ?
> >=20
> > spapr_irq_reset()
> >   -> spapr_irq_update_active_intc()
> >     -> set_active_intc()
> >       -> activate/deactivate hooks
> >=20
> > Similarly via spapr_irq_post_load().
> >=20
> > I'm hoping to add one at CAS time to avoid the CAS reboot, too.
>=20
> OK. I think the first 22 patches are ready, just some minor comments
> if I am correct. Could you merge them ?

I might repost first, because one of the changes Greg suggested to
error handling caused a larger than expected number of ripple on
fixes.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--96dIhm/ZjrNld+BP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2SwwEACgkQbDjKyiDZ
s5Lq5g/6AjNeJSgOPVXqMlJgYf2XJY195SAsU/WBFnps1kwKIlSmcbT31lAYm5Y/
lGMwxXiHp+D6RR5hOg4l8sHu8I+s3qzQrRD3Ysj+CVj6XCjs+CzyMmdJ8ToTCt6E
Dcyrutl8MVGvragAa90yntRqaQ2XS3XDRRy+zUBlPUELrCz8IN2TG72d8ZG+Dlhq
SW50on0reM8sGFAbzFVEQxFXz5dlDtzhZL1bxERH28Jrjz9T2E6BjMAlbALNEYEF
SpmtyVL4AC1kH4DzB/DtNJxcuhZ4IqNv1bDtwH5HLacqRFwd0/zjdmOCMZe2uCSu
HN2uV5/Vjwga1sUP4rH0Lysj7wGHDvAHZPkCkT+eweKrGwf89fn+xC/+itZvGwm4
4iU5wP1eZjfWRiDFYZ/AlCKqbZFYAoxEfOCOW6X1ODzNEdMzzTMpmF5obiKd5CUi
10TjARbBPTWvTtpapJ16Q4CWVCY6ABfaGf1M1JHilmuFjemmtB5xoR5qre5PNbJb
cDhGFEt3dg9lMJNU+W8WMqLFz4d+UGRcn/JiDnkjMYGGekre6bqzbn0aDBI3VcVO
6T94qvcdn/NjloRhUTqqOMRAZNjH8OqRbIFmqs4LkRM/8Y3f3D+qgISUoHTI1v+T
CmquvGBeiG5k0vsZxMqcCRgIL6/ITLN381arWWbXEjWVSeSRWhk=
=7Mmx
-----END PGP SIGNATURE-----

--96dIhm/ZjrNld+BP--

