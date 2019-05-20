Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B591C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 10:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31AD20675
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 10:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31AD20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33009 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSfVF-0005pO-Jl
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 06:26:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hSfUD-000519-Kk
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hSfU9-0006kq-91
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:25:41 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:40935 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Mateja.Marjanovic@rt-rk.com>)
	id 1hSfU3-000646-SP
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:25:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 84E9C1A1E3A;
	Mon, 20 May 2019 12:24:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from [10.10.13.110] (rtrkw310-lin.domain.local [10.10.13.110])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 632971A20C3;
	Mon, 20 May 2019 12:24:24 +0200 (CEST)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <1554212605-16457-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554212605-16457-6-git-send-email-mateja.marjanovic@rt-rk.com>
	<CAL1e-=gRi9fioR4n4pfC-ZuzrgfbNMXobVugyTKZMGvR8TwRfA@mail.gmail.com>
From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Message-ID: <06907c6a-3dd0-ccb5-ee72-e1fee83396ab@rt-rk.com>
Date: Mon, 20 May 2019 12:24:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gRi9fioR4n4pfC-ZuzrgfbNMXobVugyTKZMGvR8TwRfA@mail.gmail.com>
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v4 5/5] target/mips: Refactor and fix
 INSERT.<B|H|W|D> instructions
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
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 19.5.19. 07:25, Aleksandar Markovic wrote:
>
>
> On Apr 2, 2019 3:49 PM, "Mateja Marjanovic"=20
> <mateja.marjanovic@rt-rk.com <mailto:mateja.marjanovic@rt-rk.com>> wrot=
e:
> >
> > From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com=20
> <mailto:Mateja.Marjanovic@rt-rk.com>>
> >
> > The old version of the helper for the INSERT.<B|H|W|D> MSA instructio=
ns
> > has been replaced with four helpers that don't use switch, and change
> > the endianness of the given index, when executed on a big endian host=
.
> >
> > Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com=20
> <mailto:mateja.marjanovic@rt-rk.com>>
> > ---
>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com=20
> <mailto:amarkovic@wavecomp.com>>
>
> I'll do minor corrections (resulting from this mail thread discussion)=20
> while applying to my pull request.
>
Great, thanks.

Regards,
Mateja

