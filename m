Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65935C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 11:26:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 278A6206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 11:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278A6206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48526 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFzkR-0003u7-Ec
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 07:26:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hFzjg-0003QO-Sv
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:25:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hFzjf-0005VY-7O
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:25:16 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45979 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Mateja.Marjanovic@rt-rk.com>)
	id 1hFzje-0004dF-Pl
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:25:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id D7ED81A2071;
	Mon, 15 Apr 2019 13:24:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from [10.10.13.97] (rtrkw310-lin.domain.local [10.10.13.97])
	by mail.rt-rk.com (Postfix) with ESMTPSA id B833F1A1D85;
	Mon, 15 Apr 2019 13:24:10 +0200 (CEST)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <1554383690-28338-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554383690-28338-5-git-send-email-mateja.marjanovic@rt-rk.com>
	<CAL1e-=i3H+aMaOCqMBkK4r9E4Ezqtyqw=VbwNmJZ6Wnc3in5PA@mail.gmail.com>
From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Message-ID: <bcc405c5-2e96-19a9-123e-bc607c243209@rt-rk.com>
Date: Mon, 15 Apr 2019 13:24:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=i3H+aMaOCqMBkK4r9E4Ezqtyqw=VbwNmJZ6Wnc3in5PA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: Re: [Qemu-devel] [PATCH v6 4/4] target/mips: Optimize
 ILVR.<B|H|W|D> MSA instructions
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415112410._Ktj0EzZ6zTvOZQI4YEbeSIxAW4h3ijbDlFzO9ZYnIo@z>


On 13.4.19. 18:05, Aleksandar Markovic wrote:
> On Thu, Apr 4, 2019 at 3:16 PM Mateja Marjanovic
> <mateja.marjanovic@rt-rk.com> wrote:
>> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>>
>> Optimized ILVR.<B|H|W|D> instructions, using a hybrid
> Optimized -> Optimize
>
>> approach. For byte data elements, use a helper with an
>> unrolled loop (much better performance), for halfword,
> (much better performance) -> (having much better performance
> than direct tcg translation)
>
>> word and doubleword data elements use directly tcg
>> registers and logic performed on them.
>>
>> Performance measurement is done by executing the
>> instructions a large number of times on a computer
>> with Intel Core i7-3770 CPU @ 3.40GHz=C3=978.
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>> ||  instr  ||  helper  ||    tcg    ||   hybrid  ||
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>> || ilvr.b: || 62.87 ms ||  74.76 ms ||  61.52 ms || <-- helper
>> || ilvr.h: || 44.11 ms ||  33.00 ms ||  33.55 ms || <-- tcg
>> || ilvr.w: || 34.97 ms ||  23.06 ms ||  22.67 ms || <-- tcg
>> || ilvr.d: || 27.33 ms ||  19.87 ms ||  20.02 ms || <-- tcg
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>>
> instr -> instruction
>
> ||  61.52 ms || <-- helper  ->  ||  61.52 ms (helper) ||
>
> and similar for other three raws.
I will change those three in v7.
>
>> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>> ---
>>   target/mips/helper.h     |   2 +-
>>   target/mips/msa_helper.c |  33 +++++++++++----
>>   target/mips/translate.c  | 107 +++++++++++++++++++++++++++++++++++++=
+++++++++-
>>   3 files changed, 132 insertions(+), 10 deletions(-)
>>
>> diff --git a/target/mips/helper.h b/target/mips/helper.h
>> index cd73723..d4755ef 100644
>> --- a/target/mips/helper.h
>> +++ b/target/mips/helper.h
>> @@ -862,7 +862,6 @@ DEF_HELPER_5(msa_sld_df, void, env, i32, i32, i32,=
 i32)
