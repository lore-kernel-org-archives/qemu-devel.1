Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B89BCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:45:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F6C120873
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6C120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMX4C-0004zS-SP
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 08:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1iMX27-0003pS-7i
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1iMX24-0003LA-DM
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:43:34 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55846 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
 id 1iMX23-0002sj-UN
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:43:32 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 732611A2023;
 Mon, 21 Oct 2019 14:42:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from [10.10.14.77] (rtrkw870-lin.domain.local [10.10.14.77])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 4E81B1A1E12;
 Mon, 21 Oct 2019 14:42:25 +0200 (CEST)
Subject: Re: [PATCH v7 3/3] target/ppc: Optimize emulation of vupkhpx and
 vupklpx instructions
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <1571311659-15556-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1571311659-15556-4-git-send-email-stefan.brankovic@rt-rk.com>
 <CAL1e-=i5rySJ=uq=Jc+cH-HqtkTO6ZoagXwQNShLTieyGYcuag@mail.gmail.com>
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Message-ID: <76ec488e-b8ab-77de-efb5-53613c2c5975@rt-rk.com>
Date: Mon, 21 Oct 2019 14:42:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=i5rySJ=uq=Jc+cH-HqtkTO6ZoagXwQNShLTieyGYcuag@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------DD34E9074EB32E76A469DBF6"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------DD34E9074EB32E76A469DBF6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello Aleksandar,

Thank you for taking a look at this patch. I will start working on a=20
version 8 of the patch where I will address all your suggestions.

Kind Regards,

Stefan

