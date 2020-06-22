Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49570C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 19:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1226320768
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 19:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+O8tltO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1226320768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnRxj-0007HX-77
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 15:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnRwi-0006PV-8W
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 15:17:32 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnRwg-0006ZN-B1
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 15:17:32 -0400
Received: by mail-wm1-x344.google.com with SMTP id g21so697131wmg.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 12:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=glkQR/ZJqHbpelX/uXLYv84sEBk88reV/4ztPSkNgIs=;
 b=o+O8tltO6J8zUd61c2G7SUgTN15InFzq9w7B/ISW5uVkvzwpFWRntC+yNpJdqu9qcI
 OW2gGmR6tr7Vi/A7oqSaHwHDXt/bE7woZLb6Z17au2YKOzrxQ2+ObEDHNJdpz1JQ5lcC
 vV3NDDD5kPT8r/HfB2eS4vQkoY21xMJUpjXyeWU6/pDzlQM9a4vflABWDEbo+oZaIX6B
 axSqv7CKZYupb+t5eWZJyd1dSjsVdBSjLZq9v9kgtUlMCZmdM8wtrD49LXK/q4VAjE25
 5THG1z35dL8E6ifTzfPCWQcD7BWHGRnhALXpl6TwNfdpK+Dcb8v/nh891fkLgR1Oa6Rn
 havw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=glkQR/ZJqHbpelX/uXLYv84sEBk88reV/4ztPSkNgIs=;
 b=bcFf0TJE5vvQWLlNpLqe+rX46OQOnBNBvwM/MPS8ga6TZY13XffGsmvkvNhYz5JSU2
 a9J/o2pR2JC9hzmypRBrputGxfHt4mZIu7X91LNlxr+NgBydTq43fKzfSfDNPTMiS8Gg
 OGjh0pm9Ih+PqfCHfWA9QtcOcE8aJczlWW8u7szqvneTHywhIRo9rbtH/g6zhKBuT6wD
 RXxAgCnK5Sm+eLHa/S2VAhJnlRtmcET05qdXv7TVGRn+70qIZYjoD4wOkn1Uc3BG3/9X
 bEgybJB0NXBKX6k4BOH0GFW2f9Ejy1aaKs0aOaBx1GqdEM9J3TzktKJQcf+A/qpgUjQm
 //yg==
X-Gm-Message-State: AOAM530jinoRx4/gs2Ez2zbQ7KdIrfuTR6yUccBr+H5VP7ihd6nS+3P0
 Xmp5dF76QQt7DGjrRjyY+GU=
X-Google-Smtp-Source: ABdhPJw7g53cD0Lz8R0/lZ+Dyk108FS271RX4uzqwe92lpSwbTFZHZSpNFsAPoL57ZmaxnK/VsLQeA==
X-Received: by 2002:a1c:2602:: with SMTP id m2mr20782547wmm.50.1592853447783; 
 Mon, 22 Jun 2020 12:17:27 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id d9sm18975835wre.28.2020.06.22.12.17.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 12:17:26 -0700 (PDT)
Subject: Re: [PULL 00/15] Renesas hardware patches for 2020-06-21
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200621124807.17226-1-f4bug@amsat.org>
 <CAFEAcA_5663fFNVqcr1maATB6v8R297LmJEtD+8V4LvhaSkjPA@mail.gmail.com>
 <CAFEAcA-w4DGH2wEwySZd+zj-m+YpL39tog9S9LNH2iTcL84F9Q@mail.gmail.com>
 <8ec1ccc2-7e7f-94cf-dedf-86c09832c0f7@amsat.org>
 <CAHiYmc7V0Be1i67ZscrvsKyDEXw7aWz1vJHJ3eEPgcyPELLyYw@mail.gmail.com>
 <CAHiYmc4+B22-0AjLMYnJmcAVVYxzKKiPnbViuR-9kBYJrpOK0A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2741a5b7-91dc-4087-e9e5-9a17da353072@amsat.org>
