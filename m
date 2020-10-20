Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3757BC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 20:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C8B206FB
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 20:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lDmNek6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C8B206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUxyC-0001yh-50
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 16:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUxx4-0001Jr-9k
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 16:09:46 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:34221)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUxx1-0004xf-Tw
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 16:09:46 -0400
Received: by mail-ed1-x544.google.com with SMTP id x1so52445eds.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 13:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Sp1TpqpKZUEUMinzBTWcok5u1j2qfcRRULl9ZfNE/kw=;
 b=lDmNek6IYfLGpJxVhjVEmmU6fLVmWkhdCF+T2OyGYMN4YBLFTAyv91LkIReshRKfac
 MWIPqAEzytiVMiD8jk4ZYb/dfCwAHhX27JQtH99FQsluFWiN+xesiPi+IRWx9d9KaOrq
 VyiiAniMuMANVad9oufcQqcN021Ajl+JY50mcUfI4kfWU7uaq1zBrd+kgqNgF0zqWbUa
 mlnSPEKszY9RKy1fc/WPY4hsEJK1yaa5QlREWsMf94uPG/TXNtmpetN4V+FB/AEw8uhK
 4xiTnAdhzVAXUO78FY/OmLOlr0qPLJeXtT6+eh0aNbiAmNMyKPBwOluQvl6QjKhM3M23
 zHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Sp1TpqpKZUEUMinzBTWcok5u1j2qfcRRULl9ZfNE/kw=;
 b=NrOrRivEDpvpx9aU9229XSfKwbLlucdRy1R3S2QfiOqd8r19psT4HYrQ2lDN+SLtEs
 1qLpgKn4tow6bBiueSxLZstKWW3W8qC2oQezJkusXk9j9XmGYmriCn8vA8HRqFv4I5uY
 b1qLHCl+x4W9bxFCRBdl9p7b2FRp1fnvdwUzSWpHqOu+VgaXOlBfbQ4nUGKZDediAq94
 /rWuaHrVo9Qkfzb1omKjn4veZ9mwgknO4obf93yJiMgZubMHyr6tfRlwaQ9mj7jAPTHw
 nIsQrjqj/qzENV5faCGzSW6QjfJSUXhQ95s7SP/s8ox+7lRHPT52VP0IiHOxpojdIzoL
 2okw==
X-Gm-Message-State: AOAM533fAeaojNBwAxhwM6sbCvQcjaDPx6o1o3PIE0EM6VjcyCNCEQq5
 D4WCXfG4xhA06EPazVpS/Ur8S5yStjh12k3R4o2ciw==
X-Google-Smtp-Source: ABdhPJzXVH4UwDw/CFPjiRlyMeVHwOdmOVc2xI2+0yj2r4gXk2b8Yr3G4lFtLippT4jsaqkb67xuAuBQ9VwXxn39ap0=
X-Received: by 2002:aa7:d79a:: with SMTP id s26mr4487917edq.251.1603224582227; 
 Tue, 20 Oct 2020 13:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201016184207.786698-1-richard.henderson@linaro.org>
In-Reply-To: <20201016184207.786698-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2020 21:09:30 +0100
Message-ID: <CAFEAcA9d7h=LCKP7B3G+Wx5CUr41+bY9ziyycGamL0EsTMgxDQ@mail.gmail.com>
Subject: Re: [PATCH v11 00/12] linux-user: User support for AArch64 BTI
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 16 Oct 2020 at 19:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The kernel abi for this was merged in v5.8, just as the qemu 5.1
> merge window was closing, so this slipped to the next dev cycle.
>
> Changes from v10:
>   * Include Phil's plug of interp_name memory leak.
>   * Convert error reporting to Error api.
>   * Mirror the kernel's code structure for parsing notes
>     (though Error means that it's not exactly the same).
>   * Split aarch64 stuff from basic note parsing patch.
>
> Changes from v9:
>   * Split what is now patch 7 into 3 more (pmm).
>   * All prerequisites are now upstream.

Unfortunately the bti-2 test dumps core (x86-64 Linux host):

make[2]: Entering directory
'/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/tests/tcg/aarch64-linux-user'
timeout 60  /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/qemu-aarch64
-cpu max pauth-5 >  pauth-5.out
make[2]: Leaving directory
'/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/tests/tcg/aarch64-linux-user'
make[2]: Entering directory
'/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/tests/tcg/aarch64-linux-user'
timeout 60  /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/qemu-aarch64
 bti-2 >  bti-2.out
qemu: uncaught target signal 11 (Segmentation fault) - core dumped
timeout: the monitored command dumped core
Segmentation fault
../Makefile.target:152: recipe for target 'run-bti-2' failed
make[2]: *** [run-bti-2] Error 139
make[2]: Leaving directory
'/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/tests/tcg/aarch64-linux-user'
/home/petmay01/linaro/qemu-for-merges/tests/tcg/Makefile.qemu:85:
recipe for target 'run-guest-tests' failed
make[1]: *** [run-guest-tests] Error 2
/home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:61:
recipe for target 'run-tcg-tests-aarch64-linux-user' failed
make: *** [run-tcg-tests-aarch64-linux-user] Error 2

I've dropped the series from the pullreq.

thanks
-- PMM