On 19.10.19. 22:40, Aleksandar Markovic wrote:
>
>
> On Thursday, October 17, 2019, Stefan Brankovic=20
> <stefan.brankovic@rt-rk.com <mailto:stefan.brankovic@rt-rk.com>> wrote:
>
>     'trans_vupkpx' function implements both vupkhpx and vupklpx
>     instructions with
>     argument 'high' determine which instruction is processed.
>     Instructions are
>     implemented in two 'for' loops. Outer 'for' loop repeats unpacking
>     two times,
>     since both doubleword elements of destination register are formed
>     the same way.
>     It also stores result of every iteration in temporary register,
>     that is later
>     transferred to destination register. Inner 'for' loop does
>     unpacking of pixels
>     and forms resulting doubleword 32 by 32 bits.
>
>     Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com
>     <mailto:stefan.brankovic@rt-rk.com>>
>     ---
>     =C2=A0target/ppc/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 -
>     =C2=A0target/ppc/int_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 20 --------
>     =C2=A0target/ppc/translate/vmx-impl.inc.c | 91
>     ++++++++++++++++++++++++++++++++++++-
>     =C2=A03 files changed, 89 insertions(+), 24 deletions(-)
>
>     diff --git a/target/ppc/helper.h b/target/ppc/helper.h
>     index b489b38..fd06b56 100644
>     --- a/target/ppc/helper.h
>     +++ b/target/ppc/helper.h
>     @@ -233,8 +233,6 @@ DEF_HELPER_2(vextsh2d, void, avr, avr)
>     =C2=A0DEF_HELPER_2(vextsw2d, void, avr, avr)
>     =C2=A0DEF_HELPER_2(vnegw, void, avr, avr)
>     =C2=A0DEF_HELPER_2(vnegd, void, avr, avr)
>     -DEF_HELPER_2(vupkhpx, void, avr, avr)
>     -DEF_HELPER_2(vupklpx, void, avr, avr)
>     =C2=A0DEF_HELPER_2(vupkhsb, void, avr, avr)
>     =C2=A0DEF_HELPER_2(vupkhsh, void, avr, avr)
>     =C2=A0DEF_HELPER_2(vupkhsw, void, avr, avr)
>     diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
>     index f910c11..9ee667d 100644
>     --- a/target/ppc/int_helper.c
>     +++ b/target/ppc/int_helper.c
>     @@ -1737,26 +1737,6 @@ void helper_vsum4ubs(CPUPPCState *env,
>     ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
>     =C2=A0#define UPKHI 0
>     =C2=A0#define UPKLO 1
>     =C2=A0#endif
>     -#define VUPKPX(suffix, hi) =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
>     -=C2=A0 =C2=A0 void helper_vupk##suffix(ppc_avr_t *r, ppc_avr_t *b)=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
>     -=C2=A0 =C2=A0 { =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i; =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ppc_avr_t result; =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0\
>     - =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < ARRAY_SIZE(r->u32); =
i++) { =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t e =3D b->u16[hi=
 ? i : i + 4]; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t a =3D (e >> 15) =
? 0xff : 0; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t r =3D (e >> 10) =
& 0x1f; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0\
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t g =3D (e >> 5) &=
 0x1f; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t b =3D e & 0x1f; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
>     - =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result.u32[i] =3D (a << =
24) | (r << 16) | (g << 8) |
>     b;=C2=A0 =C2=A0 =C2=A0 =C2=A0\
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 } =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 *r =3D result; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 \
>     -=C2=A0 =C2=A0 }
>     -VUPKPX(lpx, UPKLO)
>     -VUPKPX(hpx, UPKHI)
>     -#undef VUPKPX
>
>     =C2=A0#define VUPK(suffix, unpacked, packee, hi) =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 \
>     =C2=A0 =C2=A0 =C2=A0void helper_vupk##suffix(ppc_avr_t *r, ppc_avr_=
t *b) =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
>     diff --git a/target/ppc/translate/vmx-impl.inc.c
>     b/target/ppc/translate/vmx-impl.inc.c
>     index 3550ffa..09d80d6 100644
>     --- a/target/ppc/translate/vmx-impl.inc.c
>     +++ b/target/ppc/translate/vmx-impl.inc.c
>     @@ -1031,6 +1031,95 @@ static void trans_vclzd(DisasContext *ctx)
>     =C2=A0 =C2=A0 =C2=A0tcg_temp_free_i64(avr);
>     =C2=A0}
>
>     +/*
>     + * vupkhpx VRT,VRB - Vector Unpack High Pixel
>     + * vupklpx VRT,VRB - Vector Unpack Low Pixel
>     + *
>     + * Unpacks 4 pixels coded in 1-5-5-5 pattern from high/low
>     doubleword element
>     + * of source register into contigous array of bits in the
>     destination register.
>     + * Argument 'high' determines if high or low doubleword element
>     of source
>     + * register is processed.
>     + */
>     +static void trans_vupkpx(DisasContext *ctx, int high)
>
>
> The last argument should be boolean.
>
>     +{
>     +=C2=A0 =C2=A0 int VT =3D rD(ctx->opcode);
>     +=C2=A0 =C2=A0 int VB =3D rB(ctx->opcode);
>     +=C2=A0 =C2=A0 TCGv_i64 tmp =3D tcg_temp_new_i64();
>     +=C2=A0 =C2=A0 TCGv_i64 avr =3D tcg_temp_new_i64();
>     +=C2=A0 =C2=A0 TCGv_i64 result =3D tcg_temp_new_i64();
>     +=C2=A0 =C2=A0 TCGv_i64 result1 =3D tcg_temp_new_i64();
>     +=C2=A0 =C2=A0 TCGv_i64 result2 =3D tcg_temp_new_i64();
>     +=C2=A0 =C2=A0 int64_t mask1 =3D 0x1fULL;
>     +=C2=A0 =C2=A0 int64_t mask2 =3D 0x1fULL << 8;
>     +=C2=A0 =C2=A0 int64_t mask3 =3D 0x1fULL << 16;
>     +=C2=A0 =C2=A0 int64_t mask4 =3D 0xffULL << 56;
>     +=C2=A0 =C2=A0 int i, j;
>     +
>     +=C2=A0 =C2=A0 if (high =3D=3D 1) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_avr64(avr, VB, true);
>     +=C2=A0 =C2=A0 } else {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_avr64(avr, VB, false);
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 tcg_gen_movi_i64(result, 0x0ULL);
>     +=C2=A0 =C2=A0 for (i =3D 0; i < 2; i++) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D 0; j < 2; j++) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shli_i64(tmp, av=
r, (j * 16));
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_andi_i64(tmp, tm=
p, mask1 << (j * 32));
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_or_i64(result, r=
esult, tmp);
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shli_i64(tmp, av=
r, 3 + (j * 16));
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_andi_i64(tmp, tm=
p, mask2 << (j * 32));
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_or_i64(result, r=
esult, tmp);
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shli_i64(tmp, av=
r, 6 + (j * 16));
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_andi_i64(tmp, tm=
p, mask3 << (j * 32));
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_or_i64(result, r=
esult, tmp);
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shri_i64(tmp, av=
r, (j * 16));
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_ext16s_i64(tmp, =
tmp);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_andi_i64(tmp, tm=
p, mask4);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shri_i64(tmp, tm=
p, (32 * (1 - j)));
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_or_i64(result, r=
esult, tmp);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D 0) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_i64(result1,=
 result);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_i64(result,=
 0x0ULL);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shri_i64(avr, av=
r, 32);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D 1) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_i64(result2,=
 result);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 set_avr64(VT, result1, false);
