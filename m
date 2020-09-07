Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B455C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 17:28:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8396D2067C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 17:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="p6fWqe11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8396D2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFKwP-0007Qy-KJ
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 13:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1kFKvM-0006XK-PM
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 13:27:24 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1kFKvK-00063e-Im
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 13:27:24 -0400
Received: by mail-wr1-x442.google.com with SMTP id c18so16510858wrm.9
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 10:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=yQpxWJo6HMty7kK9sWL6SsmMoyOUcPaxRFTi1QGQOgM=;
 b=p6fWqe1160ZCygq9NAkQvIg+oGQQbj5RAZxEmnVYHnLiUWa28+gkAN/p1HVbwyP47E
 qHoUMD0KwDlEVqE+lAQgh5Y4op2kPvpVUsTZQxZ5bVc4RaaddtwjLyQ53SUrNG6aWS0o
 qgaA7w3kdkKQahH1FHSiAzZwkZAa5XCmAde0zPfyp389uMDM07jhxn46/6gKKVg+BBJp
 gyg8TVWFWNbHPxW8cymz24qKF5zbYBv/WgLMDmKB0gA4Q2haF1uKfwgQTs1d5YtzUM/9
 W3dM5V0mEe5AtpfvgbOHmnTMcff6Can+B8WuBKl/ibvj+JcM1wiF1lwnd67GgMR/SuUR
 xVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yQpxWJo6HMty7kK9sWL6SsmMoyOUcPaxRFTi1QGQOgM=;
 b=c9hHvbrSgBwqtqpQnLhKXu62PVJC5oaQmOfSDTUqs5mE0SHZbD5ZMAN1LDG1jMc8M2
 CulzMKpjYoFKNbRhzX1xc25qyq0+Sq7shMbxGJhg3IZD0euHSBPE1xBKDFQwu0m7ZF8X
 l9w92baf/s9+xssTElY3yxziQK8GQyGXzjQDU5+U2A9Psjg0nSEAGczBAmkCEk+maX9T
 XlD5bqxnJ+tsV9looFSuT85TKdn0sVRLw82TonfN/pWDztpa2NBEzYNf5/Xp/B+E9L7+
 EChGyU8xXfWxpduM9q52WHTb4Sadl48DccfFgZj8dQD31sJgY9di2djiWraegR/gmE9U
 +blQ==
X-Gm-Message-State: AOAM531BYTqXTpLg2W4pjaIuTCY0qZgHjPu0DnV2fJg6PU4wdBsUOli+
 B9BTTQSHnVfOmaqldY78z9J9dQ==
X-Google-Smtp-Source: ABdhPJycjoStzRkbq7yfSxegQ4C2U8CNBTShwi+MdEjOmGaxq5ngCTq3tMe8aMipVWxwb1iVbvhWkA==
X-Received: by 2002:adf:e9c7:: with SMTP id l7mr8364772wrn.93.1599499640516;
 Mon, 07 Sep 2020 10:27:20 -0700 (PDT)
Received: from vanye ([2001:470:1f09:12f0:b26e:bfff:fea9:f1b8])
 by smtp.gmail.com with ESMTPSA id t4sm8908638wrr.26.2020.09.07.10.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 10:27:20 -0700 (PDT)
Date: Mon, 7 Sep 2020 18:27:12 +0100
From: Leif Lindholm <leif@nuviainc.com>
To: Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v3 00/16] hw/riscv: Add Microchip PolarFire SoC Icicle
 Kit board support
Message-ID: <20200907172712.GB5623@vanye>
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
 <20200906010811.GA1546@vanye>
 <CAEUhbmVfSPwO5CHO2G5Vd5fA6NA4dRCp-e_KGJhSO7nYAPmi1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEUhbmVfSPwO5CHO2G5Vd5fA6NA4dRCp-e_KGJhSO7nYAPmi1w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=leif@nuviainc.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 07, 2020 at 18:24:06 +0800, Bin Meng wrote:
