Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D3FC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 22:16:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7582620693
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 22:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioN1iMfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7582620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCVcu-0005nK-KT
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 18:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kCVcL-0005Jm-9V; Sun, 30 Aug 2020 18:16:05 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:43958)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kCVcJ-0006LO-CU; Sun, 30 Aug 2020 18:16:04 -0400
Received: by mail-yb1-xb42.google.com with SMTP id p6so1161064ybk.10;
 Sun, 30 Aug 2020 15:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kexWWvKPs+NLnxR738Y1kuxianrcIjMhmVi+Axao+uI=;
 b=ioN1iMfBTIZLg7iYESQ2MJnqIqd9LBSlNpiLUM8JZcm0Pe6Md4Jwmo3KxOegtsFM7J
 YzZ4yAT+GtaDko6ECR+a18mCsUD9VEUs9zwmvNsCqbVAhfxbWwPV5+PX+wSbihB5+zGh
 9uoUThZdhRBKXP4QDOwkt/5a4vHxDCji+8UdLGvOhhteZ/kIUZX+02rAQM7QnPVVA+Ue
 +3+bhjgp1uGzBnYwKJ4dorYBn1lEDpkkR4bmx0yc0WEBQJ2jsuOJa7DXdVEMAUhOkwW1
 SFlnUe/bF/+nKqS4MCyVgeIDuHTCP3ViLtW74//ihTHegWZ3GpalSQIPrvePotTj8M3g
 2OaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kexWWvKPs+NLnxR738Y1kuxianrcIjMhmVi+Axao+uI=;
 b=A9F9K7NrTSoFxG4cz9qbp1Lw1ev6TvEY/dN9WsdbOja46Lvl038ccch69zX8HGvH3c
 O66T+GQ0U8UDYazw43wKTYtA7EV2j7FZz3yJTPoTpEHm1QI3d0Fn324H9kJTGN9HJwol
 f7XGQLVCBaRhMN7QyRqjmfL6AUEt5mHcoy7n0vicz4u5mjMff+UxULSodu3pZXhEEpKh
 rhHatlAyCwu3HuX204veDgGQ520DIlacXQP7JBNdoHxmKjlsVMBJwsRI9HIJ0+a/r4a9
 LXZdWc46whJMlVFq9jB6eqo7Tdg/WsLhaxWo+1jiyc3CUx0vX/I68U2Ed0UPyYWTigJf
 t44A==
X-Gm-Message-State: AOAM533yeyscVanmpP6KlN4aqJZmbMVyk5bSXauehp1AOdg0ZS7uLInt
 7oDqBc8kjdHfUL8ubCrtYgTN5IsLM6OiTClzThc=
X-Google-Smtp-Source: ABdhPJy6YmiIeYGItQ3oW0u0DFMtImbD9cOfrGG5oS07N6YD16J4vojoMwELEnW8E8c2WIFK+o+sn/04X2nYp3Or79U=
X-Received: by 2002:a25:e684:: with SMTP id
 d126mr16392192ybh.332.1598825761390; 
 Sun, 30 Aug 2020 15:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <1598714261-8320-1-git-send-email-bmeng.cn@gmail.com>
 <20200830125659.GD20124@vanye>
In-Reply-To: <20200830125659.GD20124@vanye>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 31 Aug 2020 06:15:52 +0800
Message-ID: <CAEUhbmVYpSVE+C+KyEa2Ono5p-SLtC1vE=YwE_3FJK6POEJCCg@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] hw/riscv: Add Microchip PolarFire SoC Icicle Kit
 board support
To: Leif Lindholm <leif@nuviainc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Bin Meng <bin.meng@windriver.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Jason Wang <jasowang@redhat.com>, Palmer Dabbelt <palmerdabbelt@google.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Leif,

On Sun, Aug 30, 2020 at 8:57 PM Leif Lindholm <leif@nuviainc.com> wrote:
>
> Hi Bin,
>
> On Sat, Aug 29, 2020 at 23:17:24 +0800, Bin Meng wrote:
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > This adds support for Microchip PolarFire SoC Icicle Kit board.
> > The Icicle Kit board integrates a PolarFire SoC, with one SiFive's
> > E51 plus four U54 cores and many on-chip peripherals and an FPGA.
> >
> > For more details about Microchip PolarFire SoC, please see:
> > https://www.microsemi.com/product-directory/soc-fpgas/5498-polarfire-soc-fpga
> >
> > The Icicle Kit board information can be found here:
> > https://www.microsemi.com/existing-parts/parts/152514
> >
> > Unlike SiFive FU540, the RISC-V core resect vector is at 0x20220000.
> > The RISC-V CPU and HART codes has been updated to set the core's
> > reset vector based on a configurable property from machine codes.
> >
> > The following perepherals are created as an unimplemented device:
> >
> > - Bus Error Uint 0/1/2/3/4
> > - L2 cache controller
> > - SYSREG
> > - MPUCFG
> > - IOSCBCFG
> > - GPIO
> >
> > The following perepherals are emulated:
> > - SiFive CLINT
> > - SiFive PLIC
> > - PolarFire SoC Multi-Mode UART
> > - SiFive PDMA
> > - Cadence eMMC/SDHCI controller
> > - Cadence Gigabit Ethernet MAC
> >
> > The BIOS image used by this machine is hss.bin, aka Hart Software
> > Services, which can be built from:
> > https://github.com/polarfire-soc/hart-software-services
>
> Are there any version requirements, or additional qemu patches, that
> need to be taken into account. Should I expect to see output on stdio?

Thanks for trying!

Did you apply the patch to skip the DDR memory initialization
mentioned in this page?
https://wiki.qemu.org/Documentation/Platforms/RISCV#Microchip_PolarFire_SoC_Icicle_Kit

>
> I tried to build hss 3faaaaf8ce0d, using
> https://github.com/riscv/riscv-gnu-toolchain (7f1f4ab5b0e0), which
> ends up being a gcc 10.1. That caused me to raise
> https://github.com/polarfire-soc/hart-software-services/issues/2.

Yes, GCC 10 does not build is a known issue. Currently I am using GCC
9 to build HSS.

>
> Suppressing that warning gets me a hss.bin, but neither that, nor one
> I build with Debian's 8.3 riscv64-linux-gnu- produces any output when
> I apply this set on top of 39335fab59. (Even when I change the wait to
> nowait.)
>

Regards,
Bin

