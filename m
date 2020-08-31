Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F37DC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C8F20719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hxc4LY7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C8F20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmi9-0005n1-Ay
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kCmfM-00008d-L3; Mon, 31 Aug 2020 12:28:20 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:38325)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kCmfK-0000FY-L8; Mon, 31 Aug 2020 12:28:20 -0400
Received: by mail-qk1-x742.google.com with SMTP id d20so3879744qka.5;
 Mon, 31 Aug 2020 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cayOxeiuwE5lJ1Ui4eIej3QnVuzqOYfwH+FP/dKeq0A=;
 b=Hxc4LY7aitHw9myf2hptFhZNCSIgtONkdM47ansKbOUXLlUGTuA8yxcs0U1N7tDpfP
 QA9Fp4Qs+6R/xJS9Ibn+X+9qTd95vH3qr5tIPG+RQkFAH0G2aXMkJ+xqeKVtPHyt7Qbs
 P6/yfh2vUyBMqHZQOLw8CAH+yPHIZ0jH7Q6rVJBjl17rqD91ouiBjMs73yvnZZ7F4k43
 U4oBEEsDcTMPj2BzPbQcVs8CtA60+l+6Q6I6ELFxZ5BSPYbAylNWqrXgfvz6xC5sHCmo
 JG97RyhagoAFL+u39dfs+k0wPpq3AXWs/TdWBrPmh0a921E1cbNvtRP2h8nbnGE7AB6G
 FScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cayOxeiuwE5lJ1Ui4eIej3QnVuzqOYfwH+FP/dKeq0A=;
 b=q0NclDoK9HN4eayNDgbgK9XHvLQyFavxjTRJFKghcm6BQrd5lm22ZfDKr9vVy58xni
 Jul6YwYOwUomNSSI+YpXFpPtANRzSwZXXwZdHY4Z064Vvutl4R3tW6mMnRYTKcXZEhQX
 RujHl/AMlYetTf/PfYeE0hHYzYL7PHcVFpNpehd3AmukOUVZIsC5yrsjhlFVb97uRESF
 4csOpQxD+Je+mGyzE1igv4HhGU+0YgXCe00/FXfnYTevb46Tz6PKV/bei6od4P1FM61l
 GgWVEVv8dwEAjnbxbgeCnSDbiCjegoO+CgF3GXuJHeFaRdrTgyILEEtOBjpsBFoPG7M1
 Duqw==
X-Gm-Message-State: AOAM5316g5LSiOtf4t0l5TtodBmtW/aKObnlLGoSSSp8KD1P9wTsSncV
 8Y51w0p0vl307r3wXfpKG3kjHtQj2rDKKP9CXfo=
X-Google-Smtp-Source: ABdhPJyqb+3s+FzbNm70ffyv/q1yKGz65njLm1o8zP8JCaqfs9gSjkk7KPGjoON65TrAxn+4oLSybW26bu1lo95xtNU=
X-Received: by 2002:a05:620a:567:: with SMTP id
 p7mr2261056qkp.164.1598891297059; 
 Mon, 31 Aug 2020 09:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200610134731.1514409-1-mst@redhat.com>
 <20200827053216.GA1515751@ubuntu-n2-xlarge-x86>
 <20200830021939-mutt-send-email-mst@kernel.org>
 <20200830064944.GA1073664@ubuntu-n2-xlarge-x86>
 <2fd7a1df-db2b-9edd-1d73-7efa18312ace@ilande.co.uk>
 <20200830074304.GA2406902@ubuntu-n2-xlarge-x86>
In-Reply-To: <20200830074304.GA2406902@ubuntu-n2-xlarge-x86>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 31 Aug 2020 09:17:24 -0700
Message-ID: <CAKmqyKNHMtjyYYWU5R_m5xFQ8tdbjFyQyfjbpUbpPpKtHsvOkw@mail.gmail.com>
Subject: Re: [PATCH] memory: Revert "memory: accept mismatching sizes in
 memory_region_access_valid"
To: Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=alistair23@gmail.com; helo=mail-qk1-x742.google.com
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-stable@nongnu.org,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Aug 30, 2020 at 12:43 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Sun, Aug 30, 2020 at 08:24:15AM +0100, Mark Cave-Ayland wrote:
> > On 30/08/2020 07:49, Nathan Chancellor wrote:
> >
> > > Unfortunately, it does not. I applied it on top of latest
> > > git (ac8b279f13865d1a4f1958d3bf34240c1c3af90d) and I can still
> > > reproduce my failure. Is it possible that type of fix is needed
> > > in a RISC-V specific driver?
> > >
> > > Would you like me to comment on the Launchpad bug as well?
> >
> > Hi Nathan,
> >
> > I came up with a quick patch to enable some logging to catch memory accesses being
> > refused for a similar bug report at
> > https://bugs.launchpad.net/qemu/+bug/1886318/comments/13.
> >
> > Can you apply the same change to your tree and report any messages on stderr as you
> > do your board reboot test?
> >
> >
> > ATB,
> >
> > Mark.
>
> Thanks Mark, that helped.
>
> ...
> [    3.807738] reboot: Power down
> invalid size: riscv.sifive.test addr 0 size: 2
> sbi_trap_error: hart0: trap handler failed (error -2)
> sbi_trap_error: hart0: mcause=0x0000000000000007 mtval=0x0000000000100000
> sbi_trap_error: hart0: mepc=0x000000008000d4cc mstatus=0x0000000000001822
> sbi_trap_error: hart0: ra=0x000000008000999e sp=0x0000000080015c78
> sbi_trap_error: hart0: gp=0xffffffe000e765d0 tp=0xffffffe0081c0000
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
> With this diff, I can successfully shut down the board. No idea if that
> is valid or not though.

The SiFive test is not a real device, so there is no documentation to
check against, at least none that I can find.

If the mainline Linux kernel does a 16-bit write then that should be
correct as it does the same thing on hardware and SiFive's
simulations.

Do you mind sending a patch?

Alistair

>
> Cheers,
> Nathan
>
> ============================================================
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
>

