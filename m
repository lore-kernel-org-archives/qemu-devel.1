Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89DACA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 18:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C5652084C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 18:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OS0CFCn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5652084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMcOk-0000PM-KU
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 14:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iMcNv-0008Rj-2D
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 14:26:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iMcNt-0002MS-TC
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 14:26:26 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43968)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iMcNt-0002MJ-Ly
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 14:26:25 -0400
Received: by mail-pf1-x442.google.com with SMTP id a2so8929000pfo.10
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 11:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zZigJmBw7mUhOyNzGXN0BOPfbDXw73KV/BmXtbbAR20=;
 b=OS0CFCn5JDzviAapXD5rYalQmhjYxgywJNk0w/vx0gvpRCZ8CVNryteVUqw5k/JyZu
 y87SIU/BshuBml/D4aUsWvFTVCtWiLnu6Hh7Ee6fMHNpMxPdVa1hkJ8ajpte5nYUjm1e
 INhEb03c64rbhVrrj+RlO+LdqCGoOHyxvQdqhl6rhbU4gj2w8cv/gtG4i+FwaIAvd8Zk
 dob1CJuF12eQveyIF/bks9B49mP0Gl1xa1Fbw6XDgFx8b1201WFRb+/HcxhUcwOna8WW
 6xOqf0wVCctHVpcYXIeQ3o40MnpdwtUXe3jsGww3nf2xFjzvEdZE7YrcRasRtXevR1+W
 Rmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zZigJmBw7mUhOyNzGXN0BOPfbDXw73KV/BmXtbbAR20=;
 b=WIx87DNJBVR2kNE7+6wTnoD0IS8VilaWMRLDo24VB7iYCL8PfW2JS4Yh7TIZdGFx5u
 e8c8NIjmnoITotFHahTcNOyd9avbRiGwJGrZyGeblMOjxxzBDTAJAgK7lvjeCdE/bTgL
 XmW9itEUYloty88QFeH8MBY9IFB5EW6faY2N4GcAo0e3t7f1sVODB60mhA4dXvoEfInE
 qSiIbAC2wAi+ki+tFVKBmvFWZoDqnwqNRwaJM6pCwZyZhr6zLpReoVPAsExS/HANV03H
 l+bRDvIiayZJ8ZK2k0hGvPcljE0a0R01nBpFDPQ6zyj4E/H/lEbrEpY4JVM2IwX+DjPL
 V51g==
X-Gm-Message-State: APjAAAVAu0Y3GLybBqdTVrudXJK8kF8XkVzO9KSYLMw/T2ik9tri48ny
 qB2x+7hML+yYP9dqChAAzYUvGTt0gMs=
X-Google-Smtp-Source: APXvYqw9kSYyeQiobi978TdRTxueYPNijZ+TwIXXXgUV53qcTYHjWJyo4ftAByRXbFtsYd1KIgbByw==
X-Received: by 2002:a17:90a:ba86:: with SMTP id
 t6mr31673484pjr.56.1571682383501; 
 Mon, 21 Oct 2019 11:26:23 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w65sm18048638pfb.106.2019.10.21.11.26.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Oct 2019 11:26:22 -0700 (PDT)
Subject: Re: [PATCH 1/7] hw/hppa/dino.c: Improve emulation of Dino PCI chip
To: Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
References: <20191020204724.31537-1-svens@stackframe.org>
 <20191020204724.31537-2-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <96d555a9-554e-529d-1f0f-84f858dbc55a@linaro.org>
Date: Mon, 21 Oct 2019 11:26:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191020204724.31537-2-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/19 1:47 PM, Sven Schnelle wrote:
>  #define DINO_PCI_HOST_BRIDGE(obj) \
>      OBJECT_CHECK(DinoState, (obj), TYPE_DINO_PCI_HOST_BRIDGE)
>  
> +#define DINO800_REGS ((DINO_TLTIM - DINO_GMASK) / 4)
> +static uint8_t reg800_keep_bits[DINO800_REGS]
> +        = { 1, 7, 7, 8, 7, 9, 32, 8, 30, 25, 22, 9 };

(1) const.
(2) better as a mask:

static const uint32_t reg800_keep_mask[DINO800_REGS] = {
    MAKE_64BIT_MASK(0, 1),
    MAKE_64BIT_MASK(0, 7),
    ...
};

since that's the only way this is actually used.


r~

