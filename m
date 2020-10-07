Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A006C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58B2E20797
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A+rqDpX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B2E20797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQB3r-0000eq-BI
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 11:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQB13-0006m3-7y
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:06:05 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51960)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQB11-0000Yf-Gm
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:06:04 -0400
Received: by mail-wm1-x342.google.com with SMTP id d81so2700603wmc.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 08:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=3nk7/5ESvAKdkMMMWB4hPgfJ+WKGY3UwSQ5z7ObB5NQ=;
 b=A+rqDpX3HXBlMaPFgIDdD2nqca+mv1gTl/hOCcrv+utPGYf6yQnMAXemoFnnQ7pfZA
 HxrfwF/qe80By9/1TBhx0zVmtcGEdV3Jmk0OyQq5yDMhkiRvUE6K+tDVMR8xSAz5JFQw
 /kVqOijEfz3bLer+Rffd33IN0vcEoRUN0XapORl3OTcJYVClqQLVpqFxnc6Yjl8jr8K+
 NpyNeeLptX8v7b4wI1kFpwt9zhZdr2+swXDrU7c2W1/ppTnpkhAL1m66tG1frbbOIdy1
 o+h6dnT+fVcUwy7mihwxUD7hpIN+6E4YgkltbZeF/vdbkORNhvreEs/hL3b5Po/UVVi4
 gjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=3nk7/5ESvAKdkMMMWB4hPgfJ+WKGY3UwSQ5z7ObB5NQ=;
 b=gTtjhcBkT54cmSnOKhtNo6PdzIXJhR3OGeytgeRHEGiBFgf3vRU/AAEqsEweVaT7eC
 feTJvGeyc6TnpCX/6VrDxHQBtsK1eI7ycK6Pos5/VdxPyTr/xgbfp2SpwjoO/0+BqqaZ
 HnCmMkqGayC5TuEE5dgnp9IaqVE8YLxRShE38DyhW+r6J8x5HHS1SAdJaNZCHXd1WgC+
 fpGQg/M+x6nDu3S8K4eI0RiNHIE1v1g1H6LPFihJyJW+0tfVMDDsy8KEsQPZHICB8q4q
 eFlLaC0sArrrATES76uy1UTsK66t8FSa94RvppvW7rlt8fz0X6ZvmtSHov+FUjHRdekn
 XH/g==
X-Gm-Message-State: AOAM533qKCwZdYD1HHHrrEvoDKreEmqgkiOgBCFCyWyPYVIfqxaPecQN
 9Ft1o4zYH8slcPIiCFqvZJhKpA==
X-Google-Smtp-Source: ABdhPJyYorExBAZQGFQ1f53bqYUHMgGm6/ZhzWUunzg6hyY0KNkMx5aM+HXF72UyjJ1gGD3v2LBbAA==
X-Received: by 2002:a1c:9612:: with SMTP id y18mr3953724wmd.55.1602083161401; 
 Wed, 07 Oct 2020 08:06:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u8sm2919462wmj.45.2020.10.07.08.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 08:06:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CA6DB1FF7E;
 Wed,  7 Oct 2020 16:05:59 +0100 (BST)
References: <20201006172359.2998-1-richard.henderson@linaro.org>
 <20201006172359.2998-2-richard.henderson@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/1] tests/tcg/aarch64: Add bti mmap smoke test
