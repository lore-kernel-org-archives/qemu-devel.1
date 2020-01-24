Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793EDC32771
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49A3A2075D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bGXQub9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A3A2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuvit-0002lM-HT
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 04:57:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iuviG-0001xp-0n
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:57:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iuviE-0001Sx-D1
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:57:15 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:34067 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iuviD-0001NK-4A; Fri, 24 Jan 2020 04:57:14 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 483vgh6TM4z9sSg; Fri, 24 Jan 2020 20:57:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579859824;
 bh=Jv9n+UHA2DQ1DSZSZ0KSEU+QAMycleC8pBL5mcEEMwI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bGXQub9MjyKbqy2KBXmR17Cfdxrm41EPqll4hs8CXFA67cKl5y8Gl12OP+Mwy9s/s
 40NAJ+WWPTOTmyZRR/TrXtPO8wnSWCSS/rnHk0bOWhJnm6hKFJNRouMqbElLNStN5p
 sQNs25JbqmPit9zjnbzhnibm9oSp3qRFB6MzPTiI=
Date: Fri, 24 Jan 2020 20:40:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH REPOST v3 68/80] ppc/virtex_ml507: remove unused arguments
Message-ID: <20200124094000.GT2347@umbus.fritz.box>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-69-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8DtChEGCcMdSgkU2"
Content-Disposition: inline
In-Reply-To: <1579779525-20065-69-git-send-email-imammedo@redhat.com>
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
Cc: edgar.iglesias@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--8DtChEGCcMdSgkU2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2020 at 12:38:33PM +0100, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Acked-by: David Gibson <david@gibson.dopbear.id.au>

> ---
> CC: david@gibson.dropbear.id.au
> CC: qemu-ppc@nongnu.org
> CC: edgar.iglesias@gmail.com
> ---
>  hw/ppc/virtex_ml507.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index 6862552..651d8db 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -89,10 +89,7 @@ static void mmubooke_create_initial_mapping(CPUPPCStat=
e *env,
>      tlb->PID =3D 0;
>  }
> =20
> -static PowerPCCPU *ppc440_init_xilinx(ram_addr_t *ram_size,
> -                                      int do_init,
> -                                      const char *cpu_type,
> -                                      uint32_t sysclk)
> +static PowerPCCPU *ppc440_init_xilinx(const char *cpu_type, uint32_t sys=
clk)
>  {
>      PowerPCCPU *cpu;
>      CPUPPCState *env;
> @@ -213,7 +210,7 @@ static void virtex_init(MachineState *machine)
>      int i;
> =20
>      /* init CPUs */
> -    cpu =3D ppc440_init_xilinx(&ram_size, 1, machine->cpu_type, 40000000=
0);
> +    cpu =3D ppc440_init_xilinx(machine->cpu_type, 400000000);
>      env =3D &cpu->env;
> =20
>      if (env->mmu_model !=3D POWERPC_MMU_BOOKE) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8DtChEGCcMdSgkU2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4qu20ACgkQbDjKyiDZ
s5Jf7g//RjH5CD6/IPbvi+gGZ17KiQRFqaRaGJ6upvAW2Ei3+pcKdGpvhvFI2Hi9
nbwuQv/1WCWYlpDrXKh2xTJ9993JLEmpOqUsMVUcuU21owb9Ij48JVltpMI8BEJD
BhC7GdHP13Rnkmh61hCgt9pHRL+POteAFr4l7VJ8qIrVSHTbq9GSmJZNHqGhO7KI
tVHqMorhDkiPCJlSmLZ775a18kiI2wgCY/l3/XGMGouSsozRTqZMwRRIPCGeoKyN
us2PLrv5dGPc9tNa3g/eJTD4WGJoejGAz0iCSxIc6vE9GtPJ9KoxamAwaP9Aik+L
goeFOFh2nkJDiTW8jT/qb2IYmQzxR5guehiMeQxqa0yDP2VYgmbvyrINQscR8cWB
L+zoVFzQmiBB3RJO68c2VPLJ2qGIxyo0+cA8wEtgmvX2TAM38leZofDs2U9EDZEc
Ma9VUQ8q4CDG376QKqDlKOBN7DC8x7AY2q2Pw/+94oMcgP6gtJVmc/wGb1b66RzA
y9kngC/9m0JgRAhUhy15yqnkDN5bQWZ5MUkajYzm9opZpH2HzWpAQeKZP7YOQpMt
sHe/Ufl8ovYBYESgNiyijxpYrYrVN8482nSPQDBLK/DAHU5LO2sbznTodUb57Svm
BETIK1K8WGzC5OHK90sq5/sflVGALkjszCzRqVfHw81BiELzq0E=
=pVMG
-----END PGP SIGNATURE-----

--8DtChEGCcMdSgkU2--