Date: Mon, 22 Jun 2020 21:17:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc4+B22-0AjLMYnJmcAVVYxzKKiPnbViuR-9kBYJrpOK0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Ahmed Karaman <ahmed.khaled.karaman@gmail.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 6/22/20 7:30 PM, Aleksandar Markovic wrote:
> понедељак, 22. јун 2020., Aleksandar Markovic
> <aleksandar.qemu.devel@gmail.com
> <mailto:aleksandar.qemu.devel@gmail.com>> је написао/ла:
> 
> 
> 
>     понедељак, 22. јун 2020., Philippe Mathieu-Daudé <f4bug@amsat.org
>     <mailto:f4bug@amsat.org>> је написао/ла:
> 
>         +Thomas
> 
>         On 6/22/20 6:19 PM, Peter Maydell wrote:
>         > On Mon, 22 Jun 2020 at 17:01, Peter Maydell
>         <peter.maydell@linaro.org <mailto:peter.maydell@linaro.org>> wrote:
>         >>
>         >> On Sun, 21 Jun 2020 at 13:50, Philippe Mathieu-Daudé
>         <f4bug@amsat.org <mailto:f4bug@amsat.org>> wrote:
>         >>> Renesas hardware patches
>         >>>
>         >>> - Add a common entry for Renesas hardware in MAINTAINERS
>         >>> - Trivial SH4 cleanups
>         >>> - Add RX GDB simulator from Yoshinori Sato
>         >>>
> 
> 
> 
>     Can this rx patch be included in this pull request: (it was r-b-ed a
>     couple of weeks ago already):
> 
>     https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08581.html
>     <https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08581.html>

This pull request only contains hardware emulation patches (files under
hw/, not the TCG code from target/).

> R-b by Richard is here:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00229.html
> 
> The two messages are not directly connected on the list, since r-b was
> in June, and the patch was in May.
> 
>  
> 
>     Thanks in advance!
> 
>     Aleksandar
> 
> 
>      
> 
>         >>> The Renesas RX target emulation was added in commit c8c35e5f51,
>         >>> these patches complete the target by adding the hardware
>         emulation.
>         >>>
>         >>> Thank you Yoshinori for adding this code to QEMU, and your
>         patience
>         >>> during the review process. Now your port is fully integrated.
>         >>>
>         >>> Travis-CI:
>         >>> https://travis-ci.org/github/philmd/qemu/builds/700461815
>         <https://travis-ci.org/github/philmd/qemu/builds/700461815>
>         >>
>         >> Hi; I'm afraid there's a format-string issue here (manifests
>         >> on OSX, openbsd, and 32-bit platforms):
>         >>
>         >> /home/peter.maydell/qemu/hw/rx/rx-gdbsim.c: In function
>         'rx_gdbsim_init':
>         >> /home/peter.maydell/qemu/hw/rx/rx-gdbsim.c:93:22: error:
>         format '%lli'
>         >> expects argument of type 'long long int', but argument 2 has type
>         >> 'ram_addr_t {aka unsigned int}' [-Werror=format=]
>         >>          error_report("Invalid RAM size, should be more than
>         %" PRIi64 " Bytes",
>         >>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         >>                       mc->default_ram_size);
>         >>                       ~~~~~~~~~~~~~~~~~~~~
>         >
>         > Also there appears to be a makefile/dependency bug somewhere,
>         > because when I drop this merge attempt and retry building
>         > with current master I get this error:
>         >
>         > make[1]: Entering directory '/home/petmay01/qemu-for-merges/slirp'
>         > make[1]: Nothing to be done for 'all'.
>         > make[1]: Leaving directory '/home/petmay01/qemu-for-merges/slirp'
>         >   CC      qga/main.o
>         >   CC      qemu-io.o
>         >   CC      monitor/qmp-cmds-control.o
>         > make: *** No rule to make target
>         > '/home/petmay01/qemu-for-merges/hw/rx/Kconfig', needed by
>         > 'aarch64-softmmu/config-devices.mak'.  Stop.
>         > make: *** Waiting for unfinished jobs....
>         > make: Leaving directory '/home/petmay01/qemu-for-merges/build/w64'
>         >
>         > This seems to be because aarch64-softmmu/config-devices.mak.d
>         > in the build tree says that aarch64-softmmu/config-devices.mak
>         > depends on all the Kconfig files; this means that if a Kconfig
>         > file gets deleted then incremental build stops working?
> 
>         This seems the same problem previously discussed here:
>         https://www.mail-archive.com/qemu-devel@nongnu.org/msg676319.html <https://www.mail-archive.com/qemu-devel@nongnu.org/msg676319.html>
> 