>     +=C2=A0 =C2=A0 set_avr64(VT, result2, true);
>     +
>     +=C2=A0 =C2=A0 tcg_temp_free_i64(tmp);
>     +=C2=A0 =C2=A0 tcg_temp_free_i64(avr);
>     +=C2=A0 =C2=A0 tcg_temp_free_i64(result);
>     +=C2=A0 =C2=A0 tcg_temp_free_i64(result1);
>     +=C2=A0 =C2=A0 tcg_temp_free_i64(result2);
>     +}
>     +
>     +static void gen_vupkhpx(DisasContext *ctx)
>     +{
>     +=C2=A0 =C2=A0 if (unlikely(!ctx->altivec_enabled)) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_exception(ctx, POWERPC_EXCP_VPU);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>     +=C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 trans_vupkpx(ctx, 1);
>     +}
>     +
>     +static void gen_vupklpx(DisasContext *ctx)
>     +{
>     +=C2=A0 =C2=A0 if (unlikely(!ctx->altivec_enabled)) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_exception(ctx, POWERPC_EXCP_VPU);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>     +=C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 trans_vupkpx(ctx, 0);
>     +}
>     +
>     =C2=A0GEN_VXFORM(vmuloub, 4, 0);
>     =C2=A0GEN_VXFORM(vmulouh, 4, 1);
>     =C2=A0GEN_VXFORM(vmulouw, 4, 2);
>     @@ -1348,8 +1437,6 @@ GEN_VXFORM_NOA(vupkhsw, 7, 25);
>     =C2=A0GEN_VXFORM_NOA(vupklsb, 7, 10);
>     =C2=A0GEN_VXFORM_NOA(vupklsh, 7, 11);
>     =C2=A0GEN_VXFORM_NOA(vupklsw, 7, 27);
>     -GEN_VXFORM_NOA(vupkhpx, 7, 13);
>     -GEN_VXFORM_NOA(vupklpx, 7, 15);
>     =C2=A0GEN_VXFORM_NOA_ENV(vrefp, 5, 4);
>     =C2=A0GEN_VXFORM_NOA_ENV(vrsqrtefp, 5, 5);
>     =C2=A0GEN_VXFORM_NOA_ENV(vexptefp, 5, 6);
>     --=20
>     2.7.4
>
>

--------------DD34E9074EB32E76A469DBF6
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <p>Hello Aleksandar,</p>
    <p>Thank you for taking a look at this patch. I will start working
      on a version 8 of the patch where I will address all your
      suggestions.</p>
    <p>Kind Regards,</p>
    <p>Stefan<br>
    </p>
    <div class=3D"moz-cite-prefix">On 19.10.19. 22:40, Aleksandar Markovi=
c
      wrote:<br>
    </div>
    <blockquote type=3D"cite"
cite=3D"mid:CAL1e-=3Di5rySJ=3Duq=3DJc+cH-HqtkTO6ZoagXwQNShLTieyGYcuag@mai=
l.gmail.com">
      <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DU=
