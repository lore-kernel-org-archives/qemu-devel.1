Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BEDC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 471CA206E9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snK8FDUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471CA206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsapZ-0000KE-Fh
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 19:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsaox-0008LJ-9x
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 19:46:47 -0400
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32]:39105)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsaov-0000j1-KH
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 19:46:47 -0400
Received: by mail-io1-xd32.google.com with SMTP id f23so41290212iof.6
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 16:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FjACi7xCLPCR115n8oEibjR0k6KI7oAUFaYgQlZBgf8=;
 b=snK8FDUo3Xkv+N7T4rFgXt88QxqaeisA2OgXIbxgh1ZYQV3rV+jUE1K/vtiKrwJTr+
 dU6tDx/p51Wqx7a36O9xm6f8mtrONAITIiDf/FOZ4ziR/pymGeNnPXiKKMiVEO/1vZmc
 EwDXFCv9/4kbZyt5aXXtwVTZtDkYgJlNeL/MTT3OChHVZ8TSo/Hi+R1VoHpJD1ov0A2v
 ctfP0sBrs1KsOK1bykn9XHb8J2km/foKWBDE7jfqcCQS6Z9qxvhkQNjobmflQKYfx9Pt
 ue1EH6oxEdbtEcMNoiA2CP4uWvUVzgx3kYUxhTRwtyPHEYhX/4IBmf7bW6YQ+t6KO1qD
 IyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FjACi7xCLPCR115n8oEibjR0k6KI7oAUFaYgQlZBgf8=;
 b=OJm9uP1fzQpLrMnVOh1CJe4mOR44YPffhQM0Fgpz7VmvrrgGLdTer0Z6noKWPg6NlA
 NrJaR/zgWxJqDec1KG9ZnTX1tG7+eZtUxJHNT8hMPSuGPaIkanauB42DDkGcKSRDaDWc
 8MdlUtaCy0vD5Egbva4ifdTrx6ssoo7qYeaETwIPoTlYTlAsgxhubocwPEV+3rgqBTF/
 xusyHsV9mRjSrWIMAWwU8GGA3cT/fsGi60LV60kyxY9PAI6gW2Ex3kVtDd8Tm+8JiL5y
 cnf2KD8nXV7Ia4aLSePwRTGgfgzzlyuhSKHAMxccdjogg9E2Ti7M5Tn1DfspqthHntOv
 9RrQ==
X-Gm-Message-State: AOAM531r3Eu796o8TtPKyq5UVLD0qv6AkM4OAxtbJBkT1C0OPhvEjUPN
 SWLp1/GaRy2tgJqVcTwUuvvY2V7C9kaIeWRKZgg=
X-Google-Smtp-Source: ABdhPJy9JFoh8hFo4gVRJT943twSSCZ0h0+wbXzI2c2AESt8MVHOgy5cWkPjev1JN/3gKIR+FnnG+ZnQxsK9kkhLOL4=
X-Received: by 2002:a02:1a06:: with SMTP id 6mr57648308jai.8.1594079204495;
 Mon, 06 Jul 2020 16:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200702162354.928528-1-alistair.francis@wdc.com>
 <20200702162354.928528-13-alistair.francis@wdc.com>
 <CAFEAcA8b7Rk8ZDDu689tRDCqcSKRbCGVf=75e0f0WNd2GJ9dmg@mail.gmail.com>
In-Reply-To: <CAFEAcA8b7Rk8ZDDu689tRDCqcSKRbCGVf=75e0f0WNd2GJ9dmg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 16:36:57 -0700
Message-ID: <CAKmqyKMSvou0o52CR6Uo0pztsfZMqkVu5x0=HwMSMfkv2w4B4w@mail.gmail.com>
Subject: Re: [PULL v2 12/64] target/riscv: add vector amo operations
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd32.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jul 5, 2020 at 11:20 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 2 Jul 2020 at 17:33, Alistair Francis <alistair.francis@wdc.com> wrote:
> >
> > From: LIU Zhiwei <zhiwei_liu@c-sky.com>
> >
> > Vector AMOs operate as if aq and rl bits were zero on each element
> > with regard to ordering relative to other instructions in the same hart.
> > Vector AMOs provide no ordering guarantee between element operations
> > in the same vector AMO instruction
>
> Hi; Coverity thinks (probably wrongly) that there might be an array
> overflow here:
>
> > +static bool amo_op(DisasContext *s, arg_rwdvm *a, uint8_t seq)
> > +{
> > +    uint32_t data = 0;
> > +    gen_helper_amo *fn;
> > +    static gen_helper_amo *const fnsw[9] = {
>
> This is a 9-element array...
>
> > +        /* no atomic operation */
> > +        gen_helper_vamoswapw_v_w,
> > +        gen_helper_vamoaddw_v_w,
> > +        gen_helper_vamoxorw_v_w,
> > +        gen_helper_vamoandw_v_w,
> > +        gen_helper_vamoorw_v_w,
> > +        gen_helper_vamominw_v_w,
> > +        gen_helper_vamomaxw_v_w,
> > +        gen_helper_vamominuw_v_w,
> > +        gen_helper_vamomaxuw_v_w
> > +    };
>
> > +    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
> > +        gen_helper_exit_atomic(cpu_env);
> > +        s->base.is_jmp = DISAS_NORETURN;
> > +        return true;
> > +    } else {
> > +        if (s->sew == 3) {
> > +#ifdef TARGET_RISCV64
> > +            fn = fnsd[seq];
> > +#else
> > +            /* Check done in amo_check(). */
> > +            g_assert_not_reached();
> > +#endif
> > +        } else {
> > +            fn = fnsw[seq];
>
> ...which we here index via 'seq'...
>
>
> > +#ifdef TARGET_RISCV64
> > +GEN_VEXT_TRANS(vamoswapd_v, 9, rwdvm, amo_op, amo_check)
> > +GEN_VEXT_TRANS(vamoaddd_v, 10, rwdvm, amo_op, amo_check)
> > +GEN_VEXT_TRANS(vamoxord_v, 11, rwdvm, amo_op, amo_check)
> > +GEN_VEXT_TRANS(vamoandd_v, 12, rwdvm, amo_op, amo_check)
> > +GEN_VEXT_TRANS(vamoord_v, 13, rwdvm, amo_op, amo_check)
> > +GEN_VEXT_TRANS(vamomind_v, 14, rwdvm, amo_op, amo_check)
> > +GEN_VEXT_TRANS(vamomaxd_v, 15, rwdvm, amo_op, amo_check)
> > +GEN_VEXT_TRANS(vamominud_v, 16, rwdvm, amo_op, amo_check)
> > +GEN_VEXT_TRANS(vamomaxud_v, 17, rwdvm, amo_op, amo_check)
> > +#endif
>
> ...which in the calls that these macros expand out to can
> be 9 or greater.
>
> If it's in fact impossible to get into that code path
> with a value of seq that's larger than the array, it
> would help Coverity if we asserted so, maybe
>    assert(seq < ARRAY_SIZE(fnsw));
>
> This is CID 1430177, 1430178, 1430179, 1430180, 1430181,
> 1430182, 1430183, 1430184, 1430185, 14305186.

@ LIU Zhiwei can you please look into this and send a patch with a fix?

Alistair

>
> thanks
> -- PMM