>>   DEF_HELPER_5(msa_splat_df, void, env, i32, i32, i32, i32)
>>   DEF_HELPER_5(msa_pckev_df, void, env, i32, i32, i32, i32)
>>   DEF_HELPER_5(msa_pckod_df, void, env, i32, i32, i32, i32)
>> -DEF_HELPER_5(msa_ilvr_df, void, env, i32, i32, i32, i32)
>>   DEF_HELPER_5(msa_vshf_df, void, env, i32, i32, i32, i32)
>>   DEF_HELPER_5(msa_srar_df, void, env, i32, i32, i32, i32)
>>   DEF_HELPER_5(msa_srlr_df, void, env, i32, i32, i32, i32)
>> @@ -946,6 +945,7 @@ DEF_HELPER_4(msa_insert_w, void, env, i32, i32, i3=
2)
>>   DEF_HELPER_4(msa_insert_d, void, env, i32, i32, i32)
>>
>>   DEF_HELPER_4(msa_ilvl_b, void, env, i32, i32, i32)
>> +DEF_HELPER_4(msa_ilvr_b, void, env, i32, i32, i32)
>>
>>   DEF_HELPER_4(msa_fclass_df, void, env, i32, i32, i32)
>>   DEF_HELPER_4(msa_ftrunc_s_df, void, env, i32, i32, i32)
>> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
>> index 84bbe6f..2470cef 100644
>> --- a/target/mips/msa_helper.c
>> +++ b/target/mips/msa_helper.c
>> @@ -1181,14 +1181,6 @@ MSA_FN_DF(pckev_df)
>>       } while (0)
>>   MSA_FN_DF(pckod_df)
>>   #undef MSA_DO
>> -
>> -#define MSA_DO(DF)                      \
>> -    do {                                \
>> -        pwx->DF[2*i]   =3D R##DF(pwt, i); \
>> -        pwx->DF[2*i+1] =3D R##DF(pws, i); \
>> -    } while (0)
>> -MSA_FN_DF(ilvr_df)
>> -#undef MSA_DO
>>   #undef MSA_LOOP_COND
>>
>>   #define MSA_LOOP_COND(DF) \
>> @@ -1249,6 +1241,31 @@ void helper_msa_ilvl_b(CPUMIPSState *env, uint3=
2_t wd,
>>       pwd->b[15] =3D pws->b[15];
>>   }
>>
>> +void helper_msa_ilvr_b(CPUMIPSState *env, uint32_t wd,
>> +                       uint32_t ws, uint32_t wt)
>> +{
>> +    wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
>> +    wr_t *pws =3D &(env->active_fpu.fpr[ws].wr);
>> +    wr_t *pwt =3D &(env->active_fpu.fpr[wt].wr);
>> +
> Why do we use here env->active_fpu.fpr[wd].wr, while for other instruct=
ions in
> this patch, we access msa_wr_d<b|h|w|d[] directly?
With a pointer to wr_t we have an array of bytes, halfwords, words or=20
doublewords
and can read from them and change them like an ordinary array. In other=20
cases
we use a variable that is TCGv_i64 and would have to use tcg_gen=20
functions to
modify the value of the register. Before my changes in ilvr instruction=20
helpers
env->active_fpu.fpr[wd].wr was used, so I just copy-pasted that.
>
>> +    pwd->b[15] =3D pws->b[7];
>> +    pwd->b[14] =3D pwt->b[7];
>> +    pwd->b[13] =3D pws->b[6];
>> +    pwd->b[12] =3D pwt->b[6];
>> +    pwd->b[11] =3D pws->b[5];
>> +    pwd->b[10] =3D pwt->b[5];
>> +    pwd->b[9]  =3D pws->b[4];
>> +    pwd->b[8]  =3D pwt->b[4];
>> +    pwd->b[7]  =3D pws->b[3];
>> +    pwd->b[6]  =3D pwt->b[3];
>> +    pwd->b[5]  =3D pws->b[2];
>> +    pwd->b[4]  =3D pwt->b[2];
>> +    pwd->b[3]  =3D pws->b[1];
>> +    pwd->b[2]  =3D pwt->b[1];
>> +    pwd->b[1]  =3D pws->b[0];
>> +    pwd->b[0]  =3D pwt->b[0];
>> +}
>> +
>>   void helper_msa_copy_s_b(CPUMIPSState *env, uint32_t rd,
>>                            uint32_t ws, uint32_t n)
>>   {
>> diff --git a/target/mips/translate.c b/target/mips/translate.c
>> index 6c6811e..90332fb 100644
>> --- a/target/mips/translate.c
>> +++ b/target/mips/translate.c
>> @@ -28885,6 +28885,96 @@ static void gen_msa_bit(CPUMIPSState *env, Di=
sasContext *ctx)
>>   }
>>
>>   /*
>> + * [MSA] ILVR.H wd, ws, wt
>> + *
>> + *   Vector Interleave Right (halfword data elements)
>> + *
>> + */
>> +static inline void gen_ilvr_h(CPUMIPSState *env, uint32_t wd,
>> +                              uint32_t ws, uint32_t wt)
>> +{
>> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
>> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
>> +    uint64_t mask =3D 0x000000000000ffffULL;
>> +
>> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
>> +    tcg_gen_mov_i64(t2, t1);
>> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2], mask);
>> +    tcg_gen_shli_i64(t1, t1, 16);
>> +    tcg_gen_or_i64(t2, t2, t1);
>> +
>> +    mask <<=3D 16;
>> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
>> +    tcg_gen_shli_i64(t1, t1, 16);
>> +    tcg_gen_or_i64(t2, t2, t1);
>> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2], mask);
>> +    tcg_gen_shli_i64(t1, t1, 32);
>> +    tcg_gen_or_i64(msa_wr_d[wd * 2], t2, t1);
>> +
>> +    mask <<=3D 16;
>> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
>> +    tcg_gen_shri_i64(t1, t1, 32);
>> +    tcg_gen_mov_i64(t2, t1);
>> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2], mask);
>> +    tcg_gen_shri_i64(t1, t1, 16);
>> +    tcg_gen_or_i64(t2, t2, t1);
>> +
>> +    mask <<=3D 16;
>> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
>> +    tcg_gen_shri_i64(t1, t1, 16);
>> +    tcg_gen_or_i64(t2, t2, t1);
>> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2], mask);
>> +    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t2, t1);
>> +
>> +    tcg_temp_free_i64(t1);
>> +    tcg_temp_free_i64(t2);
>> +}
>> +
>> +/*
>> + * [MSA] ILVR.W wd, ws, wt
>> + *
>> + *   Vector Interleave Right (word data elements)
>> + *
>> + */
>> +static inline void gen_ilvr_w(CPUMIPSState *env, uint32_t wd,
>> +                              uint32_t ws, uint32_t wt)
>> +{
>> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
>> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
>> +    uint64_t mask =3D 0x00000000ffffffffULL;
> Use tcg_const_i64(). The same for the previous function.
Will do in v7.
>
>> +
>> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
>> +    tcg_gen_mov_i64(t2, t1);
>> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2], mask);
>> +    tcg_gen_shli_i64(t1, t1, 32);
>> +    tcg_gen_or_i64(msa_wr_d[wd * 2], t2, t1);
>> +
>> +    mask <<=3D 32;
> Just assign the constant value to the mask, no need for shift operation=
.
> The same applies for other similar cases in this patch.
I was not sure which would have better performance, so I assumed
this with shifting, but I will add with assigning a constant to a registe=
r,
and test the performance.
>> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
>> +    tcg_gen_shri_i64(t1, t1, 32);
>> +    tcg_gen_mov_i64(t2, t1);
>> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2], mask);
>> +    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t2, t1);
>> +
>> +    tcg_temp_free_i64(t1);
>> +    tcg_temp_free_i64(t2);
>> +}
>> +
>> +/*
>> + * [MSA] ILVR.D wd, ws, wt
>> + *
>> + *   Vector Interleave Right (doubleword data elements)
>> + *
>> + */
>> +static inline void gen_ilvr_d(CPUMIPSState *env, uint32_t wd,
>> +                              uint32_t ws, uint32_t wt)
>> +{
>> +    tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2]);
>> +    tcg_gen_mov_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2]);
>> +}
>> +
> This function seems to be identical to the gen_ilvev_d(). Please,
> if that is the case, in this patch rename gen_ilvev_d() to gen_ilvev_il=
vr_d(),
> and  use it both for hanlding ILVEV.D and ILVR.D.
I didn't notice that. I will check, and if you are right, I will do that=20
in v7.
>> +
>> +/*
>>    * [MSA] ILVL.B wd, ws, wt
>>    *
>>    *   Vector Interleave Left (byte data elements)
>> @@ -29380,7 +29470,22 @@ static void gen_msa_3r(CPUMIPSState *env, Dis=
asContext *ctx)
>>           gen_helper_msa_div_u_df(cpu_env, tdf, twd, tws, twt);
>>           break;
>>       case OPC_ILVR_df:
>> -        gen_helper_msa_ilvr_df(cpu_env, tdf, twd, tws, twt);
>> +        switch (df) {
>> +        case DF_BYTE:
>> +            gen_helper_msa_ilvr_b(cpu_env, twd, tws, twt);
>> +            break;
>> +        case DF_HALF:
>> +            gen_ilvr_h(env, wd, ws, wt);
>> +            break;
>> +        case DF_WORD:
>> +            gen_ilvr_w(env, wd, ws, wt);
>> +            break;
>> +        case DF_DOUBLE:
>> +            gen_ilvr_d(env, wd, ws, wt);
>> +            break;
>> +        default:
>> +            assert(0);
>> +        }
>>           break;
>>       case OPC_BINSL_df:
>>           gen_helper_msa_binsl_df(cpu_env, tdf, twd, tws, twt);
>> --
>> 2.7.4
>>
>>
> Thanks,
> Aleksandar
Thanks,
Mateja

