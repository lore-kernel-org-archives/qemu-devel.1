Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17906C35280
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 23:46:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D834D208E4
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 23:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GownFTDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D834D208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWqED-0002HP-47
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 19:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWqDW-0001lu-LD; Thu, 07 May 2020 19:46:14 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:55735 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWqDS-0001JX-P0; Thu, 07 May 2020 19:46:14 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49J98C53RFz9sSG; Fri,  8 May 2020 09:46:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588895163;
 bh=/vS34R+k5dXmIeBjV8mvwuWABN1v7+wmk7tOiBHye8Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GownFTDe6DIq1YaFkwqV4MooXH/lq1tswwUz5XtkUnhmDxPVm61z6gJlSZr/M0EPI
 Cyzant49WJRFh9ZjuL6S+nW0wTIvpDelGIWL//GIPNYntg/06K8uqS9HCYj5R0gWZR
 Aje6EnryqAqIR+wnneY23xp5mDych6ncEOLbzSi0=
Date: Fri, 8 May 2020 09:33:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] target/ppc: Untabify excp_helper.c
Message-ID: <20200507233343.GC2282@umbus.fritz.box>
References: <158886788307.1560068.14096740175576278978.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline
In-Reply-To: <158886788307.1560068.14096740175576278978.stgit@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2020 at 06:11:23PM +0200, Greg Kurz wrote:
> Some tabs crept in with a recent change.
>=20
> Fixes: 6dc6b557913f "target/ppc: Improve syscall exception logging"
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

Not quite sure why my pre-commit hook didn't catch this before I sent
the PR, but there you go.

> ---
>  target/ppc/excp_helper.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 639cac38f9c3..4db3d9ed9af5 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -70,16 +70,16 @@ static inline void dump_syscall(CPUPPCState *env)
>  static inline void dump_hcall(CPUPPCState *env)
>  {
>      qemu_log_mask(CPU_LOG_INT, "hypercall r3=3D%016" PRIx64
> -		  " r4=3D%016" PRIx64 " r5=3D%016" PRIx64 " r6=3D%016" PRIx64
> -		  " r7=3D%016" PRIx64 " r8=3D%016" PRIx64 " r9=3D%016" PRIx64
> -		  " r10=3D%016" PRIx64 " r11=3D%016" PRIx64 " r12=3D%016" PRIx64
> +                  " r4=3D%016" PRIx64 " r5=3D%016" PRIx64 " r6=3D%016" P=
RIx64
> +                  " r7=3D%016" PRIx64 " r8=3D%016" PRIx64 " r9=3D%016" P=
RIx64
> +                  " r10=3D%016" PRIx64 " r11=3D%016" PRIx64 " r12=3D%016=
" PRIx64
>                    " nip=3D" TARGET_FMT_lx "\n",
>                    ppc_dump_gpr(env, 3), ppc_dump_gpr(env, 4),
> -		  ppc_dump_gpr(env, 5), ppc_dump_gpr(env, 6),
> -		  ppc_dump_gpr(env, 7), ppc_dump_gpr(env, 8),
> -		  ppc_dump_gpr(env, 9), ppc_dump_gpr(env, 10),
> -		  ppc_dump_gpr(env, 11), ppc_dump_gpr(env, 12),
> -		  env->nip);
> +                  ppc_dump_gpr(env, 5), ppc_dump_gpr(env, 6),
> +                  ppc_dump_gpr(env, 7), ppc_dump_gpr(env, 8),
> +                  ppc_dump_gpr(env, 9), ppc_dump_gpr(env, 10),
> +                  ppc_dump_gpr(env, 11), ppc_dump_gpr(env, 12),
> +                  env->nip);
>  }
> =20
>  static int powerpc_reset_wakeup(CPUState *cs, CPUPPCState *env, int excp,
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl60mtQACgkQbDjKyiDZ
s5Lz2g//f8VVrvlfKcc2oL3SNAdW4xwnh6A7S4mFL/6TBs27oW9XzB0U5g5LhuKQ
Hv6JchtH3z0qZz1g4npAt1n9fkoPPi0UmR/WY2fKE4k5VNr1uY0+u1AOxhPWa1BA
4r8gBXsm6fXf1sL3Qumjakj1nO7XF9eQlOU2W05f0kYZSNt1k0HZt+P7KwD84y/K
EyxplN7b10DEDIdlTpRA08QPMYWD3YL5p+13S23vm4l9yu6+d15144bWryhOzsj8
+YdV8D7XwfDNPSGmAlTnQfHH2kqESICz5mQg6kyjvBW9eHgs5QxL6C/MG/Fny85b
Ju/CQTj6x3BEHflHgTkoMtdW8Zm4bxpmSLMh+caOwzn63GWNJjQIaR4iyiYUHJme
hCcxubNV7DN4oSOg3dJ0zDHB4p9qo7zCZ7MWLvsecImK1+on8HlRp4GBhFGTDdZ6
X/DYn+4iVNWT/DPNYzpsKOs/ru0pg9mQA8EJ/ei06wYwjv/vcod+QJnSB2kwFVZb
POL7z2ExmB9ExjXzsC6yui/R6gmKN4sR4dijuMZtucpphAeZf9eQ42b6gAunmP1R
c3CT1PAla4JVT0C4P3tWlxBqS9GpfBsPIMVVUTxq22EOrK7YRE2SpFfEFv8Ol1cZ
HLjnDLMAfb3L6R5xeBr0wXTzLIJcZU6rbyBgxdDN0+pjyhlXDIE=
=S41N
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--

