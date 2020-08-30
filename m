Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF8AC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 01:57:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB782075B
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 01:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uVAgYrUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB782075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCCbV-0005Cp-8u
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 21:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCCay-0004k9-OI
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 21:57:24 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:36196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCCaw-0007mt-Jk
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 21:57:24 -0400
Received: by mail-pf1-x42f.google.com with SMTP id m8so2656916pfh.3
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 18:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yyrx3sNY97qpxZofH/wQKp6HlhF94w1O2QAMnNFBt/M=;
 b=uVAgYrUJQuBGLM4Y0r5+z59/YWpkx/ECCma1rKaXN+JCtaMu0NjgEHaUfbgRVBV6Qz
 BTAKFGOcccJy8bE/R7yj9ef6lV0dshZsFyhmzgqDM7Kj+2gGo82hnswBEVTGWegJjl6R
 yDl7CrHBhJzothPJ1SCSbXPnpy0+AhH5X4gCyYkDdV+IE2VAtZMx4UbVr9ps57Sr62Wl
 njpgbJP7UVhm690CDuUY+9xRbvqdXCwLnhUHngYPZS/yai19LSJrAvRJzGzvWgf5GVKW
 AG2tk42Hpm5jaZfHx/sJHcDnG12DgnHJJ/U/ha9WrTsBckNpGyRLXr3BTN2Z+VyMhMt+
 wkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yyrx3sNY97qpxZofH/wQKp6HlhF94w1O2QAMnNFBt/M=;
 b=nMGFS5Z8AXvbjExKR1EnY0IO6ew6IWpBUv0OttNTUiQ0WXZhc4vKIf35KQRGd5CWcA
 hVq5jhg4m4rM+SlNTgue68AffKpPpeyoQ1Q2Rmvv3X7FAkoSNPaY7mkyHmxBDBTuIyg0
 a5jnHtkyJmQ6NTgCQN60EkOA7omEr+d6qm1ZtL8rUlH4B+nz5HIPBwfkQgZWDn+wa6bn
 m6Rt/uLcJ9QeIP/Yib4Gn6MSzoBZ34DfPQyc8OO9JYNk0/MpQ7PDYURSDZH9nSMv4YdI
 89TfKib1/fiZTstGOOph/ROq1P8nLrti6/ffJgKbdJ0JWKW1j34haNR9/SNubA0Hm5kJ
 1BqQ==
X-Gm-Message-State: AOAM531wWg7QIUJi2ncSLE7KrZC3arZjGBYPIyYubGinV3WS7F6aITL5
 nXjK+nGzfWqjlGBMpGQD+ctcyA==
X-Google-Smtp-Source: ABdhPJwmpyChF48T3ZB1TpNmSz1OCRiRr7L+cuDcZFzNli/wiI6Zlcj3CoHbSJ+L0/u7jQzP6XNv0g==
X-Received: by 2002:a63:5d0c:: with SMTP id r12mr3878098pgb.44.1598752640972; 
 Sat, 29 Aug 2020 18:57:20 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id r3sm1183807pfh.88.2020.08.29.18.57.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 18:57:20 -0700 (PDT)
Subject: Re: [RFC v4 69/70] target/riscv: gdb: support vector registers for
 rv64
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-70-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cc7f2642-4a9a-c494-43b9-5c99cb8c9bd8@linaro.org>
Date: Sat, 29 Aug 2020 18:57:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-70-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Hsiangkai Wang <kai.wang@sifive.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 1:49 AM, frank.chang@sifive.com wrote:
> +++ b/gdb-xml/riscv-64bit-csr.xml
> @@ -248,4 +248,11 @@
>    <reg name="mucounteren" bitsize="64"/>
>    <reg name="mscounteren" bitsize="64"/>
>    <reg name="mhcounteren" bitsize="64"/>
> +  <reg name="vstart" bitsize="64" group="vector"/>
> +  <reg name="vxsat" bitsize="64" group="vector"/>
> +  <reg name="vxrm" bitsize="64" group="vector"/>
> +  <reg name="vcsr" bitsize="64" group="vector"/>
> +  <reg name="vl" bitsize="64" group="vector"/>
> +  <reg name="vtype" bitsize="64" group="vector"/>
> +  <reg name="vlenb" bitsize="64" group="vector"/>

Just because these are csr's doesn't mean they're unrelated to RVV.  I would
think that ideally they would be in the (generated) RVV-related xml file.

But I'm certainly not a gdb expert.  So if that doesn't work, fine, leave it as is.

However, if you leave these in the csr section, I think the next patch has to
be folded in, because you've already included

>  #if defined(TARGET_RISCV32)
>      gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
> -                             241, "riscv-32bit-csr.xml", 0);
> +                             248, "riscv-32bit-csr.xml", 0);

... this.

That said, the actual dynamic xml looks fine.


r~

