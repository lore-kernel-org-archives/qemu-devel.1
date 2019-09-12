Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0051AC4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:55:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C00152081B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IVdAIplK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00152081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8QV4-0008TG-UX
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 10:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chihmin.chao@sifive.com>) id 1i8QU9-0007mQ-97
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:54:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1i8QU8-0003iW-0N
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:54:13 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:42703)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1i8QU7-0003hy-ON
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:54:11 -0400
Received: by mail-io1-xd41.google.com with SMTP id n197so55365560iod.9
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 07:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fbRovGJL1ys/q2wukbTOOY8adLV0Az6QtxpHk6uBFbw=;
 b=IVdAIplK9n52ntU2Pow8IrXJ+90KUT9W2CqqheuLIQaTgdhoRrgManupeYVuc/BOPl
 0ByfGEdlymTICgByaC/X+nXAWjMScFRMrFpxoD42iZdwec+PskpX1MlB5AQl1qZb8Clf
 R/vmDvbA8e8s5+4yP11Yzpwe48Z0/cxiqkPO4yrNwcSSQIVNWuEcJGwiJqbC99BY8ADe
 U0vLRT01t1+oGhpjpcrYdocLfSBNfgta7kUmmYyhRzaqR1pbOujmr+KQ1qUxuPx/gkTX
 zumuKntGaskLbuQA/AVJnfwLMeDU21FU0/t4gtDEwwj93W1T4IpMSR1uUsRSl/FXymTq
 lVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fbRovGJL1ys/q2wukbTOOY8adLV0Az6QtxpHk6uBFbw=;
 b=BMHdInDZzvZ78qDrr1MyoKxlFI2GroYiQB/gVzAQmpqCqAug/4fRcIjRU3JvReXu8i
 LrKpqmNdr9Npubbn/ossUeYvm6Lr950WjlB3mf0JNIg/t9tSEbC1E44g9mZEO+X4Ilf4
 hkE2Cqbc36O/NmYPzD54txJ+Fn8Y2tIOamudSfa1EyZEjHf7wSZS14PdsZUs58x26GGh
 pvpAVx+8yATaNWn8jGaYjwEf1975LNQ2GIg+ymgfRpFGdk27Xj/1t8tcvhtayAk08DWk
 F6u8V1yV5salLAUMoQnxurPInmfbgvWbUDcxDmQ6FzCR6uKqN9kfvDm2LrJREk/bYjxo
 Zg9Q==
X-Gm-Message-State: APjAAAXTmolJl8xTw6/+cDzEcn+b+FAbyQl5FWdu9kTLNbeeyB9ytvcs
 hgLB8iJTUEgdIXY5PjPZqZCNhSTxeYzQQ683av76fg==
X-Google-Smtp-Source: APXvYqzFQgPIz3BCK6jmQh9qrkx3/l0CwCP1bBvD8YlgM3FqzMUzishwXi1TivXMAzMVEax/ydmFTmiOnxLuM3EGHEc=
X-Received: by 2002:a6b:ec16:: with SMTP id c22mr4953253ioh.185.1568300050272; 
 Thu, 12 Sep 2019 07:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
 <1568183141-67641-2-git-send-email-zhiwei_liu@c-sky.com>
 <CAEiOBXUveMJGpavU7_zK0UTdNniQvnXnw5MvE-hu7yHCSw8MPQ@mail.gmail.com>
 <b9c89438-5346-e2ee-403b-3bc1fa1637bc@linaro.org>
In-Reply-To: <b9c89438-5346-e2ee-403b-3bc1fa1637bc@linaro.org>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Thu, 12 Sep 2019 22:53:59 +0800
Message-ID: <CAEiOBXXsag8hfHJGcqKLVKcVkndC67iPikcp-01WACoBA4ev3Q@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2 01/17] RISC-V: add vfp field in
 CPURISCVState
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, riku.voipio@iki.fi,
 laurent@vivier.eu, wxy194768@alibaba-inc.com,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wenmeng_zhang@c-sky.com, Alistair Francis <Alistair.Francis@wdc.com>,
 liuzhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 12, 2019 at 6:39 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 9/11/19 10:51 AM, Chih-Min Chao wrote:
> > Could  the VLEN be configurable in cpu initialization but not fixed in
> > compilation phase ?
> > Take the integer element as example  and the difference should be the
> > stride of vfp.vreg[x] isn't continuous
>
> Do you really want an unbounded amount of vector register storage?


 Hi Richard,

VLEN is implementation-defined parameter and the only limitation on spec is
that it must be power of 2.
What I prefer is the value could be adjustable in runtime.

>


> >     uint8_t *mem = malloc(size)
> >     for (int idx = 0; idx < 32; ++idx) {
> >         vfp.vreg[idx].u64 = (void *)&mem[idx * elem];
> >         vfp.vreg[idx].u32 = (void *)&mem[idx * elem];
> >         vfp.vreg[idx].u16 = (void *)&mem[idx * elem];
> >    }
>
> This isn't adjusting the stride of the elements.  And in any case this
> would
> have to be re-adjusted for every vsetvl.
>
>  Not sure about the relation with vsetvl. Could you provide an example ?

Chih-Min

>
> r~
>
