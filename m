Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE25C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 20:04:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01682206E9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 20:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N40Qzfdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01682206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCqXf-0003n8-49
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 16:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jCqWY-0002SE-1U
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 16:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jCqWX-0008VG-1O
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 16:03:13 -0400
Received: from mail-vk1-xa43.google.com ([2607:f8b0:4864:20::a43]:46734)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jCqWW-0008RI-SW; Fri, 13 Mar 2020 16:03:12 -0400
Received: by mail-vk1-xa43.google.com with SMTP id s139so3008130vka.13;
 Fri, 13 Mar 2020 13:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+AMKrNV8pQ5JeLYHHAPiXeeRhvz9n2pjmBLgaO+ouSw=;
 b=N40Qzfddch3qZyldQfuH1n680Y219RPZaxfIjp65f8hHZfZB/5w53nU1s1pep7Y/yo
 ZDjE0xcwmhb2hudLix0JvLUolOFOX2NihEXIrToBw/y/An8x+LXqPZU3hnCl9YdxMK0E
 ArzpsoSPrfHz1FBZ1N+KuR/ezoVhXQK7yrsZIEgwErqy3LYWSreWBjXQegU6vj58eXL0
 O/eWNCDuBE6h/VlukC1nbwKGw4NMqk2IaE9gHY/MK/jrAtcc4wIdja64DkfnukWnZSg/
 0NVTjt35/Q98vk4aZTSeVKmPhymU0Tl5ysw5bw2i7sXmmW9wqCtJ7ymtZVn8eRRz8ZLd
 v+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+AMKrNV8pQ5JeLYHHAPiXeeRhvz9n2pjmBLgaO+ouSw=;
 b=TZvQ+P/Qd3mV1Yztevg9EC++XjTCe75tvkb1rEEDGxsOTMzQeLTHTYyeZuZIG2x8mK
 De3TPpYP9Mm1J6vyYROQmf7nHLPPFYQa7OSpEgMfWKyYoS4bA/WVH2pux8kc0uJzbWuG
 AYKdn4IQxUypvRlrcuBJUtxNMfiLDH8KU77XCU1oW54ZcDzF1v1BKEs3RjEeW2NhI5B7
 MS1afXK8MwNL+OeNpxspuPHuhCBxiwnZBhdYGOKphlcQ1obKJQAVlAGwbr58Hmc4fnd8
 iABcJPB9e8Dyum3T8FDriOwkgJ/Ddi/B/PsAtYakUN7pU+g47qUnN3Cqw2MhWP93B8uW
 mqoA==
X-Gm-Message-State: ANhLgQ21Q/xajcTBTK4uhijlJsn9UlkxKZzdAOkw30RCYPkrHUQeBr9M
 Adj4cL8JI3/Q3U58dB96l+ulpJIRawjAwwTPzaF48mSH
X-Google-Smtp-Source: ADFU+vvhsWbz1sUVQQ83PHvkTJKNsllisjVhdd/dXDv8tkh5teOi4R5U12lngcxs0+xv5SZidzy7V0PkpZCut0lL/WE=
X-Received: by 2002:a1f:5806:: with SMTP id m6mr9995562vkb.37.1584129792299;
 Fri, 13 Mar 2020 13:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200313183652.10258-1-philmd@redhat.com>
 <20200313183652.10258-11-philmd@redhat.com>
In-Reply-To: <20200313183652.10258-11-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 13 Mar 2020 13:02:46 -0700
Message-ID: <CAKmqyKPcUFuwoGaYFruUFe7=0uxZPykRpsGA1e+Os0APLZ-jjw@mail.gmail.com>
Subject: Re: [PATCH 10/14] arch_init: Remove unused 'qapi-commands-misc.h'
 include
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a43
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
 Alistair Francis <Alistair.Francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 13, 2020 at 11:44 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Commit ffaee83bcb2 moved qmp_query_target but forgot to remove
> this include.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  arch_init.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch_init.c b/arch_init.c
> index 705d0b94ad..074fa621b6 100644
> --- a/arch_init.c
> +++ b/arch_init.c
> @@ -27,7 +27,6 @@
>  #include "sysemu/arch_init.h"
>  #include "hw/pci/pci.h"
>  #include "hw/audio/soundhw.h"
> -#include "qapi/qapi-commands-misc.h"
>  #include "qapi/error.h"
>  #include "qemu/config-file.h"
>  #include "qemu/error-report.h"
> --
> 2.21.1
>
>

