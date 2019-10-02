Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F96DC4360C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 22:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB984215EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 22:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CW6qsiik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB984215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFnJW-0005M3-2e
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 18:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFnIb-0004sg-Mw
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 18:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFnIZ-0007QD-Un
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 18:40:45 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:39959)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFnIZ-0007P9-Ca; Wed, 02 Oct 2019 18:40:43 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46kB1L5hzKz9sPZ; Thu,  3 Oct 2019 08:40:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570056038;
 bh=+wKABM1L9K4tA8ncx1HTC1/ydQ/j0JTltkW29utzxD8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CW6qsiik0JYKwJv3vDQYYgCDEwFrMRn7hoa9L+2s15zOe6ZLuOLuWj6LSW7pUFRl5
 mh21VM/5jpcxCmh5HMIjzsLPuDuXtnLrwneBIC5CLB3QxUWIxIOOYeYREKSxSt/Nan
 lfPB/UmhVzvnxcNv/rSikZKjM1HilZvJBmqlTIak=
Date: Thu, 3 Oct 2019 08:37:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] spapr/xive: skip partially initialized vCPUs in presenter
Message-ID: <20191002223741.GC11105@umbus.fritz.box>
References: <20191001085722.32755-1-clg@kaod.org>
 <20191001130614.226ef6a2@bahia.w3ibm.bluemix.net>
 <fad6aae9-8722-498c-730d-fa204f07e3c5@kaod.org>
 <20191001185629.0b284ba1@bahia.lan>
 <20191002010245.GT11105@umbus.fritz.box>
 <20191002162142.7ce18dcb@bahia.lan>
 <3db4ae61-a4f0-3ddf-e734-5795c7176559@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="A1Iwnsx6rNfRhs6P"
Content-Disposition: inline
In-Reply-To: <3db4ae61-a4f0-3ddf-e734-5795c7176559@kaod.org>
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--A1Iwnsx6rNfRhs6P
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2019 at 04:47:56PM +0200, C=E9dric Le Goater wrote:
> On 02/10/2019 16:21, Greg Kurz wrote:
> > On Wed, 2 Oct 2019 11:02:45 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> >> On Tue, Oct 01, 2019 at 06:56:28PM +0200, Greg Kurz wrote:
> >>> On Tue, 1 Oct 2019 13:56:10 +0200
> >>> C=E9dric Le Goater <clg@kaod.org> wrote:
> >>>
> >>>> On 01/10/2019 13:06, Greg Kurz wrote:
> >>>>> On Tue,  1 Oct 2019 10:57:22 +0200
> >>>>> C=E9dric Le Goater <clg@kaod.org> wrote:
> >>>>>
> >>>>>> When vCPUs are hotplugged, they are added to the QEMU CPU list bef=
ore
> >>>>>> being fully realized. This can crash the XIVE presenter because the
> >>>>>> 'tctx' pointer is not necessarily initialized when looking for a
> >>>>>> matching target.
> >>>>>>
> >>>>>
> >>>>> Ouch... :-\
> >>>>>
> >>>>>> These vCPUs are not valid targets for the presenter. Skip them.
> >>>>>>
> >>>>>
> >>>>> This likely fixes this specific issue, but more generally, this
> >>>>> seems to indicate that using CPU_FOREACH() is rather fragile.
> >>>>>
> >>>>> What about tracking XIVE TM contexts with a QLIST in xive.c ?
> >>>>
> >>>> This is a good idea. =20
> >>>>
> >>>> On HW, the thread interrupt contexts belong to the XIVE presenter=20
> >>>> subengine. This is the logic doing the CAM line matching to find
> >>>> a target for an event notification. So we should model the context=
=20
> >>>> list below the XiveRouter in QEMU which models both router and=20
> >>>> presenter subengines. We have done without a presenter model for=20
> >>>> the moment and I don't think we will need to introduce one. =20
> >>>>
> >>>> This would be a nice improvements of my patchset adding support
> >>>> for xive escalations and better support of multi chip systems.=20
> >>>> I have introduced a PNV_CHIP_CPU_FOREACH in this patchset which=20
> >>>> would become useless with a list of tctx under the XIVE interrupt
> >>>> controller, XiveRouter, SpaprXive, PnvXive.
> >>>>
> >>>
> >>> I agree. It makes more sense to have the list below the XiveRouter,
> >>> rather than relying on CPU_FOREACH(), which looks a bit weird from
> >>> a device emulation code perspective.
> >>
> >> That does sound like a better idea long term.  However, for now, I
> >> think the NULL check is a reasonable way of fixing the real error
> >> we're hitting, so I've applied the patch here.
> >>
> >=20
> > Fair enough.
> >=20
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> >=20
> >> Future cleanups to a different approach remain welcome, of course.
> >>
> >=20
> > I've started to look. This should simplify Cedric's "add XIVE support
> > for KVM guests" series, but I'll wait for your massive cleanup series
> > to get merged first.
>=20
>=20
> This is a combo patchset.=20
>=20
>=20
> These are prereqs fixes related to the presenter and how CAM lines
> are scanned. This is in direct relation with the CPU_FOREACH() issue.
>=20
>   ppc/xive: Introduce a XivePresenter interface
>   ppc/xive: Implement the XivePresenter interface
>   ppc/pnv: Introduce a PNV_CHIP_CPU_FOREACH() helper
>   ppc/pnv: Introduce a pnv_xive_is_cpu_enabled() helper
>   ppc/xive: Introduce a XiveFabric interface
>   ppc/pnv: Implement the XiveFabric interface
>   ppc/spapr: Implement the XiveFabric interface
>   ppc/xive: Use the XiveFabric and XivePresenter interfaces
>=20
> These are for interrupt resend (escalation). To be noted, the removal=20
> of the get_tctx() XiveRouter handler which has some relation with=20
> the previous subserie.
>=20
>   ppc/xive: Extend the TIMA operation with a XivePresenter parameter
>   ppc/pnv: Clarify how the TIMA is accessed on a multichip system
>   ppc/xive: Move the TIMA operations to the controller model
>   ppc/xive: Remove the get_tctx() XiveRouter handler
>   ppc/xive: Introduce a xive_tctx_ipb_update() helper
>   ppc/xive: Introduce helpers for the NVT id
>   ppc/xive: Synthesize interrupt from the saved IPB in the NVT
>=20
> This is a bug :
>=20
>   ppc/pnv: Remove pnv_xive_vst_size() routine
>   ppc/pnv: Dump the XIVE NVT table
>   ppc/pnv: Skip empty slots of the XIVE NVT table
>=20
> This is a model for the block id configuration and better support
> for multichip systems :=20
>=20
>   ppc/pnv: Introduce a pnv_xive_block_id() helper
>   ppc/pnv: Extend XiveRouter with a get_block_id() handler
>=20
> Misc improvements :=20
>=20
>   ppc/pnv: Quiesce some XIVE errors
>   ppc/xive: Introduce a xive_os_cam_decode() helper
>   ppc/xive: Check V bit in TM_PULL_POOL_CTX
>   ppc/pnv: Improve trigger data definition
>   ppc/pnv: Use the EAS trigger bit when triggering an interrupt from PSI
>=20
>=20
> I should move some in front to have them merged before hand if=20
> possible. They have been on the list for 3 months.

