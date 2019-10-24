Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9811CA9EB9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C8F520684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Ur83YBp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8F520684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNTZl-0007Xu-5y
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 23:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNTTN-0006ZY-7L
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:07:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNTTL-0002up-Ei
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:07:37 -0400
Received: from ozlabs.org ([203.11.71.1]:59055)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNTTL-0002sk-2T; Wed, 23 Oct 2019 23:07:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zBxT02nGz9sQr; Thu, 24 Oct 2019 14:07:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571886445;
 bh=F1XmhPCLNsOziR1uD64Al2UyADG9zZc4RHnjsJ9/byQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ur83YBp6C+M/YXN/sx+Jcq4iw4cTZnTyr13qUJTV/xB/k6sGzx+YNeZbcKq1dUDVq
 KB5KIkKQqHoOK87FQO/XVoG8/CmXDrgsvdU4y201R9LckRFQ6gpBc0M3+iSY2pREBg
 vUNgQ/a0Z37iQQNvVsWckP87XrrMVsfF1Qj1bL0w=
Date: Thu, 24 Oct 2019 13:50:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 2/6] xive, xics: Fix reference counting on CPU objects
Message-ID: <20191024025041.GS6439@umbus.fritz.box>
References: <157184231371.3053790.17713393349394736594.stgit@bahia.lan>
 <157184232497.3053790.5571330781863409160.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kLVKJMuKEUFaIs8+"
Content-Disposition: inline
In-Reply-To: <157184232497.3053790.5571330781863409160.stgit@bahia.lan>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--kLVKJMuKEUFaIs8+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2019 at 04:52:05PM +0200, Greg Kurz wrote:
> When a VCPU gets connected to the XIVE interrupt controller, we add a
> const link targetting the CPU object to the TCTX object. Similar links
> are added to the ICP object when using the XICS interrupt controller.
>=20
> As explained in <qom/object.h>:
>=20
>  * The caller must ensure that @target stays alive as long as
>  * this property exists.  In the case @target is a child of @obj,
>  * this will be the case.  Otherwise, the caller is responsible for
>  * taking a reference.
>=20
> We're in the latter case for both XICS and XIVE. Add the missing
> calls to object_ref() and object_unref().
>=20
> This doesn't fix any known issue because the life cycle of the TCTX or
> ICP happens to be shorter than the one of the CPU or XICS fabric, but
> better safe than sorry.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

LGTM
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/intc/xics.c |    8 +++++++-
>  hw/intc/xive.c |    6 +++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 935f325749cb..5f746079be46 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -388,8 +388,10 @@ Object *icp_create(Object *cpu, const char *type, XI=
CSFabric *xi, Error **errp)
>      obj =3D object_new(type);
>      object_property_add_child(cpu, type, obj, &error_abort);
>      object_unref(obj);
> +    object_ref(OBJECT(xi));
>      object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(xi),
>                                     &error_abort);
> +    object_ref(cpu);
>      object_property_add_const_link(obj, ICP_PROP_CPU, cpu, &error_abort);
>      object_property_set_bool(obj, true, "realized", &local_err);
>      if (local_err) {
> @@ -403,7 +405,11 @@ Object *icp_create(Object *cpu, const char *type, XI=
CSFabric *xi, Error **errp)
> =20
>  void icp_destroy(ICPState *icp)
>  {
> -    object_unparent(OBJECT(icp));
> +    Object *obj =3D OBJECT(icp);
> +
> +    object_unref(object_property_get_link(obj, ICP_PROP_CPU, &error_abor=
t));
> +    object_unref(object_property_get_link(obj, ICP_PROP_XICS, &error_abo=
rt));
> +    object_unparent(obj);
>  }
> =20
>  /*
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 38257aa02083..952a461d5329 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -682,6 +682,7 @@ Object *xive_tctx_create(Object *cpu, XiveRouter *xrt=
r, Error **errp)
>      obj =3D object_new(TYPE_XIVE_TCTX);
>      object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort);
>      object_unref(obj);
> +    object_ref(cpu);
>      object_property_add_const_link(obj, "cpu", cpu, &error_abort);
>      object_property_set_bool(obj, true, "realized", &local_err);
>      if (local_err) {
> @@ -698,7 +699,10 @@ error:
> =20
>  void xive_tctx_destroy(XiveTCTX *tctx)
>  {
> -    object_unparent(OBJECT(tctx));
> +    Object *obj =3D OBJECT(tctx);
> +
> +    object_unref(object_property_get_link(obj, "cpu", &error_abort));
> +    object_unparent(obj);
>  }
> =20
>  /*
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kLVKJMuKEUFaIs8+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2xEYEACgkQbDjKyiDZ
s5LyfA//dZ97U9hlBIwtb4ny04SaHw870f2k1PqmfN+FXJL/+RPOzduQQsg6Y13x
uedNK/r3pRAtfa/zZEIftsJgY3+ktTHIodzZg/GIKFxkbH75UNYCD+nqTBcCMmVr
gkSfoGSa8DwukN9TQX+rYYOpmoLe++O4jc/LTv2LcTzL7E/aZWMWOUWS/svuoa/o
hM82Z15lUq6SWYbEAOFJpbsAIjmbytG2FlyovXp6Jh4wuBNVoqdLilzlUwWpV18R
fAkYow9zC3UT7SR7lbXYhp4IZ9f69avgJ70iV0Pro1OAbjBXyyXKDunMxrFbpR8U
Ke94oZj9T5aBczGuPc/gQ/BxjaKiTrC1StX3TofL27wIzHvBQ1pTPar05jg5WJRv
r/be1CCtyREUS3PUPXZn+BVo2C0pqgsDsCKsreXL5dg3TNBh9gc+H1Pn7pZXXhfJ
yf2+DEiGo60WE3OD3xfC71Jk7e2QHvWOF7HfpZ7Ncle/Ly7PCgDdthA6EJSSwy0Q
NFo7fOcz3Ntgct9HZkxfg68/vZbo9/FHdrYLhubDYvOLJL9zVPQ3WT/9M1tn1DQ0
GNq/OhRX5SzKsChX6vAuUQNuFR+c5jLpzUP3mzjSd1P66D+YjcEvvyhF1vZqZHEc
qcGBCLgogqjwAxMEw/1wEsVRLQ3r6QMCvz0bNWPZH7emhB0Rzyg=
=BqZk
-----END PGP SIGNATURE-----

--kLVKJMuKEUFaIs8+--

