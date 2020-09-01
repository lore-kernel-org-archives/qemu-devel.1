Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2674C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 23:28:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E246206EF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 23:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeGnr5G9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E246206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDFhw-0006lS-4v
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 19:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kDFhG-0006Bb-9R; Tue, 01 Sep 2020 19:28:14 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:36578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kDFhE-0007ws-JC; Tue, 01 Sep 2020 19:28:13 -0400
Received: by mail-io1-xd43.google.com with SMTP id d190so3837238iof.3;
 Tue, 01 Sep 2020 16:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iwaxBwxxQkEUUSaCQNlszdrDUR8DQFyolFLsT2H18lo=;
 b=ZeGnr5G9cuca3MrHlEyaIG5ZvGF51G5qqVbzPy+EYLw6tpaQHYAZ9sqcnsKXmfDLvn
 PUqz4FyQOYXiYhkrgp7ZCjU+TEFTj2Qm+0apZncfYJIOdju5KV5oWf96xfN5/FOYB805
 B5+fyidT2qiyM2bPBXeci1p2nqHlRvd5wk1CacK5C7FoeGyjI0+HaOtyrnQgTtLv5aUO
 C7GV7XXoA0alpblHrRzXcRmRSpz1OYXBrXUry9Tb5pikqMBA08SOOp3U3BBRLliAUokg
 NKOcl8TS4hwa3aLqFJr602jKSOvqb4XnDNEQ+uWtq82hNCfx1wFjwvzAhvpytcy5g5EC
 HORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iwaxBwxxQkEUUSaCQNlszdrDUR8DQFyolFLsT2H18lo=;
 b=L9f4tqtcwjlf/CGvXHggaYnsqdb/6dYKCXeNza36j6Dl6GAn8OBSVNHRGZZtzJXIop
 kQOiG6tQ0u9LOdtuXnFmnq2lja0q0WbL5S8WaRo0F0rmqBS0008buFBclClV6ryMxdrk
 HXl3wIlN01iku/o4EdHEw9A1neWr4W7EBrUAdt1BfYfLMiP67cSvkveNY01CupxHeqFX
 GZ+2NITLTLTv5wAP2RzuKXIjiZLP8T9vfzFOGyZkvY1i37RKrP6agyyqSDG9FLqME5we
 YVF1rfZgJ+1GsKFCWfCQvoO5UB80GB+anCToZKwdAlfTqtoT91VRpp69BXZF+C/Csev5
 HqNQ==
X-Gm-Message-State: AOAM5300Aoq97UdpH85gCfs26wVAkHhUuV1oFmeRwPi/WDK0d3p1UmDC
 9p+d0en7QIRZiBfZdH+SMyElbjGHsuKT3EsH6SQ=
X-Google-Smtp-Source: ABdhPJxYCFJOHtB5427cf7yJFbRzZoOJMmjG/vl1MP9zpUz/fmIy0i8bnS+oDGN25mtUrl+fXwjnX8ntBponr7TJdVU=
X-Received: by 2002:a6b:3e84:: with SMTP id l126mr1260689ioa.118.1599002889953; 
 Tue, 01 Sep 2020 16:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200901055822.2721209-1-natechancellor@gmail.com>
In-Reply-To: <20200901055822.2721209-1-natechancellor@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 1 Sep 2020 16:17:16 -0700
Message-ID: <CAKmqyKP9hX-+9CEAKPWU-ZvCWBSUH7E5DYNX0qKU9wtkkSKCeQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: sifive_test: Allow 16-bit writes to memory region
To: Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

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

