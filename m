Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEDFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C92820679
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tXLxtcpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C92820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jklCc-0000Do-Aj
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 05:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jklBs-0008Ce-DT
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 05:14:05 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:42928)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jklBq-0001OO-Fo
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 05:14:03 -0400
Received: by mail-oo1-xc41.google.com with SMTP id 127so921616ooc.9
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 02:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6JmxOQ4y+PhXvFFTqFLGY0etJxdCYrrpTCb0vX4qbqA=;
 b=tXLxtcpwb6XrBBI9ohuiK5ibTZwFwUX5tK8WqM0zpawYQAdRLu3XNhfTH29OljVtaF
 fdAK0v1BzYMnM7QFgaF0u9LYrmD+WQuC+aCq/nBbiQjJ8HuIL54z+333HMhiVnBD+knt
 kA/70vS9T9ogCcE9bVgLHfV6OgJLWpu3IS+OqNYHBp8fiNc5bwJUty+8FfR4PnNaLr7Q
 kFq5vP04HK7S3yP6ySdwHe8lHjUxsCOzKrjCa/q/hOxXWcLGl1bwI9R3DLLHpmxRwqjE
 8CyupXzw242j+s8JoJLH3/3BH+r2K3Pj8//vKkcgMKn3IffPBkQ5uJE8+fg24NQEX1Ux
 vkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6JmxOQ4y+PhXvFFTqFLGY0etJxdCYrrpTCb0vX4qbqA=;
 b=Ik9yfXdmGP7AbE1g8xi3XI8nec1m7P7xt/lV1eOF0Cdngenbql3TM9g4OBw1+UGAZl
 ukcb5YxU68hDyEjK8jzKWfb4S671j5JwKtvb32eQKFJ+DUqNrBkKW9ccolU5cpl/4GND
 diC/JxDTI4fsvNTbpi2FOFT4WqAMNctAUUDtZ0NilJ/keJh/uyZ8MPqWdtVF7k/pqTtd
 jrxHOgXfIFkjSAVGQJNAGP52tNWP8QMG3iuAP6UnZchygFJ4tZHP/YQn1CFsUW8+O4vN
 wcI9ewWBeStv4ap1II6LegK77VEnb0YAg7D3tLiVeuAc7pZzllyzHUgxyp1LGqltzEZh
 CvMA==
X-Gm-Message-State: AOAM530OTJkmDkumrg69NwFDftyF4KXJ+9L+lqd4xCda1bj+oy2aOUJr
 lG0ZWli+LxFQLDUa6+2fPMzrqQoKfVuC0f5CqhLxhg==
X-Google-Smtp-Source: ABdhPJwW/Uqu0r7ei6lIlRIn3LMigHyhcXE+JYnC6KSLi2aD85WzWPPfXZtC1iF+DJVu1YZIWsQjm+6d167PfajFRPM=
X-Received: by 2002:a4a:9528:: with SMTP id m37mr20261541ooi.85.1592212440830; 
 Mon, 15 Jun 2020 02:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200614034729.3004-1-jiaxun.yang@flygoat.com>
 <CAHiYmc5haGPCxR4Nr-WmL_4PG48F+dqeJLzvVRHjcoBZKykr8Q@mail.gmail.com>
In-Reply-To: <CAHiYmc5haGPCxR4Nr-WmL_4PG48F+dqeJLzvVRHjcoBZKykr8Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 10:13:50 +0100
Message-ID: <CAFEAcA_dBdns09k=kxpc=OqpYK3FJH=DZCx2+FgpqnKh_6Oxkg@mail.gmail.com>
Subject: Re: [PATCH] target/mips: Fix PageMask with variable page size
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc41.google.com
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
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>,
 "aleksandar.rikalo@syrmia.com" <aleksandar.rikalo@syrmia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 14 Jun 2020 at 22:52, Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
> When you change machine.c the way you did it, you need to bump the version. Please see git log on machine.c for details.

>> --- a/target/mips/cpu.h
>> +++ b/target/mips/cpu.h
>> @@ -617,7 +617,8 @@ struct CPUMIPSState {
>>  /*
>>   * CP0 Register 5
>>   */
>> -    int32_t CP0_PageMask;
>> +    target_ulong CP0_PageMask;
>> +#define CP0PM_MASK 13

Does CP0_PageMask ever actually hold a value that won't fit
in an int32_t? If not, it might be preferable to avoid changing
its type to avoid the migration compat break, even if MIPS
doesn't have any versioned boards where we have a strict
don't-break-compat promise to users.

thanks
-- PMM

