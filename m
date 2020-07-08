Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FF5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 00:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99CA62073E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 00:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbM+DraP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99CA62073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsy5X-0002WQ-Qj
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 20:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jsy4U-00023O-Nc; Tue, 07 Jul 2020 20:36:22 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:39032)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jsy4T-00030O-2v; Tue, 07 Jul 2020 20:36:22 -0400
Received: by mail-yb1-xb41.google.com with SMTP id 134so1267305ybd.6;
 Tue, 07 Jul 2020 17:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JOFJ6oH1odZlAZAnUFbaqkxYNsQU2RyPUzhXIwucLeQ=;
 b=PbM+DraP7ezIog/lpaOhmqOVUm2U7xtcvog3SQ6MsDk7ySCPvEJd5QFWz5SOGT2Ec5
 NWTVLn4ivDNLWq0OBbF2N9Mzi5tHazyYZW+yMOilMSYOt1/yMPXOu2EyKDaW1bX5Gx6d
 MOK98P0pq6YCig3DLG7daWowVJoJA3UsxbhHziKRChklBD0pnzJXhdyqy3Uted6CqyTG
 qQlGfzyNHsU1N6S5ddQqrn46ROOtJKX8qRjIyZR7SIMhxUosby3Y0QGYpz/ORk9ZMmYn
 uYg2xFzlHwMMb9i+9t/HIbIwwREndSdV75o7/SiEQmehSiavhKV4u+N5AAclbwgF9Iz8
 WCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JOFJ6oH1odZlAZAnUFbaqkxYNsQU2RyPUzhXIwucLeQ=;
 b=nctpo6t9xtDTfjfxUHK97Aqn+P73pINVeEsm+Qoo2NJ8dQ8rNBoweeyGY3fskzS342
 3F79d27JMTsJsL/rWknfZ6YOTbC4uuJwfky0IdqbbB0gekNfTJMndUHt6fV1Dmfd1IKl
 w7da/de9BjfEOJpdh3OsIDCJIg4FyDop+WNGB9zQ+p9oBI2T9iB6t6kvVXa+46CfTmkc
 Rde15J8k59Vkl7kmyUx+GA/RSpmnEa3hp8VZydBcXqDuWEkONy5jowTtVhwT5klEQjMy
 K4y8g8p8HiJDvft2lhkPpumjqbx+fg33ArHhohmcraX2UiOpv08FJuJTvFmiKR7F/YU/
 kLCw==
X-Gm-Message-State: AOAM53167RZQZmdevc1priuYKS1DvU2kR95e+H5S5GyPlfwHuzyEJZAL
 19V5nPcc5K7BTCdxeAt+9PdY8xMKncLv3s8wdjA=
X-Google-Smtp-Source: ABdhPJztWCqWstM+bypnEWIaddYqNa2s5I+B4MpqT78Q9BTznFkV31RkJ0ixJm8NKqN7RdqJAOjmq2Ws3r5aMCRSMw0=
X-Received: by 2002:a25:aea5:: with SMTP id b37mr33327035ybj.239.1594168579465; 
 Tue, 07 Jul 2020 17:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593547870.git.alistair.francis@wdc.com>
 <ea4f280e6f77e734c8e555e3c98d10085ce9f5b6.1593547870.git.alistair.francis@wdc.com>
 <CAEUhbmVsQX+es-xw5Omj+-dsU1Km2kKNAZa_NJ6PipE4ZAEucA@mail.gmail.com>
 <CAKmqyKPDUVCVcm8d8bAqr=M_atAgfsFSAMhv6DZ5hOC5aAUHXQ@mail.gmail.com>
In-Reply-To: <CAKmqyKPDUVCVcm8d8bAqr=M_atAgfsFSAMhv6DZ5hOC5aAUHXQ@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 8 Jul 2020 08:36:08 +0800
Message-ID: <CAEUhbmXRWw7nDJsDLX+8r4D7MzVM=Tkcb7DodOf+tQ5yC9G3Zw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] target/riscv: Regen floating point rounding mode
 in dynamic mode
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

On Wed, Jul 8, 2020 at 1:33 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Thu, Jul 2, 2020 at 6:25 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > On Wed, Jul 1, 2020 at 4:23 AM Alistair Francis
> > <alistair.francis@wdc.com> wrote:
> > >
> > > When a guest specificies the the rounding mode should be dynamic 0b111
> > > then we want to re-caclulate the rounding mode on each instruction. The
> > > gen_helper_set_rounding_mode() function will correctly check the
> > > rounding mode and handle a dynamic rounding, we just need to make sure
> > > it's always called if dynamic rounding is selected.
> > >
> > > Fixes: 1885350 ("RISCV dynamic rounding mode is not behaving correctly")
> >
> > I can't find this commit id.
>
> It's a launchpad bug case: https://bugs.launchpad.net/qemu/+bug/1885350
>

My understanding is that the convention used in "Fixes" tag is for
commit id. 1885350 is not a commit id but a QEMU bug report id.

Regards,
Bin