> Hi Leif,
> 
> 
> On Sun, Sep 6, 2020 at 9:08 AM Leif Lindholm <leif@nuviainc.com> wrote:
> >
> > On Tue, Sep 01, 2020 at 09:38:55 +0800, Bin Meng wrote:
> > > From: Bin Meng <bin.meng@windriver.com>
> > >
> > > This adds support for Microchip PolarFire SoC Icicle Kit board.
> > > The Icicle Kit board integrates a PolarFire SoC, with one SiFive's
> > > E51 plus four U54 cores and many on-chip peripherals and an FPGA.
> > >
> > > For more details about Microchip PolarFire SoC, please see:
> > > https://www.microsemi.com/product-directory/soc-fpgas/5498-polarfire-soc-fpga
> > >
> > > The Icicle Kit board information can be found here:
> > > https://www.microsemi.com/existing-parts/parts/152514
> > >
> > > Unlike SiFive FU540, the RISC-V core resect vector is at 0x20220000.
> > > The RISC-V CPU and HART codes has been updated to set the core's
> > > reset vector based on a configurable property from machine codes.
> > >
> > > The following perepherals are created as an unimplemented device:
> > >
> > > - Bus Error Uint 0/1/2/3/4
> > > - L2 cache controller
> > > - SYSREG
> > > - MPUCFG
> > > - IOSCBCFG
> > > - GPIO
> > >
> > > The following perepherals are emulated:
> > > - SiFive CLINT
> > > - SiFive PLIC
> > > - PolarFire SoC Multi-Mode UART
> > > - SiFive PDMA
> > > - Cadence eMMC/SDHCI controller
> > > - Cadence Gigabit Ethernet MAC
> > >
> > > The BIOS image used by this machine is hss.bin, aka Hart Software
> > > Services, which can be built from:
> > > https://github.com/polarfire-soc/hart-software-services
> > >
> > > To launch this machine:
> > > $ qemu-system-riscv64 -M microchip-icicle-kit -smp 5 \
> > >     -bios path/to/hss.bin -sd path/to/sdcard.img \
> > >     -nic tap,ifname=tap,script=no,model=cadence_gem \
> > >     -display none -serial stdio \
> > >     -chardev socket,id=serial1,path=serial1.sock,server,wait \
> > >     -serial chardev:serial1
> >
> > I finally got around to building the sd image from
> > https://github.com/polarfire-soc/polarfire-soc-buildroot-sdk,
> > and I can successfully boot to prompt using that, and the (hacked)
> > hss.bin I verified previously - also with this v3.
> >
> 
> Good to know!
> 
> > However, unless I add the "-nic user,model=cadence_gem \" shown in
> > https://wiki.qemu.org/Documentation/Platforms/RISCV#Microchip_PolarFire_SoC_Icicle_Kit
> > but not here, I do not have functioning networking. (It is not obvious
> > to me why this is needed.)
> >
> 
> Sorry I don't understand what the issue is?

The instructions in this cover letter does not contain the line
  "-nic user,model=cadence_gem \"

The instruction in the wiki does.
The instruction in the wiki works, the instruction in the cover letter
does not.

It is not clear to me why both lines are needed.

> > > The memory is set to 1 GiB by default to match the hardware.
> >
> > Which hardware is this?
> > https://www.crowdsupply.com/microchip/polarfire-soc-icicle-kit lists
> > 2GiB.
> 
> It's this same board. But I believe the crowdsupply webpage has the
> wrong information. The board I got only has 1GB memory.

The diagram on https://www.microsemi.com/existing-parts/parts/152514
also says 2GB. Do you have any channel to Microchip to clarify this?

> > > A sanity check on ram size is performed in the machine init routine
> > > to prompt user to increase the RAM size to > 1 GiB when less than
> > > 1 GiB ram is detected.
> >
> > There is currently no visible effect in firmware from setting memory size to >
> > 1GiB (hss says 1GB, u-boot says 1GB, Linux sees 1GB).
> > Are there any plans to address this in future versions?
> 
> HSS is using hardcoded 1GB memory size and that's why in QEMU the
> minimum required memory size is 1GB. Setting less than 1GB size blocks
> HSS to load the 2nd stage bootloader U-Boot into the memory. Both
> U-Boot and Linux DTS files set the memory size to 1GB, so that's why
> both of them see only 1GB. Setting memory >1G does not affect U-Boot
> and Linux though. You can however manually edit the U-Boot and Linux
> DTS files to have a large RAM size to match QEMU -m option.

Understood, thanks.

Best Regards,

Leif

