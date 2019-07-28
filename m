Return-Path: <SRS0=P1lm=VZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139AFC7618B
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 07:46:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43E22070D
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 07:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZMcsv9ef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43E22070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43959 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrdtK-0000Av-5m
	for qemu-devel@archiver.kernel.org; Sun, 28 Jul 2019 03:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53476)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hrdst-00086l-V2
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 03:46:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hrdss-00048A-Lp
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 03:46:23 -0400
Received: from ozlabs.org ([203.11.71.1]:42575)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hrdsq-0003yO-Eg; Sun, 28 Jul 2019 03:46:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45xFHr02gSz9sBF; Sun, 28 Jul 2019 17:46:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564299976;
 bh=ABPEiZnn3So+SCNevGt1h789msf7nst6rGtpB88VQ24=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZMcsv9ef5ekl4iOqy+FF0GVBcnbfpJAv7rhSm44gDPAyCAtqiRHwwML/TXtgqX0P0
 G9Pm1yaehcXYzMW43/s88sjEY27MbPkYNgIY2q9u7lZK12ruSol+nAKpgIvR3lclni
 GcTMWoeOljMAXpv88WPDF6SZpC2Eh5cze1xOoO2c=
Date: Sun, 28 Jul 2019 17:46:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190728074602.GF5110@umbus>
References: <20190718115420.19919-1-clg@kaod.org>
 <20190718115420.19919-10-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="juZjCTNxrMaZdGZC"
Content-Disposition: inline
In-Reply-To: <20190718115420.19919-10-clg@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v2 09/17] ppc/xive: Extend XiveTCTX with a
 XiveRouter pointer
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


--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2019 at 01:54:12PM +0200, C=E9dric Le Goater wrote:
> This is to perform lookups in the NVT table when a vCPU is dispatched
> and possibily resend interrupts.
>=20
> Future XIVE chip will use a different class for the model of the
> interrupt controller and we might need to change the type of
> 'XiveRouter *' to 'Object *'
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Hrm.  This still bothers me.  AIUI there can be multiple XiveRouters
in the system, yes?  And at least theoretically can present irqs from
multiple routers?  In which case what's the rule for which one should
be associated with a specific.

I guess it's the one on the same chip, but that needs to be explained
up front, with some justification of why that's the relevant one.

> ---
>  include/hw/ppc/xive.h | 2 ++
>  hw/intc/xive.c        | 9 +++++++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 4851ff87e795..206b23ecfab3 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -320,6 +320,8 @@ typedef struct XiveTCTX {
>      qemu_irq    os_output;
> =20
>      uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
> +
> +    struct XiveRouter  *xrtr;
>  } XiveTCTX;
> =20
>  /*
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 88f2e560db0f..1b0eccb6df40 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -573,6 +573,14 @@ static void xive_tctx_realize(DeviceState *dev, Erro=
r **errp)
>      Object *obj;
>      Error *local_err =3D NULL;
> =20
> +    obj =3D object_property_get_link(OBJECT(dev), "xrtr", &local_err);
> +    if (!obj) {
> +        error_propagate(errp, local_err);
> +        error_prepend(errp, "required link 'xrtr' not found: ");
> +        return;
> +    }
> +    tctx->xrtr =3D XIVE_ROUTER(obj);
> +
>      obj =3D object_property_get_link(OBJECT(dev), "cpu", &local_err);
>      if (!obj) {
>          error_propagate(errp, local_err);
> @@ -666,6 +674,7 @@ Object *xive_tctx_create(Object *cpu, XiveRouter *xrt=
r, Error **errp)
>      object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort);
>      object_unref(obj);
>      object_property_add_const_link(obj, "cpu", cpu, &error_abort);
> +    object_property_add_const_link(obj, "xrtr", OBJECT(xrtr), &error_abo=
rt);
>      object_property_set_bool(obj, true, "realized", &local_err);
>      if (local_err) {
>          goto error;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--juZjCTNxrMaZdGZC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl09UrgACgkQbDjKyiDZ
s5KP8xAA2YL89e1pREjTedRMMDgsMPsZkDR8Hk3u6XLnD2HzrOJGWZOp5OFZ+fMz
UtK28xUcHd2UiTx3MccIcl9LEYkWndJsnAJSg4TaQnZwZvfRP4tJ/AjURqVmw2LR
562kMf29T74Lc5JHYRZB+gZ0/kyNh+Rep93hbRhxeyUhe+xvI+jgYyCfo3ssTUn0
0/KUjr1gDBCvvudCOUGpcr+zeLMNdAKxr8rasTu5LZprLtZxdrWETSMy3KKTmuwz
EU3vTAyc5sCPN3cqjinugE/pEpJIvFN2JqRFTVT39JHhUPZK9PzzB5RfcLk8E3F/
Dhk4lDib/o0ySQYkdPq1hhlJuiCcN5VVXKOLREQb5w84zNeqyBcQn63Y01m4SsYq
GI8jeYJUOauOIH7npWsxNfdYjsD40kmjuk+wPopABlNy88B57o5LmmmCqLKEfdc6
foA2HgV9CA9kOGp3TNCq5ptjME+IRigax1FDP6sK+Yk9kmQ5WlE2VW48KB59iBNo
K0IaD8tDV9zlj+2jwAmeMbfMQEhg34gEMnjtEErCY0hfGK7Xq94yndYoOofuyN0z
hkTSwfJ6uiVRlms8/izQGpd1Qjp8OG5MMZftVpIU+n6OmtJaDZNLnBeoyd/USoma
H4CBkDvGIImml0OaWwz3dhVW0QTa4f6vw1fAdxxKu9A2ZYDThRc=
=j2Gi
-----END PGP SIGNATURE-----

--juZjCTNxrMaZdGZC--

