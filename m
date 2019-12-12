Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F28CC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 05:15:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC9DF214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 05:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="l/Wag2uh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9DF214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifGp3-0007j2-6g
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 00:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ifGnN-0006Ab-A1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 00:13:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ifGnL-000348-Kp
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 00:13:49 -0500
Received: from ozlabs.org ([203.11.71.1]:39879)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ifGnL-000300-7H
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 00:13:47 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47YMQd0LSmz9sNH; Thu, 12 Dec 2019 16:13:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576127625;
 bh=LYAgn+pS7iHQ2kixpgIr66xWOo4Jx6V1A4PVwitqc8U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l/Wag2uhPIVtUwMuDe4F7qzTnuYnD8Q8FlEVXixAFmW49P7LgmSXKTSxz5yzSD1Ur
 gyXYzBYV/M0l+j5XBCOR5JkS7oukG6EqmBwuIsyU2crPzDy5t+WZ2lcirn1iMIbSba
 TdtwI55lWHRS3S7W8FswhyA7rQFBitQRAhmSbUYw=
Date: Thu, 12 Dec 2019 16:13:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 26/28] target/ppc: Use cpu_*_mmuidx_ra instead of
 MMU_MODE*_SUFFIX
Message-ID: <20191212051339.GX207300@umbus.fritz.box>
References: <20191212040039.26546-1-richard.henderson@linaro.org>
 <20191212040039.26546-27-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uWCTLymdFNG0vGYZ"
Content-Disposition: inline
In-Reply-To: <20191212040039.26546-27-richard.henderson@linaro.org>
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--uWCTLymdFNG0vGYZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2019 at 08:00:37PM -0800, Richard Henderson wrote:
> There are only two uses.  Within dcbz_common, the local variable
> mmu_idx already contains the epid computation, and we can avoid
> repeating it for the store.  Within helper_icbiep, the usage is
> trivially expanded using PPC_TLB_EPID_LOAD.
>=20
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/cpu.h        |  2 --
>  target/ppc/mem_helper.c | 11 ++---------
>  2 files changed, 2 insertions(+), 11 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index e3e82327b7..3bd983adaa 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -951,8 +951,6 @@ struct ppc_radix_page_info {
>   * + real/paged mode combinations. The other two modes are for
>   * external PID load/store.
>   */
> -#define MMU_MODE8_SUFFIX _epl
> -#define MMU_MODE9_SUFFIX _eps
>  #define PPC_TLB_EPID_LOAD 8
>  #define PPC_TLB_EPID_STORE 9
> =20
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index 1351b53f28..56855f2381 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -177,14 +177,7 @@ static void dcbz_common(CPUPPCState *env, target_ulo=
ng addr,
>      } else {
>          /* Slow path */
>          for (i =3D 0; i < dcbz_size; i +=3D 8) {
> -            if (epid) {
> -#if !defined(CONFIG_USER_ONLY)
> -                /* Does not make sense on USER_ONLY config */
> -                cpu_stq_eps_ra(env, addr + i, 0, retaddr);
> -#endif
> -            } else {
> -                cpu_stq_data_ra(env, addr + i, 0, retaddr);
> -            }
> +            cpu_stq_mmuidx_ra(env, addr + i, 0, mmu_idx, retaddr);
>          }
>      }
>  }
> @@ -216,7 +209,7 @@ void helper_icbiep(CPUPPCState *env, target_ulong add=
r)
>  #if !defined(CONFIG_USER_ONLY)
>      /* See comments above */
>      addr &=3D ~(env->dcache_line_size - 1);
> -    cpu_ldl_epl_ra(env, addr, GETPC());
> +    cpu_ldl_mmuidx_ra(env, addr, PPC_TLB_EPID_LOAD, GETPC());
>  #endif
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uWCTLymdFNG0vGYZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3xzIMACgkQbDjKyiDZ
s5JGKRAAvVjhDCp0hbvtgRirtGmP0MJDzkU7zBPwwxnbksjfDJ79km77brCkem97
3U4ZUhXFrkjwZZZL9aMJihNOn+fWofcOukpQqrm86xcJ1AtDJwaer4vXMZh8Nr2W
xenFVL3CKHDOvWjHsui0um1nPGjGJRQ3z64yIZ9gUKzI6gf/vzcm0sxRdc6kvtQf
GHZ2hnQPmI5SDR+nu3jZfrSX9QRk/DAcdL5HK7nSuQ6i3WcNWUFTEd54ijK0XxlF
+FYH6HdHycIHa70rlADhf9BaEX6M/NXnV+90uZQWJfo+4p/BODELYpZbiKEj0v0r
/X5MpTjQqtd3u2DLSD9/kWUlxBOSVdlFZy6guVzayzJ1SWy0K6PpJgnoMach95/F
XDnmzFT1BQXGAM2nXbZgyqkMTsBIuCnW1/MKozwzU/2gfHGHxe5nextE0sOzKVty
80tJiUrCfb866Brqb0ELmXGGS5JKTlBVdHkCJ9sOCXlm/fVl7RHhsg7MZ1eMp8KP
wQ3Y+OsV2wmCAjqUQtKet5/9YuQX0CTbtzxCXht/qCItvURWjpei8x55Z+Q/eQHw
BdSZ5Vpu9OGXIy8J4qvnRuYZJEPkz2OoyWVh0xMOSKUjSb7v355Ix3I5DchC405/
HBVQ4zjk6kRmyyEl57nC5OW5LVpBTS1ZS/arLSwlRKHZ8Be7bg8=
=HtS8
-----END PGP SIGNATURE-----

--uWCTLymdFNG0vGYZ--

