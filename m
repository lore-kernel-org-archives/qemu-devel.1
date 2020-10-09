Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D24BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:16:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A98512222C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WmWQOV6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98512222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQtBj-0005UN-8F
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 10:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQtAc-0004in-9w
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 10:14:54 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQtAZ-0004mu-Jl
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 10:14:53 -0400
Received: by mail-oi1-x244.google.com with SMTP id z26so10289143oih.12
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 07:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=i9LyY563dyk+VeLh1PfeD2P5rMx+jlsmbVOzgw8XLXQ=;
 b=WmWQOV6HQIPssuDu6kG8N9u+QqS+fh4rOFtIXJhi7ZVC+wosGNBv9MlKhl3CLkYs/7
 kmSlg74nwBDsVq6jTQa61fULGfgrDxXU72KCv/ijpGAMM2p5E7KXJMXonzCE1Ry/r9Lu
 kEavOZrgq3ilnTxGohw3q10Ta+e9HsZr1nvbpFwj3qozYzUUlJ1GmYdtL55DGGXQAODc
 QT5v5Do+kL3HnIubP04UDI3wtPG/IXRafCeUUoSw/RgPr9X1U0Jxnyh5Un8w8OrM0Dcx
 o+/hrMB3b1rONcDNQ30XGXw/slgeCEhUo6PAzjuwP12g8jeeHnwDX2K2QcqCEkgnrBvA
 aMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i9LyY563dyk+VeLh1PfeD2P5rMx+jlsmbVOzgw8XLXQ=;
 b=em+GiyI0tci+3E30QtaW1m8lUM3CLFkQwecLQbZqKoRQhiZkpvAg7kDphvEh6DORih
 AQrHr3CNKn+TYNeBl/q8fGXOX0++pJswzOs/Ofywf4S7VrCDYdVf3hgcJzvskpubb7En
 elKiY+Ft+F+ACmNFRix1zxW0DIDK7ekKulI0Q8bCyeRvqKVc9rovbvrFQONZh1gnjfY2
 r5mxl5K8h5cIF+PyqNijxvn8J+uRkusOR8pxBuh9S/SRq4+hiZeQjEY8OCebILkYl1FH
 SH5MNVQypCH7WKZ0bC1S5082PvfTsdUnaC93YcTCeDTfeqKtdIBWYtAZ64hdUQ5FnHRT
 Jyjw==
X-Gm-Message-State: AOAM531eWbZooiLB5fOWSw4/5oYuw8gVrUHZZEG1XtPpnlfVl2VYTrYm
 G7gzv7H72YSjYw85RG+dWG/FdA==
X-Google-Smtp-Source: ABdhPJx34/qvIo8/NbsjYltNsmH3l536bzjxEDMnyzAT/O5l7EE4B13P+SvXQxaWqDgMMSUUTTjGYQ==
X-Received: by 2002:a05:6808:3bc:: with SMTP id
 n28mr903550oie.171.1602252890179; 
 Fri, 09 Oct 2020 07:14:50 -0700 (PDT)
Received: from [172.24.51.127] (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id a82sm7432220oii.44.2020.10.09.07.14.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 07:14:49 -0700 (PDT)
Subject: Re: [PATCH] hw/net: move allocation to the heap due to very large
 stack frame
To: Elena Afanasova <eafanasova@gmail.com>, david@gibson.dropbear.id.au,
 jasowang@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <8f07132478469b35fb50a4706691e2b56b10a67b.camel@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f5c2c746-e648-a2b6-e09c-069423c752cb@linaro.org>
Date: Fri, 9 Oct 2020 09:14:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8f07132478469b35fb50a4706691e2b56b10a67b.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.208,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 9:02 AM, Elena Afanasova wrote:
> From 09905773a00e417d3a37c12350d9e55466fdce8a Mon Sep 17 00:00:00 2001
> From: Elena Afanasova <eafanasova@gmail.com>
> Date: Fri, 9 Oct 2020 06:41:36 -0700
> Subject: [PATCH] hw/net: move allocation to the heap due to very large stack
>  frame
> 
> Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
> ---
>  hw/net/spapr_llan.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