TF-8">
      <br>
      <br>
      On Thursday, October 17, 2019, Stefan Brankovic &lt;<a
        href=3D"mailto:stefan.brankovic@rt-rk.com" moz-do-not-send=3D"tru=
e">stefan.brankovic@rt-rk.com</a>&gt;
      wrote:<br>
      <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
        .8ex;border-left:1px #ccc solid;padding-left:1ex">'trans_vupkpx'
        function implements both vupkhpx and vupklpx instructions with<br=
>
        argument 'high' determine which instruction is processed.
        Instructions are<br>
        implemented in two 'for' loops. Outer 'for' loop repeats
        unpacking two times,<br>
        since both doubleword elements of destination register are
        formed the same way.<br>
        It also stores result of every iteration in temporary register,
        that is later<br>
        transferred to destination register. Inner 'for' loop does
        unpacking of pixels<br>
        and forms resulting doubleword 32 by 32 bits.<br>
        <br>
        Signed-off-by: Stefan Brankovic &lt;<a
          href=3D"mailto:stefan.brankovic@rt-rk.com"
          moz-do-not-send=3D"true">stefan.brankovic@rt-rk.com</a>&gt;<br>
        ---<br>
        =C2=A0target/ppc/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 -<br>
        =C2=A0target/ppc/int_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 20 --------<br>
        =C2=A0target/ppc/translate/vmx-impl.<wbr>inc.c | 91
        ++++++++++++++++++++++++++++++<wbr>++++++-<br>
        =C2=A03 files changed, 89 insertions(+), 24 deletions(-)<br>
        <br>
        diff --git a/target/ppc/helper.h b/target/ppc/helper.h<br>
        index b489b38..fd06b56 100644<br>
        --- a/target/ppc/helper.h<br>
        +++ b/target/ppc/helper.h<br>
        @@ -233,8 +233,6 @@ DEF_HELPER_2(vextsh2d, void, avr, avr)<br>
        =C2=A0DEF_HELPER_2(vextsw2d, void, avr, avr)<br>
        =C2=A0DEF_HELPER_2(vnegw, void, avr, avr)<br>
        =C2=A0DEF_HELPER_2(vnegd, void, avr, avr)<br>
        -DEF_HELPER_2(vupkhpx, void, avr, avr)<br>
        -DEF_HELPER_2(vupklpx, void, avr, avr)<br>
        =C2=A0DEF_HELPER_2(vupkhsb, void, avr, avr)<br>
        =C2=A0DEF_HELPER_2(vupkhsh, void, avr, avr)<br>
        =C2=A0DEF_HELPER_2(vupkhsw, void, avr, avr)<br>
        diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c<br=
>
        index f910c11..9ee667d 100644<br>
        --- a/target/ppc/int_helper.c<br>
        +++ b/target/ppc/int_helper.c<br>
        @@ -1737,26 +1737,6 @@ void helper_vsum4ubs(CPUPPCState *env,
        ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)<br>
        =C2=A0#define UPKHI 0<br>
        =C2=A0#define UPKLO 1<br>
        =C2=A0#endif<br>
        -#define VUPKPX(suffix, hi)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0
        =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
        -=C2=A0 =C2=A0 void helper_vupk##suffix(ppc_avr_t *r, ppc_avr_t *=
b)=C2=A0 =C2=A0 =C2=A0 =C2=A0
        =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
        -=C2=A0 =C2=A0 {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0
        =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
        -=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
        =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
        -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ppc_avr_t result;=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
        =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
        -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0
        =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
        -=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(r-&g=
t;u32); i++) {=C2=A0 =C2=A0 =C2=A0 =C2=A0
        =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
        -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t e =3D b-&gt;u=
16[hi ? i : i + 4];=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
        =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
        -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t a =3D (e &gt;&=
gt; 15) ? 0xff : 0;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
        =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
        -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t r =3D (e &gt;&=
gt; 10) &amp; 0x1f;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
        =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0\<br>
        -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t g =3D (e &gt;&=
gt; 5) &amp; 0x1f;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
        =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<=
br>
        -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t b =3D e &amp; =
0x1f;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0
        =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
        -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0
        =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
        -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result.u32[i] =3D (a &=
lt;&lt; 24) | (r &lt;&lt; 16) |
        (g &lt;&lt; 8) | b;=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
        -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0
        =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
        -=C2=A0 =C2=A0 =C2=A0 =C2=A0 *r =3D result;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
        =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
        -=C2=A0 =C2=A0 }<br>
        -VUPKPX(lpx, UPKLO)<br>
        -VUPKPX(hpx, UPKHI)<br>
        -#undef VUPKPX<br>
        <br>
        =C2=A0#define VUPK(suffix, unpacked, packee, hi)=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
        =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
        =C2=A0 =C2=A0 =C2=A0void helper_vupk##suffix(ppc_avr_t *r, ppc_av=
