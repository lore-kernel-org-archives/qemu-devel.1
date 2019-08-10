Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6A9C31E40
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 01:56:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 140802085A
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 01:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTtdXK2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140802085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwGcX-00035R-CQ
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 21:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48954)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hwGc8-0002bn-Ia
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 21:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hwGc7-0002lB-Bz
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 21:56:12 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:34292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hwGc7-0002kJ-55; Fri, 09 Aug 2019 21:56:11 -0400
Received: by mail-lf1-x141.google.com with SMTP id b29so63558176lfq.1;
 Fri, 09 Aug 2019 18:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KhestzNF3jl4BE+FK0L15HSsCgusxLq1SQq8c966BzI=;
 b=fTtdXK2CLQn8/o426mTdx1agdncusTwEBCGpnavQQfDDV4wRfU1RJt8zBfDh43zsq6
 7UT+ZTdUwmHWxY/d4oNV/ioKH04acZle6Xn7ADy3kdTGcwCGANQS4byC5ZXrZ6iilZmK
 wsvlKaOPliWhbHqWUj8zxKD9FK5H/Aa4P3J5I8JSYphWkEq15CVRVKw0pJyIp0W9P27a
 NWCm1sKKtP5P3pVwv76UsNfUKwvKDosOpO8ZJExb1HPHCMnC4uMXVtb+Oa8qMjahLVWq
 KMq7uQ946Fbuf+6mLxJMkdMUoyGsCVuqhfR9cmeoX61b7KOyCD8my/7PJ1BliO3vKN1p
 wu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KhestzNF3jl4BE+FK0L15HSsCgusxLq1SQq8c966BzI=;
 b=Ygu962dl0NT9Q1YD7SuH0NWGgPK5XAjjbUpqFZLykx6j1o1Y6tKwXPAqr3uTAc/DvO
 MxsVtAG+bokAygmAXGrDmuZs3CCukwcc4zmsEnBGXyiNeMR4XRvVv7D9ZXDviZU4PclM
 QE8/PAv9w9NosArYFklmLBVk7wyY/OkfETqroqg+ru096C5KQ3FGBpjztLaQdU8u1kCU
 Wu38j/6xx5XKNVPH/06vPxefD5f9ZSpJ3P+uoeC8oWpT08O7AlMjeoRmworz4IMHVVse
 lOnga38Uxm8pxBoGeKesvSPPskWaMk0OlxBKjXpsBlqO3irhC2kQVoqEH7ET9m3LFW5y
 kkaw==
X-Gm-Message-State: APjAAAUyoai+BsP54TOp4feuplCk7bL+zEaeo3L5I68UvjYbLT44TiYG
 TnQh0Li8DOFz+JQGa0vwxjL2nw1N8LRBKecS7mA=
X-Google-Smtp-Source: APXvYqwl/WKsRXczy15NeYJ2d2IA6WNoQyMza0uMg/Fj4dFFAEVahh4VJ4kNirIqSnI+/TdlWgASmTrB6HbvX5j5hyc=
X-Received: by 2002:a19:6904:: with SMTP id e4mr14603305lfc.156.1565402168608; 
 Fri, 09 Aug 2019 18:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190809091940.1223-1-alex.bennee@linaro.org>
 <20190809091940.1223-7-alex.bennee@linaro.org>
In-Reply-To: <20190809091940.1223-7-alex.bennee@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 9 Aug 2019 18:55:42 -0700
Message-ID: <CAKmqyKNPW=Jtp3PUdwuSzjNE7g58WdureNxAWUnK_KZ-Z17HnQ@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH v2 6/7] target/riscv: rationalise softfloat
 includes
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 9, 2019 at 2:22 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
> We should avoid including the whole of softfloat headers in cpu.h and
> explicitly include it only where we will be calling softfloat
> functions. We can use the -types.h and -helpers.h in cpu.h for the few
> bits that are global.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I just reviewed v1, but this also applies to v2:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c        | 1 +
>  target/riscv/cpu.h        | 2 +-
>  target/riscv/fpu_helper.c | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f8d07bd20ad..6d52f97d7c3 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -27,6 +27,7 @@
>  #include "qemu/error-report.h"
>  #include "hw/qdev-properties.h"
>  #include "migration/vmstate.h"
> +#include "fpu/softfloat-helpers.h"
>
>  /* RISC-V CPU definitions */
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 0adb307f329..240b31e2ebb 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -22,7 +22,7 @@
>
>  #include "qom/cpu.h"
>  #include "exec/cpu-defs.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat-types.h"
>
>  #define TCG_GUEST_DEFAULT_MO 0
>
> diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
> index b4f818a6465..0b79562a690 100644
> --- a/target/riscv/fpu_helper.c
> +++ b/target/riscv/fpu_helper.c
> @@ -21,6 +21,7 @@
>  #include "qemu/host-utils.h"
>  #include "exec/exec-all.h"
>  #include "exec/helper-proto.h"
> +#include "fpu/softfloat.h"
>
>  target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
>  {
> --
> 2.20.1
>
>

