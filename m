Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFB2C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 00:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BDAA217D4
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 00:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oC6tbW9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDAA217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33150 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCChk-0008UU-2R
	for qemu-devel@archiver.kernel.org; Thu, 04 Apr 2019 20:27:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hCCgS-0007jg-Ev
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 20:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hCCgN-0004ID-RO
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 20:26:16 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:45131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hCCgN-0004FK-Aw
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 20:26:11 -0400
Received: by mail-ot1-x32a.google.com with SMTP id e5so4056877otk.12
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 17:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=VXCs7j6bmcvOcj08Ujk48bqH4VdlMOvYGLpcfHHD9Ok=;
	b=oC6tbW9qB2nQ1Os6Nbt+MJxT6cLC6xiIuFVr1RMRnjGOCXg0u3FvrMzjZDGTG2iZua
	AKcWdKghFG823hi4N8N0whAW3Nd5Hm/IwBhC/p0dx6D8kC2XEhMC4d2xkZ/wX8llJpSV
	f4V5KUuS2pSI2dlHsKuwEWbKwEGDdPGpauzvkJJ3IkORMA8if6HkRbps4Lm43OTy+L6H
	+7UOLFLZSYG42xGbs94VXfPVATofXtyD2U94Vj45AGxs3YAbvFjHHPVII46ef7eU9CGb
	KnC804dEcwRsY0qgoXuKJXZr9E6fhPrm+dUr5dAVQUBlGVtJ509y8USplsLOWrargI5t
	VSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=VXCs7j6bmcvOcj08Ujk48bqH4VdlMOvYGLpcfHHD9Ok=;
	b=tidb+6n+XmRZgHsxDg0G1+AFpLk06fUq8umP/+5JJnE2bXuK9bZ9ScQ/DSikGBmC/m
	6aLyNY+50xa6Z6gp9oGQ5+lqfnO+7ZaeG5Ivko5Xf4u//9m0irQOPqQB9k3+0/3m1Oln
	J0ZojkdWEVe8vqBAS/0/5Y1jb7ZYzcVJ6EFw4ojLXFEJ3taQEvelp3zhKfrXeS5JQgaW
	fZgavAsSljfGkTxGJfTqwUs8avcVSjyLCMYcxxQchPLMUsH7dTszQRRB313TVX0ZewA8
	4eyhKcAXA1yf3C9Dg04n3TAi7GOq+Bm4yfu+SW88h3sViB3nwJ6KkDypkPVxrk2kPjxX
	Llxg==
X-Gm-Message-State: APjAAAURYVIzEtBu1NQk7tb2Mzu6uizxBrXq4Xey7kEZ+H6K8OQtQdtW
	nNcJqVX2Q30Dee1DF154mztj0yyAWlN/NZrIc5k=
X-Google-Smtp-Source: APXvYqwyDHdvSfwPbbMEY5i5HYT3hnud+HBZQkIP9oqvdhwomYy0Cpaj2479OH9Hgx2i7hkHWbR/4uYV7koDDCFIaOc=
X-Received: by 2002:a05:6830:1342:: with SMTP id
	r2mr6779738otq.105.1554423968614; 
	Thu, 04 Apr 2019 17:26:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:220e:0:0:0:0:0 with HTTP;
	Thu, 4 Apr 2019 17:26:07 -0700 (PDT)
Received: by 2002:a9d:220e:0:0:0:0:0 with HTTP;
	Thu, 4 Apr 2019 17:26:07 -0700 (PDT)
In-Reply-To: <0d428692-d478-9c03-8416-ced9700f995c@redhat.com>
References: <1554383690-28338-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554383690-28338-3-git-send-email-mateja.marjanovic@rt-rk.com>
	<e0e8ff46-2fa8-e0ce-8699-2cec076695d1@redhat.com>
	<BN6PR2201MB12518B6A27D666DE96C5E30BC6500@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<0d428692-d478-9c03-8416-ced9700f995c@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 5 Apr 2019 02:26:07 +0200
