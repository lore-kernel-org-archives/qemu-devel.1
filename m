Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9293AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B88F2073E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OCoK0wZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B88F2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKSF-0007uO-F6
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmKRb-0007G9-HP
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:04:47 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:35906)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmKRZ-0003ui-Ud
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:04:47 -0400
Received: by mail-ot1-x329.google.com with SMTP id 97so7826319otg.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 10:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BMIAgfejwZ6y34g6KIW67OFzCyu7HPmlxDc5YEnr/Kc=;
 b=OCoK0wZT1CCIzDpDEvoGp5uwg2FRQFNZ5Z4siwdmE84vtEKU461LwLRusY1I1+ZCBI
 ENBRZCUI7v3DK1IhN3H86Ag6bXgy+6STxbgOGEuMetuAH2TQIHngcUJNeRjaj8Rwurzr
 u/vPPJbhzvGOJ1BN9N5mGPmM7DscjmTGE7RwK8F6Nd4qAihIrOX0gT4wjdg/FZUdBD4D
 O3BhBI3jcuHzmFA/YhxIeeFtk8KTTfkB6ELjhHbcs4TWts18xHzS3IDcB4jn8qqHY73e
 BCPaSL0GrY1is10LRLRMDc+T7uhYfbdn8drnCED/SilQUXjJOzeH0GTf8XnojgAeru9v
 HRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BMIAgfejwZ6y34g6KIW67OFzCyu7HPmlxDc5YEnr/Kc=;
 b=N43jl0YgXL8BWUdsmykDPMkf5dixnGuDGyAvs9jx/z3HffztBT3YRmpx1nW/WPevF6
 a0DBL3ruANOvmtyaIP6AF90RBxlFbBdA8nRtSrFJysZUaG0dh0WvGmtntSZ+ueF546kM
 AKwgJ9Zo0m8ZZtgGqgpE0ulW7M8eKXGyz5Cbbzq6il3ySEuLHPepVZEbFncqjA+FFe/8
 SeyZdR+EIjcQizjJXHSufa9/SNOSbPQerlqMmdh845FguBcbGLCtCokwSBW0dn+Rj891
 yi90603+lyrdKuxtF4Nxa8E4dLMMkvDgoY5c5UXs0f/FYp4coALeOrsQIKNz5pQBiGLF
 qB+g==
X-Gm-Message-State: AOAM533XjILP6uKVztpYb3/N2UYtxoz6m4RyfNCgs3DPvxcNfKnca/3Y
 hcw9c5PqOE2ZNW+crXfrB/jrWaIQwfc3FXnRiwWQDA==
X-Google-Smtp-Source: ABdhPJyWERfxSPidEjqw0As+d3x2w0muYriu5SyRIX+XQsiRIu0q4IA6U4IJvZqUV8XEga2DD/nTeYV0o8KtKFO3FvU=
X-Received: by 2002:a05:6830:18da:: with SMTP id
 v26mr3942115ote.135.1592586284849; 
 Fri, 19 Jun 2020 10:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_HOxdK5rgKVnww6Bum3vGb=TrhDEp7oqDwsd=UbHmC_g@mail.gmail.com>
 <c47e9e4e-49eb-88c5-fdc7-8ebec121c165@ispras.ru>
 <f4fc4a1b-4054-cffd-0272-22c28d656aba@redhat.com>
In-Reply-To: <f4fc4a1b-4054-cffd-0272-22c28d656aba@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2020 18:04:33 +0100
Message-ID: <CAFEAcA_OfF2pBPCv7Wj+u4Rm3fjtApzfiE9WYhiGeEzffd60Kw@mail.gmail.com>
Subject: Re: what are the requirements on target/ code for -icount to work
 correctly?
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x329.google.com
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jun 2020 at 12:16, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 19/06/20 07:46, Pavel Dovgalyuk wrote:
> > I think, that we need some efforts from target maintainers to remove all such calls.
>
> I'll take care of target/i386 (which does need one of the three
> gen_io_end calls that are left).

I've just sent a patch that removes the target/arm gen_io_end() calls.
I had a quick look at sparc, xtensa and ppc, but they were too complicated
for a quick look to be sufficient :-)

-- PMM

