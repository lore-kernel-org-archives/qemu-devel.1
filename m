Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EDCC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 22:58:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCC820776
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 22:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCC820776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSpiy-00046W-N6
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 18:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kSpfO-0002NT-Eb
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 18:54:42 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kSpfM-00047L-JW
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 18:54:42 -0400
Received: by mail-io1-f67.google.com with SMTP id q9so1702964iow.6
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 15:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LCFXzp4nwG7s4dnWUuwq1AbEVIKGwvxFQ6HRqUlTTZQ=;
 b=mnnyfbNvIJaOTnBj3BMDmGFByUAqxVBhoKSR5b7AlG7j2B3AfChLOQFOmIOdGw0Oip
 mOP0/OWWnn9vW9W7cxzofJotHnBezwuxlnNKHaGeFkU9aPAR0uGa3jidnLYrNjdm7afg
 0AguMLdLPSGcH0scdUp8f8MS0d+FA74FFNcdp5uvyAN3ddaRbecCROcXRnCJIJQZxtil
 QpLKUoe8hoOn97uIQ0VIIVz/+GVbDnzIuxLjn+VNhQDdAmOd5zB2nuDAIG744rH95Vtg
 O54WUFVWYU4ct5OuwVng8ftRA0TI3D6tSSAkl4LVEcRX5N9GoF+CThjOnzOC+gZCEEEN
 Ex3Q==
X-Gm-Message-State: AOAM531TJx1cr40D1o3OqcSrcb+NstgZ2fBJYQq9BNBpJacrv4ryu0hp
 XSP+qjpPeFk5hN3t6vL4gg1GavuaAfo=
X-Google-Smtp-Source: ABdhPJxNOWsr049n7Sfm7FSLHgY2MGVUBWzrP7P8NMHPaI9zdmSd1+89wtITaakfTrycygdWdN1XOQ==
X-Received: by 2002:a6b:3ac5:: with SMTP id h188mr1200921ioa.173.1602716079130; 
 Wed, 14 Oct 2020 15:54:39 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com.
 [209.85.166.46])
 by smtp.gmail.com with ESMTPSA id k198sm936472ilk.80.2020.10.14.15.54.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 15:54:39 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id d20so1666581iop.10
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 15:54:38 -0700 (PDT)
X-Received: by 2002:a5d:9483:: with SMTP id v3mr1175405ioj.84.1602716078605;
 Wed, 14 Oct 2020 15:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-8-j@getutm.app>
 <19c387d2-fc9-d1d0-849c-f8e8e270a97c@eik.bme.hu>
 <CADmqK1sTLy8O58rVR116VJnAK2qYMLQvX2wYxpcix_1YkFvLug@mail.gmail.com>
 <2ab5b15f-2372-9531-4ade-50dc12592d6c@linaro.org>
 <CA+E+eSCUdR5tUT5x90iQ-h3cTiS4u=6MnfrGsP0Pj=F75FsnKA@mail.gmail.com>
 <05c6cd7d-aa9f-ddea-cc04-2db5aa3110a0@linaro.org>
In-Reply-To: <05c6cd7d-aa9f-ddea-cc04-2db5aa3110a0@linaro.org>
From: Joelle van Dyne <j@getutm.app>
Date: Wed, 14 Oct 2020 15:54:27 -0700
X-Gmail-Original-Message-ID: <CA+E+eSCi81G_ShewtABvGAucOiebkROAu2bDO0c3DUs8G6v55A@mail.gmail.com>
Message-ID: <CA+E+eSCi81G_ShewtABvGAucOiebkROAu2bDO0c3DUs8G6v55A@mail.gmail.com>
Subject: Re: [PATCH 07/10] tcg: implement bulletproof JIT
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.67; envelope-from=osy86dev@gmail.com;
 helo=mail-io1-f67.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 18:54:39
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

There's about 40 instances of *code_ptr or code_ptr[i] changed to
TCG_CODE_PTR_RW(s, code_ptr). It's around 2 instances per function, so
if I go with a local variable, that would be ~20 extra LOC.

Another alternative is two separate functions: tcg_code_ptr_insn_rw()
which returns tcg_insn_unit * and tcg_code_ptr_rw() which returns void
*. I'll go that route unless there's any objections?

-j

On Wed, Oct 14, 2020 at 2:49 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/14/20 1:58 PM, Joelle van Dyne wrote:
> > Much of the code that uses the macro is like the following (from
> > aarch64/tcg-include.inc.c)
> >
> >         *TCG_CODE_PTR_RW(s, code_ptr) =
> >             deposit32(*TCG_CODE_PTR_RW(s, code_ptr), 0, 26, offset);
> >
> > Before the change, it was just *code_ptr. I'm saying the alternative
> > was to have to write "tcg_insn_unit *rw_code_ptr = (tcg_insn_unit
> > *)TCG_CODE_PTR_RW(s, code_ptr)" everywhere or else inline cast it.
> > Whereas making it return tcg_insn_unit * means only three instances of
> > casting to uint8_t *. Using void * means casting at every instance.
>
> I should have done more than skim, I suppose.
>
> Well, without going back to look, how many of these are there, really?
> Virtually all of the writes should be via tcg_out32().
>
> If there's < 5 of the above per tcg/foo/ -- particularly if they're all
> restricted to relocations as in the above -- then I'm ok with local variable
> assignment to "rw_ptr".  Especially since the replacement isn't exactly small,
> and you're having to split to two separate lines anyway.
>
> I'll have a real look when you've split this into parts, because otherwise it's
> just too big.
>
>
> r~