r_t *b)=C2=A0 =C2=A0 =C2=A0 =C2=A0
        =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
        diff --git a/target/ppc/translate/vmx-<wbr>impl.inc.c
        b/target/ppc/translate/vmx-<wbr>impl.inc.c<br>
        index 3550ffa..09d80d6 100644<br>
        --- a/target/ppc/translate/vmx-<wbr>impl.inc.c<br>
        +++ b/target/ppc/translate/vmx-<wbr>impl.inc.c<br>
        @@ -1031,6 +1031,95 @@ static void trans_vclzd(DisasContext
        *ctx)<br>
        =C2=A0 =C2=A0 =C2=A0tcg_temp_free_i64(avr);<br>
        =C2=A0}<br>
        <br>
        +/*<br>
        + * vupkhpx VRT,VRB - Vector Unpack High Pixel<br>
        + * vupklpx VRT,VRB - Vector Unpack Low Pixel<br>
        + *<br>
        + * Unpacks 4 pixels coded in 1-5-5-5 pattern from high/low
        doubleword element<br>
        + * of source register into contigous array of bits in the
        destination register.<br>
        + * Argument 'high' determines if high or low doubleword element
        of source<br>
        + * register is processed.<br>
        + */<br>
        +static void trans_vupkpx(DisasContext *ctx, int high)</blockquot=
