Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35EAC10DCE
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 03:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB2E92074B
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 03:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSxBiBY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2E92074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCx8p-0000Rj-Kp
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 23:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1jCx8E-0008MI-Ez
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 23:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1jCx8D-0000rC-FB
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 23:06:34 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43158)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jCx8D-0000pN-8I; Fri, 13 Mar 2020 23:06:33 -0400
Received: by mail-oi1-x242.google.com with SMTP id p125so11665455oif.10;
 Fri, 13 Mar 2020 20:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jgHkvJQ23aNBJa1zvHclZ6MIVjkv5zTUyf2e/vkQpHw=;
 b=dSxBiBY1icpi2kZYNZwCASVB/7NttN2dfAoaROThc339iwrxy+FgoeivSzKjlx/ZYE
 nofg7BBSqLHsqFejiE4M9t8n7EzK5CCWdX9Rwe/BnWbtKZCnYfIGDy9DriUMS18FAkPS
 It1SoxSrnrUISpkoUfo4rzd4SzgLaj9NY4ToJphKmuh3HSQz6X2iNucRmmPhj6+wwgan
 7KKqEmLKNz3DMlAb7ts877lzV+S4LpheHoLapwRNuxIaTSD7I6ZXXhRQvNbX7dgqWTtT
 kz9XRYEgxf7NuUDODc8evGwkFJBOGatrLQs2RlkhtCVBN9PpB1TU9rBVFKROT5FnaPwF
 VLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jgHkvJQ23aNBJa1zvHclZ6MIVjkv5zTUyf2e/vkQpHw=;
 b=JuRMJjpHrECj20d7ABUZVFbhbLOW3uyJ9iP4+/ECiX8lq2Kv81B4dsjkMP2v52Dtqu
 DqGZ476FNmtqemtWq9sHThskUXlqRJOfqpg0gN4gqMofBpJf+fFOaKUi5NBdnXhMaBdO
 fdM31XHczjQQSXSP/SKOqr9fu6YzmoDkfe2NP0wIKuQ7oZFilZAdhc1930GVg5ycuKpR
 ZaHibmre7G/uiJHWLye34LcpXO62wsgoWIwRAODBUsOyWvD2NO019frDkOj/KRtCCVnp
 kisgQDfR8bUXueJEU+shfysnmYQTu9qYkC9hbLtI+KvSXk49kwGNTU3vm/4/lkbcc81g
 BF4g==
X-Gm-Message-State: ANhLgQ0jh5vBKqkUDbxmBCTVU798uFZhUN9wSHvgwkcHJPcVY+5+R9As
 Ggovx3Z3cGO+nFtFTc205R8tW1wQYPTe9TuhpWU=
X-Google-Smtp-Source: ADFU+vspU2ezPepNSfSqoxoH78vQfVRnazN7Z5uABXUY/VzZOT4WTu+d7amPgCw9Vo8l1NUjNh5CZ8M8/Vf2JNcu3Fg=
X-Received: by 2002:a05:6808:48d:: with SMTP id
 z13mr5329429oid.79.1584155191885; 
 Fri, 13 Mar 2020 20:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200313002813.3857-1-yuanzi@google.com>
In-Reply-To: <20200313002813.3857-1-yuanzi@google.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 14 Mar 2020 04:06:21 +0100
Message-ID: <CAL1e-=ghc+6GRMd3NToF6+DeAz1VSR6bxuKd7dBtSJwrj50ovQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Update TASK_UNMAPPED_BASE for aarch64
To: Lirong Yuan <yuanzi@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Josh Kunz <jkz@google.com>, Shu-Chun Weng <scw@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 13, 2020 at 1:28 AM Lirong Yuan <yuanzi@google.com> wrote:
>
> This change updates TASK_UNMAPPED_BASE (the base address for guest programs) for aarch64. It is needed to allow qemu to work with Thread Sanitizer (TSan), which has specific boundary definitions for memory mappings on different platforms:
> https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/tsan/rtl/tsan_platform.h
>
> Signed-off-by: Lirong Yuan <yuanzi@google.com>
> ---
>  linux-user/mmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 8685f02e7e..e378033797 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -184,7 +184,11 @@ static int mmap_frag(abi_ulong real_start,
>  }
>
>  #if HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
> +#ifdef TARGET_AARCH64
> +# define TASK_UNMAPPED_BASE  0x5500000000

Hi, Lirong,

Can you point from which line of the file you linked to did you
arrive to the value 0x5500000000?

Second question: What about other targets?

Regards,
Aleksandar

> +#else
>  # define TASK_UNMAPPED_BASE  (1ul << 38)
> +#endif
>  #else
>  # define TASK_UNMAPPED_BASE  0x40000000
>  #endif
> --
> 2.25.1.481.gfbce0eb801-goog
>
>

