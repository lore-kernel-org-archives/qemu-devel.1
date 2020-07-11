Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B64C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 16:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77F0620786
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 16:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrazsVRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F0620786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juHzd-0002pu-KK
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 12:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1juHyf-0001xX-Ha; Sat, 11 Jul 2020 12:03:49 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:42326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1juHyd-0008AV-L2; Sat, 11 Jul 2020 12:03:49 -0400
Received: by mail-il1-x141.google.com with SMTP id t27so7634988ill.9;
 Sat, 11 Jul 2020 09:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SVcwzPjj4FoBI5HM9gcOEJnIDLucI9hQir6z0Gq65Ek=;
 b=JrazsVRlGC1XEdRydpPsgwP30hTajIQzawVVOJL/zWqCyRyR2VtQ6Wd9P34m/DeUbe
 ahd4HBWxIYr1lrisDDSLiG+SqRshtO24OmRIMzFFyNRAdp1Y/gwsGdAQh36yw4EyN4+4
 1HLyOasEULP6Jk8xo87hUbGuhVfxk409/9xI4ogz2BhnWK1QOZR53eoQC+/LX4uRAHEf
 mzTtkjNynOGE4EkVYlpsOTNJPfnGKJAPHvegzY8sWc2P8gkto8vxT+aF/brt++ezgdnU
 lW0pMGB+TyYGmIp6u49NBWwxgxBR60mWs3F0ROyR3adehC9i0cQwOFdDckg/uHr5G1NL
 2Hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SVcwzPjj4FoBI5HM9gcOEJnIDLucI9hQir6z0Gq65Ek=;
 b=ZwkY3pIFcpX69aTxLy2GqRWFewX97fhBmd8phnEJx/Py0R+RHwLii97JL8l9Hxlzhk
 sEEa/1La5q/TAGm3SEVc8QSDbVP8nqDlzmvk8GqAL/0yIljcV5OlVL9KY4b96kH75tlZ
 ohuFbxoPw57pP5a8vpsY0852pEBrQ+M6gtcMCJ14k7cF50R+RJ0wH9fUBjCxX5lfCyrm
 CtI9m6nWLjESWlwaA2kqRHSBuEmkdoXvXa7JFQbGIq0U6x88FMq11EcaZjr4KZqzD7M8
 SpmMCT7GmSPB+piZqQPCcKIixlgwch8GjpqtaFcmtVFKGfNohLgQpMQAKGIPgx364JbL
 ThXQ==
X-Gm-Message-State: AOAM5309h1LLJbqjLW5flvwkbEsf9nuux5iuhS+4zPvopA4wXSTW2sMG
 +sRwRd6DcNWnznUotSMYWfPyJ1UL50cyhUls69M=
X-Google-Smtp-Source: ABdhPJyMKy5aW5H6F782w+puxkEb3lSqYhtAXyDt7+22qJdcis9l/jFcFyywBfPjNMVzYoLnDdtbaLsBD2kNOZikIr8=
X-Received: by 2002:a05:6e02:d51:: with SMTP id
 h17mr58127702ilj.131.1594483426171; 
 Sat, 11 Jul 2020 09:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <1594289144-24723-1-git-send-email-bmeng.cn@gmail.com>
 <1594289144-24723-2-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKPvn7dALUHhK=na1svr==oZ2rvyFOnw8FvRJZP23uHN7Q@mail.gmail.com>
 <CAEUhbmX4-Js6J9eqRnBT5q9QqRY8R5-AQ4VRg1iVDJPzcurDUA@mail.gmail.com>
In-Reply-To: <CAEUhbmX4-Js6J9eqRnBT5q9QqRY8R5-AQ4VRg1iVDJPzcurDUA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sat, 11 Jul 2020 08:53:51 -0700
Message-ID: <CAKmqyKM2ZQ4oNqLG3UQWVhnHi1q7h_HjW7hjTfAC-2-1gXjzNg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/riscv: sifive_u: Provide a reliable way for
 bootloader to detect whether it is running in QEMU
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Kadam <sagar.kadam@sifive.com>,
 Pragnesh Patel <pragnesh.patel@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 9, 2020 at 5:48 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Alistair,
>
> On Fri, Jul 10, 2020 at 6:19 AM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Thu, Jul 9, 2020 at 3:07 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > From: Bin Meng <bin.meng@windriver.com>
> > >
> > > The reset vector codes are subject to change, e.g.: with recent
> > > fw_dynamic type image support, it breaks oreboot again.
> >
> > This is a recurring problem, I have another patch for Oreboot to fix
> > the latest breakage.
> >
>
> Can Oreboot be updated to remove the QEMU detection?

In general I think it should be.

Right now it's not critical to do. I think from a QEMU perspective we
have finished changing the "ROM" code so after this release we can
update Oreboot and then it should settle down again.

>
> > >
> > > Add a subregion in the MROM, with the size of machine RAM stored,
> > > so that we can provide a reliable way for bootloader to detect
> > > whether it is running in QEMU.
> >
> > I don't really like this though. I would prefer that we don't
> > encourage guest software to behave differently on QEMU. I don't think
> > other upstream boards do this.
> >
> > Besides Oreboot setting up the clocks are there any other users of this?
>
> I don't really have any specific reason, except for testing U-Boot SPL
> by relaxing the requirement of hardcoding the memory to 8G "-m 8G" as
> I indicated in the commit message below:

Yeah, I think that's just something we will have to deal with. If the
guest expects 8GB and doesn't check the device tree passed to it then
the user has to create 8GB of memory.

Alistair

>
> commit 3eaea6eb4e534f7b87c6eca808149bb671976800
> Author: Bin Meng <bin.meng@windriver.com>
> Date:   Mon Jun 15 17:50:41 2020 -0700
>
>     hw/riscv: sifive_u: Add a dummy DDR memory controller device
>
>     It is enough to simply map the SiFive FU540 DDR memory controller
>     into the MMIO space using create_unimplemented_device(), to make
>     the upstream U-Boot v2020.07 DDR memory initialization codes happy.
>
>     Note we do not generate device tree fragment for the DDR memory
>     controller. Since the controller data in device tree consumes a
>     very large space (see fu540-hifive-unleashed-a00-ddr.dtsi in the
>     U-Boot source), and it is only needed by U-Boot SPL but not any
>     operating system, we choose not to generate the fragment here.
>     This also means when testing with U-Boot SPL, the device tree has
>     to come from U-Boot SPL itself, but not the one generated by QEMU
>     on the fly. The memory has to be set to 8GiB to match the real
>     HiFive Unleashed board when invoking QEMU (-m 8G).
>
> Cc'ing Pragnesh and Sagar as they wanted to test U-Boot SPL with QEMU
> and talked to me the other day.
>
> Regards,
> Bin

