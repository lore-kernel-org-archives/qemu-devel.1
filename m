Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5014FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 08:56:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10521206DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 08:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LBzm+oYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10521206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsMvR-0004uZ-9k
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 04:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jsMud-0003p1-FL
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 04:55:43 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43647)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jsMub-0002Io-PH
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 04:55:43 -0400
Received: by mail-ot1-x343.google.com with SMTP id 95so20466407otw.10
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 01:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5Mc6QkVGztUHRVv7JVFrwV2ydiuq16uYtp70AA4SOLI=;
 b=LBzm+oYaap+xrpETICMJOA2s5usV9WEZWaxDwWheQb9/XkPZi7C88FNeugw6qoMdX2
 XuyPxKvwFZirSB5xl+LYgcpXzjMdR8PE7FbN6o9yVntXRVAkDiHCBDlQ7Bc2C4G9p+Ve
 /dwebyYgatu7uYl4BKuysevjnSolHzEP2mDflBY9uFoxASLMvDHc3FAzV3AZmrQWu/jT
 CtoJrcnSVUbBQy1JEl8TsGFXv4FYBODUG8/4G1o5KcHXMEdgzuoWkSUW9a+rybfA7Gt6
 eCU3cGkTfEirZXuaNldKV/y/Xzjkm5lD80gtrgGqI2lza6owWPAuo8n3dEe045b7wJe5
 ysbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5Mc6QkVGztUHRVv7JVFrwV2ydiuq16uYtp70AA4SOLI=;
 b=ex2gYiCzZyueDy7Hb+GTR9reyQMiNziP4fiA4uILkcPB6LIp5qA3KFplx7gFgAroLL
 szA9RNmVKhOrj4PLZvEOVEK0psuREXztDvWE5mfQOeZO6sgvifvQQYLhAEnzxmMyB8lQ
 FGnc6rBuaHZ9HmGekNGGoUobkjmnGkmLf2zy36c7wZnYDuOYGxs8Q5baMZfK1oPBvE7G
 1YScS2/M5Ms1TjjCnGc6bDgk8ehvkxmsP/2mm8WOIwI366FyaYKMiK8dOpEwddVNAox+
 QLi/GgRmptg+NNq8g3Tn1bLMaIKJ/WMuawb3ro4bFwHXAUtHMOYeJ+OKVKqEk7+gkT8Y
 xLHQ==
X-Gm-Message-State: AOAM530BbApGNmIr/wn1AgDAa7ygpgPxyp7xe3mkOrTG1bVYyMVg2iS4
 7/oiOIYbfhHczsGn6OUsuiEVCxCvXviV75DueG482Q==
X-Google-Smtp-Source: ABdhPJxJdxNdMWiihVU6OjTkg6NmcLtQAEo4p4odUyPUQ22VkN7YW41/aPGBnIMJsUFTsujhIGK8PAs+81jTOwjkIXA=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr37933392ota.91.1594025740325; 
 Mon, 06 Jul 2020 01:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200629160535.3910-1-wentong.wu@intel.com>
 <20200629160535.3910-3-wentong.wu@intel.com>
 <3260735e-05ab-2d42-f7e4-914ad804f543@linaro.org>
 <CAFEAcA_+e7hrA5GRGb=gv3GxJRL77ARP34vyudRbiqhdsNVKwg@mail.gmail.com>
 <CAMo8BfLVDEFCXWNffVJaRb31UOTPO1iXNz5StexoKvWqQYzg6g@mail.gmail.com>
 <CAMo8Bf+Fk32dYH6GV6Z6OWLsnpJy4Sw_ny+8yviQc6MjGD+mRw@mail.gmail.com>
In-Reply-To: <CAMo8Bf+Fk32dYH6GV6Z6OWLsnpJy4Sw_ny+8yviQc6MjGD+mRw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jul 2020 09:55:29 +0100
Message-ID: <CAFEAcA_nLDvPs-X-3krwC183f8hwm5kYYpxgz4f2r-Z4BKByQQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] target/nios2: Use gen_io_start around wrctl
 instruction
To: Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Wentong Wu <wentong.wu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 5 Jul 2020 at 21:54, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Sun, Jul 5, 2020 at 11:16 AM Max Filippov <jcmvbkbc@gmail.com> wrote:
> > On Sun, Jul 5, 2020 at 10:09 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> > > On Thu, 2 Jul 2020 at 19:53, Richard Henderson
> > > <richard.henderson@linaro.org> wrote:
> > > > This isn't right.  Not so much the gen_io_start portion, but the entire
> > > > existence of helper_check_interrupt.
> > > I agree that it looks bogus (xtensa has a similar helper as well, incidentally),
> > I think there was a reason for it.
>
> ...and the reason is that this helper calls cpu_[re]set_interrupt
> to update CPU_INTERRUPT_HARD, which makes exit to the
> main CPU loop do something to handle IRQ.
> Maybe 'check_interrupt' is not a good name for that, but the
> action taken there seems right to me.

Usually I would expect that CPU_INTERRUPT_HARD would be
set by whatever was setting the interrupt (often a handler
for an inbound qemu_irq line to the CPU). Then the
cpu_exec_interrupt hook only actually does something if
both the INTERRUPT_HARD bit is set and the CPU register
says "and interrupts are unmasked". If you have a design
like that then "unmasking interrupts just means going out
to the main loop" will work.

thanks
-- PMM

