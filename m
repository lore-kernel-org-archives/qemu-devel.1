Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B87C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA22D21D46
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="urCR86m0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA22D21D46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQpJx-0007Tz-Pn
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 06:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQpJ5-000726-Gl
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:07:23 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:45086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQpJ3-0000G0-Ch
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:07:23 -0400
Received: by mail-ej1-x641.google.com with SMTP id dt13so12245353ejb.12
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 03:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SoIrrK1jpIb6KQqboLcw75A3nH+SGFdyLHluklbOGjI=;
 b=urCR86m0HsqNcfxItgm2aVUKyV1IxuXu2CKL9d0++n9VJ+tX3/+XZNDoZ+rrDhFbic
 rrqVtsEhWmCMWp6IVC/n9Tbz82f2S5Xsrlhln2kl0ap7beAZMYmoZudGMBpDR1/yvs6f
 JyWRb91QDdQXtH7ecubgAo0vDB1w9MOzfKFLMIDOzOmGhDCsxKWGVs2aKuXDHsDJw0nS
 DQcEr18em7wOP5JyIyaenSLwK3mVbU7xvy6B7nJcLnZOtnyWBliHjJJiMWkzoZuRiB6C
 x2KAKb6Qxn1Ocf+zE5WAY9iK4gc5Ox3AV2TvZYKxlm7dAZfnDwd2AWo8KBLX/k3Xckjb
 uB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SoIrrK1jpIb6KQqboLcw75A3nH+SGFdyLHluklbOGjI=;
 b=BOYuCrlK6JtmvUP7A1RB2OoZekf6xvJoaoV7uowBWZXpDVDwqr5QCP2EKDfC7UewIc
 gIE4NPcvTkJMbIix/uz3AIIYIeamnktuV4UMlbMr1JrQwDs5N7CU1G1hN2vCGY1h6Qk+
 h908y8Pn+r6xwjKQmRMW+C5YnqogsRP722nogHWjmdTuUv9pYuIdFLzpGQOPeUmqaIdo
 yCASrX4FQQwvUDwhnWqdQsDcE8BmEryVy+uOF8PYMtVqArE8x8V1YuGO2wxHn5XQtHNQ
 f5nvPqcrGbG46/fh5pd1D0FSos0zcUn7PCizND5KYse85gCkyuvoEX8WgVUe9WRpA+20
 19Zw==
X-Gm-Message-State: AOAM532qa5OQ7XmY8kMNKpkja/Hha1b7t0Z+Wfu555LCDRxLbGYcWHqQ
 A2fMKF1ARt/1mE841qG9haE7wT8T4XTnbAwMc0tB7A==
X-Google-Smtp-Source: ABdhPJzcBao4fMOTxED9NfCuyd5Bxt/wwc9if/N7iHUkklhQVExtcK6UFubrWVgy3PVEzCAYou+ggVTlamdWS7nPviA=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr13252081ejk.407.1602238038936; 
 Fri, 09 Oct 2020 03:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA-wP4NDc30WXVbWRZv3WDSNNjoxaeAA-rjATN_W2n5rQw@mail.gmail.com>
 <36032642-9bea-8625-65a6-bd4afc7e459d@redhat.com>
In-Reply-To: <36032642-9bea-8625-65a6-bd4afc7e459d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Oct 2020 11:07:07 +0100
Message-ID: <CAFEAcA8KH6vDdSy0KX3V-fX_zKLUqNTsAbZH_Q4sXkQss9Q=RQ@mail.gmail.com>
Subject: Re: more findable locations for compiled/generated files in the build
 tree?
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 9 Oct 2020 at 09:40, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 08/10/20 23:33, Peter Maydell wrote:
> > Is it possible to get Meson to put the files that are
> > generated/compiled as part of the build process in more
> > sensibly findable locations?
>
> Short answer: no.  You won't be surprised I guess.

Not really. As usual I find Meson really annoying to deal
with: it doesn't do things in the generally-standard-for-C-and-Unix
way by default, and it isn't flexible enough to be
configurable to do so. One of these days we're going to
find that its persistent inflexibility prevents us doing
something important rather than merely being an irritant.

> > I would generally expect
> > that a file foo.c should generate into foo.o, and
> > foo/bar.c should generate into foo/bar.o, and if we
> > generate a .c file from foo/bar.decode then it ought
> > to end up in foo/bar.c or something similar.
> > The old build system got all this generally right.
>
> Except for recursive make.  So for example foo/bar.decode did not go in
> foo/bar.c, it went to ARCH-softmmu/foo/bar.c (more precisely into
> target/arm/decode-bar.inc.c).

That's not recursive make particularly, it's just that if
we want to build the same file twice we need to have a
subdirectory for each way of building it, as you note.
But in each of those subdirectories you can still use the same
directory layout the source tree has, which is what we
did with the old build system.

> with the caveat is that / becomes _ in the directory (I suppose it's
> to avoid making the hundreds of empty subdirectories that we had too).

This is a silly scheme, because now you have an unnecessary
restriction that you can't have both foo_bar.c and
foo/bar.c. We don't have to pay for builds by the
subdirectory :-)

> Out of curiosity, what do you use the placement of the output files for?
> I generally just use touch on the source (rather than rm on the target)
> if I want to force-rebuild something.  For the case where I need to
> objdump a .o file or look at the generator output, I cut-and-paste
> from the Make output; for example:
>
>   Compiling C object libcommon.fa.p/dma-helpers.c.o
>   Compiling C object libqemu-arm-softmmu.fa.p/target_arm_translate.c.o
>   Generating 'libqemu-aarch64-softmmu.fa.p/decode-t32.c.inc'.

Generally at the point where I think "oh, maybe I should look
at the generator output" the output from make is no longer on
my terminal. So I just find the object file in the build tree
(not just for QEMU, but for anything I'm working on: IME
most projects put the object files in easy to guess places).

thanks
-- PMM

