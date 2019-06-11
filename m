Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32D2C31E44
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 21:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 778B62080A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 21:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsXZ888s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778B62080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55418 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hao0e-0006Py-9l
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 17:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57860)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mrolnik@gmail.com>) id 1hanw0-0004De-1k
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 17:04:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1hanvW-00008h-TF
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 17:03:32 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:43597)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hanvT-0008KR-1d
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 17:03:29 -0400
Received: by mail-qk1-x741.google.com with SMTP id m14so8599804qka.10
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 14:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Zsyr6Dy7WAtnrCuI44Erz3vUL5g/77vc95SbMfjGwpg=;
 b=KsXZ888sQQwtrVpV4P+eg78DaAgT/xZ6ERk9ahURi1F313JYGPoQVCRes4P+qiowTC
 0chb8vGt2fgKpscWgjAw8K89GwbX0e/cou+euaaLZ/Xi/ru1wHtZtQ85K68jSRKS/+P5
 16qSIzFmpEhV8vjm4rUBNExdqUwtbyr28HFxLn5eBSlw6PcEA+AU5cng0gaOvSv0lYjA
 sBGoVP6QXXrQe5itbnAfoiGdRenD6DU7j2H8mDOa1z1JN3T2fmvp8Hjk5JjlDFvr2isY
 iwGkwSMr0T/6GlKFM5WQBOt5TxLE/QN9rMbgd0AF53GNqnm2SxDg+D7aA3OYj4DnVvOR
 4VRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Zsyr6Dy7WAtnrCuI44Erz3vUL5g/77vc95SbMfjGwpg=;
 b=A/d2qFYvc/S9PJzsY+9lHqeiXb61MWqCN3pkvwSbahh+7Euz2vMn3cNviOatEiq/vF
 val989VzQZ62x0i8opxhgvd8CAVcGs+wCikljBUEvjBPOAlAmeXRAvC1lcIC5XFXYFbQ
 JDT1QKgk+y1ZBbGlcnXGK9xYd5L9zWHeVw+KtDrgqEuVcMzTCcKS1ybXkHEvyjmqiKbf
 n3VKH9mqxaymTVXabH9UW1NyQJSJWm9TCTokPRNsMZMjdbrQleWn6ooExZsWDpAcT37c
 bGQQ7Kv/tj4xMVmn8Uu2ZjJ2DoEMb9ERmEXlBnxP3DGhAg7yMZgJkDcYEtipCf4el1Om
 bc4g==
X-Gm-Message-State: APjAAAVU6/BT4zljZt4m3e3xy2dH7ZyLT7QyFgRLlNb+TsYRTCa7fpxU
 Hq5yWLfeffDAnrkK4lMCmhs3Mzx75snzwYyh1AM=
X-Google-Smtp-Source: APXvYqy1fNWXqiGDQYA2VkpeiRLyoIXGqNCsEBGjNSI5wontsBmXgRTbNvWGfqemWtZx3sj0qemTA/V+FjG4keuu4Dw=
X-Received: by 2002:a05:620a:5b1:: with SMTP id
 q17mr60446294qkq.174.1560286998280; 
 Tue, 11 Jun 2019 14:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190606193012.37715-1-mrolnik@gmail.com>
 <20190606193012.37715-5-mrolnik@gmail.com>
 <9c74618e-eb1e-0225-11dc-fe51e634d265@linaro.org>
 <CAK4993gLwXopG=EFNePsHJYmTZ5uU7EgbGe3Ad4ofOdCxQX-Mg@mail.gmail.com>
 <8429d379-c7e5-72b2-31cf-c4fa80f70695@linaro.org>
In-Reply-To: <8429d379-c7e5-72b2-31cf-c4fa80f70695@linaro.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Wed, 12 Jun 2019 00:02:41 +0300
Message-ID: <CAK4993hk62Tg4F9Gq+zFr6wbZ==fP7UPB42zc+sBJrKSztwHyQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v21 4/7] target/avr: Add instruction
 translation
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I am using this one
https://github.com/seharris/qemu-avr-tests/blob/master/free-rtos/Demo
/AVR_ATMega2560_GCC/demo.elf
it fails within __divmodsi4 function, there is rcall right after sbrc.

Thanks for helping.

On Tue, Jun 11, 2019 at 11:47 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 6/11/19 1:21 PM, Michael Rolnik wrote:
> > I merged all you fixes and I get an assert(use_icount)
> in cpu_loop_exec_tb
> > function, it happens on an instruction following SBRC.
> > what might cause it?
>
> No idea.  What is your test case?  And your tree, just in case there was an
> error in the merging.
>
> Looking through output from
>
>   qemu-avr-tests/instruction-tests/bin/SBR.elf
>
>      14a:       00 fc           sbrc    r0, 0
>      14c:       0f ef           ldi     r16, 0xFF       ; 255
>
> it works for me:
>
>  ---- 000000a5
>  movi_i32 tmp2,$0x1
>  and_i32 tmp1,r0,tmp2
>
>  ---- 000000a6
>  movi_i32 tmp2,$0x0
>  brcond_i32 tmp1,tmp2,eq,$L1
>  movi_i32 r16,$0xff
>  set_label $L1
>
>
> r~
>


-- 
Best Regards,
Michael Rolnik