Message-ID:
 <CAL1e-=gJM7rk+Agz4vMFQJeGO2wD-w=donev4D0Oqs+BtRmXkQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v6 2/4] target/mips: Optimize
 ILVEV.<B|H|W|D> MSA instructions
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
	"richard.henderson@linaro.org" <richard.henderson@linaro.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Mateja Marjanovic <mateja.marjanovic@rt-rk.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	"aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405002607.2H9m2swEr8KMKdkXKikxm80Z9NzJhXIAghXK-cibmBk@z>

On Apr 4, 2019 9:17 PM, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> w=
rote:
>
> Hi Aleksandar,
>
> On 4/4/19 8:19 PM, Aleksandar Markovic wrote:
> >> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >> Subject: Re: [PATCH v6 2/4] target/mips: Optimize ILVEV.<B|H|W|D> MSA
instructions
> >>
> >> Hi Mateja,
> >>
> >> On 4/4/19 3:14 PM, Mateja Marjanovic wrote:
> >>> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
> >>>
> >>> Optimize set of MSA instructions ILVEV.<B|H|W|D>, using
> >>> directly tcg registers and performing logic on them
> >>> instead of using helpers.
> >>>
> >>> In the following table, the first column is the performance
> >>> before this patch. The second represents the performance,
> >>> after converting from helpers to tcg, but without using
> >>> tcg_gen_deposit function. The third one is the solution
> >>> which is implemented in this patch.
> >>>
> >>> Performance measurement is done by executing the
> >>> instructions a large number of times on a computer
> >>> with Intel Core i7-3770 CPU @ 3.40GHz=C3=978.
> >>>
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> || instr    ||   before    || no-deposit ||  with-deposit ||
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> || ilvev.b  ||  126.92 ms  ||  24.52 ms  ||   24.43 ms    ||
> >>> || ilvev.h  ||   93.67 ms  ||  23.92 ms  ||   23.86 ms    ||
> >>
> >> I'm quite surprised there is not a single change here since your v5,
are
> >> you sure you used the correct result? I was expecting a slighly
improvement.
> >>
> >
> > Hello, Philippe.
> >
> > First of all, thank you so much for taking your time to provide
> > Matejan with the source code below.
> >
> > Speaking about your idea, Mateja told me he DID implemented it,
> > and did measurements, and that the improvement is noticeable,
> > but really small. I don't know why he did not include that change
> > - perhaps he didn't have enough time to integrate it.
> >
> > I know he is on a long weekend now, so we will have to wait for
> > the next week for Mateja to explain this to us. Mateja, could you
> > perhaps add a column "with-deposit-and-mask-as-tcg-constant"?
>
> Ah OK, no worries since this series will enter in the 4.1 dev cycle and
> there is still 2/3 weeks to go.
> I am simply curious to see the difference using the register approach :)
> I recently noticed I can run those tests myself (I previously mixed
> threads and thought Mateja was running this on a FPGA).
>

The problem with the test procedure and results that are presented here is
that their accuracy is very small if the emulation of the instruction under
measurement is fast. The source code is just 10,000,000 single MIPS
instruction executions in a C for loop, and that is all nice and dendy if
the emulation of that instruction dominates over for loop overhead, in
terms of emulation time. But for instructions that are emulated fast, we
are measuring more loop overhead than instruction itself.

Actually, the numbers inthat area (under let=CB=8As say 25 ms) are plain
misleading.

I think we need to devise better test, and update the table in the commit
message with the new results that will be closer to the reality - and hence
more informative and valuable.

BTW, I came to the conclusion that there is no faster emulation for special
cases when two or three operands are the same, so those cases will not be
singled out.

Aleksandar

