Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33176C04AB3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 06:36:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F22BC217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 06:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jvhqWkLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22BC217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37740 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOz9H-0006fZ-8d
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 02:36:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOz7o-0005AQ-W5
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOz7n-0004ug-OC
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:35:20 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:41557)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hOz7l-0004oV-1g; Fri, 10 May 2019 02:35:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 450gSD34VKz9sML; Fri, 10 May 2019 16:35:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557470108;
	bh=oY7agreCv0QLhCAfJdtst3+nE5cmRq/lTG9j7qBIejA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvhqWkLgYh88UQLMkrYYLdLtxIDY6jhIeVZ3iUtOK5dnlwIJGlKoTvVTAo17A5EoL
	PEZ3ckW6xiXHNKc9Amn8f3pspMRfZ/qS+DyA65EpDjgsbFe4O8IwaNyDtq2rKjGVTH
	YkWun+gII7+6YxZI3AdLo2NtPYwODNfLNpOa50NY=
Date: Fri, 10 May 2019 16:32:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190510063249.GH20559@umbus.fritz.box>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
	<20190503055316.6441-13-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GBDnBH7+ZvLx8QD4"
Content-Disposition: inline
In-Reply-To: <20190503055316.6441-13-sjitindarsingh@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 12/13] target/ppc: Introduce
 POWER9 DD2.2 cpu type
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
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--GBDnBH7+ZvLx8QD4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2019 at 03:53:15PM +1000, Suraj Jitindar Singh wrote:
> Introduce a POWER9 DD2.2 cpu type with pvr 0x004E1202.
>=20
> A DD2.2 POWER9 cpu type is needed to enable kvm for pseries tcg guests
> since it means they will use the H_ENTER_NESTED hcall to run a guest
> rather than trying the generic entry path which will fail.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr_cpu_core.c | 1 +
>  target/ppc/cpu-models.c | 2 ++
>  target/ppc/cpu-models.h | 1 +
>  3 files changed, 4 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 40e7010cf0..98d46c6edb 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -399,6 +399,7 @@ static const TypeInfo spapr_cpu_core_type_infos[] =3D=
 {
>      DEFINE_SPAPR_CPU_CORE_TYPE("power8nvl_v1.0"),
>      DEFINE_SPAPR_CPU_CORE_TYPE("power9_v1.0"),
>      DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.0"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.2"),
>  #ifdef CONFIG_KVM
>      DEFINE_SPAPR_CPU_CORE_TYPE("host"),
>  #endif
> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> index 7c75963e3c..603ae7f5b4 100644
> --- a/target/ppc/cpu-models.c
> +++ b/target/ppc/cpu-models.c
> @@ -773,6 +773,8 @@
>                  "POWER9 v1.0")
>      POWERPC_DEF("power9_v2.0",   CPU_POWERPC_POWER9_DD20,            POW=
ER9,
>                  "POWER9 v2.0")
> +    POWERPC_DEF("power9_v2.2",   CPU_POWERPC_POWER9_DD22,            POW=
ER9,
> +                "POWER9 v2.2")
>  #endif /* defined (TARGET_PPC64) */
> =20
>  /***********************************************************************=
****/
> diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> index efdb2fa53c..820e94b0c8 100644
> --- a/target/ppc/cpu-models.h
> +++ b/target/ppc/cpu-models.h
> @@ -373,6 +373,7 @@ enum {
>      CPU_POWERPC_POWER9_BASE        =3D 0x004E0000,
>      CPU_POWERPC_POWER9_DD1         =3D 0x004E0100,
>      CPU_POWERPC_POWER9_DD20        =3D 0x004E1200,
> +    CPU_POWERPC_POWER9_DD22        =3D 0x004E1202,
>      CPU_POWERPC_970_v22            =3D 0x00390202,
>      CPU_POWERPC_970FX_v10          =3D 0x00391100,
>      CPU_POWERPC_970FX_v20          =3D 0x003C0200,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GBDnBH7+ZvLx8QD4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzVGxEACgkQbDjKyiDZ
s5LaGBAArwHwM7R5LEMF2goOmrSukrIRNfYxoXkhyHooAckBcW3Jn/O0WBMgnYJy
t31rQUpG8JyMo/6OXR4czDJJ8jhML9KgXWBfEa63plJaQdZZ4iJ7gVcOhNHAHav0
RiCh1oMSGlVGfz6oB+X/dfxXRRF9pfPKPyWYAbTeFwRnyszftQSfz7i+AClLTURn
V3EhvCaqtSj7eXT1P3yquBmNP2nI5NbKlpy/HQlx875RiO6o30YI4b8U9U40cuYF
BRnMvbfw8H2IPMPCGP/VBGKr0FvUlYgEfQADqlX9jm589v6vCfncacq2hkyOZMuK
kIewocEJgyZ5YEbmwLEliOhw3y+VEmKFxiFLilLqIouryQpQTBD7gITq4EZknpgA
Z97nUXYxOGoj5KMf17bB1vzOKqO+r5nkx3G1niMxyEf52oW3pEHG8/fe8PrSzQo1
7P/wGuPXHaOUmQQguMuGouON3igQUfEsnDUDYBDfsPUPk1kilxQ8dwBZ0tePp34h
QRtbDoaNNVZw7e+yPd/nW+UCnwK/iSLUMJngrzOkUtMbipPLHXQRV4lEriTyHn73
cJHtkUxgTxsDxe3VlyU3sNgB5jsd/9DxxLBVuOZjqqHBklGpBeD/MpA38fcY2jV7
qzFwKLICAeJ87V+GGPAztIvLxGrUXkp1CFsy+lIT3V4G1JZfai4=
=ZgUe
-----END PGP SIGNATURE-----

--GBDnBH7+ZvLx8QD4--

