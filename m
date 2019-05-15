Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7079DC04AA7
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 06:50:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 416F22084E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 06:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416F22084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60516 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQnk8-0002fx-68
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 02:50:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQniP-0001Dk-D2
	for qemu-devel@nongnu.org; Wed, 15 May 2019 02:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQnds-0005RW-K5
	for qemu-devel@nongnu.org; Wed, 15 May 2019 02:43:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hQndr-0005Lx-SP
	for qemu-devel@nongnu.org; Wed, 15 May 2019 02:43:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id s17so1281095wru.3
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 23:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=U6hSEAt7kVlfX2ACvICmMavT/g6i3LH1gfXC2Uu3Pcg=;
	b=oFiCTvabyZaVBWNKOY2/hjWvW/ZOYcvd2YMlskQuAwYkq85K5X8BGbGkR5ezI66cyI
	VMWvrrsxwKmqaELEkXLyIs4zoRpbUgNqAryFzGbVPtnbRHTpclZvQQjFPLP5L5xX1XA5
	ufktjDigw/GeDyrCy8EKVYj39mfuYun6fqkcwFDMkFk0uUZCHcIlO+P/5OIET6kxdnEq
	9CmtHK+euQKDNLQfZoVyVHbqYLdY6FS/Vfi0YVERB1YGquCzebcV0Rn7XD+LPi6D58LT
	VpBGtIC9CmiWeYQLKZvNSz+C4AYwr6NZE/8B68dELWpLTDAwKVsEJx3h4vQdL5K/YWn/
	iy2w==
X-Gm-Message-State: APjAAAVhD3LvEzGKUmWjl51/9pT1Uo82kDYYXZnh2QdFAps2HXnZWtW6
	f1M2nf6iTAx/MSuuNkJM298WGw==
X-Google-Smtp-Source: APXvYqxYUkgY5fym8n9ZUAVFwCuIo0dUzda/RGpQDLmvKYbi6+zRiCqQqzR30jhihZEm/abhmtQreQ==
X-Received: by 2002:adf:dbcc:: with SMTP id e12mr220759wrj.134.1557902634382; 
	Tue, 14 May 2019 23:43:54 -0700 (PDT)
Received: from [192.168.1.43] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id o8sm947625wrx.50.2019.05.14.23.43.53
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 23:43:53 -0700 (PDT)
To: Alistair Francis <Alistair.Francis@wdc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
References: <78cf484c4d991e899d0065b2dab3a2e204ce8723.1557879499.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f3b0b9a8-2e25-6054-8893-377c30a83579@redhat.com>
Date: Wed, 15 May 2019 08:43:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <78cf484c4d991e899d0065b2dab3a2e204ce8723.1557879499.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v2 1/1] target/arm: Fix vector operation
 segfault
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"richard.henderson@linaro.org" <richard.henderson@linaro.org>,
	"alistair23@gmail.com" <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/19 2:21 AM, Alistair Francis wrote:
> Commit 89e68b575 "target/arm: Use vector operations for saturation"
> causes this abort() when booting QEMU ARM with a Cortex-A15:
> 
> 0  0x00007ffff4c2382f in raise () at /usr/lib/libc.so.6
> 1  0x00007ffff4c0e672 in abort () at /usr/lib/libc.so.6
> 2  0x00005555559c1839 in disas_neon_data_insn (insn=<optimized out>, s=<optimized out>) at ./target/arm/translate.c:6673
> 3  0x00005555559c1839 in disas_neon_data_insn (s=<optimized out>, insn=<optimized out>) at ./target/arm/translate.c:6386
> 4  0x00005555559cd8a4 in disas_arm_insn (insn=4081107068, s=0x7fffe59a9510) at ./target/arm/translate.c:9289
> 5  0x00005555559cd8a4 in arm_tr_translate_insn (dcbase=0x7fffe59a9510, cpu=<optimized out>) at ./target/arm/translate.c:13612
> 6  0x00005555558d1d39 in translator_loop (ops=0x5555561cc580 <arm_translator_ops>, db=0x7fffe59a9510, cpu=0x55555686a2f0, tb=<optimized out>, max_insns=<optimized out>) at ./accel/tcg/translator.c:96
> 7  0x00005555559d10d4 in gen_intermediate_code (cpu=cpu@entry=0x55555686a2f0, tb=tb@entry=0x7fffd7840080 <code_gen_buffer+126091347>, max_insns=max_insns@entry=512) at ./target/arm/translate.c:13901
> 8  0x00005555558d06b9 in tb_gen_code (cpu=cpu@entry=0x55555686a2f0, pc=3067096216, cs_base=0, flags=192, cflags=-16252928, cflags@entry=524288) at ./accel/tcg/translate-all.c:1736
> 9  0x00005555558ce467 in tb_find (cf_mask=524288, tb_exit=1, last_tb=0x7fffd783e640 <code_gen_buffer+126084627>, cpu=0x1) at ./accel/tcg/cpu-exec.c:407
> 10 0x00005555558ce467 in cpu_exec (cpu=cpu@entry=0x55555686a2f0) at ./accel/tcg/cpu-exec.c:728
> 11 0x000055555588b0cf in tcg_cpu_exec (cpu=0x55555686a2f0) at ./cpus.c:1431
> 12 0x000055555588d223 in qemu_tcg_cpu_thread_fn (arg=0x55555686a2f0) at ./cpus.c:1735
> 13 0x000055555588d223 in qemu_tcg_cpu_thread_fn (arg=arg@entry=0x55555686a2f0) at ./cpus.c:1709
> 14 0x0000555555d2629a in qemu_thread_start (args=<optimized out>) at ./util/qemu-thread-posix.c:502
> 15 0x00007ffff4db8a92 in start_thread () at /usr/lib/libpthread.
> 
> This patch ensures that we don't hit the abort() in the second switch
> case in disas_neon_data_insn() as we will return from the first case.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/arm/translate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index dd053c80d6..298c262825 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -6598,13 +6598,13 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
>              tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
>                             rn_ofs, rm_ofs, vec_size, vec_size,
>                             (u ? uqadd_op : sqadd_op) + size);
> -            break;
> +            return 0;
>  
>          case NEON_3R_VQSUB:
>              tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
>                             rn_ofs, rm_ofs, vec_size, vec_size,
>                             (u ? uqsub_op : sqsub_op) + size);
> -            break;
> +            return 0;
>  
>          case NEON_3R_VMUL: /* VMUL */
>              if (u) {
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

