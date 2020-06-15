Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B734FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73FE820679
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="apIwPSlK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FE820679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkl9w-0007Gz-Kg
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 05:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jkl8z-0006Fh-Of; Mon, 15 Jun 2020 05:11:06 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:58081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jkl8v-0000yA-7K; Mon, 15 Jun 2020 05:11:05 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49lltP3rmSz9sRh; Mon, 15 Jun 2020 19:10:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1592212253;
 bh=4F9W8UPE0icvD5BClBicbmjduye96dhigI4fosVyiZI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=apIwPSlKZu/1xeFDgxEiItlCIJUzbME+FGaUuEqRYe5VJlpBKPL7Y3iJ4QQGVNrbN
 PayP0p7b0by8kVfa6czINSoCRlPESvGBh+yueepETVcQ1vtChKB4o8k1ApNGGghelf
 GvQkhBPhrb2fvagGayXzUilKnFgTSFpobd6MOzWY=
Date: Mon, 15 Jun 2020 18:49:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/6] Add several Power ISA 3.1 32/64-bit vector
 instructions
Message-ID: <20200615084936.GG5861@umbus.fritz.box>
References: <20200613042029.22321-1-ljp@linux.ibm.com>
 <159202367718.1247.18123310617404464597@45ef0f9c86ae>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PpAOPzA3dXsRhoo+"
Content-Disposition: inline
In-Reply-To: <159202367718.1247.18123310617404464597@45ef0f9c86ae>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
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
Cc: qemu-ppc@nongnu.org, ljp@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--PpAOPzA3dXsRhoo+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2020 at 09:47:58PM -0700, no-reply@patchew.org wrote:
> Patchew URL:
> https://patchew.org/QEMU/20200613042029.22321-1-ljp@linux.ibm.com/

I will need you to fix these stype errors and repost.

