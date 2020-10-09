Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E19C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFBE4221FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KveGJrsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFBE4221FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQthM-0008W4-23
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 10:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQtg2-0007Ze-Q4
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 10:47:22 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39531)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQtfx-0000Ri-Hk
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 10:47:20 -0400
Received: by mail-wr1-x441.google.com with SMTP id y12so5215424wrp.6
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 07:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hmnSzgCxOYplz49V09b2rB+1Y5/XK5reFSxCJhsq/+s=;
 b=KveGJrsVDSFHS3fR4r52mUza9wajxAKoYTXKhgmiy6u1yio+C4mOuIGDRgCXFVPQ9+
 6KK8ArAe4Ks9bezqLytn4jPClF/oiNnjnVfi/2VuvXi+0aN+Yy1wn43NYzFpEBYIYRkM
 LDqacrwiyKmxHcJIlwywGAZZWj5Vylm68WfE9bP/PqQqqW/Ua+M5CYmKayvpG9CsTdg4
 R1okmTNpaASG7/wdh3cb5Zowvh9zNXV/IC4exLiIlBi6hzm44nRa4IF/NQp8cRK7gfCf
 VkxMeSchqs1JtwpyUHtLg62Qd+oyPOhB6ZX9qHMjLO2GqC1qG3FZa6LODvNk2lnTyyuc
 Flmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hmnSzgCxOYplz49V09b2rB+1Y5/XK5reFSxCJhsq/+s=;
 b=BUaMCBHU/0kuGB/Z9drRKAyEsvbx6+31NwD77MB9lMcq8cdQb+uMTBouRXxDPddWx+
 h5uKjaZJonbc5GUBJnnY4u6aa47N8vkqIU1GqVFNl30TY1JZe+SiGRJBQppi5LycPDcQ
 ZKgsJ5VqMnoKoAQiZzgQwNwpRMjJ0ajpnDzdwCKZRTDHn04m2Tk52hD2EHWs2DU/+RdB
 PLCj6rUFpNiaYQtxtIWdpzI7HdWXqzyVz/rwiN8MZnyiY+QrgJQEmhJJIxZLqgwEL/Bs
 DGs8hhkI5k8nPrqyGn1FQpBKJsTTxnzgH/x3yAo3C1V9tq9NsZXN2DrITIid/DCXevI6
 XgDQ==
X-Gm-Message-State: AOAM531b5pW3PaZRlA+aFRVEDh4iMVx5VqbJuoMYvQzJq26qaDqqY48S
 HzD3J2KyEFSYsRLvRSErFOs=
X-Google-Smtp-Source: ABdhPJyOhme5qUfZevS8RC9F18U/FPgBqIYRoIDGKeosFcVMtglGCAA54ZKrJMb8jJniDtWRjFN2jQ==
X-Received: by 2002:a05:6000:6:: with SMTP id h6mr6683622wrx.112.1602254836234; 
 Fri, 09 Oct 2020 07:47:16 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j101sm13294001wrj.9.2020.10.09.07.47.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 07:47:15 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] target/mips: Refactor helpers for fp comparison
 instructions
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org
References: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <1602103041-32017-5-git-send-email-aleksandar.qemu.devel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7da26134-7e26-457a-c48e-877e66309793@amsat.org>
Date: Fri, 9 Oct 2020 16:47:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1602103041-32017-5-git-send-email-aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.208,
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
Cc: peter.maydell@linaro.org, aleksandar.rikalo@syrmia.com,
 hpoussin@reactos.org, chenhc@lemote.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 10/7/20 10:37 PM, Aleksandar Markovic wrote:
> This change causes slighlty better performance of emulation of fp
> comparison instructions via better compiler optimization of refactored
> code. The functionality is otherwise unchanged.
> 
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---
>   target/mips/fpu_helper.c | 56 +++++++++++++++++++++++++++---------------------
>   1 file changed, 32 insertions(+), 24 deletions(-)
> 
[...]

>   /*
> @@ -2080,12 +2088,12 @@ uint64_t helper_r6_cmp_d_ ## op(CPUMIPSState *env, uint64_t fdt0,   \
>   {                                                                   \
>       uint64_t c;                                                     \
>       c = cond;                                                       \
> -    update_fcr31(env, GETPC());                                     \
>       if (c) {                                                        \
>           return -1;                                                  \
>       } else {                                                        \
>           return 0;                                                   \
>       }                                                               \
> +    update_fcr31(env, GETPC());                                     \

Isn't it now never called (dead code)?

>   }
>   
>   /*
> @@ -2175,12 +2183,12 @@ uint32_t helper_r6_cmp_s_ ## op(CPUMIPSState *env, uint32_t fst0,   \
>   {                                                                   \
>       uint64_t c;                                                     \
>       c = cond;                                                       \
> -    update_fcr31(env, GETPC());                                     \
>       if (c) {                                                        \
>           return -1;                                                  \
>       } else {                                                        \
>           return 0;                                                   \
>       }                                                               \
> +    update_fcr31(env, GETPC());                                     \

Ditto.

>   }
>   
>   /*
> 

