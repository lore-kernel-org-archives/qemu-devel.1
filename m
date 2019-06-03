Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35074C28CC6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB90A2803C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB90A2803C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60613 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXjaS-0005hW-7D
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 05:49:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hXjZa-0005Or-KT
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hXjZY-00030h-Kv
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:48:10 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:43567 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Mateja.Marjanovic@rt-rk.com>)
	id 1hXjZY-0000k6-4b
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:48:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 04E231A1DE0;
	Mon,  3 Jun 2019 11:47:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from [10.10.13.110] (rtrkw310-lin.domain.local [10.10.13.110])
	by mail.rt-rk.com (Postfix) with ESMTPSA id D90201A1CBC;
	Mon,  3 Jun 2019 11:46:59 +0200 (CEST)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>
References: <1551718283-4487-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1551718283-4487-2-git-send-email-mateja.marjanovic@rt-rk.com>
	<BN6PR2201MB1251E8A4D8209209DAC36D69C61A0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<CAL1e-=gfyTOeYZtgZ=xpgUDje2jG1N05cH9-2-dCcgMcaoJ21A@mail.gmail.com>
From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Message-ID: <f7e0f304-ddb7-60a9-3faf-c9c0d5c6668c@rt-rk.com>
Date: Mon, 3 Jun 2019 11:46:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gfyTOeYZtgZ=xpgUDje2jG1N05cH9-2-dCcgMcaoJ21A@mail.gmail.com>
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 1/2] target/mips: Improve performance for
 MSA binary operations
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
	aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2.6.19. 09:06, Aleksandar Markovic wrote:
>
>
> On Jun 1, 2019 4:16 PM, "Aleksandar Markovic" <amarkovic@wavecomp.com=20
> <mailto:amarkovic@wavecomp.com>> wrote:
> >
> > > From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com=20
> <mailto:mateja.marjanovic@rt-rk.com>>
> > > Sent: Monday, March 4, 2019 5:51 PM
> > > To: qemu-devel@nongnu.org <mailto:qemu-devel@nongnu.org>
> > > Cc: aurelien@aurel32.net <mailto:aurelien@aurel32.net>; Aleksandar=20
> Markovic; Aleksandar Rikalo
> > > Subject: [PATCH 1/2] target/mips: Improve performance for MSA=20
> binary operations
> > >
> > > From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com=20
> <mailto:Mateja.Marjanovic@rt-rk.com>>
> > >
> > > Eliminate loops for better performance.
> > >
> > > Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com=20
> <mailto:mateja.marjanovic@rt-rk.com>>
> > > ---
> > >=C2=A0 target/mips/msa_helper.c | 43=20
> ++++++++++++++++++++++++++++++-------------
> > >=C2=A0 1 file changed, 30 insertions(+), 13 deletions(-)
> > >
> >
> > The commit message should be a little bit more informative - for=20
> example,
> > it could list the affected instructions. Please consider other groups=
 of
> > MSA instructions that are implemented via helpers that use similar "f=
or"
> > loops. Otherwise:
> >
> > Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com=20
> <mailto:amarkovic@wavecomp.com>>
> >
>
> Mateja, you don't need to do anything regarding this patch, I am going=20
> to fix the issues while appying.
>
Alright, thanks. :)

Regards,
Mateja
>
> Thanks, Aleksandar
>
> > > diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> > > index 4c7ec05..1152fda 100644
> > > --- a/target/mips/msa_helper.c
> > > +++ b/target/mips/msa_helper.c
> > > @@ -804,28 +804,45 @@ void helper_msa_ ## func ## _df(CPUMIPSState=20
> *env, uint32_t > df,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > >=C2=A0 =C2=A0 =C2=A0 wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=20
> =C2=A0 =C2=A0 =C2=A0 \
> > >=C2=A0 =C2=A0 =C2=A0 wr_t *pws =3D &(env->active_fpu.fpr[ws].wr);=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=20
> =C2=A0 =C2=A0 =C2=A0 \
> > >=C2=A0 =C2=A0 =C2=A0 wr_t *pwt =3D &(env->active_fpu.fpr[wt].wr);=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=20
> =C2=A0 =C2=A0 =C2=A0 \
> > > -=C2=A0 =C2=A0 uint32_t i; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > >=C2=A0 =C2=A0 =C2=A0 switch (df) { =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > >=C2=A0 =C2=A0 =C2=A0 case DF_BYTE: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < DF_ELEMENTS(DF_BYTE)=
; i++) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=20
> =C2=A0 =C2=A0 =C2=A0 \
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->b[i] =3D msa_ ## fu=
nc ## _df(df, pws->b[i],=20
> pwt->b[i]);=C2=A0 \
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 } =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->b[0]=C2=A0 =3D msa_ ## func ## _d=
f(df, pws->b[0],=20
> pwt->b[0]);=C2=A0 =C2=A0 =C2=A0\
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->b[1]=C2=A0 =3D msa_ ## func ## _d=
f(df, pws->b[1],=20
> pwt->b[1]);=C2=A0 =C2=A0 =C2=A0\
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->b[2]=C2=A0 =3D msa_ ## func ## _d=
f(df, pws->b[2],=20
> pwt->b[2]);=C2=A0 =C2=A0 =C2=A0\
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->b[3]=C2=A0 =3D msa_ ## func ## _d=
f(df, pws->b[3],=20
> pwt->b[3]);=C2=A0 =C2=A0 =C2=A0\
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->b[4]=C2=A0 =3D msa_ ## func ## _d=
f(df, pws->b[4],=20
> pwt->b[4]);=C2=A0 =C2=A0 =C2=A0\
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->b[5]=C2=A0 =3D msa_ ## func ## _d=
f(df, pws->b[5],=20
> pwt->b[5]);=C2=A0 =C2=A0 =C2=A0\
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->b[6]=C2=A0 =3D msa_ ## func ## _d=
f(df, pws->b[6],=20
> pwt->b[6]);=C2=A0 =C2=A0 =C2=A0\
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->b[7]=C2=A0 =3D msa_ ## func ## _d=
f(df, pws->b[7],=20
> pwt->b[7]);=C2=A0 =C2=A0 =C2=A0\
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->b[8]=C2=A0 =3D msa_ ## func ## _d=
f(df, pws->b[8],=20
> pwt->b[8]);=C2=A0 =C2=A0 =C2=A0\
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->b[9]=C2=A0 =3D msa_ ## func ## _d=
f(df, pws->b[9],=20
> pwt->b[9]);=C2=A0 =C2=A0 =C2=A0\
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->b[10] =3D msa_ ## func ## _df(df,=
 pws->b[10],=20
