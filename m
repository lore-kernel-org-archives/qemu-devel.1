Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE6CC4727C
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:56:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF31421548
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UduuD1oZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF31421548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtdZ-0005vO-PU
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kMtR3-0000R0-Kh
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:43:22 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:42651)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kMtQz-0005sJ-A5
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:43:19 -0400
Received: by mail-ed1-x543.google.com with SMTP id j2so1365539eds.9
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 06:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JIyCcUqU+I+2Q6OrPjcxk7PebAegazxlkvgzooDEyS0=;
 b=UduuD1oZ41IMzCVxyekoLdEuC6s1v2qIupImEzkI92R7gxN+FoXFlgNzYeLv5JWv0x
 ff272nqku6EMZRs/RtvURn6GcIi3h/brwxlXenlCU14G1K4m4yAGAaLrKW7F0zPcNW+V
 lyjDuWCf6KKWGuMwLJEyA2ewFP8UMriWUe6Utx0TwzjftOyBjvaBHLNk82KUA7pewNLi
 yxVJITWbCxzap9rrvOsI2yZouHTFBY/JjEx+YwANbwFgQI9+230fL7XU7TaPvifsOvQ6
 lsvu4qILwNB0S/inwkAN1BY8DaCTiGewhcnuvFnKH2ISrE3nAN+wUCZURcp1kW0E5ygi
 hHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JIyCcUqU+I+2Q6OrPjcxk7PebAegazxlkvgzooDEyS0=;
 b=pgtGbZnW+GiHwFMz2XgNAc2YulB06/Z25wla33xdrxmxfk4ICSsIDhgJ40EpYIlLoa
 1ELiBCsMeTh1gAkBDGe6gNYHZd+EKDZGuTLYwR1Qh8nk1E5Rr58I1guFYeijq7kcNb9i
 Ye8q+v7jY1WhaBndUdCnAKt3pgwSwpKENyMi8gadNxFWPo422O8vd8cRsLCfK7kxDalm
 fnfyPBWb7t4fcJyz3NcRJ6jf3ANHh604j2XJ23QwN7z1/E0jewBckVAyhD98Ye+wKt7R
 dLlRsUH+sOFDJWXKlA8GU/BefZ8s3rqpym5VwD8AfPTZ/bbVqzCgZQopzGhFKOt8+DWF
 ownQ==
X-Gm-Message-State: AOAM530k20vgH8VHAB60DtWOx8K/WDWy2zg/Lwz8TSqG1DcN5hhFJlOX
 MwoMBpQNbIw5mAr3+JacphE1bG6D3Zh6p7ErZS2iJw==
X-Google-Smtp-Source: ABdhPJzZZkKfaRsUyK/PzaRm4khVZhHPqqAtuqT3zDunbjxbyOoPIM3B0T+8RW8A2g/5yZN7Nxw+PVNpr/x6onGWO5c=
X-Received: by 2002:a50:e68a:: with SMTP id z10mr1926827edm.100.1601300594518; 
 Mon, 28 Sep 2020 06:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200928125859.734287-1-philmd@redhat.com>
 <20200928125859.734287-2-philmd@redhat.com>
In-Reply-To: <20200928125859.734287-2-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2020 14:43:03 +0100
Message-ID: <CAFEAcA_Ga+155jEcGW0c0bcJ1m3h9xdRYeZH9tJF+7_z6KiGtw@mail.gmail.com>
Subject: Re: [PATCH 1/3] qemu/compiler: Simplify as all compilers support
 attribute 'gnu_printf'
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Sep 2020 at 14:37, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Since commit efc6c070aca ("configure: Add a test for the minimum
> compiler version") the minimum compiler version required for GCC
> is 4.8, which supports the gnu_printf attribute.
>
> We can safely remove the code introduced in commit 9c9e7d51bf0
> ("Move macros GCC_ATTR and GCC_FMT_ATTR to common header file").

clang doesn't support the gnu_printf attribute, though:

$ clang --version
clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
$ cat /tmp/zz9.c
#include <stdio.h>

int monitor_printf(void *mon, const char *fmt, ...)
__attribute__((format(gnu_printf, 2, 3)));

int main(void) {
  printf("hello\n");
  return 0;
}
$ clang -Wall -o /tmp/zz9  /tmp/zz9.c
/tmp/zz9.c:3:68: warning: 'format' attribute argument not supported:
gnu_printf [-Wignored-attributes]
int monitor_printf(void *mon, const char *fmt, ...)
__attribute__((format(gnu_printf, 2, 3)));
                                                                   ^
1 warning generated.

thanks
-- PMM

