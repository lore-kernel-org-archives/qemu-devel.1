Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869AFCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D2C2053B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D2C2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO2Bi-0001lF-Kk
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 12:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.rikalo@rt-rk.com>) id 1iO22q-0007i8-Nq
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.rikalo@rt-rk.com>) id 1iO22o-0001sm-Ms
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:02:32 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34675 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.rikalo@rt-rk.com>)
 id 1iO22o-0001Rj-7Y
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:02:30 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 7158B1A2240;
 Fri, 25 Oct 2019 18:01:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from [10.10.14.141] (rtrkw304-lin.domain.local [10.10.14.141])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 4D7D31A2090;
 Fri, 25 Oct 2019 18:01:24 +0200 (CEST)
Subject: Re: [PATCH v7 12/14] target/mips: msa: Split helpers for
 ASUB_<S|U>.<B|H|W|D>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1571826227-10583-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1571826227-10583-13-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Message-ID: <a96de4ab-b705-2c08-b85c-fe5424392ce4@rt-rk.com>
Date: Fri, 25 Oct 2019 18:01:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1571826227-10583-13-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 > From: Aleksandar Markovic <amarkovic@wavecomp.com>
 >
 > Achieves clearer code and slightly better performance.
 >
 > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
 > ---
 >=C2=A0 target/mips/helper.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +++-
 >=C2=A0 target/mips/msa_helper.c | 169=20
