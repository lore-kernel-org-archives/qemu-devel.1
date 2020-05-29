Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8753CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 16:41:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 565B8207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 16:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pMXlqQYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565B8207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jei4M-0003xs-IX
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 12:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jei3W-0002Gk-PC
 for qemu-devel@nongnu.org; Fri, 29 May 2020 12:40:26 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38000)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jei3V-0006RJ-Ii
 for qemu-devel@nongnu.org; Fri, 29 May 2020 12:40:26 -0400
Received: by mail-ot1-x341.google.com with SMTP id o13so2405585otl.5
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 09:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e2M+Wwc1mwNcFUeT6IxqoZrHvnQq+IKdo92Er62pcuk=;
 b=pMXlqQYPoyYb9P2/PmnjktbAv3+6X18oT/KBbIEiV44vscLU5L9+/05LuitKVnwpR/
 bus4ppqjC9U3Gk7lOyJ8yYb8NP7LKov+ItzKAf3j6XnjfRqNAEI5oNnqu11LjUXxIT14
 v7spxgtGLbbUsfWfcl8Q5qs6hdPdY3VnZ6d085nR3zEuG8c87AK3LBeZJzfuPgKMgq8n
 tTBdQAogLF48aHRLGwoOeEYwDDxSS3z5LY2fJSxjmuc8kXD+ULJr+sL3cQ0NGJWNxCmk
 VZPyg7tFepeWjbkcJdcZGPPYRx7NqBglf0FaFkTHdWf2NrBQmBwRVVEjwNzLZiQRWX8K
 +Kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e2M+Wwc1mwNcFUeT6IxqoZrHvnQq+IKdo92Er62pcuk=;
 b=POH2n+ChCAWEm6oKsduzUB6u6st7IzwltJ9gXzRtUXFZgX7eaVsl+skr/XNzWphfTx
 KJLJAnftbfB6uehGfHg5YWXOLhPuIicoR+lydu8tpPFjxIE9SpesQ7vMG2KloGIJLCS3
 F9MkDKRujG8yRRixjU1tm/K2AC5BTvGr8TPJ6+aa8aFZiSR3sR2wlv+zRsNP/MEJjwyV
 wmFfJH25+Nsdqq5WZXuls9rzjUmhkUvGUncHYKuHhjxJH5chk4OGGU5Y2BrBUf+JjWu5
 X9E1uCfeBAIIhYR/tBpqzUQbFv67VmMxiZpax0AmuR3F9WQpo+jHIutVZOqlVZ02sbXK
 LQww==
X-Gm-Message-State: AOAM530z9PnX+AQuGcG70TT6IaAFcbmeyPhIrASKxStzqEONZ2QwlYHY
 50r3XTjR4GY9j5gl8T+UlsCtiM0WZfAiRqFN8k+jnQ==
X-Google-Smtp-Source: ABdhPJw3zc5/KFIzARFhwhChrf9sDj1hVSANgCxST19qoKXhHWvlmm3kznuLQa/YoBMCeRBGzNYZQAK6nZlKT0nmF04=
X-Received: by 2002:a9d:3623:: with SMTP id w32mr6691253otb.91.1590770424218; 
 Fri, 29 May 2020 09:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200526185132.1652355-1-eblake@redhat.com>
 <m1d06msod9.fsf@redhat.com>
In-Reply-To: <m1d06msod9.fsf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 May 2020 17:40:13 +0100
Message-ID: <CAFEAcA9Huery0AeUFsLVrcK4bUGibg1f-m8gMuMiJgnr+Hj7CA@mail.gmail.com>
Subject: Re: [PATCH] or1k: Fix compilation hiccup
To: Christophe de Dinechin <dinechin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Stafford Horne <shorne@gmail.com>,
 Jia Liu <proljc@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 May 2020 at 17:23, Christophe de Dinechin
<dinechin@redhat.com> wrote:
> On 2020-05-26 at 20:51 CEST, Eric Blake wrote...
> > diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
> > index d08ce6181199..95011a8015b4 100644
> > --- a/hw/openrisc/openrisc_sim.c
> > +++ b/hw/openrisc/openrisc_sim.c
> > @@ -129,7 +129,7 @@ static void openrisc_sim_init(MachineState *machine)
> >      const char *kernel_filename = machine->kernel_filename;
> >      OpenRISCCPU *cpu = NULL;
> >      MemoryRegion *ram;
> > -    qemu_irq *cpu_irqs[2];
> > +    qemu_irq *cpu_irqs[2] = {};
>
> Why is the value [2] correct here? The loop that initializes loops over
> machine->smp.cpus. Is it always less than 2 on this machine?

Yes: openrisc_sim_machine_init() sets mc->max_cpus = 2.
My suggestion of adding an assert() is essentially telling the
compiler that indeed smp_cpus must always be in the range [1,2],
which we can tell but it can't.

thanks
-- PMM

