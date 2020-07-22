Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A536C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD6C206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ukv+Bno+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD6C206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyHy3-0008Il-7m
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 12:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jyHxC-0007Mu-JN; Wed, 22 Jul 2020 12:50:50 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:38559)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jyHx6-0001W5-4a; Wed, 22 Jul 2020 12:50:50 -0400
Received: by mail-io1-xd43.google.com with SMTP id l1so3244613ioh.5;
 Wed, 22 Jul 2020 09:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XUg1u1TtQnycfs+N+tRiWOafjQdiRU9tLYD9iCjxkx0=;
 b=ukv+Bno++XtwyOTXQwpYXB7zKWNkuEADe+Z0+TvzX0fj8rhPb9jNzxylM8m8Bb6NCY
 FjeHg7t1jG754mia4Van59B80I8vR6v3JJ2hmRu+a4xLfcvoVlKSyKqkndRG8aeS8dQ4
 unb0xqqoKv+hSbqVCanLrUVyIz798Pl+oAPgAq+l8Nuo7ap0O7drZHn+jWj97na2Ac9a
 0l+tzUL2R6R9gbFLnEa0yXvYyzfeu5F1wrO0tRttmwA79v6UaR7IsvH8F3H3Zkb/OFpX
 s7DtM0VywXVUnXz+RVca/3kzptGHG2YiiCa/JqBPFyPvIOJCTzho546Zq7QzHjzO9YIj
 JwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XUg1u1TtQnycfs+N+tRiWOafjQdiRU9tLYD9iCjxkx0=;
 b=NGF94i/wXs3ICN+DGDsDSSmeXJIK5NA5JojRJoNkEI8yMSksZMnWnOVAV6o0feFeQH
 1h0Y0SNTdM4iYCSDSYAggwE19fXoINf9QSboIbve90SM8wRDrlngYm/J+qkMQ6Utb6Ze
 QqO7k+t98hiuA33ZrI3Dt5hdpn3xc08Pgg2YobKkp8i51tZCcWIAyuMIzrFl4seNgZdM
 x67+XnS69fZ46qUV+B4dqPX+MPCGQEAHZ/uomYtMZB/In4jRKWXswVx1MmOXg047zv26
 UD4JY3B0rXID9gLrJ5dEi/koQx5rq8XwMafP5F7bEp81kN2QA1gnkZxIJjnWdmVB5G/C
 MC/w==
X-Gm-Message-State: AOAM532uUyxrLYtB0x96+ye+YaAne3UUYRs+s7Ia5zs3nVaVJcjxgL9m
 1Bt2wV1lZ0W1L27EWPm1WFovaku5QblajV5fJlU=
X-Google-Smtp-Source: ABdhPJwzKkDOKGGKgNIjpbPevG1J8O6CFdCDpqOlgCWcIA7at9mx1yjJ79nqvW4/wCkn322yZSYw8SH4wRZkp4W5FaI=
X-Received: by 2002:a5d:9306:: with SMTP id l6mr652462ion.105.1595436642400;
 Wed, 22 Jul 2020 09:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200721133742.2298-1-zhiwei_liu@c-sky.com>
 <CAKmqyKMPrwkxhXgfWqEofGUdKTJ3jAi7hQ7h6hEP-zFDN3Yt9w@mail.gmail.com>
 <CAFEAcA87pws6QNEoJk4B-+vQiE3Pe7munfJiWgQZuTDZ+uBZwg@mail.gmail.com>
In-Reply-To: <CAFEAcA87pws6QNEoJk4B-+vQiE3Pe7munfJiWgQZuTDZ+uBZwg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Jul 2020 09:40:35 -0700
Message-ID: <CAKmqyKN_OoqmXAKm-rLZRue3T+Bja=tFKdrSRWHuZD+WmBOaVg@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: Quiet Coverity complains about vamo*
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 21, 2020 at 8:30 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 21 Jul 2020 at 16:19, Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Tue, Jul 21, 2020 at 6:38 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
> > >
> > > Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> >
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> Interestingly Coverity's latest scan has decided all these
> issues are 'fixed', even without the assert. I guess that the
> online version of Coverity has had an improvement to its
> checking and so is now able to figure out that it's not going
> to overrun the array? Still I think the assert is worth having.

Strange.

I'll still apply these two patches.

Alistair

>
> thanks
> -- PMM