++++++++++++++++++++++++++++++++++++++++++-----
 >=C2=A0 target/mips/translate.c=C2=A0 |=C2=A0 38 +++++++++--
 >=C2=A0 3 files changed, 193 insertions(+), 26 deletions(-)
 >
 > diff --git a/target/mips/helper.h b/target/mips/helper.h
 > index d7c4bbf..7b8ad74 100644
 > --- a/target/mips/helper.h
 > +++ b/target/mips/helper.h
 > @@ -945,6 +945,16 @@ DEF_HELPER_4(msa_mod_s_h, void, env, i32, i32, i3=
2)
 >=C2=A0 DEF_HELPER_4(msa_mod_s_w, void, env, i32, i32, i32)
 >=C2=A0 DEF_HELPER_4(msa_mod_s_d, void, env, i32, i32, i32)
 >
 > +DEF_HELPER_4(msa_asub_s_b, void, env, i32, i32, i32)
 > +DEF_HELPER_4(msa_asub_s_h, void, env, i32, i32, i32)
 > +DEF_HELPER_4(msa_asub_s_w, void, env, i32, i32, i32)
 > +DEF_HELPER_4(msa_asub_s_d, void, env, i32, i32, i32)
 > +
 > +DEF_HELPER_4(msa_asub_u_b, void, env, i32, i32, i32)
 > +DEF_HELPER_4(msa_asub_u_h, void, env, i32, i32, i32)
 > +DEF_HELPER_4(msa_asub_u_w, void, env, i32, i32, i32)
 > +DEF_HELPER_4(msa_asub_u_d, void, env, i32, i32, i32)
 > +
 >=C2=A0 DEF_HELPER_4(msa_hsub_s_h, void, env, i32, i32, i32)
 >=C2=A0 DEF_HELPER_4(msa_hsub_s_w, void, env, i32, i32, i32)
 >=C2=A0 DEF_HELPER_4(msa_hsub_s_d, void, env, i32, i32, i32)
 > @@ -1053,8 +1063,6 @@ DEF_HELPER_5(msa_subs_s_df, void, env, i32,=20
i32, i32, i32)
 >=C2=A0 DEF_HELPER_5(msa_subs_u_df, void, env, i32, i32, i32, i32)
 >=C2=A0 DEF_HELPER_5(msa_subsus_u_df, void, env, i32, i32, i32, i32)
 >=C2=A0 DEF_HELPER_5(msa_subsuu_s_df, void, env, i32, i32, i32, i32)
 > -DEF_HELPER_5(msa_asub_s_df, void, env, i32, i32, i32, i32)
 > -DEF_HELPER_5(msa_asub_u_df, void, env, i32, i32, i32, i32)
 >=C2=A0 DEF_HELPER_5(msa_mulv_df, void, env, i32, i32, i32, i32)
 >=C2=A0 DEF_HELPER_5(msa_maddv_df, void, env, i32, i32, i32, i32)
 >=C2=A0 DEF_HELPER_5(msa_msubv_df, void, env, i32, i32, i32, i32)
 > diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
 > index ae9e8e0..0e39016 100644
 > --- a/target/mips/msa_helper.c
 > +++ b/target/mips/msa_helper.c
 > @@ -2888,6 +2888,157 @@ void helper_msa_mod_u_d(CPUMIPSState *env,
 >=C2=A0=C2=A0 *=20
+---------------+--------------------------------------------------------=
--+
 >=C2=A0=C2=A0 */
 >
 > +
 > +static inline int64_t msa_asub_s_df(uint32_t df, int64_t arg1,=20
int64_t arg2)
 > +{
 > +=C2=A0=C2=A0=C2=A0 /* signed compare */
 > +=C2=A0=C2=A0=C2=A0 return (arg1 < arg2) ?
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (uint64_t)(arg2 - arg1) : =
(uint64_t)(arg1 - arg2);
 > +}
 > +
 > +void helper_msa_asub_s_b(CPUMIPSState *env,
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 uint32_t wd, uint32_t ws, uint32_t wt)
 > +{
 > +=C2=A0=C2=A0=C2=A0 wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
 > +=C2=A0=C2=A0=C2=A0 wr_t *pws =3D &(env->active_fpu.fpr[ws].wr);
 > +=C2=A0=C2=A0=C2=A0 wr_t *pwt =3D &(env->active_fpu.fpr[wt].wr);
 > +
 > +=C2=A0=C2=A0=C2=A0 pwd->b[0]=C2=A0 =3D msa_asub_s_df(DF_BYTE, pws->b[=
0], pwt->b[0]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[1]=C2=A0 =3D msa_asub_s_df(DF_BYTE, pws->b[=
1], pwt->b[1]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[2]=C2=A0 =3D msa_asub_s_df(DF_BYTE, pws->b[=
2], pwt->b[2]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[3]=C2=A0 =3D msa_asub_s_df(DF_BYTE, pws->b[=
3], pwt->b[3]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[4]=C2=A0 =3D msa_asub_s_df(DF_BYTE, pws->b[=
4], pwt->b[4]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[5]=C2=A0 =3D msa_asub_s_df(DF_BYTE, pws->b[=
5], pwt->b[5]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[6]=C2=A0 =3D msa_asub_s_df(DF_BYTE, pws->b[=
6], pwt->b[6]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[7]=C2=A0 =3D msa_asub_s_df(DF_BYTE, pws->b[=
7], pwt->b[7]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[8]=C2=A0 =3D msa_asub_s_df(DF_BYTE, pws->b[=
8], pwt->b[8]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[9]=C2=A0 =3D msa_asub_s_df(DF_BYTE, pws->b[=
9], pwt->b[9]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[10] =3D msa_asub_s_df(DF_BYTE, pws->b[10], =
pwt->b[10]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[11] =3D msa_asub_s_df(DF_BYTE, pws->b[11], =
pwt->b[11]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[12] =3D msa_asub_s_df(DF_BYTE, pws->b[12], =
pwt->b[12]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[13] =3D msa_asub_s_df(DF_BYTE, pws->b[13], =
pwt->b[13]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[14] =3D msa_asub_s_df(DF_BYTE, pws->b[14], =
pwt->b[14]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[15] =3D msa_asub_s_df(DF_BYTE, pws->b[15], =
pwt->b[15]);
 > +}
 > +
 > +void helper_msa_asub_s_h(CPUMIPSState *env,
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 uint32_t wd, uint32_t ws, uint32_t wt)
 > +{
 > +=C2=A0=C2=A0=C2=A0 wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
 > +=C2=A0=C2=A0=C2=A0 wr_t *pws =3D &(env->active_fpu.fpr[ws].wr);
 > +=C2=A0=C2=A0=C2=A0 wr_t *pwt =3D &(env->active_fpu.fpr[wt].wr);
 > +
 > +=C2=A0=C2=A0=C2=A0 pwd->h[0]=C2=A0 =3D msa_asub_s_df(DF_HALF, pws->h[=
0], pwt->h[0]);
 > +=C2=A0=C2=A0=C2=A0 pwd->h[1]=C2=A0 =3D msa_asub_s_df(DF_HALF, pws->h[=
1], pwt->h[1]);
 > +=C2=A0=C2=A0=C2=A0 pwd->h[2]=C2=A0 =3D msa_asub_s_df(DF_HALF, pws->h[=
2], pwt->h[2]);
 > +=C2=A0=C2=A0=C2=A0 pwd->h[3]=C2=A0 =3D msa_asub_s_df(DF_HALF, pws->h[=
3], pwt->h[3]);
 > +=C2=A0=C2=A0=C2=A0 pwd->h[4]=C2=A0 =3D msa_asub_s_df(DF_HALF, pws->h[=
4], pwt->h[4]);
 > +=C2=A0=C2=A0=C2=A0 pwd->h[5]=C2=A0 =3D msa_asub_s_df(DF_HALF, pws->h[=
5], pwt->h[5]);
 > +=C2=A0=C2=A0=C2=A0 pwd->h[6]=C2=A0 =3D msa_asub_s_df(DF_HALF, pws->h[=
6], pwt->h[6]);
 > +=C2=A0=C2=A0=C2=A0 pwd->h[7]=C2=A0 =3D msa_asub_s_df(DF_HALF, pws->h[=
7], pwt->h[7]);
 > +}
 > +
 > +void helper_msa_asub_s_w(CPUMIPSState *env,
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 uint32_t wd, uint32_t ws, uint32_t wt)
 > +{
 > +=C2=A0=C2=A0=C2=A0 wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
 > +=C2=A0=C2=A0=C2=A0 wr_t *pws =3D &(env->active_fpu.fpr[ws].wr);
 > +=C2=A0=C2=A0=C2=A0 wr_t *pwt =3D &(env->active_fpu.fpr[wt].wr);
 > +
 > +=C2=A0=C2=A0=C2=A0 pwd->w[0]=C2=A0 =3D msa_asub_s_df(DF_WORD, pws->w[=
0], pwt->w[0]);
 > +=C2=A0=C2=A0=C2=A0 pwd->w[1]=C2=A0 =3D msa_asub_s_df(DF_WORD, pws->w[=
1], pwt->w[1]);
 > +=C2=A0=C2=A0=C2=A0 pwd->w[2]=C2=A0 =3D msa_asub_s_df(DF_WORD, pws->w[=
2], pwt->w[2]);
 > +=C2=A0=C2=A0=C2=A0 pwd->w[3]=C2=A0 =3D msa_asub_s_df(DF_WORD, pws->w[=
3], pwt->w[3]);
 > +}
 > +
 > +void helper_msa_asub_s_d(CPUMIPSState *env,
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 uint32_t wd, uint32_t ws, uint32_t wt)
 > +{
 > +=C2=A0=C2=A0=C2=A0 wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
 > +=C2=A0=C2=A0=C2=A0 wr_t *pws =3D &(env->active_fpu.fpr[ws].wr);
 > +=C2=A0=C2=A0=C2=A0 wr_t *pwt =3D &(env->active_fpu.fpr[wt].wr);
 > +
 > +=C2=A0=C2=A0=C2=A0 pwd->d[0]=C2=A0 =3D msa_asub_s_df(DF_DOUBLE, pws->=
d[0], pwt->d[0]);
 > +=C2=A0=C2=A0=C2=A0 pwd->d[1]=C2=A0 =3D msa_asub_s_df(DF_DOUBLE, pws->=
d[1], pwt->d[1]);
 > +}
 > +
 > +
 > +static inline uint64_t msa_asub_u_df(uint32_t df, uint64_t arg1,=20
uint64_t arg2)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t u_arg1 =3D UNSIGNED(arg1, df);
 > +=C2=A0=C2=A0=C2=A0 uint64_t u_arg2 =3D UNSIGNED(arg2, df);
 > +=C2=A0=C2=A0=C2=A0 /* unsigned compare */
 > +=C2=A0=C2=A0=C2=A0 return (u_arg1 < u_arg2) ?
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (uint64_t)(u_arg2 - u_arg1=
) : (uint64_t)(u_arg1 - u_arg2);
 > +}
 > +
 > +void helper_msa_asub_u_b(CPUMIPSState *env,
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 uint32_t wd, uint32_t ws, uint32_t wt)
 > +{
 > +=C2=A0=C2=A0=C2=A0 wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
 > +=C2=A0=C2=A0=C2=A0 wr_t *pws =3D &(env->active_fpu.fpr[ws].wr);
 > +=C2=A0=C2=A0=C2=A0 wr_t *pwt =3D &(env->active_fpu.fpr[wt].wr);
 > +
 > +=C2=A0=C2=A0=C2=A0 pwd->b[0]=C2=A0 =3D msa_asub_u_df(DF_BYTE, pws->b[=
0], pwt->b[0]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[1]=C2=A0 =3D msa_asub_u_df(DF_BYTE, pws->b[=
1], pwt->b[1]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[2]=C2=A0 =3D msa_asub_u_df(DF_BYTE, pws->b[=
2], pwt->b[2]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[3]=C2=A0 =3D msa_asub_u_df(DF_BYTE, pws->b[=
3], pwt->b[3]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[4]=C2=A0 =3D msa_asub_u_df(DF_BYTE, pws->b[=
4], pwt->b[4]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[5]=C2=A0 =3D msa_asub_u_df(DF_BYTE, pws->b[=
5], pwt->b[5]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[6]=C2=A0 =3D msa_asub_u_df(DF_BYTE, pws->b[=
6], pwt->b[6]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[7]=C2=A0 =3D msa_asub_u_df(DF_BYTE, pws->b[=
7], pwt->b[7]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[8]=C2=A0 =3D msa_asub_u_df(DF_BYTE, pws->b[=
8], pwt->b[8]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[9]=C2=A0 =3D msa_asub_u_df(DF_BYTE, pws->b[=
9], pwt->b[9]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[10] =3D msa_asub_u_df(DF_BYTE, pws->b[10], =
pwt->b[10]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[11] =3D msa_asub_u_df(DF_BYTE, pws->b[11], =
pwt->b[11]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[12] =3D msa_asub_u_df(DF_BYTE, pws->b[12], =
pwt->b[12]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[13] =3D msa_asub_u_df(DF_BYTE, pws->b[13], =
pwt->b[13]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[14] =3D msa_asub_u_df(DF_BYTE, pws->b[14], =
pwt->b[14]);
 > +=C2=A0=C2=A0=C2=A0 pwd->b[15] =3D msa_asub_u_df(DF_BYTE, pws->b[15], =
pwt->b[15]);
 > +}
 > +
 > +void helper_msa_asub_u_h(CPUMIPSState *env,
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 uint32_t wd, uint32_t ws, uint32_t wt)
 > +{
 > +=C2=A0=C2=A0=C2=A0 wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
 > +=C2=A0=C2=A0=C2=A0 wr_t *pws =3D &(env->active_fpu.fpr[ws].wr);
 > +=C2=A0=C2=A0=C2=A0 wr_t *pwt =3D &(env->active_fpu.fpr[wt].wr);
 > +
 > +=C2=A0=C2=A0=C2=A0 pwd->h[0]=C2=A0 =3D msa_asub_u_df(DF_HALF, pws->h[=
0], pwt->h[0]);
 > +=C2=A0=C2=A0=C2=A0 pwd->h[1]=C2=A0 =3D msa_asub_u_df(DF_HALF, pws->h[=
1], pwt->h[1]);
 > +=C2=A0=C2=A0=C2=A0 pwd->h[2]=C2=A0 =3D msa_asub_u_df(DF_HALF, pws->h[=
2], pwt->h[2]);
 > +=C2=A0=C2=A0=C2=A0 pwd->h[3]=C2=A0 =3D msa_asub_u_df(DF_HALF, pws->h[=
3], pwt->h[3]);
 > +=C2=A0=C2=A0=C2=A0 pwd->h[4]=C2=A0 =3D msa_asub_u_df(DF_HALF, pws->h[=
4], pwt->h[4]);
 > +=C2=A0=C2=A0=C2=A0 pwd->h[5]=C2=A0 =3D msa_asub_u_df(DF_HALF, pws->h[=
5], pwt->h[5]);
 > +=C2=A0=C2=A0=C2=A0 pwd->h[6]=C2=A0 =3D msa_asub_u_df(DF_HALF, pws->h[=
6], pwt->h[6]);
 > +=C2=A0=C2=A0=C2=A0 pwd->h[7]=C2=A0 =3D msa_asub_u_df(DF_HALF, pws->h[=
7], pwt->h[7]);
 > +}
 > +
 > +void helper_msa_asub_u_w(CPUMIPSState *env,
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 uint32_t wd, uint32_t ws, uint32_t wt)
 > +{
 > +=C2=A0=C2=A0=C2=A0 wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
 > +=C2=A0=C2=A0=C2=A0 wr_t *pws =3D &(env->active_fpu.fpr[ws].wr);
 > +=C2=A0=C2=A0=C2=A0 wr_t *pwt =3D &(env->active_fpu.fpr[wt].wr);
 > +
 > +=C2=A0=C2=A0=C2=A0 pwd->w[0]=C2=A0 =3D msa_asub_u_df(DF_WORD, pws->w[=
0], pwt->w[0]);
 > +=C2=A0=C2=A0=C2=A0 pwd->w[1]=C2=A0 =3D msa_asub_u_df(DF_WORD, pws->w[=
1], pwt->w[1]);
 > +=C2=A0=C2=A0=C2=A0 pwd->w[2]=C2=A0 =3D msa_asub_u_df(DF_WORD, pws->w[=
2], pwt->w[2]);
 > +=C2=A0=C2=A0=C2=A0 pwd->w[3]=C2=A0 =3D msa_asub_u_df(DF_WORD, pws->w[=
3], pwt->w[3]);
 > +}
 > +
 > +void helper_msa_asub_u_d(CPUMIPSState *env,
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 uint32_t wd, uint32_t ws, uint32_t wt)
 > +{
 > +=C2=A0=C2=A0=C2=A0 wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
 > +=C2=A0=C2=A0=C2=A0 wr_t *pws =3D &(env->active_fpu.fpr[ws].wr);
 > +=C2=A0=C2=A0=C2=A0 wr_t *pwt =3D &(env->active_fpu.fpr[wt].wr);
 > +
 > +=C2=A0=C2=A0=C2=A0 pwd->d[0]=C2=A0 =3D msa_asub_u_df(DF_DOUBLE, pws->=
d[0], pwt->d[0]);
 > +=C2=A0=C2=A0=C2=A0 pwd->d[1]=C2=A0 =3D msa_asub_u_df(DF_DOUBLE, pws->=
d[1], pwt->d[1]);
 > +}
 > +
 > +
 >=C2=A0 /* TODO: insert the rest of Int Subtract group helpers here */
 >
 >
 > @@ -4447,22 +4598,6 @@ static inline int64_t msa_subsuu_s_df(uint32_t=20
df, int64_t arg1, int64_t arg2)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 >=C2=A0 }
 >
 > -static inline int64_t msa_asub_s_df(uint32_t df, int64_t arg1,=20
int64_t arg2)
 > -{
 > -=C2=A0=C2=A0=C2=A0 /* signed compare */
 > -=C2=A0=C2=A0=C2=A0 return (arg1 < arg2) ?
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (uint64_t)(arg2 - arg1) : =
(uint64_t)(arg1 - arg2);
 > -}
 > -
 > -static inline uint64_t msa_asub_u_df(uint32_t df, uint64_t arg1,=20
uint64_t arg2)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t u_arg1 =3D UNSIGNED(arg1, df);
 > -=C2=A0=C2=A0=C2=A0 uint64_t u_arg2 =3D UNSIGNED(arg2, df);
 > -=C2=A0=C2=A0=C2=A0 /* unsigned compare */
 > -=C2=A0=C2=A0=C2=A0 return (u_arg1 < u_arg2) ?
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (uint64_t)(u_arg2 - u_arg1=
) : (uint64_t)(u_arg1 - u_arg2);
 > -}
 > -
 >=C2=A0 static inline int64_t msa_mulv_df(uint32_t df, int64_t arg1, int=
64_t=20
arg2)
 >=C2=A0 {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return arg1 * arg2;
 > @@ -4624,8 +4759,6 @@ MSA_BINOP_DF(subs_s)
 >=C2=A0 MSA_BINOP_DF(subs_u)
 >=C2=A0 MSA_BINOP_DF(subsus_u)
 >=C2=A0 MSA_BINOP_DF(subsuu_s)
 > -MSA_BINOP_DF(asub_s)
 > -MSA_BINOP_DF(asub_u)
 >=C2=A0 MSA_BINOP_DF(mulv)
 >=C2=A0 MSA_BINOP_DF(dotp_s)
 >=C2=A0 MSA_BINOP_DF(dotp_u)
 > diff --git a/target/mips/translate.c b/target/mips/translate.c
 > index 4c68c5b..20c69d2 100644
 > --- a/target/mips/translate.c
 > +++ b/target/mips/translate.c
 > @@ -28850,6 +28850,38 @@ static void gen_msa_3r(CPUMIPSState *env,=20
DisasContext *ctx)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_ASUB_S_df:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (df) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case DF_BYTE:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ge=
n_helper_msa_asub_s_b(cpu_env, twd, tws, twt);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case DF_HALF:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ge=
n_helper_msa_asub_s_h(cpu_env, twd, tws, twt);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case DF_WORD:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ge=
n_helper_msa_asub_s_w(cpu_env, twd, tws, twt);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case DF_DOUBLE:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ge=
n_helper_msa_asub_s_d(cpu_env, twd, tws, twt);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_ASUB_U_df:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (df) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case DF_BYTE:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ge=
n_helper_msa_asub_u_b(cpu_env, twd, tws, twt);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case DF_HALF:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ge=
n_helper_msa_asub_u_h(cpu_env, twd, tws, twt);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case DF_WORD:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ge=
n_helper_msa_asub_u_w(cpu_env, twd, tws, twt);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case DF_DOUBLE:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ge=
n_helper_msa_asub_u_d(cpu_env, twd, tws, twt);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case OPC_ILVEV_df:
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (df) {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case DF_BYTE:
 > @@ -29059,12 +29091,6 @@ static void gen_msa_3r(CPUMIPSState *env,=20
DisasContext *ctx)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case OPC_SUBSUU_S_df:
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_msa_s=
ubsuu_s_df(cpu_env, tdf, twd, tws, twt);
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > -=C2=A0=C2=A0=C2=A0 case OPC_ASUB_S_df:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_msa_asub_s_df(c=
pu_env, tdf, twd, tws, twt);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > -=C2=A0=C2=A0=C2=A0 case OPC_ASUB_U_df:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_msa_asub_u_df(c=
pu_env, tdf, twd, tws, twt);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 >
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case OPC_DOTP_S_df:
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case OPC_DOTP_U_df:


Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>


