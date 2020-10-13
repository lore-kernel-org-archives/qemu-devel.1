Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E06C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E916721741
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dzdIfovO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E916721741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS8Tl-00043C-3a
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 20:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kS8RM-00022Q-Eo; Mon, 12 Oct 2020 20:45:20 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:59221 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kS8RI-0006nA-E5; Mon, 12 Oct 2020 20:45:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C9GzQ19Rwz9sT6; Tue, 13 Oct 2020 11:45:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602549906;
 bh=iesMAIFFSIXx2LuRbGWZtshOkHiV8rUz3ueyL+1s+4w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dzdIfovOYxi3i0Rib6mVY7/B1mNWoeJR80jBzwMeJbc6baVg8j1b4yKSFDjVR8cp6
 /pj7UEGoJwlMesrPjulwOiUnp2QI5v1PkgPAzJzYEyXFEolg3mYhMIWTo9bnKp0yyJ
 rvu/VMPpO6D1iOEcmu0Kwtb8H/Nc6iHC4669BZx8=
Date: Tue, 13 Oct 2020 11:39:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] spapr: Clarify why DR connectors aren't user creatable
Message-ID: <20201013003907.GE71119@yekko.fritz.box>
References: <160250199940.765467.6896806997161856576.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TD8GDToEDw0WLGOL"
Content-Disposition: inline
In-Reply-To: <160250199940.765467.6896806997161856576.stgit@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--TD8GDToEDw0WLGOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2020 at 01:26:39PM +0200, Greg Kurz wrote:
> DR connector is a device that emulates a firmware abstraction used by PAPR
> compliant guests to manage hotplug/dynamic-reconfiguration of PHBs, PCI
> devices, memory, and CPUs.
>=20
> It is internally created by the spapr platform and requires to be owned by
> either the machine (PHBs, CPUs, memory) or by a PHB (PCI devices).
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.2, thanks.

> ---
>  hw/ppc/spapr_drc.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 697b28c34305..77718cde1ff2 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -586,7 +586,8 @@ static void spapr_dr_connector_class_init(ObjectClass=
 *k, void *data)
>      dk->realize =3D realize;
>      dk->unrealize =3D unrealize;
>      /*
> -     * Reason: it crashes FIXME find and document the real reason
> +     * Reason: DR connector needs to be wired to either the machine or t=
o a
> +     * PHB in spapr_dr_connector_new().
>       */
>      dk->user_creatable =3D false;
>  }
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TD8GDToEDw0WLGOL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+E9ykACgkQbDjKyiDZ
s5KoYw//bktkMN93o+vv7ufI3SopuMqVlzSipV40/1zFrRTpIwfYhckuceOa/Z13
tjdTzDirU/Wk7uh3ycW+UTMRil26CHzdk3Rv8vzjWIKbTfLc/Q7uNjNM838Vfl2T
WCcUCHRiq+5ibEBtYjB8jwXkrufaPwWE6okg1B6FZUpwKrD/a0DGxOIeiBEQXzUi
1rFrYsQYaLOOQUujOxVUqlPXYPNOCHLHo+LazUVPiWunC6Lje9THu5lKnKXNlNlX
2wjhxiszvwEtnJhw186taYJS9tlT+xxQmFU1nl+MOj5p2Xad32S4ZM0aaC/8Zpzd
6vi47cYeQyb6g8CHeBmmJ9VF+wz+NyAgufruZGbmc5wnRZEE1htpOQYiGZJFvAxn
QEzpyNOX0wBAnpnP+8vOc879MXj3HG+nUim8FizeJW6/d+ti+ZYXRLUD4TJqZwTQ
WSowWWbEDLrmCuOo8REdxSbGcY72DotkaDjq43gBjTtYx+kVMq5eXDihaK2PPq+3
yHd7oT/siO1mF1d4v9S5SC4S5h4X3h7kbXpW2rJKmetP+5rI5zotwUgDSB7azl07
hE+T5jSc4O7JuQRwxQKJek3dIJIrXBUaRzXibPPkZ1ckvDkPh3uljylirHfcRx1W
k/YUNYPdXqJRuXhm5DyNTWoXvFKJOPN/jHPPzXY66XW3yO3OruQ=
=oKl3
-----END PGP SIGNATURE-----

--TD8GDToEDw0WLGOL--

