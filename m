Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0189BC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1F7620692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Di7569ja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F7620692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCxt-0006NC-M4
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 10:09:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1ipCwd-000526-50
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:08:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1ipCwc-0005Mk-2s
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:08:27 -0500
Received: from mail-yw1-xc2d.google.com ([2607:f8b0:4864:20::c2d]:35785)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>) id 1ipCwb-0005Lr-Uj
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:08:26 -0500
Received: by mail-yw1-xc2d.google.com with SMTP id i190so1353117ywc.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 07:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=985pM4FDuhtUXdsmogKrwW2BBOoYOvdp7XNxJZTjF2Y=;
 b=Di7569janeGys9tyR1UA5NDqSY+y0/otEY+IPnNAcEVvzT71qPrmEgmwwm1vI36uEQ
 aQg/n+ZyXidq+2yHvCxsxpU3i7mBqKGKd0k13DwtQvP1ThhmhmiPqH3b1bNBL4IJ2Tov
 RCVL+0tMWXnm9scpiKGCW2AL0gg9CtlUWZXuRiTECJbld2dbKjTTNjon45Rin6lZB3QN
 fpL6vhPFvfudRXaJMHkeinaEAz7f/BkS0K5nb2yPm/Qe/K2hdKIZgAXUK8J6oNI3DZ+4
 3Rff+BrZHVmcMfhakE+/fLF4wuAmQM/zGkbN35nL1lD4Y7+aH6FlpIOQsy3wOz5tXfiX
 m5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=985pM4FDuhtUXdsmogKrwW2BBOoYOvdp7XNxJZTjF2Y=;
 b=qXQIkxYmGkNF7y5mQJpNSISChGPQVlcOBdL79CnDia1Ftw59vi4s9eKwbn2CbDMvk8
 TwEh+vuIlzzb9HUd79Be36liidmaeOF21DwnTHiAuKN4fJRYYrOe7I0DFH7bHalFFN0J
 XhOpZ1V8qNdg5EXqzT4c8ON0fWSEmFastmnSNYTirWFhW1Lveeok6Bz44sC2SwgugMb3
 cbcoGRIVibdERmqHygbG8FQ7DPtKT9W0OElVbgC/yfCoLRmIYI0hKmwQO2dkfUe5VjSL
 rWBOokymqms02OuOhu1O3/EUk2mFWWIuAQaLRjxtQAEzfFazoxACsxyz5J4GelckCxTa
 SuCQ==
X-Gm-Message-State: APjAAAWavd02EK9iF9XsbpLBg2nFxofdB6Q7iUFUU8HJN/tyZvd6DOMy
 FoT+rTbnzIeBICtQSZ08dTOizaFfQJ2DYKslqCY=
X-Google-Smtp-Source: APXvYqwyuS4YWFgq0E1cPey6ekWFMQI4UPrSnkF028DVUugEvEW5d8arRdDswq4ThQu3MAPVLFC3yBx4jfLGXFaxaoI=
X-Received: by 2002:a81:7841:: with SMTP id t62mr3916311ywc.140.1578496104647; 
 Wed, 08 Jan 2020 07:08:24 -0800 (PST)
MIME-Version: 1.0
References: <CAMAD20mmgEa_W869C961T_1DQnx+J=dKYFJgv=2WEw5iDL5T1A@mail.gmail.com>
In-Reply-To: <CAMAD20mmgEa_W869C961T_1DQnx+J=dKYFJgv=2WEw5iDL5T1A@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 8 Jan 2020 23:08:13 +0800
Message-ID: <CAEUhbmX_0Mw2-FiYRtBS3t72v1vDkBLfco6_SuKrFao4hgpuBw@mail.gmail.com>
Subject: Re: riscv: How to debug a wrong pc after executing ret instruction?
To: Ian Jiang <ianjiang.ict@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c2d
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 8, 2020 at 5:23 PM Ian Jiang <ianjiang.ict@gmail.com> wrote:
>
> Problem
> ======
> The next instruction after executing "ret" (i.e. jalr x0, 0(x1)) is not at 0x000000008000056c (x1/ra) as expected,  but at  0x000000008000056c.

I don't get this. is not at address A but at address B, but you wrote
A and B exactly the same?

> How to debug this issue? Any suggestion is appreciated.
>
> QEMU command
> =============
> qemu-system-riscv64 -nographic -machine virt -kernel my-test.elf -smp 1 -d in_asm,cpu
>
> Trace (piece)
> ===========
> IN:
> 0x0000000081150000:  00259eb7  lui t4,2461696
> 0x0000000081150004:  00099b37  lui s6,626688
> 0x0000000081150008:  01db3023  sd t4,0(s6)
> 0x000000008115000c:  00008067  ret
>
> pc        0000000081150000
> x1/ra    000000008000056c
>
> IN:
> 0x0000000080003da0: 10503023  sd t0,256(zero)
> ...
>
>
> QEMU version
> ===========
> upstream tag v4.2.0
>

Regards,
Bin