e>
      <div><br>
      </div>
      <div>The last argument should be boolean.</div>
      <div>=C2=A0</div>
      <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
        .8ex;border-left:1px #ccc solid;padding-left:1ex">
        +{<br>
        +=C2=A0 =C2=A0 int VT =3D rD(ctx-&gt;opcode);<br>
        +=C2=A0 =C2=A0 int VB =3D rB(ctx-&gt;opcode);<br>
        +=C2=A0 =C2=A0 TCGv_i64 tmp =3D tcg_temp_new_i64();<br>
        +=C2=A0 =C2=A0 TCGv_i64 avr =3D tcg_temp_new_i64();<br>
        +=C2=A0 =C2=A0 TCGv_i64 result =3D tcg_temp_new_i64();<br>
        +=C2=A0 =C2=A0 TCGv_i64 result1 =3D tcg_temp_new_i64();<br>
        +=C2=A0 =C2=A0 TCGv_i64 result2 =3D tcg_temp_new_i64();<br>
        +=C2=A0 =C2=A0 int64_t mask1 =3D 0x1fULL;<br>
        +=C2=A0 =C2=A0 int64_t mask2 =3D 0x1fULL &lt;&lt; 8;<br>
        +=C2=A0 =C2=A0 int64_t mask3 =3D 0x1fULL &lt;&lt; 16;<br>
        +=C2=A0 =C2=A0 int64_t mask4 =3D 0xffULL &lt;&lt; 56;<br>
        +=C2=A0 =C2=A0 int i, j;<br>
        +<br>
        +=C2=A0 =C2=A0 if (high =3D=3D 1) {<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_avr64(avr, VB, true);<br>
        +=C2=A0 =C2=A0 } else {<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_avr64(avr, VB, false);<br>
        +=C2=A0 =C2=A0 }<br>
        +<br>
        +=C2=A0 =C2=A0 tcg_gen_movi_i64(result, 0x0ULL);<br>
        +=C2=A0 =C2=A0 for (i =3D 0; i &lt; 2; i++) {<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D 0; j &lt; 2; j++) {<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shli_i64(tmp, =
avr, (j * 16));<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_andi_i64(tmp, =
tmp, mask1 &lt;&lt; (j *
        32));<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_or_i64(result,=
 result, tmp);<br>
        +<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shli_i64(tmp, =
avr, 3 + (j * 16));<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_andi_i64(tmp, =
tmp, mask2 &lt;&lt; (j *
        32));<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_or_i64(result,=
 result, tmp);<br>
        +<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shli_i64(tmp, =
avr, 6 + (j * 16));<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_andi_i64(tmp, =
tmp, mask3 &lt;&lt; (j *
        32));<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_or_i64(result,=
 result, tmp);<br>
        +<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shri_i64(tmp, =
avr, (j * 16));<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_ext16s_i64(tmp=
, tmp);<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_andi_i64(tmp, =
tmp, mask4);<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shri_i64(tmp, =
tmp, (32 * (1 - j)));<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_or_i64(result,=
 result, tmp);<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D 0) {<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_i64(result=
1, result);<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_i64(resul=
t, 0x0ULL);<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shri_i64(avr, =
avr, 32);<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D 1) {<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_i64(result=
2, result);<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
        +=C2=A0 =C2=A0 }<br>
        +<br>
        +=C2=A0 =C2=A0 set_avr64(VT, result1, false);<br>
        +=C2=A0 =C2=A0 set_avr64(VT, result2, true);<br>
        +<br>
        +=C2=A0 =C2=A0 tcg_temp_free_i64(tmp);<br>
        +=C2=A0 =C2=A0 tcg_temp_free_i64(avr);<br>
        +=C2=A0 =C2=A0 tcg_temp_free_i64(result);<br>
        +=C2=A0 =C2=A0 tcg_temp_free_i64(result1);<br>
        +=C2=A0 =C2=A0 tcg_temp_free_i64(result2);<br>
        +}<br>
        +<br>
        +static void gen_vupkhpx(DisasContext *ctx)<br>
        +{<br>
        +=C2=A0 =C2=A0 if (unlikely(!ctx-&gt;altivec_<wbr>enabled)) {<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_exception(ctx, POWERPC_EXCP_VPU)=
;<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
        +=C2=A0 =C2=A0 }<br>
        +=C2=A0 =C2=A0 trans_vupkpx(ctx, 1);<br>
        +}<br>
        +<br>
        +static void gen_vupklpx(DisasContext *ctx)<br>
        +{<br>
        +=C2=A0 =C2=A0 if (unlikely(!ctx-&gt;altivec_<wbr>enabled)) {<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_exception(ctx, POWERPC_EXCP_VPU)=
;<br>
        +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
        +=C2=A0 =C2=A0 }<br>
        +=C2=A0 =C2=A0 trans_vupkpx(ctx, 0);<br>
        +}<br>
        +<br>
        =C2=A0GEN_VXFORM(vmuloub, 4, 0);<br>
        =C2=A0GEN_VXFORM(vmulouh, 4, 1);<br>
        =C2=A0GEN_VXFORM(vmulouw, 4, 2);<br>
        @@ -1348,8 +1437,6 @@ GEN_VXFORM_NOA(vupkhsw, 7, 25);<br>
        =C2=A0GEN_VXFORM_NOA(vupklsb, 7, 10);<br>
        =C2=A0GEN_VXFORM_NOA(vupklsh, 7, 11);<br>
        =C2=A0GEN_VXFORM_NOA(vupklsw, 7, 27);<br>
        -GEN_VXFORM_NOA(vupkhpx, 7, 13);<br>
        -GEN_VXFORM_NOA(vupklpx, 7, 15);<br>
        =C2=A0GEN_VXFORM_NOA_ENV(vrefp, 5, 4);<br>
        =C2=A0GEN_VXFORM_NOA_ENV(vrsqrtefp, 5, 5);<br>
        =C2=A0GEN_VXFORM_NOA_ENV(vexptefp, 5, 6);<br>
        -- <br>
        2.7.4<br>
        <br>
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------DD34E9074EB32E76A469DBF6--

