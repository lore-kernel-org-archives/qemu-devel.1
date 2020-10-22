Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0CEC388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:54:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136D622275
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbqhs0fv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136D622275
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVb2Y-0001kY-P7
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 09:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVb12-0008Qw-CI; Thu, 22 Oct 2020 09:52:28 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVb10-00078B-E4; Thu, 22 Oct 2020 09:52:27 -0400
Received: by mail-wr1-x443.google.com with SMTP id g12so2524254wrp.10;
 Thu, 22 Oct 2020 06:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Flyhmf/QdxgNE8A1Ie89A3W4LOBnGXKziXmqRHYv31U=;
 b=cbqhs0fv91Epni/S0e9mgRnCDETuM0flnd4oNKyZZPdsIK6Px+BgAf6Z90pZ1Cmi0T
 Oi1ec+PZMPbxSqGuxnVrWHXVrdiPhu2iGQKFIGTUhEB7FgmXDZfzkZTnKDR0AApFpQAR
 s+8W1HrHKCZxMBNqk0shflPnbB3+EshfDcIpETLuBJWaXU/hhOmnVRGGvn3ylt4ZOuJU
 k7hYLLN63riFo94fAdUX7joqHGOApx9edz7e04Ph39ZrS4CjiBzQxtedffOQkrf/7lHk
 kpIYWMSTKfCg5bypOrUC42sVr/M/96u0Cjis21cuyfhdp1VeB4Eg1d8/0IKiDCdJ/S68
 NiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Flyhmf/QdxgNE8A1Ie89A3W4LOBnGXKziXmqRHYv31U=;
 b=thQ0XjVVVrGjxTgnHoUZXq+BjWO03Qgk35gXckYOxHeOSacy2KEqsljdGOhtmdOD5F
 CwQPBbkYbqonxapOqPTB9bqomSDWrVjgEvGBADui1s3lHMbGW+//E9hNGG897Oi9w2uH
 uung2h/vjOB04IuexrgMAizS2KjYeY07qn1b7u6WphyUJxxr1fUktkLdDT8OdfL7j6Bu
 M/MfG+2427nMYoyEkAboDk6+EbuFVVXNLayts9HSG/HZVuCbzB8ToFdvJRJ8k2UHt4PE
 /W4CU5AOMjdWeG9NNgjHeq7yGUmz3ioRElD1lEOSpslXIqTs545XeTvDRM9ZVN3mHsGQ
 toiA==
X-Gm-Message-State: AOAM533MSomI90BGtMr/EmtQou0FIwVjQmfh1uI6p+Y/F/EGjs/74xbb
 gl/RKxJ3gdEyylD0cu4WT5gMhFCFhos=
X-Google-Smtp-Source: ABdhPJzjVQ/b/yTKFd+P/XmkEGi53ceXPoQwjs5UOEupcwCYrbeOHNfZYqizwJEyqUzANFQ+BjUIYA==
X-Received: by 2002:adf:fa8a:: with SMTP id h10mr2818840wrr.336.1603374744050; 
 Thu, 22 Oct 2020 06:52:24 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id 32sm4165232wro.31.2020.10.22.06.52.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2020 06:52:23 -0700 (PDT)
Subject: Re: [PATCH] disas/capstone: Fix monitor disassembly of >32 bytes
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201022132445.25039-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b073898a-4be2-3b06-96d6-7551a9d1a6f3@amsat.org>
Date: Thu, 22 Oct 2020 15:52:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201022132445.25039-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/20 3:24 PM, Peter Maydell wrote:
> If we're using the capstone disassembler, disassembly of a run of
> instructions more than 32 bytes long disassembles the wrong data for
> instructions beyond the 32 byte mark:
> 
> (qemu) xp /16x 0x100
> 0000000000000100: 0x00000005 0x54410001 0x00000001 0x00001000
> 0000000000000110: 0x00000000 0x00000004 0x54410002 0x3c000000
> 0000000000000120: 0x00000000 0x00000004 0x54410009 0x74736574
> 0000000000000130: 0x00000000 0x00000000 0x00000000 0x00000000
> (qemu) xp /16i 0x100
> 0x00000100: 00000005 andeq r0, r0, r5
> 0x00000104: 54410001 strbpl r0, [r1], #-1
> 0x00000108: 00000001 andeq r0, r0, r1
> 0x0000010c: 00001000 andeq r1, r0, r0
> 0x00000110: 00000000 andeq r0, r0, r0
> 0x00000114: 00000004 andeq r0, r0, r4
> 0x00000118: 54410002 strbpl r0, [r1], #-2
> 0x0000011c: 3c000000 .byte 0x00, 0x00, 0x00, 0x3c
> 0x00000120: 54410001 strbpl r0, [r1], #-1
> 0x00000124: 00000001 andeq r0, r0, r1
> 0x00000128: 00001000 andeq r1, r0, r0
> 0x0000012c: 00000000 andeq r0, r0, r0
> 0x00000130: 00000004 andeq r0, r0, r4
> 0x00000134: 54410002 strbpl r0, [r1], #-2
> 0x00000138: 3c000000 .byte 0x00, 0x00, 0x00, 0x3c
> 0x0000013c: 00000000 andeq r0, r0, r0
> 
> Here the disassembly of 0x120..0x13f is using the data that is in
> 0x104..0x123.
> 
> This is caused by passing the wrong value to the read_memory_func().
> The intention is that at this point in the loop the 'cap_buf' buffer
> already contains 'csize' bytes of data for the instruction at guest
> addr 'pc', and we want to read in an extra 'tsize' bytes.  Those
> extra bytes are therefore at 'pc + csize', not 'pc'.  On the first
> time through the loop 'csize' happens to be zero, so the initial read
> of 32 bytes into cap_buf is correct and as long as the disassembly
> never needs to read more data we return the correct information.
> 
> Use the correct guest address in the call to read_memory_func().
> 
> Cc: qemu-stable@nongnu.org
> Fixes: https://bugs.launchpad.net/qemu/+bug/1900779
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Note for qemu-stable: in 5.1 this function was in disas.c so the
> patch won't literally apply to it, but the same change in that
> file should be correct.
> ---
>   disas/capstone.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/disas/capstone.c b/disas/capstone.c
> index 0a9ef9c8927..7462c0e3053 100644
> --- a/disas/capstone.c
> +++ b/disas/capstone.c
> @@ -286,7 +286,7 @@ bool cap_disas_monitor(disassemble_info *info, uint64_t pc, int count)
>   
>           /* Make certain that we can make progress.  */
>           assert(tsize != 0);
> -        info->read_memory_func(pc, cap_buf + csize, tsize, info);
> +        info->read_memory_func(pc + csize, cap_buf + csize, tsize, info);
>           csize += tsize;
>   
>           if (cs_disasm_iter(handle, &cbuf, &csize, &pc, insn)) {
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


