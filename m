Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0CDC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F17206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="giVmbD0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F17206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb67s-00044r-KB
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 13:06:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb66Y-00033P-0J
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:04:54 -0500
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:40129)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb66W-0002Hg-4q
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:04:53 -0500
Received: by mail-ed1-x542.google.com with SMTP id p93so2165723edd.7
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 10:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dxXbOI7ed8dRPBwSnjmcgvk4xlQZYHJtago+2YsXS7Y=;
 b=giVmbD0PGMtfIRdxLfBGh87NwQtGwQZ9kLUlKlZ3AGMQI36Tmen1AShowZd0h0xbQO
 gKvsAJTv+fWfasz4C5ZXud3cddM0gle7XI9F0csIFuZ+3biOj2h4JoZ37pHOUgbmOq1i
 rLzUrboQQ7zn8m7clDnBCmtZuY5I7Du3QUmj6r/zvT98anVvZPeQ8gJeRqZh5SBznqZs
 jzaUJmUG3/W33FFa7w8OtCw5tbbyhyNjR3XpuI+FTGf8EkHoWgtpzviJBTU82UZ4Et5d
 NvsRAdMYu/zxEWmdHfOz52vHdpyhHTU6YgkT+j1P5ct7weyvVp4w+c81Jw1QXi0g3jZT
 EhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dxXbOI7ed8dRPBwSnjmcgvk4xlQZYHJtago+2YsXS7Y=;
 b=JZiCSsf8C6Q424wMNoQ2mM8oenTD01Xhg8ZgpVAOLvSemORCsznQ06gsGaRH1lgrnb
 B4tvP4kY5tqrTsrxyetCLObn0qYhwg0Q4WF1zl9grofcKP80LZTiuI6F80TSJ3VFtPf7
 SaGmM5mmq9H0O/qShzSWWnkoMaoxhnJcB9GTCPXUanusITuCOv1+trP2hWPX7/QlPYGP
 1ZLr1PaI0ONqYaFCEL/Yp63Cxl7Vwxil80LZqsm9L2gf3RI39avgoqCgWCjmnIJuji9p
 Ze5imSt+B2WtgAOYuNNIBjy86cIICJv3OTfZy/DpWu/qrWzoXvHn+XtZKlvCMprtVtZt
 UMAA==
X-Gm-Message-State: AOAM530AVR2iq/2RB3XEiJXbL+zUSdVe5oYcojzWodl1Sb0riWAP0Yxq
 Kqg8dGuza35jY64PAaPKeIApZv4AT1xAroBLHizZtA==
X-Google-Smtp-Source: ABdhPJwshlhZEWjjBZvWOefPxiAiynKSM4JtzYqC7Dh/7QUQ7+CKNYZciOq7ND6tchpC6ExhxMcGtiuy7bXPhP80/Yk=
X-Received: by 2002:aa7:df82:: with SMTP id b2mr3177933edy.251.1604685890188; 
 Fri, 06 Nov 2020 10:04:50 -0800 (PST)
MIME-Version: 1.0
References: <20201106171153.32673-1-peter.maydell@linaro.org>
 <20201106171153.32673-2-peter.maydell@linaro.org>
 <202011061847.23354.pisa@cmp.felk.cvut.cz>
In-Reply-To: <202011061847.23354.pisa@cmp.felk.cvut.cz>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2020 18:04:38 +0000
Message-ID: <CAFEAcA8rR0Tjx111Xzj5VpZGSVLi8R70PSQ7Wahzb1AQM2TgLA@mail.gmail.com>
Subject: Re: [PATCH for-5.2 1/4] hw/net/can/ctucan: Don't allow guest to write
 off end of tx_buffer
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Jason Wang <jasowang@redhat.com>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 Ondrej Ille <ondrej.ille@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?SmFuIENoYXJ2w6F0?= <charvj10@fel.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Nov 2020 at 17:48, Pavel Pisa <pisa@cmp.felk.cvut.cz> wrote:
>
> Hello Peter,
>
> thanks much for the catching the problem and investing time into
> fixing. I hope to find time for more review of remarks and Xilinx
> patches next week. I do not find reasonable time slot till Sunday.
> Excuse me. To not block updates, I confirm your changes.
>
> On Friday 06 of November 2020 18:11:50 Peter Maydell wrote:
> > The ctucan device has 4 CAN bus cores, each of which has a set of 20
> > 32-bit registers for writing the transmitted data. The registers are
> > however not contiguous; each core's buffers is 0x100 bytes after
> > the last.
> >
> > We got the checks on the address wrong in the ctucan_mem_write()
> > function:
> >  * the first "is addr in range at all" check allowed
> >    addr == CTUCAN_CORE_MEM_SIZE, which is actually the first
> >    byte off the end of the range
> >  * the decode of addresses into core-number plus offset in the
> >    tx buffer for that core failed to check that the offset was
> >    in range, so the guest could write off the end of the
> >    tx_buffer[] array
> >  * the decode had an explicit check for whether the core-number
> >    was out of range, which is actually impossible given the
> >    CTUCAN_CORE_MEM_SIZE check and the number of cores.
> >
> > Fix the top level check, check the offset, and turn the check
> > on the core-number into an assertion.
> >
> > Fixes: Coverity CID 1432874
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  hw/net/can/ctucan_core.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/net/can/ctucan_core.c b/hw/net/can/ctucan_core.c
> > index d20835cd7e9..ea09bf71a0c 100644
> > --- a/hw/net/can/ctucan_core.c
> > +++ b/hw/net/can/ctucan_core.c
> > @@ -303,7 +303,7 @@ void ctucan_mem_write(CtuCanCoreState *s, hwaddr addr,
> > uint64_t val, DPRINTF("write 0x%02llx addr 0x%02x\n",
> >              (unsigned long long)val, (unsigned int)addr);
> >
> > -    if (addr > CTUCAN_CORE_MEM_SIZE) {
> > +    if (addr >= CTUCAN_CORE_MEM_SIZE) {
> >          return;
> >      }
>
> Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

> > @@ -312,7 +312,8 @@ void ctucan_mem_write(CtuCanCoreState *s, hwaddr addr,
> > uint64_t val, addr -= CTU_CAN_FD_TXTB1_DATA_1;
> >          buff_num = addr / CTUCAN_CORE_TXBUFF_SPAN;
> >          addr %= CTUCAN_CORE_TXBUFF_SPAN;
> > -        if (buff_num < CTUCAN_CORE_TXBUF_NUM) {
> > +        assert(buff_num < CTUCAN_CORE_TXBUF_NUM);
>
> Assert is not necessary. If there is not buffer at that location,
> then write has no effect. Assert would check for driver errors,
> but it is not a problem of QEMU and for sure should not lead to its
> crash.

We assert() here as a guide to readers of the code that we know
that buff_num can't possibly be out of range for the array
access we're about to do: the values of CTUCAN_CORE_MEM_SIZE,
CTUCAN_CORE_TXBUFF_SPAN, etc, make it mathematically impossible.
We prefer to assert() that kind of condition rather than having
an if() test for it.

thanks
-- PMM

