Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DA4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 18:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1431F207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 18:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="jBfd/2Jn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1431F207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlzAL-0004io-6W
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 14:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@atishpatra.org>)
 id 1jlz8G-0003wi-DI
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 14:19:24 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@atishpatra.org>)
 id 1jlz8E-0006xu-M8
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 14:19:24 -0400
Received: by mail-wr1-x443.google.com with SMTP id l11so7096872wru.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 11:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atishpatra.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DN2qGbjgTw1HuyNiQyO27/o6aBZFoKs8ePi0n5WFSc0=;
 b=jBfd/2JnpCBEDIB11YYZphIzxVH3mCxjtdnDLpb2ulaVUBf2xrL+njil/WVLBCCbn8
 l0xUFfIvnAvMJYVTg10XhzIy5GM8BiOCwZAwWwvpNCt9t4X+kCs6tCV37ZM+ORBoqK3k
 0+05VzY4yTG8XJRbRcuNlE1CmLVGMl7OaUtgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DN2qGbjgTw1HuyNiQyO27/o6aBZFoKs8ePi0n5WFSc0=;
 b=l4s5jJo6lB6Rz/RsOZyTqr8vbcBLiLFkh5iUG1Hl3BbOHcvSzXt1saZMLQDdF/idFu
 y2zMwGWDMt6KjzYV+KU+ZHqILh5fwM7ZXVT00JV9bDF2B4TRQcNt/yAQXGC0qItwrqBL
 E2E3ZaNlFZiR6iLVc34WHshZ2lkKHAu1jaLFgM9JJVaZ93AB6+2+++1owg3IQfUnw8zY
 7KQZcyCbJDOP9utHZCxv1prw1uFd3+7lRi+52F5+FB0yUKloAtGva01KtbnSfsdolyXb
 yJoTeKPSHWEmYLvytMb45ppHdboBlAiFM5nHF4bsmvVawKyIdCHoBWzyNzw6YTpPi0ue
 Prpg==
X-Gm-Message-State: AOAM532soCOLmwayJDYkUyC1Q8f5KkM+0QuMvt37HswdFzH/DGbJMIGo
 HVkgVnbchbQxZabBoB0GOqOhIHSap9oR8NlW5+yU
X-Google-Smtp-Source: ABdhPJy6x+EA9ilxhqKjWN30Nz9VubjxRtjT2zdIFeXQRADP0VyYxtLBc6QHrbVhcUeh2aIbdnZxBAWpW1xO9PKSi7k=
X-Received: by 2002:adf:e68a:: with SMTP id r10mr5829502wrm.384.1592504360503; 
 Thu, 18 Jun 2020 11:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200616192700.1900260-1-atish.patra@wdc.com>
 <CAEUhbmVRN2Ze=jNqFSJbZgO0_ggyX6B-1UydPJB1sZVdAokrxQ@mail.gmail.com>
In-Reply-To: <CAEUhbmVRN2Ze=jNqFSJbZgO0_ggyX6B-1UydPJB1sZVdAokrxQ@mail.gmail.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Thu, 18 Jun 2020 11:19:09 -0700
Message-ID: <CAOnJCUKN=L+eqMsp5X_6HG3j85Gzf6jtZMdNhCZ+cwROpJOTCQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add OpenSBI dynamic firmware support
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=atishp@atishpatra.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 18, 2020 at 1:56 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Wed, Jun 17, 2020 at 3:29 AM Atish Patra <atish.patra@wdc.com> wrote:
> >
> > This series adds support OpenSBI dynamic firmware support to Qemu.
> > Qemu loader passes the information about the DT and next stage (i.e. kernel
> > or U-boot) via "a2" register. It allows the user to build bigger OS images
> > without worrying about overwriting DT. It also unifies the reset vector code
>
> I am not sure in what situation overwriting DT could happen. Could you
> please elaborate?
>

Currently, the DT is loaded 0x82200000 (34MB offset) for fw_jump.
Thus, a bigger kernel image
would overwrite the DT. In fact, it was reported by FreeBSD folks.
https://github.com/riscv/opensbi/issues/169

There are temporary solutions that can put DT a little bit further or
put it within 2MB offset. But that's
just delaying the inevitable.

> > in rom and dt placement. Now, the DT is copied directly in DRAM instead of ROM.
> >
> > The changes have been verified on following qemu machines.
> >
> > 64bit:
> >  - spike, sifive_u, virt
> > 32bit:
> >  - virt
>
> Any test instructions?
>

you just need to provide fw_dynamic instead of fw_jump in bios argument.

For example: Here is my qemu commandline for testing

qemu-system-riscv64 -M virt -smp 4 -m 2g -display none -serial
mon:stdio -bios
~/workspace/opensbi/build/platform/generic/firmware/fw_dynamic.bin \
   -kernel /home/atish/workspace/linux/arch/riscv/boot/Image -initrd
/home/atish/workspace/rootfs_images/riscv64_busybox_rootfs.img -object
rng-random,filename=/dev/urandom,id=rng0 \
   -device virtio-rng-device,rng=rng0 -device
virtio-net-device,netdev=usernet -netdev
user,id=usernet,hostfwd=tcp::10000-:22 -d in_asm -D log -append 'rw
console=ttyS0 earlycon'

> >
> > I have also verified fw_jump on all the above platforms to ensure that this
> > series doesn't break the existing setup.
> >
>
> Regards,
> Bin
>


-- 
Regards,
Atish

