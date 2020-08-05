Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D45C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 05:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8388A206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 05:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dUGHuybN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8388A206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3CI8-0001Lh-RX
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 01:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k3CHO-0000oL-Il; Wed, 05 Aug 2020 01:47:58 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43443 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k3CHL-00047S-LA; Wed, 05 Aug 2020 01:47:58 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BM0yZ52w9z9sRK; Wed,  5 Aug 2020 15:47:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1596606470;
 bh=XopgAh5OXsXzay6tHa5wpGyKhf3N4pPNHM3xmPMu+K8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dUGHuybNNEPs0tgLfxaHo6IqIyEMXYSRgNdl2Rs0kFvWg/w37/ulruEVZe/3euk7J
 cXj87DzYKorYGh7adS05n12475oh8bgiOyXMneJdEbONSQnJRpB4kw69GS5rGxpdcv
 SmPYetwEyzPlISlDSFUIbPzmB5/z47d6Z88+duEE=
Date: Wed, 5 Aug 2020 11:51:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] docs: Update POWER9 XIVE support for nested guests
Message-ID: <20200805015122.GB2178@yekko.fritz.box>
References: <20200804131639.407049-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
In-Reply-To: <20200804131639.407049-1-clg@kaod.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 01:47:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 04, 2020 at 03:16:39PM +0200, C=E9dric Le Goater wrote:
> It is not yet supported.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-5.2.

> ---
>  docs/specs/ppc-spapr-xive.rst | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/docs/specs/ppc-spapr-xive.rst b/docs/specs/ppc-spapr-xive.rst
> index 6159bc6eed62..7199db730b82 100644
> --- a/docs/specs/ppc-spapr-xive.rst
> +++ b/docs/specs/ppc-spapr-xive.rst
> @@ -61,6 +61,11 @@ depend on the XIVE KVM capability of the host. On olde=
r kernels
>  without XIVE KVM support, QEMU will use the emulated XIVE device as a
>  fallback and on newer kernels (>=3D5.2), the KVM XIVE device.
> =20
> +XIVE native exploitation mode is not supported for KVM nested guests,
> +VMs running under a L1 hypervisor (KVM on pSeries). In that case, the
> +hypervisor will not advertise the KVM capability and QEMU will use the
> +emulated XIVE device, same as for older versions of KVM.
> +
>  As a final refinement, the user can also switch the use of the KVM
>  device with the machine option ``kernel_irqchip``.
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8qEJgACgkQbDjKyiDZ
s5K02Q/+P6Vf6hI+avDErajhx7a1l9Ws0ege7nkfBKxYl2b5gQZYIKMgoLIFWTI6
4rR6+CaN3RBGOGCJwb63D3hNL6VdWDiagY7lRhqMs3c4bI/mdXEYwnlCDQrmbJ3l
Q6NR7MEEU7MiUIP6SnKJdyIWWHuIa8UDPhWjcSgrs9fdbTcf1DYbhIdfl/iQjDUl
4OCEYF0762SRhERom0Crls6/VF4F7LJdx2A4V8uMCk5EOGQmn0npCVqbqMZ6IBFX
9IruclLdwqwK7bw2xnCQ21J9Qt5A3555Nf+DDyWe6mINPMfwswG3ed10e4UeFB3+
3VaUvFE+ySOi5WYUrLV49hgm7FtN18RR8RH+NogJc10TYGKWz6kdquLTWL70oPKy
OMzgKmcRC047+6FkOFwB+88RU/gKjfRlIbzSAZO4zn4qJytz2nPlBKXTvxopJJQd
IrHwFL6bbSutXfOXGbb8EfKi00jqkHq/0lcu26gsvBPfeb/ykQWmPa0f2kqKI4/x
qC9oljMnJYuBGzt2OIUEtQby/iSvjPPtP1SXTrJIpQoSYzZoSLEi6ow5hIItgPe+
je6d1GW5+BNQVLHHdG8WtaSGJpDZ1e+fiocSI7AnWOZuR34+uGscSqV6hgtPUcTg
HoOEBF4QgYq9eLuVLpFsnEaN0Mc9Q8L+vow1OUStfAgnG01dzeM=
=Jgq/
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--