> I try to have a quick look at your work, and I'm pleased to see how
> Mateja improves the quality/accuracy of each series.
>
> Regards,
>
> Phil.
>
> > Yours,
> > Aleksandar
> >
> >
> >>> || ilvev.w  ||  117.86 ms  ||  23.83 ms  ||   22.17 ms    ||
> >>> || ilvev.d  ||   45.49 ms  ||  19.74 ms  ||   19.71 ms    ||
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>
> >>> No-deposit column and with-deposit column have the
> >>> same statistical values in every row, except ILVEV.W,
> >>> which is the only function which uses the deposit
> >>> function.
> >>>
> >>> No-deposit version of the ILVEV.W implementation:
> >>>
> >>> static inline void gen_ilvev_w(CPUMIPSState *env, uint32_t wd,
> >>>                                uint32_t ws, uint32_t wt)
> >>> {
> >>>     TCGv_i64 t1 =3D tcg_temp_new_i64();
> >>>     TCGv_i64 t2 =3D tcg_temp_new_i64();
> >>>     uint64_t mask =3D 0x00000000ffffffffULL;
> >>>
> >>>     tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
> >>>     tcg_gen_andi_i64(t2, msa_wr_d[ws * 2], mask);
> >>>     tcg_gen_shli_i64(t2, t2, 32);
> >>>     tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
> >>>
> >>>     tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> >>>     tcg_gen_andi_i64(t2, msa_wr_d[ws * 2 + 1], mask);
> >>>     tcg_gen_shli_i64(t2, t2, 32);
> >>>     tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
> >>>
> >>>     tcg_temp_free_i64(t1);
> >>>     tcg_temp_free_i64(t2);
> >>> }
> >>>
> >>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> >>> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> >>> ---
> >>>  target/mips/helper.h     |   1 -
> >>>  target/mips/msa_helper.c |   9 -----
> >>>  target/mips/translate.c  | 101
++++++++++++++++++++++++++++++++++++++++++++++-
> >>>  3 files changed, 100 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/target/mips/helper.h b/target/mips/helper.h
> >>> index 02e16c7..82f6a40 100644
> >>> --- a/target/mips/helper.h
> >>> +++ b/target/mips/helper.h
> >>> @@ -864,7 +864,6 @@ DEF_HELPER_5(msa_pckev_df, void, env, i32, i32,
i32, i32)
> >>>  DEF_HELPER_5(msa_pckod_df, void, env, i32, i32, i32, i32)
> >>>  DEF_HELPER_5(msa_ilvl_df, void, env, i32, i32, i32, i32)
> >>>  DEF_HELPER_5(msa_ilvr_df, void, env, i32, i32, i32, i32)
> >>> -DEF_HELPER_5(msa_ilvev_df, void, env, i32, i32, i32, i32)
> >>>  DEF_HELPER_5(msa_vshf_df, void, env, i32, i32, i32, i32)
> >>>  DEF_HELPER_5(msa_srar_df, void, env, i32, i32, i32, i32)
> >>>  DEF_HELPER_5(msa_srlr_df, void, env, i32, i32, i32, i32)
> >>> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> >>> index a7ea6aa..d5c3842 100644
> >>> --- a/target/mips/msa_helper.c
> >>> +++ b/target/mips/msa_helper.c
> >>> @@ -1197,15 +1197,6 @@ MSA_FN_DF(ilvl_df)
> >>>      } while (0)
> >>>  MSA_FN_DF(ilvr_df)
> >>>  #undef MSA_DO
> >>> -
> >>> -#define MSA_DO(DF)                      \
> >>> -    do {                                \
> >>> -        pwx->DF[2*i]   =3D pwt->DF[2*i];  \
> >>> -        pwx->DF[2*i+1] =3D pws->DF[2*i];  \
> >>> -    } while (0)
> >>> -MSA_FN_DF(ilvev_df)
> >>> -#undef MSA_DO
> >>> -
> >>>  #undef MSA_LOOP_COND
> >>>
> >>>  #define MSA_LOOP_COND(DF) \
> >>> diff --git a/target/mips/translate.c b/target/mips/translate.c
> >>> index df685e4..3057669 100644
> >>> --- a/target/mips/translate.c
> >>> +++ b/target/mips/translate.c
> >>> @@ -28973,6 +28973,90 @@ static inline void gen_ilvod_d(CPUMIPSState
*env, uint32_t wd,
> >>>      tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2 + 1]);
> >>>  }
> >>>
> >>> +/*
> >>> + * [MSA] ILVEV.B wd, ws, wt
> >>> + *
> >>> + *   Vector Interleave Even (byte data elements)
> >>> + *
> >>> + */
> >>> +static inline void gen_ilvev_b(CPUMIPSState *env, uint32_t wd,
> >>> +                               uint32_t ws, uint32_t wt)
> >>> +{
> >>> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> >>> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
> >>> +    TCGv_i64 mask =3D tcg_const_i64(0x00ff00ff00ff00ffULL);
> >>> +
> >>> +    tcg_gen_and_i64(t1, msa_wr_d[wt * 2], mask);
> >>> +    tcg_gen_and_i64(t2, msa_wr_d[ws * 2], mask);
> >>> +    tcg_gen_shli_i64(t2, t2, 8);
> >>> +    tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
> >>> +
> >>> +    tcg_gen_and_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> >>> +    tcg_gen_and_i64(t2, msa_wr_d[ws * 2 + 1], mask);
> >>> +    tcg_gen_shli_i64(t2, t2, 8);
> >>> +    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
> >>> +
> >>> +    tcg_temp_free_i64(mask);
> >>> +    tcg_temp_free_i64(t1);
> >>> +    tcg_temp_free_i64(t2);
> >>> +}
> >>> +
> >>> +/*
> >>> + * [MSA] ILVEV.H wd, ws, wt
> >>> + *
> >>> + *   Vector Interleave Even (halfword data elements)
> >>> + *
> >>> + */
> >>> +static inline void gen_ilvev_h(CPUMIPSState *env, uint32_t wd,
> >>> +                               uint32_t ws, uint32_t wt)
> >>> +{
> >>> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> >>> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
> >>> +    TCGv_i64 mask =3D tcg_const_i64(0x0000ffff0000ffffULL);
> >>> +
> >>> +    tcg_gen_and_i64(t1, msa_wr_d[wt * 2], mask);
> >>> +    tcg_gen_and_i64(t2, msa_wr_d[ws * 2], mask);
> >>> +    tcg_gen_shli_i64(t2, t2, 16);
> >>> +    tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
> >>> +
> >>> +    tcg_gen_and_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> >>> +    tcg_gen_and_i64(t2, msa_wr_d[ws * 2 + 1], mask);
> >>> +    tcg_gen_shli_i64(t2, t2, 16);
> >>> +    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
> >>> +
> >>> +    tcg_temp_free_i64(mask);
> >>> +    tcg_temp_free_i64(t1);
> >>> +    tcg_temp_free_i64(t2);
> >>> +}
> >>
> >> Apparently you missed my comment about refactoring using mask/shift as
> >> arguments:
> >>
> >> static inline void gen_ilvev_hb(CPUMIPSState *env, uint32_t wd,
> >>                                 uint32_t ws, uint32_t wt,
> >>                                 int64_t mask, int64_t shift)
> >> {
> >>     TCGv_i64 t1 =3D tcg_temp_new_i64();
> >>     TCGv_i64 t2 =3D tcg_temp_new_i64();
> >>     TCGv_i64 tm =3D tcg_const_i64(mask);
> >>
> >>     tcg_gen_and_i64(t1, msa_wr_d[wt * 2], tm);
> >>     tcg_gen_and_i64(t2, msa_wr_d[ws * 2], tm);
> >>     tcg_gen_shli_i64(t2, t2, shift);
> >>     tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
> >>
> >>     tcg_gen_and_i64(t1, msa_wr_d[wt * 2 + 1], tm);
> >>     tcg_gen_and_i64(t2, msa_wr_d[ws * 2 + 1], tm);
> >>     tcg_gen_shli_i64(t2, t2, shift);
> >>     tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
> >>
> >>     tcg_temp_free_i64(tm);
> >>     tcg_temp_free_i64(t1);
> >>     tcg_temp_free_i64(t2);
> >> }
> >>
> >> static inline void gen_ilvev_b(CPUMIPSState *env, uint32_t wd,
> >>                                uint32_t ws, uint32_t wt)
> >> {
> >>     gen_ilvev_hb(env, wd, ws, wt, 0x00ff00ff00ff00ffLL, 8);
> >> }
> >>
> >> static inline void gen_ilvev_h(CPUMIPSState *env, uint32_t wd,
> >>                                uint32_t ws, uint32_t wt)
> >> {
> >>     gen_ilvev_hb(env, wd, ws, wt, 0x0000ffff0000ffffLL, 16);
> >> }
> >>
> >>
> >>> +
> >>> +/*
> >>> + * [MSA] ILVEV.W wd, ws, wt
> >>> + *
> >>> + *   Vector Interleave Even (word data elements)
> >>> + *
> >>> + */
> >>> +static inline void gen_ilvev_w(CPUMIPSState *env, uint32_t wd,
> >>> +                               uint32_t ws, uint32_t wt)
> >>> +{
> >>> +    tcg_gen_deposit_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2],
> >>> +                        msa_wr_d[ws * 2], 32, 32);
> >>> +    tcg_gen_deposit_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[wt * 2 + 1],
> >>> +                        msa_wr_d[ws * 2 + 1], 32, 32);
> >>> +}
> >>> +
> >>> +/*
> >>> + * [MSA] ILVEV.D wd, ws, wt
> >>> + *
> >>> + *   Vector Interleave Even (Doubleword data elements)
> >>> + *
> >>> + */
> >>> +static inline void gen_ilvev_d(CPUMIPSState *env, uint32_t wd,
> >>> +                               uint32_t ws, uint32_t wt)
> >>> +{
> >>> +    tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2]);
> >>> +    tcg_gen_mov_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2]);
> >>> +}
> >>> +
> >>>  static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
> >>>  {
> >>>  #define MASK_MSA_3R(op)    (MASK_MSA_MINOR(op) | (op & (0x7 << 23)))
> >>> @@ -29129,7 +29213,22 @@ static void gen_msa_3r(CPUMIPSState *env,
DisasContext *ctx)
> >>>          gen_helper_msa_mod_s_df(cpu_env, tdf, twd, tws, twt);
> >>>          break;
> >>>      case OPC_ILVEV_df:
> >>> -        gen_helper_msa_ilvev_df(cpu_env, tdf, twd, tws, twt);
> >>> +        switch (df) {
> >>> +        case DF_BYTE:
> >>> +            gen_ilvev_b(env, wd, ws, wt);
> >>> +            break;
> >>> +        case DF_HALF:
> >>> +            gen_ilvev_h(env, wd, ws, wt);
> >>> +            break;
> >>> +        case DF_WORD:
> >>> +            gen_ilvev_w(env, wd, ws, wt);
> >>> +            break;
> >>> +        case DF_DOUBLE:
> >>> +            gen_ilvev_d(env, wd, ws, wt);
> >>> +            break;
> >>> +        default:
> >>> +            assert(0);
> >>> +        }
> >>>          break;
> >>>      case OPC_BINSR_df:
> >>>          gen_helper_msa_binsr_df(cpu_env, tdf, twd, tws, twt);
> >>>
> >>
> > ________________________________________
> > From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Sent: Thursday, April 4, 2019 3:42 PM
> > To: Mateja Marjanovic; qemu-devel@nongnu.org
> > Cc: aurelien@aurel32.net; richard.henderson@linaro.org; Aleksandar
Markovic; Aleksandar Rikalo
> > Subject: Re: [PATCH v6 2/4] target/mips: Optimize ILVEV.<B|H|W|D> MSA
instructions
> >
> > Hi Mateja,
> >
> > On 4/4/19 3:14 PM, Mateja Marjanovic wrote:
> >> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
> >>
> >> Optimize set of MSA instructions ILVEV.<B|H|W|D>, using
> >> directly tcg registers and performing logic on them
> >> instead of using helpers.
> >>
> >> In the following table, the first column is the performance
> >> before this patch. The second represents the performance,
> >> after converting from helpers to tcg, but without using
> >> tcg_gen_deposit function. The third one is the solution
> >> which is implemented in this patch.
> >>
> >> Performance measurement is done by executing the
> >> instructions a large number of times on a computer
> >> with Intel Core i7-3770 CPU @ 3.40GHz=C3=978.
> >>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> || instr    ||   before    || no-deposit ||  with-deposit ||
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> || ilvev.b  ||  126.92 ms  ||  24.52 ms  ||   24.43 ms    ||
> >> || ilvev.h  ||   93.67 ms  ||  23.92 ms  ||   23.86 ms    ||
> >
> > I'm quite surprised there is not a single change here since your v5, ar=
e
> > you sure you used the correct result? I was expecting a slighly
improvement.
> >
> >> || ilvev.w  ||  117.86 ms  ||  23.83 ms  ||   22.17 ms    ||
> >> || ilvev.d  ||   45.49 ms  ||  19.74 ms  ||   19.71 ms    ||
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> No-deposit column and with-deposit column have the
> >> same statistical values in every row, except ILVEV.W,
> >> which is the only function which uses the deposit
> >> function.
> >>
> >> No-deposit version of the ILVEV.W implementation:
> >>
> >> static inline void gen_ilvev_w(CPUMIPSState *env, uint32_t wd,
> >>                                uint32_t ws, uint32_t wt)
> >> {
> >>     TCGv_i64 t1 =3D tcg_temp_new_i64();
> >>     TCGv_i64 t2 =3D tcg_temp_new_i64();
> >>     uint64_t mask =3D 0x00000000ffffffffULL;
> >>
> >>     tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
> >>     tcg_gen_andi_i64(t2, msa_wr_d[ws * 2], mask);
> >>     tcg_gen_shli_i64(t2, t2, 32);
> >>     tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
> >>
> >>     tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> >>     tcg_gen_andi_i64(t2, msa_wr_d[ws * 2 + 1], mask);
> >>     tcg_gen_shli_i64(t2, t2, 32);
> >>     tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
> >>
> >>     tcg_temp_free_i64(t1);
> >>     tcg_temp_free_i64(t2);
> >> }
> >>
> >> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> >> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> >> ---
> >>  target/mips/helper.h     |   1 -
> >>  target/mips/msa_helper.c |   9 -----
> >>  target/mips/translate.c  | 101
++++++++++++++++++++++++++++++++++++++++++++++-
> >>  3 files changed, 100 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/target/mips/helper.h b/target/mips/helper.h
> >> index 02e16c7..82f6a40 100644
> >> --- a/target/mips/helper.h
> >> +++ b/target/mips/helper.h
> >> @@ -864,7 +864,6 @@ DEF_HELPER_5(msa_pckev_df, void, env, i32, i32,
i32, i32)
> >>  DEF_HELPER_5(msa_pckod_df, void, env, i32, i32, i32, i32)
> >>  DEF_HELPER_5(msa_ilvl_df, void, env, i32, i32, i32, i32)
> >>  DEF_HELPER_5(msa_ilvr_df, void, env, i32, i32, i32, i32)
> >> -DEF_HELPER_5(msa_ilvev_df, void, env, i32, i32, i32, i32)
> >>  DEF_HELPER_5(msa_vshf_df, void, env, i32, i32, i32, i32)
> >>  DEF_HELPER_5(msa_srar_df, void, env, i32, i32, i32, i32)
> >>  DEF_HELPER_5(msa_srlr_df, void, env, i32, i32, i32, i32)
> >> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> >> index a7ea6aa..d5c3842 100644
> >> --- a/target/mips/msa_helper.c
> >> +++ b/target/mips/msa_helper.c
> >> @@ -1197,15 +1197,6 @@ MSA_FN_DF(ilvl_df)
> >>      } while (0)
> >>  MSA_FN_DF(ilvr_df)
> >>  #undef MSA_DO
> >> -
> >> -#define MSA_DO(DF)                      \
> >> -    do {                                \
> >> -        pwx->DF[2*i]   =3D pwt->DF[2*i];  \
> >> -        pwx->DF[2*i+1] =3D pws->DF[2*i];  \
> >> -    } while (0)
> >> -MSA_FN_DF(ilvev_df)
> >> -#undef MSA_DO
> >> -
> >>  #undef MSA_LOOP_COND
> >>
> >>  #define MSA_LOOP_COND(DF) \
> >> diff --git a/target/mips/translate.c b/target/mips/translate.c
> >> index df685e4..3057669 100644
> >> --- a/target/mips/translate.c
> >> +++ b/target/mips/translate.c
> >> @@ -28973,6 +28973,90 @@ static inline void gen_ilvod_d(CPUMIPSState
*env, uint32_t wd,
> >>      tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2 + 1]);
> >>  }
> >>
> >> +/*
> >> + * [MSA] ILVEV.B wd, ws, wt
> >> + *
> >> + *   Vector Interleave Even (byte data elements)
> >> + *
> >> + */
> >> +static inline void gen_ilvev_b(CPUMIPSState *env, uint32_t wd,
> >> +                               uint32_t ws, uint32_t wt)
> >> +{
> >> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> >> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
> >> +    TCGv_i64 mask =3D tcg_const_i64(0x00ff00ff00ff00ffULL);
> >> +
> >> +    tcg_gen_and_i64(t1, msa_wr_d[wt * 2], mask);
> >> +    tcg_gen_and_i64(t2, msa_wr_d[ws * 2], mask);
> >> +    tcg_gen_shli_i64(t2, t2, 8);
> >> +    tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
> >> +
> >> +    tcg_gen_and_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> >> +    tcg_gen_and_i64(t2, msa_wr_d[ws * 2 + 1], mask);
> >> +    tcg_gen_shli_i64(t2, t2, 8);
> >> +    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
> >> +
> >> +    tcg_temp_free_i64(mask);
> >> +    tcg_temp_free_i64(t1);
> >> +    tcg_temp_free_i64(t2);
> >> +}
> >> +
> >> +/*
> >> + * [MSA] ILVEV.H wd, ws, wt
> >> + *
> >> + *   Vector Interleave Even (halfword data elements)
> >> + *
> >> + */
> >> +static inline void gen_ilvev_h(CPUMIPSState *env, uint32_t wd,
> >> +                               uint32_t ws, uint32_t wt)
> >> +{
> >> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> >> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
> >> +    TCGv_i64 mask =3D tcg_const_i64(0x0000ffff0000ffffULL);
> >> +
> >> +    tcg_gen_and_i64(t1, msa_wr_d[wt * 2], mask);
> >> +    tcg_gen_and_i64(t2, msa_wr_d[ws * 2], mask);
> >> +    tcg_gen_shli_i64(t2, t2, 16);
> >> +    tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
> >> +
> >> +    tcg_gen_and_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> >> +    tcg_gen_and_i64(t2, msa_wr_d[ws * 2 + 1], mask);
> >> +    tcg_gen_shli_i64(t2, t2, 16);
> >> +    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
> >> +
> >> +    tcg_temp_free_i64(mask);
> >> +    tcg_temp_free_i64(t1);
> >> +    tcg_temp_free_i64(t2);
> >> +}
> >
> > Apparently you missed my comment about refactoring using mask/shift as
> > arguments:
> >
> > static inline void gen_ilvev_hb(CPUMIPSState *env, uint32_t wd,
> >                                 uint32_t ws, uint32_t wt,
> >                                 int64_t mask, int64_t shift)
> > {
> >     TCGv_i64 t1 =3D tcg_temp_new_i64();
> >     TCGv_i64 t2 =3D tcg_temp_new_i64();
> >     TCGv_i64 tm =3D tcg_const_i64(mask);
> >
> >     tcg_gen_and_i64(t1, msa_wr_d[wt * 2], tm);
> >     tcg_gen_and_i64(t2, msa_wr_d[ws * 2], tm);
> >     tcg_gen_shli_i64(t2, t2, shift);
> >     tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
> >
> >     tcg_gen_and_i64(t1, msa_wr_d[wt * 2 + 1], tm);
> >     tcg_gen_and_i64(t2, msa_wr_d[ws * 2 + 1], tm);
> >     tcg_gen_shli_i64(t2, t2, shift);
> >     tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
> >
> >     tcg_temp_free_i64(tm);
> >     tcg_temp_free_i64(t1);
> >     tcg_temp_free_i64(t2);
> > }
> >
> > static inline void gen_ilvev_b(CPUMIPSState *env, uint32_t wd,
> >                                uint32_t ws, uint32_t wt)
> > {
> >     gen_ilvev_hb(env, wd, ws, wt, 0x00ff00ff00ff00ffLL, 8);
> > }
> >
> > static inline void gen_ilvev_h(CPUMIPSState *env, uint32_t wd,
> >                                uint32_t ws, uint32_t wt)
> > {
> >     gen_ilvev_hb(env, wd, ws, wt, 0x0000ffff0000ffffLL, 16);
> > }
> >
> >
> >> +
> >> +/*
> >> + * [MSA] ILVEV.W wd, ws, wt
> >> + *
> >> + *   Vector Interleave Even (word data elements)
> >> + *
> >> + */
> >> +static inline void gen_ilvev_w(CPUMIPSState *env, uint32_t wd,
> >> +                               uint32_t ws, uint32_t wt)
> >> +{
> >> +    tcg_gen_deposit_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2],
> >> +                        msa_wr_d[ws * 2], 32, 32);
> >> +    tcg_gen_deposit_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[wt * 2 + 1],
> >> +                        msa_wr_d[ws * 2 + 1], 32, 32);
> >> +}
> >> +
> >> +/*
> >> + * [MSA] ILVEV.D wd, ws, wt
> >> + *
> >> + *   Vector Interleave Even (Doubleword data elements)
> >> + *
> >> + */
> >> +static inline void gen_ilvev_d(CPUMIPSState *env, uint32_t wd,
> >> +                               uint32_t ws, uint32_t wt)
> >> +{
> >> +    tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2]);
> >> +    tcg_gen_mov_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2]);
> >> +}
> >> +
> >>  static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
> >>  {
> >>  #define MASK_MSA_3R(op)    (MASK_MSA_MINOR(op) | (op & (0x7 << 23)))
> >> @@ -29129,7 +29213,22 @@ static void gen_msa_3r(CPUMIPSState *env,
DisasContext *ctx)
> >>          gen_helper_msa_mod_s_df(cpu_env, tdf, twd, tws, twt);
> >>          break;
> >>      case OPC_ILVEV_df:
> >> -        gen_helper_msa_ilvev_df(cpu_env, tdf, twd, tws, twt);
> >> +        switch (df) {
> >> +        case DF_BYTE:
> >> +            gen_ilvev_b(env, wd, ws, wt);
> >> +            break;
> >> +        case DF_HALF:
> >> +            gen_ilvev_h(env, wd, ws, wt);
> >> +            break;
> >> +        case DF_WORD:
> >> +            gen_ilvev_w(env, wd, ws, wt);
> >> +            break;
> >> +        case DF_DOUBLE:
> >> +            gen_ilvev_d(env, wd, ws, wt);
> >> +            break;
> >> +        default:
> >> +            assert(0);
> >> +        }
> >>          break;
> >>      case OPC_BINSR_df:
> >>          gen_helper_msa_binsr_df(cpu_env, tdf, twd, tws, twt);
> >>
>
