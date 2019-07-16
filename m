Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC900C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 00:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A335721851
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 00:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XMng9ATI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A335721851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnXRn-0004gl-M5
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 20:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42326)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnXRX-0003ul-Fz
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 20:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnXRW-0001ln-3Q
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 20:05:11 -0400
Received: from ozlabs.org ([203.11.71.1]:55971)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hnXRU-0001ga-Gr
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 20:05:10 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45pHZm0tj2z9sMr; Wed, 17 Jul 2019 10:05:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563321904;
 bh=jSzPKnwin2sq42fRhXQqzQ/9GE26t4dpc9Lq09zuDa0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XMng9ATIoi/QaaNrmTdxOC5bCmw9Umjd97hZ3ExsxeO7bB5q2sU43wyINPCBqE+Dg
 XubhVkFiiVrVCt3Hvs1RfjV1mcYEdm3bgY7KavsVG00FkaXKQmfU1xyCEU2+zDC3q3
 C7AuMCpd2D44LjUTpVFCtCjzOcmAI6Uy787o9VEk=
Date: Tue, 16 Jul 2019 19:02:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Message-ID: <20190716090241.GI7525@umbus.fritz.box>
References: <1563200574-11098-1-git-send-email-stefan.brankovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZOudaV4lSIjFTlHv"
Content-Disposition: inline
In-Reply-To: <1563200574-11098-1-git-send-email-stefan.brankovic@rt-rk.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v5 0/8] target/ppc: Optimize emulation of
 some Altivec instructions
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
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ZOudaV4lSIjFTlHv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2019 at 04:22:46PM +0200, Stefan Brankovic wrote:
> Optimize emulation of ten Altivec instructions: lvsl, lvsr, vsl, vsr, vpk=
px,
> vgbbd, vclzb, vclzh, vclzw and vclzd.
>=20
> This series buils up on and complements recent work of Thomas Murta, Mark
> Cave-Ayland and Richard Henderson in the same area. It is based on devisi=
ng TCG
> translation implementation for selected instructions rather than using he=
lpers.
> The selected instructions are most of the time idiosyncratic to ppc platf=
orm,
> so relatively complex TCG translation (without direct mapping to host
> instruction that is not possible in these cases) seems to be the best opt=
ion,
> and that approach is presented in this series. The performance improvemen=
ts
> are significant in all cases.

I've applied 1 & 2, I'm waiting on Richards ack for the rest.

>=20
> V5:
>=20
> Fixed vpkpx bug and added it back in patch.
> Fixed graphical distortions on OSX 10.3 and 10.4.
> Removed conversion of vmrgh and vmrgl instructions to vector operations f=
or
> further investigation.
>=20
> V4:
>=20
> Addressed Richard's Henderson's suggestions.
> Removed vpkpx's optimization for further investigation on graphical disto=
rtions
> it caused on OSX 10.2-4 guests.
> Added opcodes for vector vmrgh(b|h|w) and vmrgl(b|h|w) in tcg.
> Implemented vector vmrgh and vmrgl instructions for i386.
> Converted vmrgh and vmrgl instructions to vector operations.
>=20
> V3:
>=20
> Fixed problem during build.
>=20
> V2:
>=20
> Addressed Richard's Henderson's suggestions.
> Fixed problem during build on patch 2/8.
> Rebased series to the latest qemu code.
>=20
> Stefan Brankovic (8):
>   target/ppc: Optimize emulation of lvsl and lvsr instructions
>   target/ppc: Optimize emulation of vsl and vsr instructions
>   target/ppc: Optimize emulation of vpkpx instruction
>   target/ppc: Optimize emulation of vgbbd instruction
>   target/ppc: Optimize emulation of vclzd instruction
>   target/ppc: Optimize emulation of vclzw instruction
>   target/ppc: Optimize emulation of vclzh and vclzb instructions
>   target/ppc: Refactor emulation of vmrgew and vmrgow instructions
>=20
>  target/ppc/helper.h                 |  10 -
>  target/ppc/int_helper.c             | 365 --------------------
>  target/ppc/translate/vmx-impl.inc.c | 656 ++++++++++++++++++++++++++++++=
++----
>  3 files changed, 587 insertions(+), 444 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZOudaV4lSIjFTlHv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0tkq8ACgkQbDjKyiDZ
s5KxUQ/+IvivwUIa8rPzTKbamioLD855CThiHb2q7f8JJoyTmalWSRxY4FLq1w9o
cN8g4gcoA7B7PyaBCuNR4f/BAZjolQIySo6IHnrsJso3aLa/f4apeSkM0ZnndJFo
WDgkMf/FSJYJACaK+1EEYT8buYolQD+8N1mshuSMcv/p4sMOuiNndcN2bsGPYolV
AmU3F6B1dpr5T7ZsynN/pVMTHZdb1VYkN4hPz62/v64HfqtVBvoAvtfoaCbga7Kb
CmgsSDiF+tku4tBEqrrajbeoGVWCSDOnB1176nu3UbzNxiIpy9Wbo9vRzTtOrM7m
E18F3akDxbbe5OjtE8MPRUdk7r0iGfhY00euiy+LbTqIgBvBOTOyB9o/7zjzhOLh
+JqlFScGV1U7GA2UTFhvxB484Hg6bcK9BKGz0zpTC3IZOSMPrwbGcILzmzhTk4Eg
cy0Z7jEhIAYyn+RRtubtYUWuJSzX/FbLH2AtF4O/4Swj58nMMHD7sMli74MWelUQ
wFesKbCNkU1pO4imy56Q8eEiMOf28rZdFL0sNA3PiEBOcHMU8sqoCTnMU1MMB5KH
E+PR2vm3kvMdNDA1t25EVQpKuOrsjXBxTQw5FVmkMg25GHqc11wFgJXv6RWatHzf
qnZfY62JSAXa/JpDzCIUlfNVsRQmyKPmTrKNpxjteYsfszTEvdc=
=jHpe
-----END PGP SIGNATURE-----

--ZOudaV4lSIjFTlHv--