In-reply-to: <20201006172359.2998-2-richard.henderson@linaro.org>
Date: Wed, 07 Oct 2020 16:05:59 +0100
Message-ID: <87lfgiyt2g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> This tests PROT_BTI, and also does not require special
> compiler support.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/tcg/aarch64/bti-2.c         | 108 ++++++++++++++++++++++++++++++
>  tests/tcg/aarch64/Makefile.target |   7 +-
>  2 files changed, 113 insertions(+), 2 deletions(-)
>  create mode 100644 tests/tcg/aarch64/bti-2.c
>
> diff --git a/tests/tcg/aarch64/bti-2.c b/tests/tcg/aarch64/bti-2.c
> new file mode 100644
> index 0000000000..6dc8908b5a
> --- /dev/null
> +++ b/tests/tcg/aarch64/bti-2.c
> @@ -0,0 +1,108 @@
> +/*
> + * Branch target identification, basic notskip cases.
> + */
> +
> +#include <stdio.h>
> +#include <signal.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +
> +#ifndef PROT_BTI
> +#define PROT_BTI  0x10
> +#endif
> +
> +static void skip2_sigill(int sig, siginfo_t *info, void *vuc)
> +{
> +    ucontext_t *uc =3D vuc;
> +    uc->uc_mcontext.pc +=3D 8;
> +    uc->uc_mcontext.pstate =3D 1;
> +}
> +
> +#define NOP       "nop"
> +#define BTI_N     "hint #32"
> +#define BTI_C     "hint #34"
> +#define BTI_J     "hint #36"
> +#define BTI_JC    "hint #38"
> +
> +#define BTYPE_1(DEST)    \
> +    "mov x1, #1\n\t"     \
> +    "adr x16, 1f\n\t"    \
> +    "br x16\n"           \
> +"1: " DEST "\n\t"        \
> +    "mov x1, #0"
> +
> +#define BTYPE_2(DEST)    \
> +    "mov x1, #1\n\t"     \
> +    "adr x16, 1f\n\t"    \
> +    "blr x16\n"          \
> +"1: " DEST "\n\t"        \
> +    "mov x1, #0"
> +
> +#define BTYPE_3(DEST)    \
> +    "mov x1, #1\n\t"     \
> +    "adr x15, 1f\n\t"    \
> +    "br x15\n"           \
> +"1: " DEST "\n\t"        \
> +    "mov x1, #0"
> +
> +#define TEST(WHICH, DEST, EXPECT) \
> +    WHICH(DEST) "\n"              \
> +    ".if " #EXPECT "\n\t"         \
> +    "eor x1, x1," #EXPECT "\n"    \
> +    ".endif\n\t"                  \
> +    "add x0, x0, x1\n\t"
> +
> +extern char test_begin[], test_end[];
> +
> +asm("\n"
> +"test_begin:\n\t"
> +    BTI_C "\n\t"
> +    "mov x2, x30\n\t"
> +    "mov x0, #0\n\t"
> +
> +    TEST(BTYPE_1, NOP, 1)
> +    TEST(BTYPE_1, BTI_N, 1)
> +    TEST(BTYPE_1, BTI_C, 0)
> +    TEST(BTYPE_1, BTI_J, 0)
> +    TEST(BTYPE_1, BTI_JC, 0)
> +
> +    TEST(BTYPE_2, NOP, 1)
> +    TEST(BTYPE_2, BTI_N, 1)
> +    TEST(BTYPE_2, BTI_C, 0)
> +    TEST(BTYPE_2, BTI_J, 1)
> +    TEST(BTYPE_2, BTI_JC, 0)
> +
> +    TEST(BTYPE_3, NOP, 1)
> +    TEST(BTYPE_3, BTI_N, 1)
> +    TEST(BTYPE_3, BTI_C, 1)
> +    TEST(BTYPE_3, BTI_J, 0)
> +    TEST(BTYPE_3, BTI_JC, 0)
> +
> +    "ret x2\n"
> +"test_end:"
> +);
> +
> +int main()
> +{
> +    struct sigaction sa;
> +
> +    void *p =3D mmap(0, getpagesize(),
> +                   PROT_EXEC | PROT_READ | PROT_WRITE | PROT_BTI,
> +                   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +    if (p =3D=3D MAP_FAILED) {
> +        perror("mmap");
> +        return 1;
> +    }
> +
> +    memset(&sa, 0, sizeof(sa));
> +    sa.sa_sigaction =3D skip2_sigill;
> +    sa.sa_flags =3D SA_SIGINFO;
> +    if (sigaction(SIGILL, &sa, NULL) < 0) {
> +        perror("sigaction");
> +        return 1;
> +    }
> +
> +    memcpy(p, test_begin, test_end - test_begin);
> +    return ((int (*)(void))p)();
> +}
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefi=
le.target
> index 491683e91d..d7d33e293c 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -26,11 +26,14 @@ run-plugin-pauth-%: QEMU_OPTS +=3D -cpu max
>  endif
>=20=20
>  # BTI Tests
> +# bti-1 tests the elf notes, so we require special compiler support.
>  ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_ARMV8_BTI),)
>  AARCH64_TESTS +=3D bti-1
> -bti-%: CFLAGS +=3D -mbranch-protection=3Dstandard
> -bti-%: LDFLAGS +=3D -nostdlib
> +bti-1: CFLAGS +=3D -mbranch-protection=3Dstandard
> +bti-1: LDFLAGS +=3D -nostdlib
>  endif
> +# bti-2 tests PROT_BTI, so no special compiler support required.
> +AARCH64_TESTS +=3D bti-2


LGTM

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

(I assume this just rolls up with your existing BTI patches).

--=20
Alex Benn=C3=A9e

