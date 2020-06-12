Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864CDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 13:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5495320838
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 13:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RW4rg/sJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5495320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjjRj-00047c-FE
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 09:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjjR9-0003hX-9f
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 09:09:35 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40188)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjjR7-0007Ru-1D
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 09:09:34 -0400
Received: by mail-oi1-x241.google.com with SMTP id t25so8592668oij.7
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 06:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ceCocKRNs3dBgSMPne50auidKrxMR+Be3yMRA2tEL8M=;
 b=RW4rg/sJ/6976NIfy+EY63tUA5pVyQEY7G1Od0f0OR6ey5m+VXLJmreHoyl1rm/z32
 l18W1P54lPw788//lOcpqn4qDbFlHPdMeshh9ORNWQIWovOBNt7Tt5RCV6fZ8F+QfgvC
 28vC8mQreSCR2coTlSfGw4r7o5l/8QYlax/9ODofpoazwUs4lF3Xbkc2Vt3kONzpkqED
 EGiiZKNQB6G0ey/rws46Kwli4HbbY7TAVrBC4zn61KupmbNxcqIUPR82PHQa2hanwkJc
 LBIvEOFRkLaiWU9RYFJRB2FKahwORJQsfpPZwp7duRC2rzwRCEQ2eUUYizeX60Uou7Ox
 /cLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ceCocKRNs3dBgSMPne50auidKrxMR+Be3yMRA2tEL8M=;
 b=T6IlYNl0W72BKAvhcMg09JYaIc3WvZKDLLOs1tp0AoJ7xwlkh1KDub0pJ10W6UxRr1
 6xKUHru7I3mlCAdNcfW5cqDWHj3yRqAIEuJkck0s3UatLtsteIstiZkljSksxiusmSgo
 0ivx8oPu7nK39/k7WZ7ajtwm6DJx5wdjsarReJC2dqkLXZ1ijm6oeM+FIMWInfV9guSR
 ZhayWe5ipNivmuEF/dclnXNspoI+uUE46XtbSUklEv4tAJKQCte8emcpk/62fR84LwZr
 bQSDW09d3lfK94W067JcEapHknA58VCOr4j//Dsm2JzWUbm0Pa+qP0wgVyuLKm+7HL8z
 LwAg==
X-Gm-Message-State: AOAM533dncjtXHasis+G/2dmZwf/2KcmJorgDiGSoPaxs72FDSxsbKhE
 +Si78B2dD8210ntYgAYfsrelzxfehCyQdLFfVSTdEw==
X-Google-Smtp-Source: ABdhPJyP9QiYUShR1V+CGD9mJYLet7wk3MlH3Qor2H9vEtx0DZ3YbHHifOnq/WceorHvGp/dVYCP2Lvij/JxkcsvxxY=
X-Received: by 2002:aca:568c:: with SMTP id k134mr1964713oib.48.1591967366216; 
 Fri, 12 Jun 2020 06:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200611194449.31468-1-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jun 2020 14:09:15 +0100
Message-ID: <CAFEAcA-qrxBdn5aA0kaituroTX8c1yFGdRux0_X1Y+W5_s-WHA@mail.gmail.com>
Subject: Re: [PULL 000/115] Huge miscellaneous pull request for 2020-06-11
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 11 Jun 2020 at 21:19, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 31d321c2b3574dcc74e9f6411af06bca6b5d10f4:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/sparc-next-20200609' into staging (2020-06-09 17:29:47 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to d3ffb42f3fbe24c29a2bd7806dab1dd521b4d59c:
>
>   target/i386: Remove obsolete TODO file (2020-06-11 14:08:59 -0400)
>
> ----------------------------------------------------------------
> * Miscellaneous fixes and feature enablement (many)
> * SEV refactoring (David)
> * Hyper-V initial support (Jon)
> * i386 TCG fixes (x87 and SSE, Joseph)
> * vmport cleanup and improvements (Philippe, Liran)
> * Use-after-free with vCPU hot-unplug (Nengyuan)
> * run-coverity-scan improvements (myself)
> * Record/replay fixes (Pavel)
> * -machine kernel_irqchip=split improvements for INTx (Peter)
> * Code cleanups (Philippe)
> * Crash and security fixes (PJP)
> * HVF cleanups (Roman)
>

Hi; I'm afraid this fails to build on OSX, and has a check-tcg
failure on x86-64 Linux.

OSX:

In file included from /Users/pm215/src/qemu-for-merges/target/i386/hvf/hvf.c:53:
In file included from /Users/pm215/src/qemu-for-merges/include/sysemu/hvf.h:16:
/Users/pm215/src/qemu-for-merges/target/i386/cpu.h:1601:5: error:
unknown type name 'hvf_lazy_flags'
    hvf_lazy_flags hvf_lflags;
    ^
In file included from /Users/pm215/src/qemu-for-merges/target/i386/hvf/hvf.c:53:
In file included from /Users/pm215/src/qemu-for-merges/include/sysemu/hvf.h:16:
In file included from /Users/pm215/src/qemu-for-merges/target/i386/cpu.h:2021:
/Users/pm215/src/qemu-for-merges/include/exec/cpu-all.h:442:12: error:
returning 'void' from a function with incompatible result type
'ArchCPU *' (aka 'struct X86CPU *')
    return container_of(env, ArchCPU, env);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/Users/pm215/src/qemu-for-merges/include/qemu/compiler.h:56:41: note:
expanded from macro 'container_of'
#define container_of(ptr, type, member) ({                      \
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~
In file included from /Users/pm215/src/qemu-for-merges/target/i386/hvf/hvf.c:53:
In file included from /Users/pm215/src/qemu-for-merges/include/sysemu/hvf.h:16:
In file included from /Users/pm215/src/qemu-for-merges/target/i386/cpu.h:2021:
/Users/pm215/src/qemu-for-merges/include/exec/cpu-all.h:464:14: error:
initializing 'ArchCPU *' (aka 'struct X86CPU *') with an expression of
incompatible type 'void'
    ArchCPU *arch_cpu = container_of(env, ArchCPU, env);
             ^          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
3 errors generated.


On x86-64 Linux host, running the check-tcg tests on the static
linux-user build:

  BUILD   i386-linux-user guest-tests with docker qemu:fedora-i386-cross
/home/petmay01/linaro/qemu-for-merges/tests/tcg/i386/test-i386-pcmpistri.c:
In function 'main':
/home/petmay01/linaro/qemu-for-merges/tests/tcg/i386/test-i386-pcmpistri.c:28:15:
warning: left-hand operand of comma expression has no effect
[-Wunused-value]
   28 |     if ("%d\n", _mm_cmpistri(s1.x, s3.x, 0x4c) != 16) {
      |               ^

(only a warning because we don't seem to be using -Werror here?)

and then the test crashed at runtime:

  TEST    test-i386-pcmpistri on i386
qemu: uncaught target signal 4 (Illegal instruction) - core dumped
timeout: the monitored command dumped core
Illegal instruction
../Makefile.target:151: recipe for target 'run-test-i386-pcmpistri' failed


thanks
-- PMM