>=20
>=20
>=20
> Hi,
>=20
> This series seems to have some coding style problems. See output below for
> more information:
>=20
> Message-id: 20200613042029.22321-1-ljp@linux.ibm.com
> Subject: [PATCH 0/6] Add several Power ISA 3.1 32/64-bit vector instructi=
ons
> Type: series
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Switched to a new branch 'test'
> d39f30e target/ppc: add vdiv{su}{wd} vmod{su}{wd} instructions
> 966b641 fix the prototype of muls64/mulu64
> 42111c5 target/ppc: add vmulh{su}d instructions
> c96e996 targetc/ppc: add vmulh{su}w instructions
> c52004c target/ppc: add vmulld instruction
> 1061e4e target/ppc: add byte-reverse br[dwh] instructions
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> 1/6 Checking commit 1061e4ead5bc (target/ppc: add byte-reverse br[dwh] in=
structions)
> ERROR: code indent should never use tabs
> #26: FILE: target/ppc/translate.c:6977:
> +^ITCGv_i64 temp =3D tcg_temp_new_i64();$
>=20
> ERROR: code indent should never use tabs
> #28: FILE: target/ppc/translate.c:6979:
> +^Itcg_gen_bswap64_i64(temp, cpu_gpr[rS(ctx->opcode)]);$
>=20
> WARNING: line over 80 characters
> #29: FILE: target/ppc/translate.c:6980:
> +       tcg_gen_st_i64(temp, cpu_env, offsetof(CPUPPCState, gpr[rA(ctx->o=
pcode)]));
>=20
> ERROR: code indent should never use tabs
> #29: FILE: target/ppc/translate.c:6980:
> +^Itcg_gen_st_i64(temp, cpu_env, offsetof(CPUPPCState, gpr[rA(ctx->opcode=
)]));$
>=20
> ERROR: code indent should never use tabs
> #31: FILE: target/ppc/translate.c:6982:
> +^Itcg_temp_free_i64(temp);$
>=20
> ERROR: code indent should never use tabs
> #37: FILE: target/ppc/translate.c:6988:
> +^ITCGv_i64 temp =3D tcg_temp_new_i64();$
>=20
> ERROR: code indent should never use tabs
> #38: FILE: target/ppc/translate.c:6989:
> +^ITCGv_i64 lsb =3D tcg_temp_new_i64();$
>=20
> ERROR: code indent should never use tabs
> #39: FILE: target/ppc/translate.c:6990:
> +^ITCGv_i64 msb =3D tcg_temp_new_i64();$
>=20
> ERROR: code indent should never use tabs
> #41: FILE: target/ppc/translate.c:6992:
> +^Itcg_gen_movi_i64(lsb, 0x00000000ffffffffull);$
>=20
> ERROR: code indent should never use tabs
> #42: FILE: target/ppc/translate.c:6993:
> +^Itcg_gen_and_i64(temp, lsb, cpu_gpr[rS(ctx->opcode)]);$
>=20
> ERROR: code indent should never use tabs
> #43: FILE: target/ppc/translate.c:6994:
> +^Itcg_gen_bswap32_i64(lsb, temp);$
>=20
> ERROR: trailing whitespace
> #44: FILE: target/ppc/translate.c:6995:
> +^I$
>=20
> ERROR: code indent should never use tabs
> #44: FILE: target/ppc/translate.c:6995:
> +^I$
>=20
> ERROR: code indent should never use tabs
> #45: FILE: target/ppc/translate.c:6996:
> +^Itcg_gen_shri_i64(msb, cpu_gpr[rS(ctx->opcode)], 32);$
>=20
> ERROR: code indent should never use tabs
> #46: FILE: target/ppc/translate.c:6997:
> +^Itcg_gen_bswap32_i64(temp, msb);$
>=20
> ERROR: code indent should never use tabs
> #47: FILE: target/ppc/translate.c:6998:
> +^Itcg_gen_shli_i64(msb, temp, 32);$
>=20
> ERROR: trailing whitespace
> #48: FILE: target/ppc/translate.c:6999:
> +^I$
>=20
> ERROR: code indent should never use tabs
> #48: FILE: target/ppc/translate.c:6999:
> +^I$
>=20
> ERROR: code indent should never use tabs
> #49: FILE: target/ppc/translate.c:7000:
> +^Itcg_gen_or_i64(temp, lsb, msb);$
>=20
> WARNING: line over 80 characters
> #51: FILE: target/ppc/translate.c:7002:
> +       tcg_gen_st_i64(temp, cpu_env, offsetof(CPUPPCState, gpr[rA(ctx->o=
pcode)]));
>=20
> ERROR: code indent should never use tabs
> #51: FILE: target/ppc/translate.c:7002:
> +^Itcg_gen_st_i64(temp, cpu_env, offsetof(CPUPPCState, gpr[rA(ctx->opcode=
)]));$
>=20
> ERROR: code indent should never use tabs
> #53: FILE: target/ppc/translate.c:7004:
> +^Itcg_temp_free_i64(temp);$
>=20
> ERROR: code indent should never use tabs
> #54: FILE: target/ppc/translate.c:7005:
> +^Itcg_temp_free_i64(lsb);$
>=20
> ERROR: code indent should never use tabs
> #55: FILE: target/ppc/translate.c:7006:
> +^Itcg_temp_free_i64(msb);$
>=20
> ERROR: code indent should never use tabs
> #61: FILE: target/ppc/translate.c:7012:
> +^ITCGv_i64 temp =3D tcg_temp_new_i64();$
>=20
> ERROR: code indent should never use tabs
> #62: FILE: target/ppc/translate.c:7013:
> +^ITCGv_i64 t0 =3D tcg_temp_new_i64();$
>=20
> ERROR: code indent should never use tabs
> #63: FILE: target/ppc/translate.c:7014:
> +^ITCGv_i64 t1 =3D tcg_temp_new_i64();$
>=20
> ERROR: code indent should never use tabs
> #64: FILE: target/ppc/translate.c:7015:
> +^ITCGv_i64 t2 =3D tcg_temp_new_i64();$
>=20
> ERROR: code indent should never use tabs
> #65: FILE: target/ppc/translate.c:7016:
> +^ITCGv_i64 t3 =3D tcg_temp_new_i64();$
>=20
> ERROR: code indent should never use tabs
> #67: FILE: target/ppc/translate.c:7018:
> +^Itcg_gen_movi_i64(t0, 0x00ff00ff00ff00ffull);$
>=20
> ERROR: code indent should never use tabs
> #68: FILE: target/ppc/translate.c:7019:
> +^Itcg_gen_shri_i64(t1, cpu_gpr[rS(ctx->opcode)], 8);$
>=20
> ERROR: code indent should never use tabs
> #69: FILE: target/ppc/translate.c:7020:
> +^Itcg_gen_and_i64(t2, t1, t0);$
>=20
> ERROR: code indent should never use tabs
> #70: FILE: target/ppc/translate.c:7021:
> +^Itcg_gen_and_i64(t1, cpu_gpr[rS(ctx->opcode)], t0);$
>=20
> ERROR: code indent should never use tabs
> #71: FILE: target/ppc/translate.c:7022:
> +^Itcg_gen_shli_i64(t1, t1, 8);$
>=20
> ERROR: code indent should never use tabs
> #72: FILE: target/ppc/translate.c:7023:
> +^Itcg_gen_or_i64(temp, t1, t2);$
>=20
> WARNING: line over 80 characters
> #73: FILE: target/ppc/translate.c:7024:
> +       tcg_gen_st_i64(temp, cpu_env, offsetof(CPUPPCState, gpr[rA(ctx->o=
pcode)]));
>=20
> ERROR: code indent should never use tabs
> #73: FILE: target/ppc/translate.c:7024:
> +^Itcg_gen_st_i64(temp, cpu_env, offsetof(CPUPPCState, gpr[rA(ctx->opcode=
)]));$
>=20
> ERROR: code indent should never use tabs
> #75: FILE: target/ppc/translate.c:7026:
> +^Itcg_temp_free_i64(temp);$
>=20
> ERROR: code indent should never use tabs
> #76: FILE: target/ppc/translate.c:7027:
> +^Itcg_temp_free_i64(t0);$
>=20
> ERROR: code indent should never use tabs
> #77: FILE: target/ppc/translate.c:7028:
> +^Itcg_temp_free_i64(t1);$
>=20
> ERROR: code indent should never use tabs
> #78: FILE: target/ppc/translate.c:7029:
> +^Itcg_temp_free_i64(t2);$
>=20
> ERROR: code indent should never use tabs
> #79: FILE: target/ppc/translate.c:7030:
> +^Itcg_temp_free_i64(t3);$
>=20
> total: 39 errors, 3 warnings, 69 lines checked
>=20
> Patch 1/6 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> 2/6 Checking commit c52004cd8f89 (target/ppc: add vmulld instruction)
> 3/6 Checking commit c96e996917c6 (targetc/ppc: add vmulh{su}w instruction=
s)
> ERROR: code indent should never use tabs
> #34: FILE: target/ppc/int_helper.c:526:
> +#define VMULH_DO(name, op, element, cast_orig, cast_temp)^I^I\$
>=20
> ERROR: code indent should never use tabs
> #35: FILE: target/ppc/int_helper.c:527:
> +    void helper_vmulh##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)^I\$
>=20
> ERROR: code indent should never use tabs
> #36: FILE: target/ppc/int_helper.c:528:
> +    {^I^I^I^I^I^I^I^I^I\$
>=20
> ERROR: code indent should never use tabs
> #37: FILE: target/ppc/int_helper.c:529:
> +^Iint i;^I^I^I^I^I^I^I^I\$
>=20
> ERROR: code indent should never use tabs
> #38: FILE: target/ppc/int_helper.c:530:
> +^I^I^I^I^I^I^I^I^I\$
>=20
> ERROR: code indent should never use tabs
> #39: FILE: target/ppc/int_helper.c:531:
> +^Ifor (i =3D 0; i < ARRAY_SIZE(r->element); i++) {^I^I^I\$
>=20
> ERROR: code indent should never use tabs
> #40: FILE: target/ppc/int_helper.c:532:
> +^I^Ir->element[i] =3D (cast_orig)(((cast_temp)a->element[i] op \$
>=20
> ERROR: code indent should never use tabs
> #41: FILE: target/ppc/int_helper.c:533:
> +^I^I^I^I(cast_temp)b->element[i]) >> 32);^I\$
>=20
> ERROR: code indent should never use tabs
> #42: FILE: target/ppc/int_helper.c:534:
> +^I}^I^I^I^I^I^I^I^I\$
>=20
> ERROR: code indent should never use tabs
> #61: FILE: target/ppc/translate/vmx-impl.inc.c:816:
> +^I^Ivmulhuw, PPC_NONE, PPC2_ISA300);$
>=20
> ERROR: code indent should never use tabs
> #67: FILE: target/ppc/translate/vmx-impl.inc.c:822:
> +^I^Ivmulhsw, PPC_NONE, PPC2_ISA300);$
>=20
> total: 11 errors, 0 warnings, 55 lines checked
>=20
> Patch 3/6 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> 4/6 Checking commit 42111c50379b (target/ppc: add vmulh{su}d instructions)
> ERROR: code indent should never use tabs
> #36: FILE: target/ppc/int_helper.c:528:
> +^Iint i;$
>=20
> ERROR: code indent should never use tabs
> #37: FILE: target/ppc/int_helper.c:529:
> +^Iuint64_t h64 =3D 0;$
>=20
> ERROR: code indent should never use tabs
> #38: FILE: target/ppc/int_helper.c:530:
> +^Iuint64_t l64 =3D 0;$
>=20
> ERROR: code indent should never use tabs
> #40: FILE: target/ppc/int_helper.c:532:
> +^Ifor (i =3D 0; i < 2; i++) {$
>=20
> ERROR: code indent should never use tabs
> #41: FILE: target/ppc/int_helper.c:533:
> +^I^Imuls64(&l64, &h64, a->s64[i], b->s64[i]);$
>=20
> ERROR: code indent should never use tabs
> #42: FILE: target/ppc/int_helper.c:534:
> +^I^Ir->s64[i] =3D h64;$
>=20
> ERROR: code indent should never use tabs
> #43: FILE: target/ppc/int_helper.c:535:
> +^I}$
>=20
> ERROR: code indent should never use tabs
> #48: FILE: target/ppc/int_helper.c:540:
> +^Iint i;$
>=20
> ERROR: code indent should never use tabs
> #49: FILE: target/ppc/int_helper.c:541:
> +^Iuint64_t h64 =3D 0;$
>=20
> ERROR: code indent should never use tabs
> #50: FILE: target/ppc/int_helper.c:542:
> +^Iuint64_t l64 =3D 0;$
>=20
> ERROR: code indent should never use tabs
> #52: FILE: target/ppc/int_helper.c:544:
> +^Ifor (i =3D 0; i < 2; i++) {$
>=20
> ERROR: code indent should never use tabs
> #53: FILE: target/ppc/int_helper.c:545:
> +^I^Imulu64(&l64, &h64, a->s64[i], b->s64[i]);$
>=20
> ERROR: code indent should never use tabs
> #54: FILE: target/ppc/int_helper.c:546:
> +^I^Ir->u64[i] =3D h64;$
>=20
> ERROR: code indent should never use tabs
> #55: FILE: target/ppc/int_helper.c:547:
> +^I}$
>=20
> total: 14 errors, 0 warnings, 63 lines checked
>=20
> Patch 4/6 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> 5/6 Checking commit 966b641eba85 (fix the prototype of muls64/mulu64)
> 6/6 Checking commit d39f30e2a46f (target/ppc: add vdiv{su}{wd} vmod{su}{w=
d} instructions)
> ERROR: code indent should never use tabs
> #104: FILE: target/ppc/translate/vmx-impl.inc.c:832:
> +^I^Ivdivsw, PPC_NONE, PPC2_ISA300, 0x00000000);$
>=20
> ERROR: code indent should never use tabs
> #107: FILE: target/ppc/translate/vmx-impl.inc.c:835:
> +^I^Ivdivsd, PPC_NONE, PPC2_ISA300, 0x00000000);$
>=20
> WARNING: line over 80 characters
> #123: FILE: target/ppc/translate/vmx-ops.inc.c:54:
> +#define GEN_VXFORM_DUAL_BOTH(name0, name1, opc2, opc3, inval0, inval1, t=
ype0, type1) \
>=20
> ERROR: code indent should never use tabs
> #136: FILE: target/ppc/translate/vmx-ops.inc.c:122:
> +^I^I^IPPC_ALTIVEC, PPC2_ISA300),$
>=20
> ERROR: code indent should never use tabs
> #138: FILE: target/ppc/translate/vmx-ops.inc.c:124:
> +^I^I^IPPC_ALTIVEC, PPC2_ISA300),$
>=20
> total: 4 errors, 1 warnings, 108 lines checked
>=20
> Patch 6/6 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 1
>=20
>=20
> The full log is available at
> http://patchew.org/logs/20200613042029.22321-1-ljp@linux.ibm.com/testing.=
checkpatch/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PpAOPzA3dXsRhoo+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7nNh0ACgkQbDjKyiDZ
s5I85g/+JVDYOrCzhSkI8CpvK7E49yAYpB9dw6kPKnNXvjKIFueDNWXwN5EhNJ9n
79VOklzLic5V3pwgZtRYUiiXpATFimmpBJ+TbZCfV4O+xUM6ENmwSJzrUctHA2w+
RHnNTcUi34iCjdMt9ceRkxwIbxiZETOduPwMPcP/8njUykxfzFfRnxuNZ9uTe9zS
9ISqnOrfLXuqLJ7BYjeyKkkzkBvpgEFO2/xcXGL2N6EAsa+1yGNeTU/Dd+sZnwpp
BDyLbHHd746tVpw+EotHsEW0e52thDO/tc4OL2Rn9z2VupZv6J8/3XvYTB/N3crw
9mcHIeESSdljhtIt0j6ivLPDHeqYInzAigBr7Jd9xIIb0+t3rAWPqbEMeeRHvabD
IqyZGdD3LpHTwJj7hiVjIhGpGWIqXsJ+SP5yEDW8iOYjbdyuisjXfVPvKEOXCs9C
qo5qVbKfMwsQxai/xHaALHQqpBG7FLsnvj5af3if9TOwRpgWPiIbbdUevjSksxKO
4jXorKRc0a1V/D00vKvOwXyxZU9G4ucuy0adntvvqcPrvP4YdpHAqTZhznkvnNVF
QwQ3aNutuem10xWfEWgFyB/ICFiG+ysmKJu+gPZp+AtWImm+YFyb3SLNXN3sUpQT
SBhGlsN5OY1WQKS/jQLqVc5di0FIvbg0bOn8AAPEjuBx/N9HqJs=
=q6Ny
-----END PGP SIGNATURE-----

--PpAOPzA3dXsRhoo+--