Sorry :(.  I've been kind of overwhelmed.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--A1Iwnsx6rNfRhs6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2VJrUACgkQbDjKyiDZ
s5IVaBAAqq9HMeY4FZFOt1+ghDSzIPIGyAwj8hjGdVszF62QRMXHNYNZ9s9bbNUc
8fHmNaXkqjWHpJUkTUVPzXCezG2JvA0Tz1p3S4OKCfcDW2XQxv7K9sUW8i3iMBYS
OV/5XDXj3JnOBPV8I5DMnaaMKQUxrjqV0/mwj21+0HAutLi37sJr7mgFe+AZh9QW
iAuC32FigVfNZE50DhZInxBPHRSwo+1StHE6Z9V3n3Aeaa0IHbgKYVkG2r/0kuFX
vL7Y4/uSiRbqK7FvM6ilcTg/LteRQX4oIVFP7iikFc9Yiqz3nZOeblFNq8J0UCFc
XNNZ74JetelFIH2oS9/laJwM9NzvBbPaiMCicBJr5FLiTETFzScvG3b0rpRMSmrE
IFtXdaHGLowad6jU8AzFllZ41M077uJB0sz591laGyVniu1qyiZsHq6wG8DnkuYN
+C85yCgmCm53d5YK8SHiW0AkdwuKgwDCmk8j0+Brd5QHpbO91cGm9PJd35WihE3x
9nz2ZtK0JiUFww+d/bVsAajdrkz2Fo/4EoxFoH/NE2vGsjtarlrDLoMcskFnX8wz
alSs7VV8te+a0+6h79kx+uCZN/UVlr+uFyGYFAHCvhx5pIQJRXu/1x5/9vZw8yWU
3KFAjlzABerM7jnFpyYyD3jzKIXYjylGNs+2hSaJLj9WI72eivQ=
=Vl2s
-----END PGP SIGNATURE-----

--A1Iwnsx6rNfRhs6P--

