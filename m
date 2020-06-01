Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B2CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 23:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 407692073B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 23:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rz09eZ1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407692073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jftzK-0001wt-Ci
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 19:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfty6-0000cl-6T
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 19:35:46 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfty5-0004nr-9o
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 19:35:45 -0400
Received: by mail-pl1-x643.google.com with SMTP id y17so556357plb.8
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 16:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=X4I89W39vWdVNoghag0DFn1ebCW1eil3jLJKcfTKZ5M=;
 b=Rz09eZ1jDr2GqUZY/02LI/v+G4Mymsh044uItJIu+SnTWqBOlAr+pJ1tg3MAcjFFs1
 Wl6k+fmHMq6vXzx2AY0IPGk7NZeU4+E1Sdxl6Mw5AoL9jND4oWQZEQZD+r57AvzHYH/N
 NuhvsCmxF/i2/oBgKNFahnAkMkXFOc81T1dqP9gwS5GJh/0SPKNFan23YgZ6NQ73MEYJ
 qtizNevWe96Vk8MzhSZxh7Hzp13L2QEO5pK/Ckpe0BVTVtsiYNZzxunfsbyOeIti92AR
 Gv4QktnI7lS9pbKOOeJaYUI0JaAylDORYJBmQBzWNsCRniPV5I/JXtMFJ7Pws0xd4Q6l
 nS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X4I89W39vWdVNoghag0DFn1ebCW1eil3jLJKcfTKZ5M=;
 b=oI+Y5vNFPDnLZHLaA0cvgVpz3DeDMLEAXdgZDCAEw9YiqCbsXBkmyFGRWfRQDUgnzG
 rIc2FvzZ2nCyEiVAcHCflM/IYTcvUOO5D3l5Iok2Kl42roJtV+Cg3w68WzqbZiBtbGwZ
 UqbcJM2U7DIK/3CaYZOMTWa5ySqGQRrFZ/iBpPnSwHmSoJwvdxR+td9qh9TjTuwKwcMf
 wH/VvNeXdKws6Df0yutfrbZ6tkQ/SDbRpTMuaST633Dxoqp5qiYNjyaWnTqh2R50//D9
 G/Z0F48+kAwATYeByo/jFGEF1VU47hdcxJAFShIRHqPlOX1txFx3XotrXDsXihChvrVN
 1EfA==
X-Gm-Message-State: AOAM531aX7HYTUuf+kl1/fV7IXrDqPU1xrHQyxD/Np1J0pjk+gnpWwSv
 wW6bWsm/WHvCz3s2Gnn2H4f7tg==
X-Google-Smtp-Source: ABdhPJxfVrNnYPK0N8OZPuZkt0Nk1A1urRieu/jIbg1ZT2QBbNMgMrB6P433MN9FZD6oMK1YrM174A==
X-Received: by 2002:a17:902:7896:: with SMTP id
 q22mr23251618pll.216.1591054543738; 
 Mon, 01 Jun 2020 16:35:43 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id z1sm441635pfr.88.2020.06.01.16.35.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 16:35:43 -0700 (PDT)
Subject: Re: [PATCH v2 2/8] hw/pci-host/prep: Correct RAVEN bus bridge memory
 region size
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200601142930.29408-1-f4bug@amsat.org>
 <20200601142930.29408-3-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <92a1fda6-0ee9-e7f2-7248-b79c01c7b2e3@linaro.org>
Date: Mon, 1 Jun 2020 16:35:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200601142930.29408-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
> By using the UINT32_MAX value, the bm-raven MemoryRegion
> ends up missing 1 byte:
> 
>   $ qemu-system-ppc -M prep -S -monitor stdio -usb
>   memory-region: bm-raven
>     0000000000000000-00000000fffffffe (prio 0, i/o): bm-raven
>       0000000000000000-000000003effffff (prio 0, i/o): alias bm-pci-memory @pci-memory 0000000000000000-000000003effffff
>       0000000080000000-00000000ffffffff (prio 0, i/o): alias bm-system @system 0000000000000000-000000007fffffff
> 
> Fix by using the correct value. We now have:
> 
>   memory-region: bm-raven
>     0000000000000000-00000000ffffffff (prio 0, i/o): bm-raven
>       0000000000000000-000000003effffff (prio 0, i/o): alias bm-pci-memory @pci-memory 0000000000000000-000000003effffff
>       0000000080000000-00000000ffffffff (prio 0, i/o): alias bm-system @system 0000000000000000-000000007fffffff
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/pci-host/prep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


