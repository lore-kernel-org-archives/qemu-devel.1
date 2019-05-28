Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076E8C04AB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 01:15:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA382075E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 01:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oHfI+4ew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA382075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55296 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVQhy-0003cr-OP
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 21:15:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVQgJ-0002iy-Ot
	for qemu-devel@nongnu.org; Mon, 27 May 2019 21:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVQgE-0006vA-9a
	for qemu-devel@nongnu.org; Mon, 27 May 2019 21:13:35 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:45541 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hVQgA-0006ko-Sw; Mon, 27 May 2019 21:13:30 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45CbST4DwVz9s5c; Tue, 28 May 2019 11:13:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559005993;
	bh=/p/e5G8trdFMDY3OGCyszpvCOMkoML5I50AXZwtJaBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oHfI+4ewxanWUQhPOrfuWWti/AV+dOmSs5V7nyYtt/OFVajSQiWoacEXAdKqNoiwE
	D8X45mq9jdEX+IGqBK6KXHrGjFtDmp/MY3G7spmxigG9rEhTjXjVJCei8USzzGBRu9
	VsVvUfM4xVBxYDygELoAGCBXUEvqYD9MHHn/POYs=
Date: Tue, 28 May 2019 11:09:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20190528010937.GD11618@umbus.fritz.box>
References: <20190524065345.25591-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Content-Disposition: inline
In-Reply-To: <20190524065345.25591-1-mark.cave-ayland@ilande.co.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v2] target/ppc: Fix lxvw4x,
 lxvh8x and lxvb16x
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2019 at 07:53:45AM +0100, Mark Cave-Ayland wrote:
> From: Anton Blanchard <anton@ozlabs.org>
>=20
> During the conversion these instructions were incorrectly treated as
> stores. We need to use set_cpu_vsr* and not get_cpu_vsr*.
>=20
> Fixes: 8b3b2d75c7c0 ("introduce get_cpu_vsr{l,h}() and set_cpu_vsr{l,h}()=
 helpers for VSR register access")
> Signed-off-by: Anton Blanchard <anton@ozlabs.org>
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Tested-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  target/ppc/translate/vsx-impl.inc.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
> index 199d22da97..cdb44b8b70 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -102,8 +102,7 @@ static void gen_lxvw4x(DisasContext *ctx)
>      }
>      xth =3D tcg_temp_new_i64();
>      xtl =3D tcg_temp_new_i64();
> -    get_cpu_vsrh(xth, xT(ctx->opcode));
> -    get_cpu_vsrl(xtl, xT(ctx->opcode));
> +
>      gen_set_access_type(ctx, ACCESS_INT);
>      EA =3D tcg_temp_new();
> =20
> @@ -126,6 +125,8 @@ static void gen_lxvw4x(DisasContext *ctx)
>          tcg_gen_addi_tl(EA, EA, 8);
>          tcg_gen_qemu_ld_i64(xtl, EA, ctx->mem_idx, MO_BEQ);
>      }
> +    set_cpu_vsrh(xT(ctx->opcode), xth);
> +    set_cpu_vsrl(xT(ctx->opcode), xtl);
>      tcg_temp_free(EA);
>      tcg_temp_free_i64(xth);
>      tcg_temp_free_i64(xtl);
> @@ -185,8 +186,6 @@ static void gen_lxvh8x(DisasContext *ctx)
>      }
>      xth =3D tcg_temp_new_i64();
>      xtl =3D tcg_temp_new_i64();
> -    get_cpu_vsrh(xth, xT(ctx->opcode));
> -    get_cpu_vsrl(xtl, xT(ctx->opcode));
>      gen_set_access_type(ctx, ACCESS_INT);
> =20
>      EA =3D tcg_temp_new();
> @@ -197,6 +196,8 @@ static void gen_lxvh8x(DisasContext *ctx)
>      if (ctx->le_mode) {
>          gen_bswap16x8(xth, xtl, xth, xtl);
>      }
> +    set_cpu_vsrh(xT(ctx->opcode), xth);
> +    set_cpu_vsrl(xT(ctx->opcode), xtl);
>      tcg_temp_free(EA);
>      tcg_temp_free_i64(xth);
>      tcg_temp_free_i64(xtl);
> @@ -214,14 +215,14 @@ static void gen_lxvb16x(DisasContext *ctx)
>      }
>      xth =3D tcg_temp_new_i64();
>      xtl =3D tcg_temp_new_i64();
> -    get_cpu_vsrh(xth, xT(ctx->opcode));
> -    get_cpu_vsrl(xtl, xT(ctx->opcode));
>      gen_set_access_type(ctx, ACCESS_INT);
>      EA =3D tcg_temp_new();
>      gen_addr_reg_index(ctx, EA);
>      tcg_gen_qemu_ld_i64(xth, EA, ctx->mem_idx, MO_BEQ);
>      tcg_gen_addi_tl(EA, EA, 8);
>      tcg_gen_qemu_ld_i64(xtl, EA, ctx->mem_idx, MO_BEQ);
> +    set_cpu_vsrh(xT(ctx->opcode), xth);
> +    set_cpu_vsrl(xT(ctx->opcode), xtl);
>      tcg_temp_free(EA);
>      tcg_temp_free_i64(xth);
>      tcg_temp_free_i64(xtl);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzsilEACgkQbDjKyiDZ
s5KM9BAAjKyZ+ZOTPXLjR7b9OpgbrXIIcIfLtAoTkNNhoWtvwxtrQMHIXMoPS1SG
Lwt16PaZKGO7fGY4lylqC4uFdNzYvDGj5ga71q1+46ugHnknSPqsA9T8hJaJ8SLF
HtLd8oR+WrgU7YbTNHz8QQ7KTusnS8bOopGpSjW4LHYawFrpVqw/0tATmAtl2cAv
EG04WGWBGVrPXtGgxMJIC/qG9ibb8+F+J4AM5Phqm2OWK6gYnSeidx2VcQ4NLruw
cFlqis/T/qRJ2bYor/XMQgxOYjrNIPHk7vmgSD9DqEVnSv+6DLVaPeYh5kia21Jm
SYFAsy155LDR94UhDBYp0rkwKJfHaVy4sJqaANVMnqL1dh9KT7vbqEWnDQ9r7luE
+zjuddPHpjVdCYTEn0lIj6rHY/1e67h2oz+iTsLdpcaERhTlTVcAP7DSKtl7Dvri
o7N2oM6r3lmgXeZy0MGIN63baj7T+v2txKZene3rh0KIyJWsMDOthlrsOFLV/QkG
8Atj+J2CfraZnfFWsBY9fN2VndJK5UzFc/s4QPkL5iOAqx0WJNFxX828EtJPRZg6
m9GOA6vwakXOLwcsduziycsguzoP+lQ/F8Ssh1Wt62K4NB1d9FPthHlqAoiQhsi/
RycG3WuKUNF/iwqVrxLSiIKlolMy/tHojLZC4Br2YqKqIBD/T8o=
=bL4F
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--

