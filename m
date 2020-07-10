Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D07C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 00:49:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C1F620774
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 00:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlHlFEQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1F620774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jthEV-00054K-OO
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 20:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jthDj-0004ba-UW; Thu, 09 Jul 2020 20:48:55 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:45197)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jthDi-0007qP-EE; Thu, 09 Jul 2020 20:48:55 -0400
Received: by mail-yb1-xb42.google.com with SMTP id y17so1867745ybm.12;
 Thu, 09 Jul 2020 17:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VyIvS3uKEBNp2G+aLQCY5/C+zFk9eAPeiMWpDEx5FiE=;
 b=qlHlFEQ894TJw0S6CkOJyKmH9m+bW1gWbh7Jp3VJ43YYLP7Hc9u2Ouwp9l03+HqGwQ
 Acogb2uaMvopNdQMIVn7BvsNRK5z51VzX25IBh4puDAFbVojr8TVnqzLOxpC7XoYRZe7
 ELcP74hVFePgsdN8j1wYsSgI+GvyBB3IQzgQR4QB8TzwhT+199eSjeaejo2ry7n5UJYS
 x8zNpWNWqlefwbueDwsGEspFNJTKupDvpORSzM+IQRk7eQgRVKPMCVGU/epjpmZkszLw
 ZkjTZb7NHLQGCd2141/D10YLjgJ5G9+clC4GIg4Ao+Xy0emE0jwEWnigO0GsU399jYzG
 kc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VyIvS3uKEBNp2G+aLQCY5/C+zFk9eAPeiMWpDEx5FiE=;
 b=iE6gbI+VKShOSlWxvHAcCtFNTZBZbCXEIMJ96fkYIPDCAW2FIsjQ9cbshpvmAfMpC+
 hiEvGzgmHAjtlpzjf9yaCR/u6sR0M7mtbJS6VP9rywnsQ/JgHcUsev9B9pS+9ztTNdMB
 7LBZ3qOpfnB2b+6MpNuoGovLIFmPAM++unibw8lod9wVxBn9ZdoK51wzsVsdt+5qeWVk
 FXzDh/iBI8I4h9QJKJD4h80cRd22hzvXO4qKtQ8ST2lE0HrcvpVnIkBl8xDXXux26vqK
 lX18n6GI/RzquR+hsmMfpEWlCZmreNFMESsjVmMAlHnKDPy+vnkV9dxWfbVjwt5fNgCO
 drDg==
X-Gm-Message-State: AOAM530b+bisyyojbk8LRZ56ECJmncqRb34snyuzSlFTJ8V/u4B2Zc/d
 m6pIQ02fr9+xjrv1ovjcIMF3JW3uhYoQam2Dk0c=
X-Google-Smtp-Source: ABdhPJwabWhWYuJzrOWdaR3qcm717u70QZW2H4awvFbH52S5oAcgcnOTLj7jHLR4Ij9h1I/Ud6BYCSGOVAQ/ymcDed8=
X-Received: by 2002:a25:aea5:: with SMTP id b37mr51174235ybj.239.1594342133185; 
 Thu, 09 Jul 2020 17:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <1594289144-24723-1-git-send-email-bmeng.cn@gmail.com>
 <1594289144-24723-2-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKPvn7dALUHhK=na1svr==oZ2rvyFOnw8FvRJZP23uHN7Q@mail.gmail.com>
In-Reply-To: <CAKmqyKPvn7dALUHhK=na1svr==oZ2rvyFOnw8FvRJZP23uHN7Q@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 10 Jul 2020 08:48:42 +0800
Message-ID: <CAEUhbmX4-Js6J9eqRnBT5q9QqRY8R5-AQ4VRg1iVDJPzcurDUA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/riscv: sifive_u: Provide a reliable way for
 bootloader to detect whether it is running in QEMU
To: Alistair Francis <alistair23@gmail.com>,
 Pragnesh Patel <pragnesh.patel@sifive.com>, 
 Sagar Kadam <sagar.kadam@sifive.com>
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

On Fri, Jul 10, 2020 at 6:19 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Thu, Jul 9, 2020 at 3:07 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > The reset vector codes are subject to change, e.g.: with recent
> > fw_dynamic type image support, it breaks oreboot again.
>
> This is a recurring problem, I have another patch for Oreboot to fix
> the latest breakage.
>

Can Oreboot be updated to remove the QEMU detection?

> >
> > Add a subregion in the MROM, with the size of machine RAM stored,
> > so that we can provide a reliable way for bootloader to detect
> > whether it is running in QEMU.
>
> I don't really like this though. I would prefer that we don't
> encourage guest software to behave differently on QEMU. I don't think
> other upstream boards do this.
>
> Besides Oreboot setting up the clocks are there any other users of this?

I don't really have any specific reason, except for testing U-Boot SPL
by relaxing the requirement of hardcoding the memory to 8G "-m 8G" as
I indicated in the commit message below:

commit 3eaea6eb4e534f7b87c6eca808149bb671976800
Author: Bin Meng <bin.meng@windriver.com>
Date:   Mon Jun 15 17:50:41 2020 -0700

    hw/riscv: sifive_u: Add a dummy DDR memory controller device

    It is enough to simply map the SiFive FU540 DDR memory controller
    into the MMIO space using create_unimplemented_device(), to make
    the upstream U-Boot v2020.07 DDR memory initialization codes happy.

    Note we do not generate device tree fragment for the DDR memory
    controller. Since the controller data in device tree consumes a
    very large space (see fu540-hifive-unleashed-a00-ddr.dtsi in the
    U-Boot source), and it is only needed by U-Boot SPL but not any
    operating system, we choose not to generate the fragment here.
    This also means when testing with U-Boot SPL, the device tree has
    to come from U-Boot SPL itself, but not the one generated by QEMU
    on the fly. The memory has to be set to 8GiB to match the real
    HiFive Unleashed board when invoking QEMU (-m 8G).

Cc'ing Pragnesh and Sagar as they wanted to test U-Boot SPL with QEMU
and talked to me the other day.

Regards,
Bin

