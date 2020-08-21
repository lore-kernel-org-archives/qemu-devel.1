Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A02CC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:03:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 658E82075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqsLllNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658E82075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9CJg-0001sh-Ir
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 15:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k9CIW-0001MW-9o; Fri, 21 Aug 2020 15:01:56 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:41411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k9CIU-0004ql-Bd; Fri, 21 Aug 2020 15:01:55 -0400
Received: by mail-io1-xd41.google.com with SMTP id m23so2156806iol.8;
 Fri, 21 Aug 2020 12:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bTMBrEIv/24suFZSfOma+qz4vCxNJrg1e4ZEX6dqYJY=;
 b=aqsLllNCJ6NDNc7/PfNfje3XtSyAmrozA8vVKKwVBeJ75kLeZXV2ZfxPK5ywBpFGdd
 n/04u4nR6tye8hJRUd0L+tmr6QT/k35D0P6FeC7tNxIZz3ieGoRxNMPIC7lSx+0DajUW
 hKVzW+uYQND1pttxWIXka+8yENdJww78Lh4FVZh7vhdqfTOyAyhpEbkmCBZP6EWodVGP
 fMMsqOmWaLwy0/KRo6zkrmJIROkT1Jcc2bPnQ/vKepe2JA5BAzYYwiSqJAsZXRoI2sQ9
 feO1QZ9fPG+nG8O38JJ+6uPrxTwMi7AVWx65fLKwOKCiyenYhEykTAoYRK0OBK0Zhp+s
 WK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bTMBrEIv/24suFZSfOma+qz4vCxNJrg1e4ZEX6dqYJY=;
 b=FCMYuURQ9b/flkzLcdlYgVGnRrjO73XI3FPrKs/5a/HbY7Ad0wsn25mF4b5nD4woz/
 p+2+WBNtPyp8VaIlh8gcuCJlu4ncirQS30oP6KYTVBaztL3r5l/AbQypJmgo8VgwDlYD
 1xhPf9uwbn94vXQOcG696IIPajQe0XR1oMdRCPJVsen3b3ozSh/M8IS4zfD0IUjJuWcH
 ml9zQqxmOpCGtBkgNSmuQ+OwL1oEsmd5PQAmJP7GR8estVkedTMC7Xi7F1U7Nac7pLqB
 eLf8u9zx8GjiMkVUy1+MsZLlfIAJjzi2vEgEY11KkHdpzZkDRG1Ef/hNNduQaso0cOsk
 DNMQ==
X-Gm-Message-State: AOAM530ThHOqD7dA7KpjBxMm+a6Yo32MKksNYDlP1kydDOuy0KVHhUV8
 fnrRf7f18iEH+iiQuFATQ74MN61I/aPqTuL6prk=
X-Google-Smtp-Source: ABdhPJwGcdgufSlQq8QKyzc3fITCgjcmynuTgtuRd4gdAxpvDFpHGJ84c7rdgxCQopwgsiQNw8qHc1CP8fQm7VD53iY=
X-Received: by 2002:a6b:6016:: with SMTP id r22mr3459175iog.42.1598036510426; 
 Fri, 21 Aug 2020 12:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-19-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1597423256-14847-19-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 21 Aug 2020 11:51:13 -0700
Message-ID: <CAKmqyKO3qaTSCm2x1k0LDaVHLBgj2wcWunm=LvQF3t2Eh_kywA@mail.gmail.com>
Subject: Re: [PATCH 18/18] hw/riscv: microchip_pfsoc: Document the software
 used for testing
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
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
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 14, 2020 at 9:49 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Add some useful comments to document the software used for testing.
> including how to patch HSS to bypass the DDR memory initialization,
> HSS and Yocto BSP build instructions, etc.
>
> To launch this machine for testing:
> $ qemu-system-riscv64 -M microchip-icicle-kit -smp 5 \
>     -bios path/to/hss.bin -sd path/to/sdcard.img \
>     -nic user,model=cadence_gem \
>     -nic tap,ifname=tap,model=cadence_gem \
>     -display none -serial stdio \
>     -chardev socket,id=serial1,path=serial1.sock,server,wait \
>     -serial chardev:serial1
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
>
> ---
>
>  hw/riscv/microchip_pfsoc.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index e8b7f86..1575fef 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -56,6 +56,27 @@
>  /*
>   * The BIOS image used by this machine is called Hart Software Services (HSS).
>   * See https://github.com/polarfire-soc/hart-software-services
> + *
> + * As of now the DDR memory controller in the Microchip PolarFire SoC has not
> + * been modeled. Simply creating unimplemented devices does not make HSS happy.
> + * Emulating the DDR memory controller is tedious, so a patched HSS should be
> + * used as the BIOS for this machine.
> + *
> + * To patch HSS, open boards/icicle-kit-es/hss_board_init.c in the HSS source
> + * tree, find the boardInitFunctions[] array that contains the initialization
> + * routines for this board, and remove the line that contains 'HSS_DDRInit'.
> + *
> + * QEMU does not support eMMC hence the SD configuration shall be used in the
> + * HSS and Yocto BSP build. The eMMC configuration is not supported.
> + *
> + * Instructions to build HSS:
> + *   $ cp boards/icicle-kit-es/def_config.sdcard .config
> + *   $ make BOARD=icicle-kit-es
> + *
> + * For Yocto build, "MACHINE=icicle-kit-es-sd" should be specified, otherwise
> + * when booting Linux kernel the rootfs cannot be mounted. The generated image
> + * is something like: mpfs-dev-cli-icicle-kit-es-sd.rootfs.wic. Resize the file
> + * with 'qemu-image' to a power of 2 before passing to QEMU '-sd' command line.

Instead of adding comments in the code (where it's hard for users to
find and prone to getting out of date) can you drop this patch and
instead update the RISC-V QEMU wiki?

https://wiki.qemu.org/Documentation/Platforms/RISCV

Just add an Icicle section.

Alistair

>   */
>  #define BIOS_FILENAME   "hss.bin"
>  #define RESET_VECTOR    0x20220000
> --
> 2.7.4
>
>

