Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D872C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 11:25:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4292080C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 11:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Q54vkzkk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4292080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg630-0001ja-Ts
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 07:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38309)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lucienmp_antispam@yahoo.com>) id 1hg62I-0001I8-Cg
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lucienmp_antispam@yahoo.com>) id 1hg62G-0008S8-DE
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:24:22 -0400
Received: from sonic315-20.consmr.mail.ne1.yahoo.com ([66.163.190.146]:45127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lucienmp_antispam@yahoo.com>)
 id 1hg62G-0008MM-3H
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1561548256; bh=poDkVUu+Rs1lFtFvRWTmdPmxyoeKy/1f2sNcgn9VuUE=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject;
 b=Q54vkzkkxr9u+9flPh439oJ7UvR289q6YhclQ63/JjZKtbWQzqqrG2E6oleC9IidOZTYt+M771cZcQ0tBwvUaVbFr0eqAZQHJk6Y1q/GacibazSqXk43YYxpEWtfDjfK5NfIjO5t0jpRL0kDFytcrHGFUOqGtV4QWTlO66f0yJYgwsRUPXbmDHGrSEnAbzqxcFXvPPHUNHVf4++kcwNp0vor4G7AX3jBzh1LTc6kp6icXQ9ETZml9Z1iJ2QMf5Yd+sOF6Wtutl1AqZRF26FqgMcX+Kvd3l3kDi1IeMwiJEK4wnx7bwqhX6iZFwaaRzuCA+8waxJCn8CrMFxNcDYEXA==
X-YMail-OSG: YuDelk8VM1k8jbOThaKvF7LAqAZXMlvKCaQ3_dm9fy2RdkCta.Ef12bx3CwkRWp
 cZZlzsnbPpjNMFGYdwVdH99h0VsQax2ieImABBeBHhllNOgi.jd4XXPTCw0PTNg3upT7OcUhZzKJ
 CbJV3gXMt_UpFpceB3ks0uJuV22D1V1CZhPU2w6.SsBmrcKEbGpvRZ8K7TJqFqd.DJRyQQqsQDkn
 juiKY_sHn61CiS10w8Qn2km27Y9jnw91TLcN8uLMEiLL26gpKOxsWzHB4z43aEs_qScOSRoBXaki
 Vbn7ZUOn5dt7z8JVrFj8ZCzx5LK_cC.c_xhmS5Y.15C3jNRBMnYBtZHuzS4KF.9i8X3400Xfimur
 cVuBtcjLK18FxjHf5QZq8Ajw42vPRE_W3IZolSZ7ieZQZdz1EBzU0.iWFNJOIpC3lWunOx9Ol5Nn
 sXx3QKJ3yzh8B3.HCKR2hzS9UdELLtdO1dtWJ5Q937R1aBGOX4v.91FU3gUns0vkDZ0Y44U8exK5
 nhiKo_ACbScU3.r3bopLPdexLci.hO0mZGC3gM3r9xYImBbK6qaKtbJEYzmaSVt0Lf6RX_2vEexC
 XMiNYz_YuQvS_CxG5IalZLASROjw9dYjEMX_fjyGfhOtsW3ZX5JTZveGeWDYrGDQT1.GJc0ToUKu
 3T2xOAx5pMVzSHeE4ba1h30eU40VtWFaIbXibf5BxK0Bi1mSdAkohlhL3SplJ4ZjE6sYdFRpUKMm
 8sDShEPyRz_cLm_cPTZiUkKwK_ROb1D4edkeYThk6mXTEZ54snTZ7FfTlGc5.3tSk0f_Vmgdz9Q0
 r8LG8WesdY0pMn35OW9NU7EikpPcqYcd0_0ASqOt9uTS3Ud1OoOtHT2fNlhlaSkxBLpnIrhZIrk4
 kfRrxjIv_cYl8iQt_AdLAeWjnyxyYKFw0fTjenQ6bDmys9SvQqAbfeGDd1zalTNvotStK0PMeExB
 EEkJnsfLwY8HVfiVIfj0wPsJMvJXuZ1ASuZIt3r5POwAKfEOJxYWN2zpmL_THwlNWfS8hWjDz5L8
 6TjG73TXUl4PKH_PgeUZYIqkQLRqkvgC.tYk5qPyTVvmMU1nrKdcTIvk5zvR_XzIApEixdu6g5g7
 ySGOwsK0.FM28jBtFTm7vIh8bG5hvBxppGmIY8E02vgp0yzuLbHr5DLmYxxLasHqmn81x3TUdMTW
 Aild22f1T_t5xedl91z8YbD7DKhRyI_PX2njiqHjsAAljhTvsfrBF8J6q2I4J
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 26 Jun 2019 11:24:16 +0000
Date: Wed, 26 Jun 2019 11:24:05 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>
Message-ID: <1277274524.199018.1561548245851@mail.yahoo.com>
In-Reply-To: <2af0f156-d1d7-4957-547a-13dc24a9a8cd@vivier.eu>
References: <20190526075056.33865-1-lucienmp_antispam@yahoo.com>
 <ab1edfe7-8498-eee6-096c-d66d6122d133@vivier.eu>
 <1c3d400a-7ea2-2bdd-8301-8f6c85075b24@linaro.org>
 <2af0f156-d1d7-4957-547a-13dc24a9a8cd@vivier.eu>
MIME-Version: 1.0
X-Mailer: WebService/1.1.13875 YMailNorrin Mozilla/5.0 (Windows NT 10.0; Win64;
 x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100
 Safari/537.36
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 66.163.190.146
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] Regression for m68k causing Single-Step
 via GDB/RSP to not single step
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
From: Lucien Anti-Spam via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>
Cc: Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Emilio G . Cota" <cota@braap.org>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Richard/Laurent,
Great catch, I also just stumbled on this problem as well which I didnt see=
 with my other application code.
