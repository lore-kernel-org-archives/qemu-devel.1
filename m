Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC45C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 23:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7282098B
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 23:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="j8RBtorq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7282098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCWsI-0001tb-HI
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 19:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1kCWrf-0001I5-0u
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 19:35:59 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1kCWrc-0005du-Rw
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 19:35:58 -0400
Received: by mail-wm1-x344.google.com with SMTP id v4so3002385wmj.5
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 16:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=RASHodX0lMfHYt83QbTf2ezLNOxfAhKMutmXcqjpFuQ=;
 b=j8RBtorqaVEsLOmNgpW3EzUGHsToCN3xfe46gSDMurZJGFNEg18k0GvZKdOoScuO0k
 zlYrwS0pah7kXPLGqgfPBRxHOJGPX3hbhsI3IsaXdMIBVLnNEv98mTUVFnReYcAAxGPs
 sMg/fgdjTuC5L4ZV/psfBJMxu1gMdqqaZwLDPxgr1QUuEQZ1by7JTpF3LXNIgls9bR52
 fbo1mee/ZsECNW5HqyQcko3TlbS/htkuGhXweyfG8AEFHcNh24jV/7Uzha0LIsCp77WY
 2j0lJeqJ5X2rWl35Ys3SW/QIPjgsfGETi4kpiHBODBy2jWGW/fLNKVxR38vIVBxqD2wL
 Tfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=RASHodX0lMfHYt83QbTf2ezLNOxfAhKMutmXcqjpFuQ=;
 b=XwATiBoPkNpD1UKUPj7ZXqe2qqTd7/XPTewqRbrueiO28d2aXiC7XpW28Yhrl/4wu0
 evJwZm7PKcrTlPoCsncUbtRd7Lb2Lj2y1FdOte4V/t7HZM1RLUXp4IZY4VbBK/kbrPB3
 oOB7WD60GCfXSaEJjXckkxau6kd08D8qPvs54ge7ekFp+/Q4cipIWTHlG4uaZ82E8VIZ
 B1RzsGsmb8prs/wTD0I+7I8h98K/kRLJNNIopV3w41AFiJk5qXjv94bgV7lAx7ZFkDQQ
 5rZf36ox7KTiWl0Onnp3Y9DyaGFTTZMP4crHiRPeyRqct4S2S2RtdN0ypMyqiCcII+UI
 4WXw==
X-Gm-Message-State: AOAM531+fbybjs5KJ0vBtSBQgQ7GMDZDdKMPw54VHWvIYh+VbUMJPFdI
 HupagZ9a8hpbp4b8Lm3b+cGanA==
X-Google-Smtp-Source: ABdhPJxnrUjQW5Yi/f20qAyShWbhd5YUVdj0/CuqpJzH0j7u25Md01wYnJ7zSCsxCVI2pBPRk9H3XQ==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr342678wmh.177.1598830555254; 
 Sun, 30 Aug 2020 16:35:55 -0700 (PDT)
Received: from vanye ([2001:470:1f09:12f0:b26e:bfff:fea9:f1b8])
 by smtp.gmail.com with ESMTPSA id z6sm9218591wml.41.2020.08.30.16.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2020 16:35:54 -0700 (PDT)
Date: Mon, 31 Aug 2020 00:35:52 +0100
From: Leif Lindholm <leif@nuviainc.com>
To: Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v2 00/16] hw/riscv: Add Microchip PolarFire SoC Icicle
 Kit board support
Message-ID: <20200830233552.GG20124@vanye>
References: <1598714261-8320-1-git-send-email-bmeng.cn@gmail.com>
 <20200830125659.GD20124@vanye>
 <CAEUhbmVYpSVE+C+KyEa2Ono5p-SLtC1vE=YwE_3FJK6POEJCCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEUhbmVYpSVE+C+KyEa2Ono5p-SLtC1vE=YwE_3FJK6POEJCCg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=leif@nuviainc.com; helo=mail-wm1-x344.google.com
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

On Mon, Aug 31, 2020 at 06:15:52 +0800, Bin Meng wrote:
> Hi Leif,
> 
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
> >
> > Are there any version requirements, or additional qemu patches, that
> > need to be taken into account. Should I expect to see output on stdio?
> 
> Thanks for trying!
> 
> Did you apply the patch to skip the DDR memory initialization
> mentioned in this page?
> https://wiki.qemu.org/Documentation/Platforms/RISCV#Microchip_PolarFire_SoC_Icicle_Kit

I did, but in honesty only after I sent the previous email :)
(Since it made no difference, I didn't bother following up.)

> > I tried to build hss 3faaaaf8ce0d, using
> > https://github.com/riscv/riscv-gnu-toolchain (7f1f4ab5b0e0), which
> > ends up being a gcc 10.1. That caused me to raise
> > https://github.com/polarfire-soc/hart-software-services/issues/2.
> 
> Yes, GCC 10 does not build is a known issue. Currently I am using GCC
> 9 to build HSS.

Right, I can confirm that with commit 93f82dc18e1d riscv-gnu-toolchain
(the last before changing to gcc 10.1), I generate a 9.2.0 gcc that
builds a hss.bin that boots successfully with the minimal command line

qemu-system-riscv64 -M microchip-icicle-kit -smp 5 -bios hss.bin \
  -display none -serial stdio

Thanks!

(I haven't looked any further than the hss.bin yet, but I'm now
unblocked to do so.)

Best Regards,

Leif