> pwt->b[10]);=C2=A0 =C2=A0\
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->b[11] =3D msa_ ## func ## _df(df,=
 pws->b[11],=20
> pwt->b[11]);=C2=A0 =C2=A0\
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->b[12] =3D msa_ ## func ## _df(df,=
 pws->b[12],=20
> pwt->b[12]);=C2=A0 =C2=A0\
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->b[13] =3D msa_ ## func ## _df(df,=
 pws->b[13],=20
> pwt->b[13]);=C2=A0 =C2=A0\
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->b[14] =3D msa_ ## func ## _df(df,=
 pws->b[14],=20
> pwt->b[14]);=C2=A0 =C2=A0\
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->b[15] =3D msa_ ## func ## _df(df,=
 pws->b[15],=20
> pwt->b[15]);=C2=A0 =C2=A0\
> > >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break; =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > >=C2=A0 =C2=A0 =C2=A0 case DF_HALF: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < DF_ELEMENTS(DF_HALF)=
; i++) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=20
> =C2=A0 =C2=A0 =C2=A0 \
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->h[i] =3D msa_ ## fu=
nc ## _df(df, pws->h[i],=20
> pwt->h[i]);=C2=A0 \
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 } =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->h[0] =3D msa_ ## func ## _df(df, =
pws->h[0],=20
> pwt->h[0]);=C2=A0 =C2=A0 =C2=A0 \
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->h[1] =3D msa_ ## func ## _df(df, =
pws->h[1],=20
> pwt->h[1]);=C2=A0 =C2=A0 =C2=A0 \
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->h[2] =3D msa_ ## func ## _df(df, =
pws->h[2],=20
> pwt->h[2]);=C2=A0 =C2=A0 =C2=A0 \
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->h[3] =3D msa_ ## func ## _df(df, =
pws->h[3],=20
> pwt->h[3]);=C2=A0 =C2=A0 =C2=A0 \
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->h[4] =3D msa_ ## func ## _df(df, =
pws->h[4],=20
> pwt->h[4]);=C2=A0 =C2=A0 =C2=A0 \
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->h[5] =3D msa_ ## func ## _df(df, =
pws->h[5],=20
> pwt->h[5]);=C2=A0 =C2=A0 =C2=A0 \
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->h[6] =3D msa_ ## func ## _df(df, =
pws->h[6],=20
> pwt->h[6]);=C2=A0 =C2=A0 =C2=A0 \
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->h[7] =3D msa_ ## func ## _df(df, =
pws->h[7],=20
> pwt->h[7]);=C2=A0 =C2=A0 =C2=A0 \
> > >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break; =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > >=C2=A0 =C2=A0 =C2=A0 case DF_WORD: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < DF_ELEMENTS(DF_WORD)=
; i++) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=20
> =C2=A0 =C2=A0 =C2=A0 \
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->w[i] =3D msa_ ## fu=
nc ## _df(df, pws->w[i],=20
> pwt->w[i]);=C2=A0 \
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 } =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->w[0] =3D msa_ ## func ## _df(df, =
pws->w[0],=20
> pwt->w[0]);=C2=A0 =C2=A0 =C2=A0 \
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->w[1] =3D msa_ ## func ## _df(df, =
pws->w[1],=20
> pwt->w[1]);=C2=A0 =C2=A0 =C2=A0 \
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->w[2] =3D msa_ ## func ## _df(df, =
pws->w[2],=20
> pwt->w[2]);=C2=A0 =C2=A0 =C2=A0 \
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->w[3] =3D msa_ ## func ## _df(df, =
pws->w[3],=20
> pwt->w[3]);=C2=A0 =C2=A0 =C2=A0 \
> > >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break; =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > >=C2=A0 =C2=A0 =C2=A0 case DF_DOUBLE: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < DF_ELEMENTS(DF_DOUBL=
E); i++) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=20
> =C2=A0 =C2=A0 =C2=A0 \
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->d[i] =3D msa_ ## fu=
nc ## _df(df, pws->d[i],=20
> pwt->d[i]);=C2=A0 \
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 } =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->d[0] =3D msa_ ## func ## _df(df, =
pws->d[0],=20
> pwt->d[0]);=C2=A0 =C2=A0 =C2=A0 \
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd->d[1] =3D msa_ ## func ## _df(df, =
pws->d[1],=20
> pwt->d[1]);=C2=A0 =C2=A0 =C2=A0 \
> > >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break; =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > >=C2=A0 =C2=A0 =C2=A0 default: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 \
> > >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(0); =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > > --
> > > 2.7.4
> > >
> > >
>
