Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8BAC433E6
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 07:43:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8272076D
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 07:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3U0eft0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8272076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCI0F-0005Mu-KA
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 03:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <natechancellor@gmail.com>)
 id 1kCHza-0004lZ-Kr; Sun, 30 Aug 2020 03:43:10 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:45943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <natechancellor@gmail.com>)
 id 1kCHzY-0007px-La; Sun, 30 Aug 2020 03:43:10 -0400
Received: by mail-qt1-x842.google.com with SMTP id z2so2674069qtv.12;
 Sun, 30 Aug 2020 00:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=SYg2+G3dKCOTe5AARyDGUkkSUhFK9990y3j+lGB5Zt0=;
 b=L3U0eft0HY/R1k608U+0Pu/JLxa2qb0dN+a5BOkjbZjRIeEN8gEbrZh/wB3TUGj1cX
 GOpIZc95U1AVsHc3xSFtnKx+dIB0j+U5+S6WiZMrziiJohr3nHS9PbE7e7BqDNUyxZzd
 ZeRr69CZy3L0Gu2zqOV90+i5J8c2+kAXuxPjEptsynmIs0xceISh1W1NXrkRy+uJnxB1
 CgSICy5yosKeRWD1+g4x9DaSLXTFDGULRy/FJUVf+3cDwNX1xSKuepH7Awn0YmAix8hY
 sOibFKbdT9ZgU0ltENDy8o8oufO/INzey74XzjHRHGt62SA/GvKNLpB48UtFoEy8Cqs7
 sv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SYg2+G3dKCOTe5AARyDGUkkSUhFK9990y3j+lGB5Zt0=;
 b=hvWE+ub12xEdyXb7tZ/rC9rSPpmHnTujl7/NGmAEhTRz8TafeQtLSwD6wd8IN0rU13
 IZWoqj5S05xdnHft55xd5HvNFuS4llili9mdFjFyOI1JtaYxi2/RjtSDEoYQmdmVqwZ8
 pTmCcbCZ7sMs2bx7XUcUjurAdNkhqkB2BaFcc004OnVGxEmo2ercsQ9PwQfex5lZS8kB
 wOe78YFynGch8Rk0Vv683stNf1rsD2NuKa8Uw2iEdSbEIE/MPUgNV2wZVBB2jVG83Guy
 JpM5HGxO3SoJl4ftj+bnblOkjhzLokFgJeW40uIT0RQ9sROwLxB/WX6r0fTqT8kRu6iw
 m3oQ==
X-Gm-Message-State: AOAM530QaIikT4sLGqbFIrl3U154v7uMWjj3/s9KSfUHXUbzNcFrhiPI
 /M59jOQQS6HwFLY39SPzcZA=
X-Google-Smtp-Source: ABdhPJxteLzs73nUj4rCK011cZW1EKSPmdRAitNtjBiQtfNUgoyndX6Xg0vhuxp/qZb4QKA1uvAbKQ==
X-Received: by 2002:ac8:264e:: with SMTP id v14mr3770011qtv.229.1598773386987; 
 Sun, 30 Aug 2020 00:43:06 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
 by smtp.gmail.com with ESMTPSA id x29sm5151425qtv.80.2020.08.30.00.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2020 00:43:06 -0700 (PDT)
Date: Sun, 30 Aug 2020 00:43:04 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH] memory: Revert "memory: accept mismatching sizes in
 memory_region_access_valid"
Message-ID: <20200830074304.GA2406902@ubuntu-n2-xlarge-x86>
References: <20200610134731.1514409-1-mst@redhat.com>
 <20200827053216.GA1515751@ubuntu-n2-xlarge-x86>
 <20200830021939-mutt-send-email-mst@kernel.org>
 <20200830064944.GA1073664@ubuntu-n2-xlarge-x86>
 <2fd7a1df-db2b-9edd-1d73-7efa18312ace@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fd7a1df-db2b-9edd-1d73-7efa18312ace@ilande.co.uk>
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=natechancellor@gmail.com; helo=mail-qt1-x842.google.com
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Aug 30, 2020 at 08:24:15AM +0100, Mark Cave-Ayland wrote:
> On 30/08/2020 07:49, Nathan Chancellor wrote:
> 
> > Unfortunately, it does not. I applied it on top of latest
> > git (ac8b279f13865d1a4f1958d3bf34240c1c3af90d) and I can still
> > reproduce my failure. Is it possible that type of fix is needed
> > in a RISC-V specific driver?
> > 
> > Would you like me to comment on the Launchpad bug as well?
> 
> Hi Nathan,
> 
> I came up with a quick patch to enable some logging to catch memory accesses being
> refused for a similar bug report at
> https://bugs.launchpad.net/qemu/+bug/1886318/comments/13.
> 
> Can you apply the same change to your tree and report any messages on stderr as you
> do your board reboot test?
> 
> 
> ATB,
> 
> Mark.

Thanks Mark, that helped.

...
[    3.807738] reboot: Power down
invalid size: riscv.sifive.test addr 0 size: 2
sbi_trap_error: hart0: trap handler failed (error -2)
sbi_trap_error: hart0: mcause=0x0000000000000007 mtval=0x0000000000100000
sbi_trap_error: hart0: mepc=0x000000008000d4cc mstatus=0x0000000000001822
sbi_trap_error: hart0: ra=0x000000008000999e sp=0x0000000080015c78
sbi_trap_error: hart0: gp=0xffffffe000e765d0 tp=0xffffffe0081c0000
sbi_trap_error: hart0: s0=0x0000000080015c88 s1=0x0000000000000040
sbi_trap_error: hart0: a0=0x0000000000000000 a1=0x0000000080004024
sbi_trap_error: hart0: a2=0x0000000080004024 a3=0x0000000080004024
sbi_trap_error: hart0: a4=0x0000000000100000 a5=0x0000000000005555
sbi_trap_error: hart0: a6=0x0000000000004024 a7=0x0000000080011158
sbi_trap_error: hart0: s2=0x0000000000000000 s3=0x0000000080016000
sbi_trap_error: hart0: s4=0x0000000000000000 s5=0x0000000000000000
sbi_trap_error: hart0: s6=0x0000000000000001 s7=0x0000000000000000
sbi_trap_error: hart0: s8=0x0000000000000000 s9=0x0000000000000000
sbi_trap_error: hart0: s10=0x0000000000000000 s11=0x0000000000000008
sbi_trap_error: hart0: t0=0x0000000000000000 t1=0x0000000000000000
sbi_trap_error: hart0: t2=0x0000000000000000 t3=0x0000000000000000
sbi_trap_error: hart0: t4=0x0000000000000000 t5=0x0000000000000000
sbi_trap_error: hart0: t6=0x0000000000000000

With this diff, I can successfully shut down the board. No idea if that
is valid or not though.

Cheers,
Nathan

============================================================

diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
index 0c78fb2c93..8c70dd69df 100644
--- a/hw/riscv/sifive_test.c
+++ b/hw/riscv/sifive_test.c
@@ -59,7 +59,7 @@ static const MemoryRegionOps sifive_test_ops = {
     .write = sifive_test_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
     .valid = {
-        .min_access_size = 4,
+        .min_access_size = 2,
         .max_access_size = 4
     }
 };


