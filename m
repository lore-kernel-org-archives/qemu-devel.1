Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3F3C54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:05:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B443D206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AACA6q/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B443D206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT3Rx-00015q-Oz
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 09:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT3Qn-0000NY-U6
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT3Ql-0007ws-5I
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:04:17 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34652)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jT3Qk-0007wc-KI
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:04:14 -0400
Received: by mail-ot1-x342.google.com with SMTP id 72so25974509otu.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 06:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PuRd6I5K4cYio7H8Dul4eqCBWbrS3XwjI28PCJSaHLk=;
 b=AACA6q/qcYkgadALa3zbEspFiB5o/AuHoGvdvMk6dGHRod+S+0Hv7C4/R665OWIWNY
 vBHfTPWd/6VGYgDVO08OajiHNKMGJd4nR3hvhYt2anK4Uk4PFZemsBENRtKqereGmgHU
 PLPe5V7Ioc++xKMgfXslCUFmBNn7UkBz2wr+1YFEZ8/AFhhhhdKSSbtkq+2Y+Ve987KT
 rCSeSYSKYkDBVggbXMCC0H61hf2MIfOb+wg8UlYrqMiHn2u5xTmv08uGh7e4P20Aynd6
 MO8wuI5qeNbWcbSNrKuW4XFGkpWV1LCEEHm7m/j0cyNF+5U0+owT33hyfCh1UysoUC9r
 oH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PuRd6I5K4cYio7H8Dul4eqCBWbrS3XwjI28PCJSaHLk=;
 b=QxFFFewfhXv4P8NXCg9NHWAkq18GZGKaHjirFDF+0KaqVNkcEjxgETndpF7k69yhZ+
 ryxev5wT1tjKHuh/0+XdgVHVjHoMgQdROvgJt4v1P3RUWFMMDez5uC8kQDeD978PjzUk
 jVdGZ69P6yzO9qnprGDRBycTB7zwqwXdfzZm/fvY5LmaMpEBGrUyR0usa72zt8u6NaOi
 pZPWJPNFEAU5+27rpsvPEGHBIKUNAHrcTewaesjkvV1cFjLzrjmHk6Nuv75k4ZcpSyqM
 BhRnQNf3e78x4XlS4DO82TkM3IHum1jYHysb06E5MBreK8+wfvsu+fGZFCe5L9VpUNPs
 tX2A==
X-Gm-Message-State: AGi0PuZ6aL0j61RM4Nr5Un/cgXRmglDFxztJ2SKzEYwoFGH99DvdcroY
 PGOwYSpRxPDxXACtVFB+72zlXvvUfhCZp4U4cUuSqw==
X-Google-Smtp-Source: APiQypLOkflUgdN1zcZU4BSrROagvQULpsMaD2oKmmnnSTCpcmb5LBkPKqOZarL7Mhq5WjYpKSwQ36AgRHW0cEA7k9Q=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr17279263otc.221.1587992653227; 
 Mon, 27 Apr 2020 06:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200423073358.27155-1-philmd@redhat.com>
In-Reply-To: <20200423073358.27155-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2020 14:04:01 +0100
Message-ID: <CAFEAcA8j7y2VbM1U0Df-TEjS6Kh-iBGXA8Vg1ZrD5Ff6=WthjA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] target/arm: Restrict TCG cpus to TCG accel
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Apr 2020 at 08:34, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> These are the uncontroversial patches from "Support disabling
> TCG on ARM (part 2)"
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg689168.html
>
> The other patches are blocked by the "accel: Allow targets to
> use Kconfig" series:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg689024.html
>
> All patches reviewed.
>
> Since v1:
> - Dropped 'Make set_feature() available for other files' patch
>   which fails to build with KVM only, see:
> https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg03843.html
>
> Many thanks to Richard Henderson for his patience!
>
> Regards,
>
> Phil.
>
> Philippe Mathieu-Daud=C3=A9 (4):
>   target/arm: Restric the Address Translate write operation to TCG accel
>   target/arm/cpu: Use ARRAY_SIZE() to iterate over ARMCPUInfo[]
>   target/arm/cpu: Update coding style to make checkpatch.pl happy
>   target/arm: Restrict TCG cpus to TCG accel
>
> Thomas Huth (1):
>   target/arm: Make cpu_register() available for other files


Patch 5 doesn't compile, because it moves code out from
cpu.c to cpu_tcg.c, where it no longer has access to the
file-local set_feature() function:

  CC      arm-softmmu/target/arm/cpu_tcg.o
/home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/cpu_tcg.c:47:5:
error: implicit declaration of function 'set_feature' is invalid in
C99
      [-Werror,-Wimplicit-function-declaration]
    set_feature(&cpu->env, ARM_FEATURE_V5);
    ^
/home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/cpu_tcg.c:47:5:
note: did you mean 'arm_feature'?
/home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/cpu.h:1940:19:
note: 'arm_feature' declared here
static inline int arm_feature(CPUARMState *env, int feature)
                  ^
/home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/cpu_tcg.c:47:5:
error: this function declaration is not a prototype
[-Werror,-Wstrict-prototypes]
    set_feature(&cpu->env, ARM_FEATURE_V5);
    ^
/home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/cpu_tcg.c:74:5:
error: implicit declaration of function 'set_feature' is invalid in
C99
      [-Werror,-Wimplicit-function-declaration]
    set_feature(&cpu->env, ARM_FEATURE_V5);
    ^
/home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/cpu_tcg.c:87:5:
error: implicit declaration of function 'set_feature' is invalid in
C99
      [-Werror,-Wimplicit-function-declaration]
    set_feature(&cpu->env, ARM_FEATURE_V5);
    ^
[etc]

I've applied patches 1-4 to target-arm.next.


thanks
-- PMM

