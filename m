Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0F3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E175E223C7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uldos1Do"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E175E223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyAW-0003s4-Rw
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZxgq-000408-CB
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:53:42 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZxgo-0004EV-Gd
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:53:39 -0500
Received: by mail-wr1-x443.google.com with SMTP id n15so18924464wrq.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Abd1JDvWKvwvWMwVFtuk3o19dYdiYvo//0MeZhwCziU=;
 b=Uldos1DoFe3eLZMbgm9IbbxQbIk92ehGA95WC8RzaFGcBvQ/v1K4zFoG+GFaAyZiOH
 CUJNBq6ElY9xTDjEwjQw7Zl4JLRC19uMQlomDJOPmrkDyL++KBiWFLZ0Bldoqn6FXVTx
 S4ignYVVCpIYFFy6T74S482wHyBuyGl46iQ7527gEWy+WxMtdBg0Wf8oGvJBXT4s5GZr
 m/Whj4oqj9Ru4mAf6VPno5m6WhpTrur7JxBbEGYQcTgbVGYXV2Yl0t06dMPPAV3IIyo3
 4p/9f2TkpHLkXo61WjIuv4Xl/bxC7pBJTanqro0MeTdIG+6VW0LZIdKm+qw1at6hpayg
 lhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Abd1JDvWKvwvWMwVFtuk3o19dYdiYvo//0MeZhwCziU=;
 b=jGSt41a+LvihSr4b+PIr5+iMws6r9bCaQxADwwKP+nXDwmfaDtvR1WGdlskBNBte5I
 V/QoE/7Is41IquJaB6MdyTnz32ZPJYwdSra7fUCnIlgLq7FuYQ/KIngHqET1IfAro6Fb
 Mq0Z5EfBUKobAKDlTwIakhT7toLTNwlJWexDwRDsXYx1ttg9Mvlp+T9eNdxZVLTS3yFJ
 wTHqxBm8KnTJyZicjShJ3eT64w6UboAZyGeU58fUb3U20c1njB8qphv4TdH6TUdfaAxT
 JH9AcBM5fMnem4vDTVavT3uIyMyLq1rl/oZ0+Cyf5wbtv+P8SA2cCGO9TfUjBK81ppPP
 JTwA==
X-Gm-Message-State: AOAM531tYLI/QMx+npZWQUZo6wzRaarS0hFM8Ne9eZoUDtcPCVhBovDp
 uig7hJFsqXKo4UU6sOH9MLo=
X-Google-Smtp-Source: ABdhPJyNKVGySGYQXYESwLio+JBHRUiiv+W1PJATDZBCXkVF4SAD/2S+nwgoNe0TYl6jAeMA1Vv3lQ==
X-Received: by 2002:adf:9e48:: with SMTP id v8mr15677585wre.55.1604415216316; 
 Tue, 03 Nov 2020 06:53:36 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id v12sm27452269wro.72.2020.11.03.06.53.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 06:53:35 -0800 (PST)
Subject: Re: [PATCH V16 1/6] target/mips: Fix PageMask with variable page size
To: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1604053541-27822-1-git-send-email-chenhc@lemote.com>
 <1604053541-27822-2-git-send-email-chenhc@lemote.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7fdb67f6-edf6-4fe9-6e3b-f2817a3a06f3@amsat.org>
Date: Tue, 3 Nov 2020 15:53:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1604053541-27822-2-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/30/20 11:25 AM, Huacai Chen wrote:
> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> 
> Our current code assumed the target page size is always 4k
> when handling PageMask and VPN2, however, variable page size
> was just added to mips target and that's no longer true.
> 
> Fixes: ee3863b9d414 ("target/mips: Support variable page size")
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  target/mips/cp0_helper.c | 36 +++++++++++++++++++++++++++++-------
>  target/mips/cpu.h        |  1 +
>  2 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
> index 12143ac..d90ddd9 100644
> --- a/target/mips/cp0_helper.c
> +++ b/target/mips/cp0_helper.c
> @@ -892,13 +892,31 @@ void helper_mtc0_memorymapid(CPUMIPSState *env, target_ulong arg1)
>  
>  void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask)
>  {
> -    uint64_t mask = arg1 >> (TARGET_PAGE_BITS + 1);
> -    if (!(env->insn_flags & ISA_MIPS32R6) || (arg1 == ~0) ||
> -        (mask == 0x0000 || mask == 0x0003 || mask == 0x000F ||
> -         mask == 0x003F || mask == 0x00FF || mask == 0x03FF ||
> -         mask == 0x0FFF || mask == 0x3FFF || mask == 0xFFFF)) {
> -        env->CP0_PageMask = arg1 & (0x1FFFFFFF & (TARGET_PAGE_MASK << 1));
> +    unsigned long mask;
> +    int maskbits;
> +
> +    if (env->insn_flags & ISA_MIPS32R6) {
> +        return;
> +    }
> +    /* Don't care MASKX as we don't support 1KB page */
> +    mask = extract32((uint32_t)arg1, CP0PM_MASK, 16);
> +    maskbits = find_first_zero_bit(&mask, 32);
> +
> +    /* Ensure no more set bit after first zero */
> +    if (mask >> maskbits) {
> +        goto invalid;
> +    }
> +    /* We don't support VTLB entry smaller than target page */
> +    if ((maskbits + 12) < TARGET_PAGE_BITS) {
> +        goto invalid;
>      }
> +    env->CP0_PageMask = mask << CP0PM_MASK;
> +
> +    return;
> +
> +invalid:
> +    /* When invalid, set to default target page size. */
> +    env->CP0_PageMask = (~TARGET_PAGE_MASK >> 12) << CP0PM_MASK;
>  }

I was going to queue this patch for 5.2-rc1, but it fails all
I6400 tests...

  Linux version 4.7.0-rc1-dirty (root@2e66df87a9ff) (gcc version 6.3.0
20170516 (Debian 6.3.0-18) ) #1 SMP Sat Feb 1 18:38:13 UTC 2020
  GCRs appear to have been moved (expected them at 0x1fbf8000)!
  earlycon: uart8250 at I/O port 0x3f8 (options '38400n8')
  bootconsole [uart8250] enabled
  MIPS CPS SMP unable to proceed without a CM
  CPU0 revision is: 0001a900 (MIPS I6400)
  FPU revision is: 20f30300
  MSA revision is: 00000300
  MIPS: machine is mti,malta
  Software DMA cache coherency enabled
  Determined physical RAM map:
  memory: 0000000008000000 @ 0000000000000000 (usable)
  Zone ranges:
  DMA      [mem 0x0000000000000000-0x0000000000ffffff]
  DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
  Normal   empty
  Movable zone start for each node
  Early memory node ranges
  node   0: [mem 0x0000000000000000-0x0000000007ffffff]
  Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
  Primary instruction cache 64kB, VIPT, 4-way, linesize 64 bytes.
  Primary data cache 64kB, 4-way, VIPT, no aliases, linesize 64 bytes
  percpu: Embedded 5 pages/cpu @980000000107c000 s29664 r8192 d44064 u81920
  Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8163
  Kernel command line: clocksource=GIC console=tty0 console=ttyS0
  PID hash table entries: 512 (order: -2, 4096 bytes)
  Dentry cache hash table entries: 16384 (order: 3, 131072 bytes)
  Inode-cache hash table entries: 8192 (order: 2, 65536 bytes)
  Kernel panic - not syncing: MMU doesn't support PAGE_SIZE=0x4000

