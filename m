Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECCCC433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 10:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B82B52072D
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 10:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a4rFxelR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82B52072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9nY3-00061G-31
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 06:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9nWf-0005Lq-Sp
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 06:47:07 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c]:44375)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9nWe-0006zi-77
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 06:47:01 -0400
Received: by mail-ed1-x52c.google.com with SMTP id l23so5545658edv.11
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2020 03:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=lkyhwDNnw7XZv6SYqjgm87YmPNWWjQPSa711ZWQL59o=;
 b=a4rFxelRdgMUTZ8dr09znm0NVd778FQYj/oZ9/AKj0EzOrBfoKT1v1BnQWrJtS4/Se
 NEGPhI5VrqjXoMY4Ose+l5ATh6TTJiS7JIGFDdfYbNmK3a3YO/rGCl0IwWLgmPWlZxmm
 NnkxcUOBEVYRZAVWxWOtTmre8EjT68e/oT3oalzqLPEK+qv24x84B12ji6qRlY8pzzlR
 ND9aLmuGWZz3mSGB2GsdBbWudF+EgYXBRhBn47X78Js/AYgA7eNbHLvdF39e8Zjs7TJp
 3cXpHoWNEF20eWh6ydJdY5P94oysoaMJmCVgzDVTumm0gtCVfwqgI2/6z9eyV7+EzHtC
 DaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=lkyhwDNnw7XZv6SYqjgm87YmPNWWjQPSa711ZWQL59o=;
 b=SKXOJHIRZ5gbk6DO74a24BCR7UXxizSIPqLCE9pmUmUJWVPjzlF+xYm0KwlW9kUNha
 X36OQt7L5TO0pRNMVl18YYtKbNPcZCxju2lJVdBaMaZUHyYjOrA6/pRWxqs2QtpMem1L
 KfKQiPPaBc14C4TOmZM9snjUmo/pREN/2PG2/38if1uW3EqDd76mjFGXBwGIi+PZPI0l
 Lsc6bj+xL60cF5AwvLAVUtZxGCXIaaSpqV7r9PlW6XJBwkC+ykA5itGL3rQghe5WGQA6
 NJxAeNq3mkGhyr0cIrXPfO+o/6PxYIn4nmOlj0RPIgIDEmYNtNMkkOTBAQMCRQYk3QgE
 CFQA==
X-Gm-Message-State: AOAM531RISYbulZ82/3/9xx1IN1dP0PmPAKKfUZH99FAsy9vrFXVFB1S
 j9LS8D6elAtvn8c1zfCQAbSXTLFUkpzqJ6loqDXCdtSZpiNSuQ==
X-Google-Smtp-Source: ABdhPJxj+9T2JkyZhq9HrjZnFrq4ohuF0JnyfZvY99S9pQf18Y9R0h+33Qj0ZbX7SaxFnmZv/0EjiT+r/eEcjzEjURE=
X-Received: by 2002:a05:6402:8cb:: with SMTP id
 d11mr940109edz.100.1598179618575; 
 Sun, 23 Aug 2020 03:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA-dDW27t7VcV5D=01ckBOD5oerr1XK0an7BemORdyQHHA@mail.gmail.com>
In-Reply-To: <CAFEAcA-dDW27t7VcV5D=01ckBOD5oerr1XK0an7BemORdyQHHA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 23 Aug 2020 11:46:47 +0100
Message-ID: <CAFEAcA-SmcO2ENZyXpPxxkqwybXP8=m5DXpeqkKw9PdaGnbm0g@mail.gmail.com>
Subject: Re: odd meson failure: Unknown variable "exe_name"
To: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 23 Aug 2020 at 11:45, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On my x86-64 Linux box, one of my local build trees turned out not
> to work:
>
> $ rm -rf build/x86 && mkdir build/x86 && (cd build/x86 &&
> '../../configure'
> '--target-list=arm-softmmu,aarch64-softmmu,arm-linux-user,aarch64-linux-user'
> '--enable-debug' '--cc=ccache gcc' '--audio-drv-list=pa'
> '--with-pkgversion=pm215' '--enable-trace-backends=log,dtrace'
> '--enable-docs')
>
> fails with
> [...]
> Program keycodemapdb/tools/keymap-gen found: YES
> Program scripts/decodetree.py found: YES
> Program ../scripts/modules/module_block.py found: YES
> Program nm found: YES
> Program scripts/undefsym.sh found: YES
> Program scripts/feature_to_c.sh found: YES
>
> ../../meson.build:1030:14: ERROR: Unknown variable "exe_name".
>
> A full log can be found at
> /home/petmay01/linaro/qemu-from-laptop/qemu/build/x86/meson-logs/meson-log.txt
>
> ERROR: meson setup failed
>
>
> This is the same box that's worked fine for merge testing, so
> presumably something about the particular set of configure
> options is tripping it up.

Dropping the '--enable-trace-backends=...' option lets it pass,
so that's the area where the problem is.

-- PMM

