Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C211C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:11:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF883208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H8FxLO88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF883208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48962 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcuEa-0004Y2-7G
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 12:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59509)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hctRF-0008I6-0B
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hctRA-0001DS-7i
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:20:50 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hctR9-0000Zx-Ir
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:20:47 -0400
Received: by mail-wr1-x441.google.com with SMTP id p13so10383191wru.10
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 08:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=J3zDDuCsQV21k3G8y+iBAAZT8+0LQktIOuTtHzn2g1s=;
 b=H8FxLO88RmHe9zbf4i6zVNcVyVZ5ywyz1sT5hrvU0ykFE3ly+9aeYqy8kxvT+hdKSW
 q4ErWOwk18+zG8UdQDDbSoP2FlofvXkUemOEO+dQz552M/P2k36iBjHMUMuGNPu0Cbke
 0NxZqmW3hJwzzMj6f/DMkXJCJfl2CjsHMcwAqdzV3vdFGDliDTPPs7g3wiliP8lXzkf+
 OakvAWq1gaEsvwylpBgrI/JJYqH0gdRwXEcBXbUiYOcA6p7eRBL1Evc8lyYdBC+DjCQ1
 oC1WKZdRWY2bAblLHtzZSlWUjv+d7p1dDukuoaPeVIM5N/Tef4tuaXveUievE0lXfKqj
 TSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=J3zDDuCsQV21k3G8y+iBAAZT8+0LQktIOuTtHzn2g1s=;
 b=jEiwuvxETmmKsO/Y3btIlshrGCCzvgBmA01+516kqLhLY/OKMBgBknbwq8NGEblTQZ
 Ii7+NYtTr1TehhLSDNvOTfClRXfDxqccbo4ARevSJsridi/iUH6XafiM+IMwUBi18FUm
 OWTM5ceeyfGuhev4SK2g3s7j/kHAikEgvu5EAzBYWoV+VMjnu+NbknUMekpSKeFWWXie
 +nQkamFelTPZw6SzbsEFfXQRyw//WYvorVnLewgy1YVFbrpGHW0FS67PcGcyiJ1hK3gU
 5GoynZjWhrfTWy70iVTS1PZG36B0U9pjXyXq/Jz5D4kUeJVNS/EeHnxDeAtKm+i+cEns
 k2Kw==
X-Gm-Message-State: APjAAAV6xn7yQHz0cmkuoQKRR2CCV/OjJYqtNBLpt0nduSktR+xF8Jij
 ROqerr/3ZBWyTxyzRZh60y+m3Q==
X-Google-Smtp-Source: APXvYqyRTH7Q3zhhs1rc6/j1TvrfxLfaMqs0CTMbNzSumaIkwPh9mOjIc1VcmUv7FKALEXHinXk5DA==
X-Received: by 2002:a5d:6b12:: with SMTP id v18mr78408078wrw.306.1560784797014; 
 Mon, 17 Jun 2019 08:19:57 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id a7sm10381899wrs.94.2019.06.17.08.19.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 08:19:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C7C501FF87;
 Mon, 17 Jun 2019 16:19:55 +0100 (BST)
References: <20190531154735.20809-1-philmd@redhat.com>
 <20190531154735.20809-2-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <20190531154735.20809-2-philmd@redhat.com>
Date: Mon, 17 Jun 2019 16:19:55 +0100
Message-ID: <878su09r38.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] target/arm: Add stubs to build
 with CONFIG_SEMIHOSTING disabled
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Miroslav Rezanina <mrezanin@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> If a distribution wants to build QEMU without semihosting support,
> it currently gets this build failure:
>
>   $ ./configure --target-list=3Daarch64-softmmu --without-default-devices
>   $ sed -i s/CONFIG_SEMIHOSTING=3Dy/CONFIG_SEMIHOSTING=3Dn/default-config=
s/arm-softmmu.mak

I'm still not convinced we should be adding support for stuff being done
outside the normal build process... that said...

>   $ make subdir-aarch64-softmmu
>   [...]
>     LINK    aarch64-softmmu/qemu-system-aarch64
>   /usr/bin/ld: target/arm/arm-semi.o: in function `do_arm_semihosting':
>   ./target/arm/arm-semi.c:321: undefined reference to `qemu_semihosting_c=
onsole_out'
>   /usr/bin/ld: ./target/arm/arm-semi.c:318: undefined reference to `qemu_=
semihosting_console_out'
>   collect2: error: ld returned 1 exit status
>   make[1]: *** [Makefile:204: qemu-system-aarch64] Error 1
>   make: *** [Makefile:472: subdir-aarch64-softmmu] Error 2
>
> Fix it by providing a stub when semihosting is disabled.
>
> Reported-by: Miroslav Rezanina <mrezanin@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  target/arm/Makefile.objs    |  3 ++-
>  target/arm/arm-semi-stubs.c | 21 +++++++++++++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
>  create mode 100644 target/arm/arm-semi-stubs.c
>
> diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
> index 6bdcc65c2c..39b02b1fa4 100644
> --- a/target/arm/Makefile.objs
> +++ b/target/arm/Makefile.objs
> @@ -1,4 +1,5 @@
> -obj-y +=3D arm-semi.o
> +obj-$(CONFIG_SEMIHOSTING) +=3D arm-semi.o
> +obj-$(call lnot,$(CONFIG_SEMIHOSTING)) +=3D arm-semi-stubs.o
>  obj-$(CONFIG_SOFTMMU) +=3D machine.o psci.o arch_dump.o monitor.o
>  obj-$(CONFIG_KVM) +=3D kvm.o
>  obj-$(call land,$(CONFIG_KVM),$(call lnot,$(TARGET_AARCH64))) +=3D kvm32=
.o
> diff --git a/target/arm/arm-semi-stubs.c b/target/arm/arm-semi-stubs.c
> new file mode 100644
> index 0000000000..a91ecbd9d5
> --- /dev/null
> +++ b/target/arm/arm-semi-stubs.c
> @@ -0,0 +1,21 @@
> +/*
> + *  Arm "Angel" semihosting stubs
> + *
> + * Copyright (c) 2019 Red Hat, Inc.
> + *
> + * Author:
> + *   Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +
> +target_ulong do_arm_semihosting(CPUARMState *env)
> +{
> +    g_assert_not_reached();
> +}

Could this not just be added to arm-semi.c in an

  #ifndef CONFIG_SEMIHOSTING
  target_ulong do_arm_semihosting(CPUARMState *env)
  {
      g_assert_not_reached();
  }
  #else
  ... rest of arm-semi.c....
  #endif


--
Alex Benn=C3=A9e

