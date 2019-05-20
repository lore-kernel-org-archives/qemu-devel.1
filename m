Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04374C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 13:09:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77A620815
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 13:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77A620815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35453 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSi2b-0001Re-1A
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 09:09:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hSi0y-0000jJ-Pb
	for qemu-devel@nongnu.org; Mon, 20 May 2019 09:07:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hSi0t-0007qW-8b
	for qemu-devel@nongnu.org; Mon, 20 May 2019 09:07:38 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:48257 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Mateja.Marjanovic@rt-rk.com>)
	id 1hSi0r-0007od-KG
	for qemu-devel@nongnu.org; Mon, 20 May 2019 09:07:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id C9A351A2268;
	Mon, 20 May 2019 15:07:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from [10.10.13.110] (rtrkw310-lin.domain.local [10.10.13.110])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 9E70D1A2266;
	Mon, 20 May 2019 15:07:30 +0200 (CEST)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <1554212605-16457-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554212605-16457-3-git-send-email-mateja.marjanovic@rt-rk.com>
	<CAL1e-=j6+P=WVAyUfbEqh1iXLiN6cAjgv0YPZj+RSFaWgEVFog@mail.gmail.com>
From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Message-ID: <cae74a66-b6ed-a2ef-ae10-d0c49c9ba11d@rt-rk.com>
Date: Mon, 20 May 2019 15:07:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=j6+P=WVAyUfbEqh1iXLiN6cAjgv0YPZj+RSFaWgEVFog@mail.gmail.com>
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v4 2/5] target/mips: Fix MSA instructions
 ST.<B|H|W|D> on big endian host
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


On 20.5.19. 14:59, Aleksandar Markovic wrote:
>
>
> On Apr 2, 2019 3:47 PM, "Mateja Marjanovic"=20
> <mateja.marjanovic@rt-rk.com <mailto:mateja.marjanovic@rt-rk.com>> wrot=
e:
> >
> > From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com=20
> <mailto:Mateja.Marjanovic@rt-rk.com>>
> >
> > Fix the case when the host is a big endian machine, and change
> > the approach toward ST.<B|H|W|D> instruction helpers.
> >
> > Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com=20
> <mailto:mateja.marjanovic@rt-rk.com>>
> > ---
>
> Hello, Mateja.
>
> There is unfortunatelly still a slight problem with the new=20
> implementation: it looks like the invocations to=20
> ensure_writable_pages() in new helpers are missing. Or, perhaps, there=20
> is a reason you removed them. Please reanalyse and reexplain. But=20
> thanks for previous efforts.
>
I see, I deleted it by accident.

Thanks,
Mateja

