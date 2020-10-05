Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81B1C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 22:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C75206CB
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 22:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxl0i+Mp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C75206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPYsI-0005EW-9Q
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 18:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kPYr2-0004Kh-EW; Mon, 05 Oct 2020 18:21:14 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:38859)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kPYqv-0006Xc-64; Mon, 05 Oct 2020 18:21:12 -0400
Received: by mail-il1-x143.google.com with SMTP id z5so9286715ilq.5;
 Mon, 05 Oct 2020 15:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/w3wO+trZ16Sgm70yMjg9eMipq82LDClQIJC/lTGDwU=;
 b=jxl0i+MpkP0FIRaWv/Ds20ytLAfRNS+3+qPDiaInEI8izeIJPir1vjtnVVc7oWfxou
 BmG1twcYpH0e16rFto/nOcJSZ4unKwRewHmNF5pnBy6lLdPBG3AYhkT3hMWjh6sNKGTc
 DjCT6fAKuBCRetu225VyokPYaMdNXbRkeeFDMuGeXXpZwDC/+2e3wc230hKGfEB6/YWS
 8sEG+S2h8t5LycPRTabX5XWAiTQSGQN5M+zzxIuVug1O7tTTn/qRKQ8PpTk3UKnWWymi
 6/c27OktIG1pfgooi6E32+u4h/sWKh1L6qO/ooua1u3wyhvJc47ZvXbFE/k5NZe/gjxJ
 DNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/w3wO+trZ16Sgm70yMjg9eMipq82LDClQIJC/lTGDwU=;
 b=BxiRCjWleTtP/pR5cY/UcTR+Bsbe0G3grYjyDUhh2SWHj68LyfDp3oi53V8DSGIR6W
 uKDFKwy15vGJj2LHmxoao9Gui9VggScow18MVi9CAYHKxnfmXlzXLFyVwckD9QzxuLe6
 4KkGQoR0vLxNUFStb6ovpNsQDvnNC/+4d+yU7b3feu8DoUkMEjflOlB0or/+LpjW+jQt
 MDY8W6MjGHN/7yzC/akJkT/4+JUPpFMGblD5/djVfU9fM9YcGJfrcdksC2k6BbaE73bl
 HeFKa2+I+kKTNS3BEH7UOmotS0YEwI1zXLgzrSpWSFhr7mOv3AAfTK367bVMgGAwGrc0
 tIcQ==
X-Gm-Message-State: AOAM531e0SRxN+5p5bnDdMUA2BttoK0Z6vAM/r0lpoqxUY4jcUS2uVAN
 F0E6w1JJKfpyYUKytjl6Yq10/krKIcMMdsfVkM0=
X-Google-Smtp-Source: ABdhPJxfrVCWPNkb/DKLmE4YkeliPaIHTPQh9uxAmmdfXCVxTij1oaEtrOXjuzdqeAK/Xn6SID0zzBKitLpn+7ukuak=
X-Received: by 2002:a92:c5c2:: with SMTP id s2mr1261550ilt.177.1601936461828; 
 Mon, 05 Oct 2020 15:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200929020337.1559-1-jiangyifei@huawei.com>
 <20200929020337.1559-4-jiangyifei@huawei.com>
 <2e725e26-3952-dbd2-c4aa-d9e933406220@linaro.org>
In-Reply-To: <2e725e26-3952-dbd2-c4aa-d9e933406220@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Oct 2020 15:09:34 -0700
Message-ID: <CAKmqyKMzZ3W130jG973PWBQ52zBLVfSP+=Xbp7Cdk4NpuHDkgw@mail.gmail.com>
Subject: Re: [PATCH 3/5] target/riscv: Add H extention state description
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "Zhangxiaofeng \(F\)" <victor.zhangxiaofeng@huawei.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Yifei Jiang <jiangyifei@huawei.com>, yinyipeng <yinyipeng1@huawei.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, "Wubin \(H\)" <wu.wubin@huawei.com>,
 "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 1, 2020 at 10:56 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 9/28/20 9:03 PM, Yifei Jiang wrote:
> > +        VMSTATE_UINTTL(env.vsstatus, RISCVCPU),
> > +        VMSTATE_UINTTL(env.vstvec, RISCVCPU),
> > +        VMSTATE_UINTTL(env.vsscratch, RISCVCPU),
> > +        VMSTATE_UINTTL(env.vsepc, RISCVCPU),
> > +        VMSTATE_UINTTL(env.vscause, RISCVCPU),
> > +        VMSTATE_UINTTL(env.vstval, RISCVCPU),
> > +        VMSTATE_UINTTL(env.vsatp, RISCVCPU),
>
> So... if I understand things correctly, this is synthetic state, internal to
> QEMU.  It is generally better to only serialize architectural state, so that if
> qemu internals are rearranged, it is easy to decide on the correct sequence of
> operations.

I don't think the virtual registers are synthetic, they contain what
the guest Hypervisor/Hypervisor guest wrote to those CSRs. I don't
think we could re-generate them from anything else.

There are some other registers in this series that I think can be
re-generated. The PMP is a good example of that, where the PMP config
data could be re-generated from the CSRs.

Alistair

>
> It seems like this should be re-generated with a post_load hook, calling some
> of the code currently in riscv_cpu_swap_hypervisor_regs().  Note that some
> minor rearrangement would be needed to call that code from this new context.
>
>
> r~
>