> > =C2=A0target/mips/helper.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +++-
> > =C2=A0target/mips/msa_helper.c | 65=20
> ++++++++++++++++++++++++++++++++++++------------
> > =C2=A0target/mips/translate.c=C2=A0 | 19 +++++++++++++-
> > =C2=A03 files changed, 71 insertions(+), 18 deletions(-)
> >
> > diff --git a/target/mips/helper.h b/target/mips/helper.h
> > index 8b6703c..82f6a40 100644
> > --- a/target/mips/helper.h
> > +++ b/target/mips/helper.h
> > @@ -875,7 +875,6 @@ DEF_HELPER_5(msa_hsub_u_df, void, env, i32, i32,=20
> i32, i32)
> > =C2=A0DEF_HELPER_5(msa_sldi_df, void, env, i32, i32, i32, i32)
> > =C2=A0DEF_HELPER_5(msa_splati_df, void, env, i32, i32, i32, i32)
> >
> > -DEF_HELPER_5(msa_insert_df, void, env, i32, i32, i32, i32)
> > =C2=A0DEF_HELPER_5(msa_insve_df, void, env, i32, i32, i32, i32)
> > =C2=A0DEF_HELPER_3(msa_ctcmsa, void, env, tl, i32)
> > =C2=A0DEF_HELPER_2(msa_cfcmsa, tl, env, i32)
> > @@ -942,6 +941,10 @@ DEF_HELPER_4(msa_copy_s_d, void, env, i32, i32,=20
> i32)
> > =C2=A0DEF_HELPER_4(msa_copy_u_b, void, env, i32, i32, i32)
> > =C2=A0DEF_HELPER_4(msa_copy_u_h, void, env, i32, i32, i32)
> > =C2=A0DEF_HELPER_4(msa_copy_u_w, void, env, i32, i32, i32)
> > +DEF_HELPER_4(msa_insert_b, void, env, i32, i32, i32)
> > +DEF_HELPER_4(msa_insert_h, void, env, i32, i32, i32)
> > +DEF_HELPER_4(msa_insert_w, void, env, i32, i32, i32)
> > +DEF_HELPER_4(msa_insert_d, void, env, i32, i32, i32)
> >
> > =C2=A0DEF_HELPER_4(msa_fclass_df, void, env, i32, i32, i32)
> > =C2=A0DEF_HELPER_4(msa_ftrunc_s_df, void, env, i32, i32, i32)
> > diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> > index d5bf4dc..d5c3842 100644
> > --- a/target/mips/msa_helper.c
> > +++ b/target/mips/msa_helper.c
> > @@ -1323,28 +1323,61 @@ void helper_msa_copy_u_w(CPUMIPSState *env,=20
> uint32_t rd,
> > =C2=A0 =C2=A0 =C2=A0env->active_tc.gpr[rd] =3D (uint32_t)env->active_=
fpu.fpr[ws].wr.w[n];
> > =C2=A0}
> >
> > -void helper_msa_insert_df(CPUMIPSState *env, uint32_t df, uint32_t w=
d,
> > +void helper_msa_insert_b(CPUMIPSState *env, uint32_t wd,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t rs_num, uint32_t n)
> > =C2=A0{
> > =C2=A0 =C2=A0 =C2=A0wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
> > =C2=A0 =C2=A0 =C2=A0target_ulong rs =3D env->active_tc.gpr[rs_num];
> > +=C2=A0 =C2=A0 n %=3D 16;
> > +#if defined(HOST_WORDS_BIGENDIAN)
> > +=C2=A0 =C2=A0 if (n < 8) {
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D 8 - n - 1;
> > +=C2=A0 =C2=A0 } else {
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D 24 - n - 1;
> > +=C2=A0 =C2=A0 }
> > +#endif
> > +=C2=A0 =C2=A0 pwd->b[n] =3D (int8_t)rs;
> > +}
> >
> > -=C2=A0 =C2=A0 switch (df) {
> > -=C2=A0 =C2=A0 case DF_BYTE:
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->b[n] =3D (int8_t)rs;
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > -=C2=A0 =C2=A0 case DF_HALF:
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->h[n] =3D (int16_t)rs;
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > -=C2=A0 =C2=A0 case DF_WORD:
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->w[n] =3D (int32_t)rs;
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > -=C2=A0 =C2=A0 case DF_DOUBLE:
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->d[n] =3D (int64_t)rs;
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > -=C2=A0 =C2=A0 default:
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(0);
> > +void helper_msa_insert_h(CPUMIPSState *env, uint32_t wd,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 uint32_t rs_num, uint32_t n)
> > +{
> > +=C2=A0 =C2=A0 wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
> > +=C2=A0 =C2=A0 target_ulong rs =3D env->active_tc.gpr[rs_num];
> > +=C2=A0 =C2=A0 n %=3D 8;
> > +#if defined(HOST_WORDS_BIGENDIAN)
> > +=C2=A0 =C2=A0 if (n < 4) {
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D 4 - n - 1;
> > +=C2=A0 =C2=A0 } else {
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D 12 - n - 1;
> > +=C2=A0 =C2=A0 }
> > +#endif
> > +=C2=A0 =C2=A0 pwd->h[n] =3D (int16_t)rs;
> > +}
> > +
> > +void helper_msa_insert_w(CPUMIPSState *env, uint32_t wd,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 uint32_t rs_num, uint32_t n)
> > +{
> > +=C2=A0 =C2=A0 wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
> > +=C2=A0 =C2=A0 target_ulong rs =3D env->active_tc.gpr[rs_num];
> > +=C2=A0 =C2=A0 n %=3D 4;
> > +#if defined(HOST_WORDS_BIGENDIAN)
> > +=C2=A0 =C2=A0 if (n < 2) {
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D 2 - n - 1;
> > +=C2=A0 =C2=A0 } else {
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D 6 - n - 1;
> > =C2=A0 =C2=A0 =C2=A0}
> > +#endif
> > +=C2=A0 =C2=A0 pwd->w[n] =3D (int32_t)rs;
> > +}
> > +
> > +void helper_msa_insert_d(CPUMIPSState *env, uint32_t wd,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 uint32_t rs_num, uint32_t n)
> > +{
> > +=C2=A0 =C2=A0 wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
> > +=C2=A0 =C2=A0 target_ulong rs =3D env->active_tc.gpr[rs_num];
> > +=C2=A0 =C2=A0 n %=3D 2;
> > +=C2=A0 =C2=A0 pwd->d[n] =3D (int64_t)rs;
> > =C2=A0}
> >
> > =C2=A0void helper_msa_insve_df(CPUMIPSState *env, uint32_t df, uint32=
_t wd,
> > diff --git a/target/mips/translate.c b/target/mips/translate.c
> > index 72ed0a8..64587c4 100644
> > --- a/target/mips/translate.c
> > +++ b/target/mips/translate.c
> > @@ -29446,7 +29446,24 @@ static void gen_msa_elm_df(CPUMIPSState=20
> *env, DisasContext *ctx, uint32_t df,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case OPC_INSERT_df:
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_msa_insert_df(c=
pu_env, tdf, twd, tws, tn);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (df) {
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case DF_BYTE:
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_m=
sa_insert_b(cpu_env, twd, tws, tn);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case DF_HALF:
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_m=
sa_insert_h(cpu_env, twd, tws, tn);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case DF_WORD:
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_m=
sa_insert_w(cpu_env, twd, tws, tn);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > +#if defined(TARGET_MIPS64)
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case DF_DOUBLE:
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_m=
sa_insert_d(cpu_env, twd, tws, tn);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > +#endif
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(0);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> > --
> > 2.7.4
> >
> >
>
