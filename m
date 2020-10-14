Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4113DC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 21:01:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC5A22253
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 21:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC5A22253
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSntU-0007UI-Ff
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 17:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kSnr2-0006xL-DV
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 16:58:36 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41583)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kSnr0-0005H2-Rj
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 16:58:36 -0400
Received: by mail-oi1-f195.google.com with SMTP id q136so649655oic.8
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 13:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SBgQvNfTMFbXYvGMf+mHwmXETuCgfbPmaHXGodIYVxI=;
 b=Uhm0AjSXO3zoFxZUpmSrCA72pdDGGEQeeF+8FLBWxdSC6FhYGtC9x2y5Iw030bAWQJ
 3mSZLOo2PiOnbFk3VSHsg6T8Kv9b/uV9j5hXKj5hb4/YI2P+yZo+gheyu+qbta+CROfE
 CmAnUEBJSXipWV11/QTmoxNSFisCqF51coRpukXREM26v/pBbqYwk/KLc7vL1ZKm1Tlo
 /k5dwTR4IAPiuocX9Z9wZUP7eWCZSh8TzB1VY/ThSByZ475WPI2Y1Ke97f6qMrKxmLnK
 3dFLCyydkC4B5klLbn8makmMDVZ19heqKiLOtJ8PcXvWHFR8zUqj2VGZCW8WOYU6h8sF
 AT/A==
X-Gm-Message-State: AOAM5338JMJuGEIsO3N2pVBSLTF1eaYY6x2l+ydh2ez1juuhduJEagxi
 BU0K1PajYT2i8fVM0qH9yFrVHgQXmxzhxQ==
X-Google-Smtp-Source: ABdhPJzJZSuIhLBDRLvB9Uk5GMgKpUgUWYwtnqrusfHHof3K2xUlnNdsMffulSvmvCHS5jKIJI+x4w==
X-Received: by 2002:aca:4996:: with SMTP id w144mr13867oia.43.1602709111302;
 Wed, 14 Oct 2020 13:58:31 -0700 (PDT)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com.
 [209.85.161.41])
 by smtp.gmail.com with ESMTPSA id w25sm198524otq.58.2020.10.14.13.58.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 13:58:30 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id v123so206242ooa.5
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 13:58:30 -0700 (PDT)
X-Received: by 2002:a4a:9e87:: with SMTP id u7mr19687ook.15.1602709110319;
 Wed, 14 Oct 2020 13:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-8-j@getutm.app>
 <19c387d2-fc9-d1d0-849c-f8e8e270a97c@eik.bme.hu>
 <CADmqK1sTLy8O58rVR116VJnAK2qYMLQvX2wYxpcix_1YkFvLug@mail.gmail.com>
 <2ab5b15f-2372-9531-4ade-50dc12592d6c@linaro.org>
In-Reply-To: <2ab5b15f-2372-9531-4ade-50dc12592d6c@linaro.org>
From: Joelle van Dyne <j@getutm.app>
Date: Wed, 14 Oct 2020 13:58:18 -0700
X-Gmail-Original-Message-ID: <CA+E+eSCUdR5tUT5x90iQ-h3cTiS4u=6MnfrGsP0Pj=F75FsnKA@mail.gmail.com>
Message-ID: <CA+E+eSCUdR5tUT5x90iQ-h3cTiS4u=6MnfrGsP0Pj=F75FsnKA@mail.gmail.com>
Subject: Re: [PATCH 07/10] tcg: implement bulletproof JIT
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.167.195; envelope-from=osy86dev@gmail.com;
 helo=mail-oi1-f195.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 16:58:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Joelle van Dyne <j@getutm.app>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Much of the code that uses the macro is like the following (from
aarch64/tcg-include.inc.c)

        *TCG_CODE_PTR_RW(s, code_ptr) =
            deposit32(*TCG_CODE_PTR_RW(s, code_ptr), 0, 26, offset);

Before the change, it was just *code_ptr. I'm saying the alternative
was to have to write "tcg_insn_unit *rw_code_ptr = (tcg_insn_unit
*)TCG_CODE_PTR_RW(s, code_ptr)" everywhere or else inline cast it.
Whereas making it return tcg_insn_unit * means only three instances of
casting to uint8_t *. Using void * means casting at every instance.

Not opposed to using an inline function over a macro but "inline" is
not ANSI C. Not sure what this project thinks about that considering
the style checker prohibits C99 style comments. Personally I don't
care much.

-j

On Wed, Oct 14, 2020 at 1:35 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/14/20 9:03 AM, Joelle van Dyne wrote:
> >>> static int encode_search(TranslationBlock *tb, uint8_t *block)
> >>> {
> >>> -    uint8_t *highwater = tcg_ctx->code_gen_highwater;
> >>> -    uint8_t *p = block;
> >>> +    uint8_t *highwater;
> >>> +    uint8_t *p;
> >>>     int i, j, n;
> >>>
> >>> +    highwater = (uint8_t *)TCG_CODE_PTR_RW(tcg_ctx,
> >>> +                                           tcg_ctx->code_gen_highwater);
> >>> +    p = (uint8_t *)TCG_CODE_PTR_RW(tcg_ctx, block);
> >>
> >> Why do you need explicit casts here? Can this be avoided by using
> >> appropriate type or within the macro (I haven't checked this at all just
> >> dislike casts as they can hide problems otherwise caught by the compiler).
> > There's the choice between tcg_insn_unit * and uint8_t *. Since it's
> > used much more widely in tcg-target.inc.c, it seemed like
> > tcg_insn_unit * was a better choice.
>
> False choice.  This is why tcg_ctx->code_gen_highwater is void*.
>
> >>> +#if defined(CONFIG_IOS_JIT)
> >>> +# define TCG_CODE_PTR_RW(s, code_ptr) \
> >>> +    (tcg_insn_unit *)((uintptr_t)(code_ptr) + (s)->code_rw_mirror_diff)
>
> Better as
>
> static inline void *tcg_code_ptr_rw(TCGContext *s, void *rx)
> {
> #ifdef CONFIG_IOS_JIT
>     return rx + s->code_rw_mirror_diff;
> #else
>     return rx;
> #endif
> }
>
>
> r~

