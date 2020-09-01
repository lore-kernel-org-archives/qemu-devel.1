Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30045C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 00:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE0632068E
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 00:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DP+IpnT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0632068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDGNY-0005Ba-1x
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 20:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kDGM7-0004Vd-VL; Tue, 01 Sep 2020 20:10:28 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:40022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kDGM5-0003iu-Oy; Tue, 01 Sep 2020 20:10:27 -0400
Received: by mail-io1-xd44.google.com with SMTP id j2so3917228ioj.7;
 Tue, 01 Sep 2020 17:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yeU1FPunAPmsBSs9Tjosk06eY4V5ULE2ckvo7jl6YJY=;
 b=DP+IpnT4hLRjd3e6wtRGHXnIPChg5vrkUnACRMPZ9dmzEe1eHnrXsR5UEsNe7IZiPz
 4NnnyQIJeslLWoDGdgel8Teb2U5/cnLAMSyNaY7Nc0Iun//NSmvWs1/JpV3O3KTnlT7G
 v4IeCvRgXngGv1cLgZ5x6irGea4/kvFlJsFZzPgZ9OjsgZdm1HdHIIhSvzg+sTy6HHIg
 s5GZ/e/rCum9woxuoP10LDWpR0ysEME8Vjrtel/Vt9oI41Z7gVovwXCh+Kha9LwRhpD6
 vW1ixFExt8jJmjJPEEifYtUcndHKxHpBsKuxwmqUBdDgQfjq/m3QzW3/38nxPe/rl5e2
 jlmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yeU1FPunAPmsBSs9Tjosk06eY4V5ULE2ckvo7jl6YJY=;
 b=eIDu7DVWTtcJt51g8+saCz/Uw9k8SSOu4wLy5/zhFdAccSOM0otS4eKFAVVYj85f2X
 KxOApVYcqnK0VNPpi1+MQTsfyBhkm+B3w9kIHvRkxPtjqz1ecphdALiXWjJ+kin2tDJF
 YPnfjXfEKT7v24E2thrHjsvKuHl0dDE7FzdYqmv7lS76G9BjJqMJlz/fpxmDPn2bpqKe
 E0UNYnmpZ8Z2z3YetAqmaG2nmeLff57JJcRVghnu9/gURx1giRJDrkgMq5hGiUPsu31h
 D6UAmdkcJd8J+V0NQo8EWw2blERO0RX9v7Da4Q0D9lgVPPeh+VU4GkNlkzzdQ7EPXzRT
 PGxA==
X-Gm-Message-State: AOAM531KesPg3sWjkyUX8F9OfNZSSoZ7hsbXpjyNAVs5uamE2zg29JN6
 ohqZBnUs+SniE0vHKfKAf+JrHNVHEIH0DSdVd5U=
X-Google-Smtp-Source: ABdhPJzL2WzNImOSX7VI14NaRdvpJDLD0JA+ZjHdwG098uZxuZsTXrYBcDPFRu4iTheviqsbsC3IVLX3wYhIjQt7TL0=
X-Received: by 2002:a05:6602:2f88:: with SMTP id
 u8mr1335112iow.175.1599005423899; 
 Tue, 01 Sep 2020 17:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200901055822.2721209-1-natechancellor@gmail.com>
In-Reply-To: <20200901055822.2721209-1-natechancellor@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 1 Sep 2020 16:59:29 -0700
Message-ID: <CAKmqyKNRMmJgmZSPK6wqqNQW41QLHwChPi+1cjqao_x1Q_iryQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: sifive_test: Allow 16-bit writes to memory region
To: Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-stable@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 31, 2020 at 10:59 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When shutting down the machine running a mainline Linux kernel, the
> following error happens:
>
> $ build/riscv64-softmmu/qemu-system-riscv64 -bios default -M virt \
>     -display none -initrd rootfs.cpio -kernel Image -m 512m \
>     -nodefaults -serial mon:stdio
> ...
> Requesting system poweroff
> [    4.999630] reboot: Power down
> sbi_trap_error: hart0: trap handler failed (error -2)
> sbi_trap_error: hart0: mcause=0x0000000000000007 mtval=0x0000000000100000
> sbi_trap_error: hart0: mepc=0x000000008000d4cc mstatus=0x0000000000001822
> sbi_trap_error: hart0: ra=0x000000008000999e sp=0x0000000080015c78
> sbi_trap_error: hart0: gp=0xffffffe000e76610 tp=0xffffffe0081b89c0
> sbi_trap_error: hart0: s0=0x0000000080015c88 s1=0x0000000000000040
> sbi_trap_error: hart0: a0=0x0000000000000000 a1=0x0000000080004024
> sbi_trap_error: hart0: a2=0x0000000080004024 a3=0x0000000080004024
> sbi_trap_error: hart0: a4=0x0000000000100000 a5=0x0000000000005555
> sbi_trap_error: hart0: a6=0x0000000000004024 a7=0x0000000080011158
> sbi_trap_error: hart0: s2=0x0000000000000000 s3=0x0000000080016000
> sbi_trap_error: hart0: s4=0x0000000000000000 s5=0x0000000000000000
> sbi_trap_error: hart0: s6=0x0000000000000001 s7=0x0000000000000000
> sbi_trap_error: hart0: s8=0x0000000000000000 s9=0x0000000000000000
> sbi_trap_error: hart0: s10=0x0000000000000000 s11=0x0000000000000008
> sbi_trap_error: hart0: t0=0x0000000000000000 t1=0x0000000000000000
> sbi_trap_error: hart0: t2=0x0000000000000000 t3=0x0000000000000000
> sbi_trap_error: hart0: t4=0x0000000000000000 t5=0x0000000000000000
> sbi_trap_error: hart0: t6=0x0000000000000000
>
> The kernel does a 16-bit write when powering off the machine, which
> was allowed before commit 5d971f9e67 ("memory: Revert "memory: accept
> mismatching sizes in memory_region_access_valid""). Make min_access_size
> match reality so that the machine can shut down properly now.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 88a07990fa ("SiFive RISC-V Test Finisher")
> Fixes: 5d971f9e67 ("memory: Revert "memory: accept mismatching sizes in memory_region_access_valid"")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>
> Please let me know if the tags are wrong or inappropriate, this is my
> first QEMU patch.
>
>  hw/riscv/sifive_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
> index 0c78fb2c93..8c70dd69df 100644
> --- a/hw/riscv/sifive_test.c
> +++ b/hw/riscv/sifive_test.c
> @@ -59,7 +59,7 @@ static const MemoryRegionOps sifive_test_ops = {
>      .write = sifive_test_write,
>      .endianness = DEVICE_NATIVE_ENDIAN,
>      .valid = {
> -        .min_access_size = 4,
> +        .min_access_size = 2,
>          .max_access_size = 4
>      }
>  };
>
> base-commit: 2f4c51c0f384d7888a04b4815861e6d5fd244d75
> --
> 2.28.0
>
>

