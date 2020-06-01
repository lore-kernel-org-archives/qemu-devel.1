Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D1FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 23:35:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 114382073B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 23:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XeMGKj7B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114382073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfty5-0000Qa-BR
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 19:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jftxL-00081j-8M
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 19:34:59 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jftxJ-0003wW-LE
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 19:34:58 -0400
Received: by mail-pf1-x443.google.com with SMTP id w68so3370330pfb.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 16:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SPELmbQOfJIxeMT9yjj8Ttxr0aEkF6JZGwDFAGf+QKo=;
 b=XeMGKj7BghBcp2AERgXZ3nTBeIoAIUH/QQeOWQNC1SpyJ1js2QYbZMbRSOUVUAt0j2
 ncfOpuATtAdTP94XpGcKXfdqMoTdPJsi9CRR9fGsJS8NL4hIycPoqMeHTRJwkCJb1Zx4
 qTobAVKXDsJVkVIa0rs0QP7WdEF+1We/S+eRQIVQrhP1cR2+K+gyzRvDFA73xoeeGgXl
 iTgkw5DkIVCBy8zLij67PnioIDXU2T4w1kxMyCiTDq66i2GWAKeGYCn5nyQXZu8vLT2p
 Ovw2B7DeBa0jZl6OU8E71U4mhttPCzWLF0KBArl4wt2PIgJ5xh4fsMTTeEp/PFZmfcgq
 ZTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SPELmbQOfJIxeMT9yjj8Ttxr0aEkF6JZGwDFAGf+QKo=;
 b=XzuAtFY6s9x4XWDmsS+f5u/3FTgSZRzUOCiidfLBvQ578TfrVk3bR33FuZTOnR2bva
 VnU6kjO0ptacbLrLCZWdF7rcPnUQS7T0s/CyxtlmjhrG2OOUXBW0mIGZzo16r/daKrCX
 AKNWYXX0o5m1uBhfnjbpOxcIFfn5SIL8oT+ty+Z1PpS1kYF3oYTSekYdVKm6hWWX/RL7
 gt93Tc96H1OkoEKeluSv3QIu/QqqE8nyQNShkS8EKmp9pzfGebomSO7Vm6uCqAgp4G+1
 0ao5YRsIH+X9bI5FyF+I7uYUgo37KwpE/gPkoqUVW+eKGxEmLHEPMPv/RZEfG746ucwd
 15Dw==
X-Gm-Message-State: AOAM532P/Qgr2NG7lA0YWPeHMm+/BGh76Votr+t9GTd9dn91riMEjdpO
 p8v3T48yEpzZT1nWwWzT73xmTw==
X-Google-Smtp-Source: ABdhPJy70MClJTNM3/F9rCQwlfST2nkGKHtgtJ3ON+z7WX0Mf7Rk+9MNvB5hr4p0gshkq+RehqkyPA==
X-Received: by 2002:a63:d54b:: with SMTP id v11mr8829615pgi.198.1591054495930; 
 Mon, 01 Jun 2020 16:34:55 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p8sm477466pgs.29.2020.06.01.16.34.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 16:34:54 -0700 (PDT)
Subject: Re: [PATCH v2 1/8] hw/arm/aspeed: Correct DRAM container region size
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200601142930.29408-1-f4bug@amsat.org>
 <20200601142930.29408-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0c840231-813a-20a4-62c0-a3d42c33914f@linaro.org>
Date: Mon, 1 Jun 2020 16:34:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200601142930.29408-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Helge Deller <deller@gmx.de>,
 Paul Durrant <paul@xen.org>, qemu-trivial@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/1/20 7:29 AM, Philippe Mathieu-Daudé wrote:
> memory_region_set_size() handle the 16 Exabytes limit by
> special-casing the UINT64_MAX value. This is not a problem
> for the 32-bit maximum, 4 GiB.
> By using the UINT32_MAX value, the aspeed-ram-container
> MemoryRegion ends up missing 1 byte:
> 
>  $ qemu-system-arm -M ast2600-evb -S -monitor stdio
>  (qemu) info mtree
> 
>   address-space: aspeed.fmc-ast2600-dma-dram
>     0000000080000000-000000017ffffffe (prio 0, i/o): aspeed-ram-container
>       0000000080000000-00000000bfffffff (prio 0, ram): ram
>       00000000c0000000-ffffffffffffffff (prio 0, i/o): max_ram
> 
> Fix by using the correct value. We now have:
> 
>   address-space: aspeed.fmc-ast2600-dma-dram
>     0000000080000000-000000017fffffff (prio 0, i/o): aspeed-ram-container
>       0000000080000000-00000000bfffffff (prio 0, ram): ram
>       00000000c0000000-ffffffffffffffff (prio 0, i/o): max_ram
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/arm/aspeed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