> Yours,
> Aleksandar
>
> > =C2=A0target/mips/op_helper.c | 188=20
> ++++++++++++++++++++++++++++++++++++++++++------
> > =C2=A01 file changed, 168 insertions(+), 20 deletions(-)
> >
> > diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> > index 45be406..d94909a 100644
> > --- a/target/mips/op_helper.c
> > +++ b/target/mips/op_helper.c
> > @@ -4565,31 +4565,179 @@ static inline void=20
> ensure_writable_pages(CPUMIPSState *env,
> > =C2=A0#endif
> > =C2=A0}
> >
> > -#define MSA_ST_DF(DF, TYPE, ST_INSN, ...) =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0\
> > -void helper_msa_st_ ## TYPE(CPUMIPSState *env, uint32_t wd,=C2=A0 =C2=
=A0 =C2=A0 =C2=A0=20
> =C2=A0 =C2=A0 =C2=A0\
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_ulong addr) =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 \
> > -{ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > -=C2=A0 =C2=A0 wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr); =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > -=C2=A0 =C2=A0 int mmu_idx =3D cpu_mmu_index(env, false); =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > -=C2=A0 =C2=A0 int i; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 \
> > -=C2=A0 =C2=A0 MEMOP_IDX(DF) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0\
> > -=C2=A0 =C2=A0 ensure_writable_pages(env, addr, mmu_idx, GETPC()); =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > -=C2=A0 =C2=A0 for (i =3D 0; i < DF_ELEMENTS(DF); i++) { =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ST_INSN(env, addr + (i << DF), pwd->TYPE=
[i],=20
> ##__VA_ARGS__);=C2=A0 =C2=A0 \
> > -=C2=A0 =C2=A0 } =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > +void helper_msa_st_b(CPUMIPSState *env, uint32_t wd,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0target_ulong addr)
> > +{
> > +=C2=A0 =C2=A0 wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
> > +=C2=A0 =C2=A0 MEMOP_IDX(DF_BYTE)
> > +#if !defined(CONFIG_USER_ONLY)
> > +#if !defined(HOST_WORDS_BIGENDIAN)
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (0=C2=A0 << DF_BYTE), p=
wd->b[0],=C2=A0 oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (1=C2=A0 << DF_BYTE), p=
wd->b[1],=C2=A0 oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (2=C2=A0 << DF_BYTE), p=
wd->b[2],=C2=A0 oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (3=C2=A0 << DF_BYTE), p=
wd->b[3],=C2=A0 oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (4=C2=A0 << DF_BYTE), p=
wd->b[4],=C2=A0 oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (5=C2=A0 << DF_BYTE), p=
wd->b[5],=C2=A0 oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (6=C2=A0 << DF_BYTE), p=
wd->b[6],=C2=A0 oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (7=C2=A0 << DF_BYTE), p=
wd->b[7],=C2=A0 oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (8=C2=A0 << DF_BYTE), p=
wd->b[8],=C2=A0 oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (9=C2=A0 << DF_BYTE), p=
wd->b[9],=C2=A0 oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (10 << DF_BYTE), pwd->b=
[10], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (11 << DF_BYTE), pwd->b=
[11], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (12 << DF_BYTE), pwd->b=
[12], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (13 << DF_BYTE), pwd->b=
[13], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (14 << DF_BYTE), pwd->b=
[14], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (15 << DF_BYTE), pwd->b=
[15], oi,=20
> GETPC());
> > +#else
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (7=C2=A0 << DF_BYTE), p=
wd->b[0],=C2=A0 oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (6=C2=A0 << DF_BYTE), p=
wd->b[1],=C2=A0 oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (5=C2=A0 << DF_BYTE), p=
wd->b[2],=C2=A0 oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (4=C2=A0 << DF_BYTE), p=
wd->b[3],=C2=A0 oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (3=C2=A0 << DF_BYTE), p=
wd->b[4],=C2=A0 oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (2=C2=A0 << DF_BYTE), p=
wd->b[5],=C2=A0 oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (1=C2=A0 << DF_BYTE), p=
wd->b[6],=C2=A0 oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (0=C2=A0 << DF_BYTE), p=
wd->b[7],=C2=A0 oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (15 << DF_BYTE), pwd->b=
[8],=C2=A0 oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (14 << DF_BYTE), pwd->b=
[9],=C2=A0 oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (13 << DF_BYTE), pwd->b=
[10], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (12 << DF_BYTE), pwd->b=
[11], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (11 << DF_BYTE), pwd->b=
[12], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (10 << DF_BYTE), pwd->b=
[13], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (9=C2=A0 << DF_BYTE), p=
wd->b[14], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + (8=C2=A0 << DF_BYTE), p=
wd->b[15], oi,=20
> GETPC());
> > +#endif
> > +#else
> > +#if !defined(HOST_WORDS_BIGENDIAN)
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (0=C2=A0 << DF_BYTE), pwd->b[=
0]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (1=C2=A0 << DF_BYTE), pwd->b[=
1]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (2=C2=A0 << DF_BYTE), pwd->b[=
2]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (3=C2=A0 << DF_BYTE), pwd->b[=
3]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (4=C2=A0 << DF_BYTE), pwd->b[=
4]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (5=C2=A0 << DF_BYTE), pwd->b[=
5]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (6=C2=A0 << DF_BYTE), pwd->b[=
6]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (7=C2=A0 << DF_BYTE), pwd->b[=
7]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (8=C2=A0 << DF_BYTE), pwd->b[=
8]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (9=C2=A0 << DF_BYTE), pwd->b[=
9]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (10 << DF_BYTE), pwd->b[10]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (11 << DF_BYTE), pwd->b[11]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (12 << DF_BYTE), pwd->b[12]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (13 << DF_BYTE), pwd->b[13]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (14 << DF_BYTE), pwd->b[14]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (15 << DF_BYTE), pwd->b[15]);
> > +#else
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (7=C2=A0 << DF_BYTE), pwd->b[=
0]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (6=C2=A0 << DF_BYTE), pwd->b[=
1]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (5=C2=A0 << DF_BYTE), pwd->b[=
2]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (4=C2=A0 << DF_BYTE), pwd->b[=
3]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (3=C2=A0 << DF_BYTE), pwd->b[=
4]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (2=C2=A0 << DF_BYTE), pwd->b[=
5]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (1=C2=A0 << DF_BYTE), pwd->b[=
6]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (0=C2=A0 << DF_BYTE), pwd->b[=
7]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (15 << DF_BYTE), pwd->b[8]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (14 << DF_BYTE), pwd->b[9]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (13 << DF_BYTE), pwd->b[10]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (12 << DF_BYTE), pwd->b[11]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (11 << DF_BYTE), pwd->b[12]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (10 << DF_BYTE), pwd->b[13]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (9=C2=A0 << DF_BYTE), pwd->b[=
14]);
> > +=C2=A0 =C2=A0 cpu_stb_data(env, addr + (8=C2=A0 << DF_BYTE), pwd->b[=
15]);
> > +#endif
> > +#endif
> > +}
> > +
> > +void helper_msa_st_h(CPUMIPSState *env, uint32_t wd,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0target_ulong addr)
> > +{
> > +=C2=A0 =C2=A0 wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
> > +=C2=A0 =C2=A0 MEMOP_IDX(DF_HALF)
> > +#if !defined(CONFIG_USER_ONLY)
> > +#if !defined(HOST_WORDS_BIGENDIAN)
> > +=C2=A0 =C2=A0 helper_ret_stw_mmu(env, addr + (0 << DF_HALF), pwd->h[=
0], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stw_mmu(env, addr + (1 << DF_HALF), pwd->h[=
1], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stw_mmu(env, addr + (2 << DF_HALF), pwd->h[=
2], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stw_mmu(env, addr + (3 << DF_HALF), pwd->h[=
3], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stw_mmu(env, addr + (4 << DF_HALF), pwd->h[=
4], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stw_mmu(env, addr + (5 << DF_HALF), pwd->h[=
5], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stw_mmu(env, addr + (6 << DF_HALF), pwd->h[=
6], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stw_mmu(env, addr + (7 << DF_HALF), pwd->h[=
7], oi,=20
> GETPC());
> > +#else
> > +=C2=A0 =C2=A0 helper_ret_stw_mmu(env, addr + (3 << DF_HALF), pwd->h[=
0], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stw_mmu(env, addr + (2 << DF_HALF), pwd->h[=
1], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stw_mmu(env, addr + (1 << DF_HALF), pwd->h[=
2], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stw_mmu(env, addr + (0 << DF_HALF), pwd->h[=
3], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stw_mmu(env, addr + (7 << DF_HALF), pwd->h[=
4], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stw_mmu(env, addr + (6 << DF_HALF), pwd->h[=
5], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stw_mmu(env, addr + (5 << DF_HALF), pwd->h[=
6], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stw_mmu(env, addr + (4 << DF_HALF), pwd->h[=
7], oi,=20
> GETPC());
> > +#endif
> > +#else
> > +#if !defined(HOST_WORDS_BIGENDIAN)
> > +=C2=A0 =C2=A0 cpu_stw_data(env, addr + (0 << DF_HALF), pwd->h[0]);
> > +=C2=A0 =C2=A0 cpu_stw_data(env, addr + (1 << DF_HALF), pwd->h[1]);
> > +=C2=A0 =C2=A0 cpu_stw_data(env, addr + (2 << DF_HALF), pwd->h[2]);
> > +=C2=A0 =C2=A0 cpu_stw_data(env, addr + (3 << DF_HALF), pwd->h[3]);
> > +=C2=A0 =C2=A0 cpu_stw_data(env, addr + (4 << DF_HALF), pwd->h[4]);
> > +=C2=A0 =C2=A0 cpu_stw_data(env, addr + (5 << DF_HALF), pwd->h[5]);
> > +=C2=A0 =C2=A0 cpu_stw_data(env, addr + (6 << DF_HALF), pwd->h[6]);
> > +=C2=A0 =C2=A0 cpu_stw_data(env, addr + (7 << DF_HALF), pwd->h[7]);
> > +#else
> > +=C2=A0 =C2=A0 cpu_stw_data(env, addr + (3 << DF_HALF), pwd->h[0]);
> > +=C2=A0 =C2=A0 cpu_stw_data(env, addr + (2 << DF_HALF), pwd->h[1]);
> > +=C2=A0 =C2=A0 cpu_stw_data(env, addr + (1 << DF_HALF), pwd->h[2]);
> > +=C2=A0 =C2=A0 cpu_stw_data(env, addr + (0 << DF_HALF), pwd->h[3]);
> > +=C2=A0 =C2=A0 cpu_stw_data(env, addr + (7 << DF_HALF), pwd->h[4]);
> > +=C2=A0 =C2=A0 cpu_stw_data(env, addr + (6 << DF_HALF), pwd->h[5]);
> > +=C2=A0 =C2=A0 cpu_stw_data(env, addr + (5 << DF_HALF), pwd->h[6]);
> > +=C2=A0 =C2=A0 cpu_stw_data(env, addr + (4 << DF_HALF), pwd->h[7]);
> > +#endif
> > +#endif
> > =C2=A0}
> >
> > +void helper_msa_st_w(CPUMIPSState *env, uint32_t wd,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0target_ulong addr)
> > +{
> > +=C2=A0 =C2=A0 wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
> > +=C2=A0 =C2=A0 MEMOP_IDX(DF_WORD)
> > =C2=A0#if !defined(CONFIG_USER_ONLY)
> > -MSA_ST_DF(DF_BYTE,=C2=A0 =C2=A0b, helper_ret_stb_mmu, oi, GETPC())
> > -MSA_ST_DF(DF_HALF,=C2=A0 =C2=A0h, helper_ret_stw_mmu, oi, GETPC())
> > -MSA_ST_DF(DF_WORD,=C2=A0 =C2=A0w, helper_ret_stl_mmu, oi, GETPC())
> > -MSA_ST_DF(DF_DOUBLE, d, helper_ret_stq_mmu, oi, GETPC())
> > +#if !defined(HOST_WORDS_BIGENDIAN)
> > +=C2=A0 =C2=A0 helper_ret_stl_mmu(env, addr + (0 << DF_WORD), oi, GET=
PC(),=20
> pwd->w[0]);
> > +=C2=A0 =C2=A0 helper_ret_stl_mmu(env, addr + (1 << DF_WORD), oi, GET=
PC(),=20
> pwd->w[1]);
> > +=C2=A0 =C2=A0 helper_ret_stl_mmu(env, addr + (2 << DF_WORD), oi, GET=
PC(),=20
> pwd->w[2]);
> > +=C2=A0 =C2=A0 helper_ret_stl_mmu(env, addr + (3 << DF_WORD), oi, GET=
PC(),=20
> pwd->w[3]);
> > =C2=A0#else
> > -MSA_ST_DF(DF_BYTE,=C2=A0 =C2=A0b, cpu_stb_data)
> > -MSA_ST_DF(DF_HALF,=C2=A0 =C2=A0h, cpu_stw_data)
> > -MSA_ST_DF(DF_WORD,=C2=A0 =C2=A0w, cpu_stl_data)
> > -MSA_ST_DF(DF_DOUBLE, d, cpu_stq_data)
> > +=C2=A0 =C2=A0 helper_ret_stl_mmu(env, addr + (1 << DF_WORD), oi, GET=
PC(),=20
> pwd->w[0]);
> > +=C2=A0 =C2=A0 helper_ret_stl_mmu(env, addr + (0 << DF_WORD), oi, GET=
PC(),=20
> pwd->w[1]);
> > +=C2=A0 =C2=A0 helper_ret_stl_mmu(env, addr + (3 << DF_WORD), oi, GET=
PC(),=20
> pwd->w[2]);
> > +=C2=A0 =C2=A0 helper_ret_stl_mmu(env, addr + (2 << DF_WORD), oi, GET=
PC(),=20
> pwd->w[3]);
> > =C2=A0#endif
> > +#else
> > +#if !defined(HOST_WORDS_BIGENDIAN)
> > +=C2=A0 =C2=A0 cpu_stl_data(env, addr + (0 << DF_WORD), pwd->w[0]);
> > +=C2=A0 =C2=A0 cpu_stl_data(env, addr + (1 << DF_WORD), pwd->w[1]);
> > +=C2=A0 =C2=A0 cpu_stl_data(env, addr + (2 << DF_WORD), pwd->w[2]);
> > +=C2=A0 =C2=A0 cpu_stl_data(env, addr + (3 << DF_WORD), pwd->w[3]);
> > +#else
> > +=C2=A0 =C2=A0 cpu_stl_data(env, addr + (1 << DF_WORD), pwd->w[0]);
> > +=C2=A0 =C2=A0 cpu_stl_data(env, addr + (0 << DF_WORD), pwd->w[1]);
> > +=C2=A0 =C2=A0 cpu_stl_data(env, addr + (3 << DF_WORD), pwd->w[2]);
> > +=C2=A0 =C2=A0 cpu_stl_data(env, addr + (2 << DF_WORD), pwd->w[3]);
> > +#endif
> > +#endif
> > +}
> > +
> > +void helper_msa_st_d(CPUMIPSState *env, uint32_t wd,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0target_ulong addr)
> > +{
> > +=C2=A0 =C2=A0 wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
> > +=C2=A0 =C2=A0 MEMOP_IDX(DF_DOUBLE)
> > +#if !defined(CONFIG_USER_ONLY)
> > +=C2=A0 =C2=A0 helper_ret_stq_mmu(env, addr + (0 << DF_DOUBLE), pwd->=
d[0], oi,=20
> GETPC());
> > +=C2=A0 =C2=A0 helper_ret_stq_mmu(env, addr + (1 << DF_DOUBLE), pwd->=
d[1], oi,=20
> GETPC());
> > +#else
> > +=C2=A0 =C2=A0 cpu_stq_data(env, addr + (0 << DF_DOUBLE), pwd->d[0]);
> > +=C2=A0 =C2=A0 cpu_stq_data(env, addr + (1 << DF_DOUBLE), pwd->d[1]);
> > +#endif
> > +}
> >
> > =C2=A0void helper_cache(CPUMIPSState *env, target_ulong addr, uint32_=
t op)
> > =C2=A0{
> > --
> > 2.7.4
> >
> >
>