But I have another problem after applying the changes from your email, "RTE=
" and breakpoints around a MOV/BusException/RTE behave oddly.
I would like to test with the same software you are using, could you tell m=
e what M68K machine setup, and images you use as well as your debugger plea=
se?
Cheers,Luc
    On Wednesday, June 19, 2019, 04:59:12 AM GMT+9, Laurent Vivier <laurent=
@vivier.eu> wrote: =20
=20
 Le 18/06/2019 =C3=A0 21:39, Richard Henderson a =C3=A9crit=C2=A0:
> On 6/18/19 11:44 AM, Laurent Vivier wrote:
>> Le 26/05/2019 =C3=A0 09:50, Lucien Murray-Pitts a =C3=A9crit=C2=A0:
>>> A regression that was introduced, with the refactor to TranslatorOps,
>>> drops two lines that update the PC when single-stepping is being perfor=
med.
>>> ( short commit 11ab74b )
>>>
>>> This patch resolves that issue.
>>
>> Fixes: 11ab74b01e0a ("target/m68k: Convert to TranslatorOps")
>>
>>> Signed-off-by: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>
>>> ---
>>>=C2=A0 target/m68k/translate.c | 2 ++
>>>=C2=A0 1 file changed, 2 insertions(+)
>>>
>>> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
>>> index f0534a4ba0..2922ea79c3 100644
>>> --- a/target/m68k/translate.c
>>> +++ b/target/m68k/translate.c
>>> @@ -6130,6 +6130,8 @@ static void m68k_tr_tb_stop(DisasContextBase *dcb=
ase, CPUState *cpu)
>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>>>=C2=A0 =C2=A0 =C2=A0 }
>>>=C2=A0 =C2=A0 =C2=A0 if (dc->base.singlestep_enabled) {
>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 update_cc_op(dc);
>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_i32(QREG_PC, dc->pc);
>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_raise_exception(cpu_env, t=
cg_const_i32(EXCP_DEBUG));
>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>>>=C2=A0 =C2=A0 =C2=A0 }
>>>
>>
>> I've tested this fix single-stepping on a kernel, these two lines are=20
>> not enough to fix the problem. In fact four lines have been dropped and=
=20
>> we must re-add them all:
>>
>> iff --git a/target/m68k/translate.c b/target/m68k/translate.c
>> index d0f6d1f5cc..6c78001501 100644
>> --- a/target/m68k/translate.c
>> +++ b/target/m68k/translate.c
>> @@ -6200,6 +6200,10 @@ static void m68k_tr_tb_stop(DisasContextBase *dcb=
ase, CPUState *cpu)
>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>>=C2=A0 =C2=A0 =C2=A0 }
>>=C2=A0 =C2=A0 =C2=A0 if (dc->base.singlestep_enabled) {
>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dc->base.is_jmp !=3D DISAS_JUMP) {
>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 update_cc_op(dc);
>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_i32(QREG_PC, dc-=
>pc);
>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_raise_exception(cpu_env, tc=
g_const_i32(EXCP_DEBUG));
>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>>=C2=A0 =C2=A0 =C2=A0 }
>=20
> Even this isn't quite right, according to the comments in the switch that
> follows.=C2=A0 I think it'd be best written like so.
>=20
>=20
> r~
>=20
>=20
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index 2ae537461f..b61c7ea0f1 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -6124,27 +6124,34 @@ static void m68k_tr_tb_stop(DisasContextBase *dcb=
ase,
> CPUState *cpu)
>=C2=A0 {
>=C2=A0 =C2=A0 =C2=A0 DisasContext *dc =3D container_of(dcbase, DisasContex=
t, base);
>=20
> -=C2=A0 =C2=A0 if (dc->base.is_jmp =3D=3D DISAS_NORETURN) {
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> -=C2=A0 =C2=A0 }
> -=C2=A0 =C2=A0 if (dc->base.singlestep_enabled) {
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_raise_exception(cpu_env, tcg_cons=
t_i32(EXCP_DEBUG));
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> -=C2=A0 =C2=A0 }
> -
>=C2=A0 =C2=A0 =C2=A0 switch (dc->base.is_jmp) {
> +=C2=A0 =C2=A0 case DISAS_NORETURN:
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>=C2=A0 =C2=A0 =C2=A0 case DISAS_TOO_MANY:
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 update_cc_op(dc);
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_jmp_tb(dc, 0, dc->pc);
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dc->base.singlestep_enabled) {
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_i32(QREG_PC, dc->=
pc);
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_raise_exception(cpu=
_env, tcg_const_i32(EXCP_DEBUG));
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_jmp_tb(dc, 0, dc->pc);
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>=C2=A0 =C2=A0 =C2=A0 case DISAS_JUMP:
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* We updated CC_OP and PC in gen_jmp/g=
en_jmp_im.=C2=A0 */
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_lookup_and_goto_ptr();
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dc->base.singlestep_enabled) {
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_raise_exception(cpu=
_env, tcg_const_i32(EXCP_DEBUG));
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_lookup_and_goto_ptr();
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>=C2=A0 =C2=A0 =C2=A0 case DISAS_EXIT:
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* We updated CC_OP and PC in gen_exit_=
tb, but also modified
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 other state that may require ret=
urning to the main loop.=C2=A0 */
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_exit_tb(NULL, 0);
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dc->base.singlestep_enabled) {
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_raise_exception(cpu=
_env, tcg_const_i32(EXCP_DEBUG));
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_exit_tb(NULL, 0);
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>=C2=A0 =C2=A0 =C2=A0 default:
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();
>=20

Yes, it works too.

Could you formally send a patch?

Thanks,
Laurent
 =20
