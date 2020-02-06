Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ADAC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C1120730
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VM80vK22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C1120730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfE3-00017C-Tv
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izf6m-0005ga-49
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:14:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izf6k-0004oU-Jg
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:14:07 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55514)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izf6k-0004lV-D4
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:14:06 -0500
Received: by mail-wm1-x341.google.com with SMTP id q9so5853133wmj.5
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 03:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GRMeqKJwTVvqpZLaQ4kebxTaSrmiwzPkNnpWIv8IGp8=;
 b=VM80vK2212+bNJu9fuhYXPC94BVaT0OwUtwXHvUpaQ/R0myQfwOZ9bPfnVC7MwvdHj
 kG5BMv5N/wVC+rpimPgAEs1vS6zlgZ4oTLgeTKbllujjMwgCvq71s+zuIzqqclu6IHo+
 a62PHw1Nn3rsdw07yU+V+CPkfaThprpw9tQzee8u+sF0Fvr5VR885JNDCUEbyFZWJs0n
 0oLLNUclkhkGPMRTmrAjHsDPNYLC79w4f8UWGMXeRUq76lB14wvdRZ2At/KdZxhghIDy
 XbOBAsCOt8Gex87bYHZ1XVBmWi9VOqaM231UHxKp2H28NR3St24OOcuTpcMIkG3+QbjH
 WeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GRMeqKJwTVvqpZLaQ4kebxTaSrmiwzPkNnpWIv8IGp8=;
 b=FgCLHVJDlZrLr4k2QH85CvqO/eWdPzonYq4IpJgurDhjfANeDoY84aZLhpicVXQ//e
 Wvs4ORt23sQd4pmF7oCQYVF7fdhfCwL7/f4aYN3bKL7OUuvC6Rzt7jpKxQRPhaYtdEGc
 01SZxz5qEOPEahgxcVZEeK4F2Ud0Yrr1jyOWeW3CFpKNG6LLB2xbW0Tf4QHr0VEOk0+H
 FBPx0DXuGWHkJZy3t+Cp0xQlgHQA0h+vSxbg+AYHyNAJrwehUDAdndAj138xC7pdwxoA
 tEhrgKRC8nUjB4Tt/dV/fBN/XCEDBARDdCKaMprfa3IYkMDvY0ISytXP1piaEudPb/Ak
 xikw==
X-Gm-Message-State: APjAAAXJvxlj8dR0jP/zkv5yxJ8TfEXQzsQUvpTbd9lVf+qN2fHe3mdg
 leqw+UPTANEeYKCHy2wBBqsUBw==
X-Google-Smtp-Source: APXvYqwswUxV4r/eVmo1Gx9H2fNMADdL8OxSARI1GaXTiGfPzVVgOMmm3/7MgQf3vXlK3TCyNSdnHA==
X-Received: by 2002:a1c:bc08:: with SMTP id m8mr4172623wmf.189.1580987643611; 
 Thu, 06 Feb 2020 03:14:03 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id a26sm3461581wmm.18.2020.02.06.03.14.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 03:14:02 -0800 (PST)
Subject: Re: [PATCH v6 08/22] target/i386: use gdb_get_reg helpers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200205171031.22582-1-alex.bennee@linaro.org>
 <20200205171031.22582-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9c1e4644-9858-ccd2-f5e6-bb029bf2861f@linaro.org>
Date: Thu, 6 Feb 2020 11:14:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205171031.22582-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: damien.hedde@greensocs.com, luis.machado@linaro.org,
 Eduardo Habkost <ehabkost@redhat.com>, alan.hayward@arm.com,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 5:10 PM, Alex Bennée wrote:
> This is cleaner than poking memory directly and will make later
> clean-ups easier.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/i386/gdbstub.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
> index 572ead641ca..208b3de70da 100644
> --- a/target/i386/gdbstub.c
> +++ b/target/i386/gdbstub.c
> @@ -95,29 +95,26 @@ int x86_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
>              if (env->hflags & HF_CS64_MASK) {
>                  return gdb_get_reg64(mem_buf, env->regs[gpr_map[n]]);
>              } else if (n < CPU_NB_REGS32) {
> +
>                  return gdb_get_reg64(mem_buf,
>                                       env->regs[gpr_map[n]] & 0xffffffffUL);

Watch the stray spaces.

>      } else if (n >= IDX_FP_REGS && n < IDX_FP_REGS + 8) {
> -#ifdef USE_X86LDOUBLE
> -        /* FIXME: byteswap float values - after fixing fpregs layout. */
> -        memcpy(mem_buf, &env->fpregs[n - IDX_FP_REGS], 10);
> -#else
> -        memset(mem_buf, 0, 10);
> -#endif
> +        guint8 *data = (guint8 *) &env->fpregs[n - IDX_FP_REGS];
> +        memcpy(mem_buf, data, 10);
> +        /* byte swap? this is at least correct of x86-on-x86 */

Yes, byte swap.

typedef struct {
    uint64_t low;
    uint16_t high;
} floatx80;

Output little-endian low, followed by little-endian high.

> @@ -290,10 +287,7 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>              return 4;
>          }
>      } else if (n >= IDX_FP_REGS && n < IDX_FP_REGS + 8) {
> -#ifdef USE_X86LDOUBLE
> -        /* FIXME: byteswap float values - after fixing fpregs layout. */
>          memcpy(&env->fpregs[n - IDX_FP_REGS], mem_buf, 10);
> -#endif
>          return 10;

Similarly.


r~


