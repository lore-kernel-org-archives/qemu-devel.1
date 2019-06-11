Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8DAC31E44
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 21:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B67020866
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 21:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ef9wFrfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B67020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55422 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hao10-0006qw-SV
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 17:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58111)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hanwg-0004Qd-0F
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 17:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hanlp-0008OU-VT
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 16:53:31 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44713)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hanlp-0008Kl-MR
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 16:53:29 -0400
Received: by mail-pg1-x541.google.com with SMTP id n2so7607555pgp.11
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 13:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DPbgMEUYSLDK0m9QMSpDQuYqdtkL9x82h5Hs/N4s2XE=;
 b=ef9wFrfzgnR0bhMQcK/QgNkRuaA5AEZwMEN5IrLKMbsuf2G1stIwXgmaBpqp6RK9DA
 Rm/ySZ7nabkuaF7m7iuySRFhLX2KeKM1zsi56h2IjRlY/Pv1d5COwx7Asw2Nta+ocCAG
 RUm6aJxfGJyWRJsyGD17WIH7HTnK7hKk4CevhbRV/ny8GwyWQOUz4te59tjYp/7+lhvt
 A1z2a3LA49RKCFRgLGXOHITjQjVXr6DU9VT74rql6SlvBHiFruqU+jozejT/WrTr8J+X
 SwveQp2va+XAGlxkQWIxCSWhlMKNdTcZXSTYna4RD6vSFM+UCqdQ9kzGAKRFrmBDa1kl
 zUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DPbgMEUYSLDK0m9QMSpDQuYqdtkL9x82h5Hs/N4s2XE=;
 b=uIeBatEe50VKkHSlLGERVSmipG+wKEJH2+MI11C+wuF97s9P6tt8AZsEVZ1oSHXjIP
 st1xY+Pv20dzxvyz9cDD+GyDjehevZoGfPnBH6g2tnQ3ZFJOH/3gBNGgju9AiTeWh4gy
 pBh8uneqySaJks3UmnHFgxRePoTJVZWL3JksK5+orueD2276OIE8ZlK1TBRpZhsB6GNp
 2GxsQvXG5npoZaXbOSj1JvDK/OVIipJuNC2Ar8EIUCmXtDefcaqARH1NUHsvT560TL8a
 YUMXUeHqIfv+pHV0zT8KfNT17DhquxZq/KmMr3ZO5aoXD8JKJ468sLCFjdwQwR92CTGj
 H7iA==
X-Gm-Message-State: APjAAAVeuVdSujfEeV5nflJCVdMjbAnBoY0aDq9khv8gtgDhYLftxiJF
 Ubr4IUkUQYF2FYwm/6dNbHwZkitksX0=
X-Google-Smtp-Source: APXvYqzD2cYdYLtLza3lqvK/vYnYs06rVTXHEtz+A7K2G7UIPtaLBMpNNPunOYQTdu8rA0izK1PtWg==
X-Received: by 2002:aa7:8a95:: with SMTP id a21mr82833325pfc.215.1560286407737; 
 Tue, 11 Jun 2019 13:53:27 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id
 l21sm15314046pff.40.2019.06.11.13.53.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 13:53:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20190519201953.20161-1-richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3188141b-4f56-5784-6e47-fe24fe20d5aa@linaro.org>
Date: Tue, 11 Jun 2019 13:53:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190519201953.20161-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH 00/13] linux-user: path, clone, sparc,
 shmat fixes
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laurent has merged the final two patches, but ping for the first 11.

I see there are trivial patch conflicts with master, but I'd rather
respin with substantive review if possible.


r~


On 5/19/19 1:19 PM, Richard Henderson wrote:
> This is an omnibus patchset of:
> 
>   v2: util/path: Do not cache all filenames at startup
>   https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg04149.html
> 
>   v1: linux-user: Fix shmat emulation by honoring host SHMLBA
>   https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03430.html
> 
> And a v3 update of
> 
>   v2: linux-user sparc fixes
>   https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg02273.html
> 
> 
> r~
> 
> 
> Richard Henderson (13):
>   util/path: Do not cache all filenames at startup
>   linux-user: Rename cpu_clone_regs to cpu_clone_regs_child
>   linux-user: Introduce cpu_clone_regs_parent
>   linux-user/alpha: Set r20 secondary return value
>   target/sparc: Define an enumeration for accessing env->regwptr
>   linux-user/sparc: Use WREG constants in sparc/target_cpu.h
>   linux-user/sparc: Use WREG constants in sparc/signal.c
>   linux-user/sparc: Fix cpu_clone_regs
>   linux-user/sparc: Flush register windows before clone/fork/vfork
>   scripts/qemu-binfmt-conf: Update for sparc64
>   tests/tcg/multiarch/linux-test: Fix error check for shmat
>   linux-user: Fix shmat emulation by honoring host SHMLBA
>   linux-user: Align mmap_find_vma to host page size
> 
>  linux-user/aarch64/target_cpu.h    |   6 +-
>  linux-user/alpha/target_cpu.h      |   8 +-
>  linux-user/arm/target_cpu.h        |   6 +-
>  linux-user/cris/target_cpu.h       |   6 +-
>  linux-user/hppa/target_cpu.h       |   6 +-
>  linux-user/i386/target_cpu.h       |   6 +-
>  linux-user/m68k/target_cpu.h       |   6 +-
>  linux-user/microblaze/target_cpu.h |   6 +-
>  linux-user/mips/target_cpu.h       |   6 +-
>  linux-user/nios2/target_cpu.h      |   6 +-
>  linux-user/openrisc/target_cpu.h   |   7 +-
>  linux-user/ppc/target_cpu.h        |   6 +-
>  linux-user/qemu.h                  |   2 +-
>  linux-user/riscv/target_cpu.h      |   6 +-
>  linux-user/s390x/target_cpu.h      |   6 +-
>  linux-user/sh4/target_cpu.h        |   6 +-
>  linux-user/sparc/target_cpu.h      |  45 ++++---
>  linux-user/tilegx/target_cpu.h     |   6 +-
>  linux-user/xtensa/target_cpu.h     |   7 +-
>  target/sparc/cpu.h                 |  33 +++++
>  linux-user/elfload.c               |  17 ++-
>  linux-user/mmap.c                  |  76 ++++++-----
>  linux-user/sparc/cpu_loop.c        |  12 ++
>  linux-user/sparc/signal.c          |  96 +++++---------
>  linux-user/syscall.c               |   9 +-
>  tests/tcg/multiarch/linux-test.c   |   3 +-
>  util/path.c                        | 201 +++++++----------------------
>  scripts/qemu-binfmt-conf.sh        |   8 +-
>  28 files changed, 309 insertions(+), 299 deletions(-)
> 


