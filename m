Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C90CC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 14:28:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AB36218AE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 14:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j77RHnqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB36218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAawG-0006Hp-IY
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 10:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iAavN-0005cf-18
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 10:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAavL-0002vD-8v
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 10:27:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAavL-0002uY-18
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 10:27:15 -0400
Received: by mail-wr1-x442.google.com with SMTP id y19so7178158wrd.3
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 07:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M0rwh9vsgamdFHoBBBtNFCYgmuc/OSe8teYV5KcbESY=;
 b=j77RHnqfDMnja6nQGwyQwM+Qq9jmgcU2G0DmgpSgzPwmIh5kMaXaaKGi7LqDFsh9Sv
 v/qbB8dSoBlVRqYqzSeM10wUM7Ov0jFn72DEOUyJVC/IqKUWS4GEt/zRhsiMxSePlcqz
 LW1zkfRwlyDFU9IVJIedY6NsXa8bm5HV9vHQHnGt95vyZnLujL+3J2VjwIftu2KZEG3k
 N3HsjJ6gu+xmQ0WZGmu8QT+f9w3N4QFzzECU+ekAjh1pxt4KpjX91fHsmf+HDyFQPT01
 JeLMzr+UWW9TgA6ZYLzNsNgpwNCYdY6l1RO6F/Wz8Oq0YwaFj579DsGitbMB59TC0Z+V
 NoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M0rwh9vsgamdFHoBBBtNFCYgmuc/OSe8teYV5KcbESY=;
 b=PC9hAydWg4rdgse8gg+uXSWBAe3VPJ5sHV60szu/LvoVcNj6wkDBv8U3RrFroI/sUN
 kSSRCdy155S/YGSvcrbX0fid/ee0obHNpCGoOzwAsAmuO+rR6HWR+lT8Gu+GbkBrx7Lg
 RcRT1lRMLOe5xVmzl/xvPs5XsOgBLvGVX76bm5FqvrxD6//Smytr742jLcw31Een5ZqM
 GacXsaefHpn42r/JmSKAb+g77tPd+0a7i1xF6RxgWFmC6mpGw6sAwRE7RJOq7aUjQoQx
 mkTmh7sfvhsLrXi4AQpGMtf4yFeIWReousg2IYSsUkoe0E+XRPjUf1gV23ouOhyRTqKf
 JUrw==
X-Gm-Message-State: APjAAAUIE37sP761WxagdJc0QJ0Jj81CLSsT/RFyfER9SqyPv5ySxWbL
 ZZqB9uMOS2R67NVe1MBTSCF9KPIMcHL2Mj9Zc8922A==
X-Google-Smtp-Source: APXvYqxE87kAeDROkA+5usfvPPEs6knR6OCjFHG2Qq6t6wi+2GIylcnemotB8yLi/nWTJrMhpzp9QtZMACKIKjt4UE8=
X-Received: by 2002:adf:e9c5:: with SMTP id l5mr3332649wrn.40.1568816833715;
 Wed, 18 Sep 2019 07:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190918121101.30690-1-philmd@redhat.com>
In-Reply-To: <20190918121101.30690-1-philmd@redhat.com>
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Date: Wed, 18 Sep 2019 15:27:03 +0100
Message-ID: <CAHDbmO3tc49r9y8weBd_8F2GD7+ojPu_viqq3kH0k5zkokzqfg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] target/i386: Fix broken build with WHPX
 enabled
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
Cc: Lucian Petrut <lpetrut@cloudbasesolutions.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 QEMU Developers <qemu-devel@nongnu.org>, Justin Terry <juterry@microsoft.com>,
 Ilias Maratos <i.maratos@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ah I though these would be enabled by default for x86 hosts. I guess we
need another build entry in .Travis even if we can't test it there.

On Wed, 18 Sep 2019, 13:11 Philippe Mathieu-Daud=C3=A9, <philmd@redhat.com>
wrote:

> The WHPX build is broken since commit 12e9493df92 which removed the
> "hw/boards.h" where MachineState is declared:
>
>   $ ./configure \
>      --enable-hax --enable-whpx
>
>   $ make x86_64-softmmu/all
>   [...]
>     CC      x86_64-softmmu/target/i386/whpx-all.o
>   target/i386/whpx-all.c: In function 'whpx_accel_init':
>   target/i386/whpx-all.c:1378:25: error: dereferencing pointer to
>   incomplete type 'MachineState' {aka 'struct MachineState'}
>        whpx->mem_quota =3D ms->ram_size;
>                            ^~
>   make[1]: *** [rules.mak:69: target/i386/whpx-all.o] Error 1
>     CC      x86_64-softmmu/trace/generated-helpers.o
>   make[1]: Target 'all' not remade because of errors.
>   make: *** [Makefile:471: x86_64-softmmu/all] Error 2
>
> Restore this header, partially reverting commit 12e9493df92.
>
> Fixes: 12e9493df92
> Reported-by: Ilias Maratos <i.maratos@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  target/i386/whpx-all.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> index 0c15241ae4..def0c28480 100644
> --- a/target/i386/whpx-all.c
> +++ b/target/i386/whpx-all.c
> @@ -18,6 +18,7 @@
>  #include "sysemu/cpus.h"
>  #include "sysemu/runstate.h"
>  #include "qemu/main-loop.h"
> +#include "hw/boards.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "migration/blocker.h"
> --
> 2.20.1
>
>
>
