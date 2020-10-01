Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF03C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D1D21707
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c5D7Pe18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D1D21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2qr-00010J-5l
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO2NZ-0008BE-QP
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:28:29 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:41070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO2NX-0004dr-Tu
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:28:29 -0400
Received: by mail-oi1-x231.google.com with SMTP id x69so6427785oia.8
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Vy+r5hxGZwwtLf/uYAutZcZKgInNFibT2LV9eyEsjqY=;
 b=c5D7Pe18TRQs347pr/QyD9gnkgvRfLQRxtC8riJLlR0PupE6ix1E4H8kY3E5gIqQea
 hv9H1eerUq1/vM2EnHtXyNHIlAuAi+UjL11tnYfalYntzODAn84MIHzUZEC0XRDtq1U7
 YUw0Pqd6ASHWSzqT9JS3+e9G9D/cUnQZ4/XeMBKo/5c0xPXDw63bTyzFmHqQJNAk/d2l
 GQoAoQGhvOdO6x9R1JuxbS+6HMLPsRkGLsDYpOhSuo7xaENuj+sh7sNofFZOkmVaY4l3
 n3JidHG2Q1+X6cs2++MHvIDvTq1m6vD0TCloSi8GmLyN9fsiDRM8FwjXHxPWf08ZwJM6
 Z2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vy+r5hxGZwwtLf/uYAutZcZKgInNFibT2LV9eyEsjqY=;
 b=R7md7mf9clNE1p5L17HBVvdMvrZFUj5PYakr5zIsEe6E316tk1eWPZ+RKvi21uOke/
 8sDikTMgKuWMx1qMx90q6kEBQtbZYQeKoJsCUx0NqnMdLrIQdlNPhdhi7WGYw8ZKbhGl
 I3/BG9XfM5coGA7vLRog6EXEW2SgJipCkoK3OxC+KtEhuEUnOkYoRhpFHvixBrm/3lxc
 U+2JPJNiRyn880sURe6BXDa10BvHQcN9vV2r2fSQs9YwlTbh4ZxI+bhgsbRKRKTJWIqb
 03SLJa2vGqs2lMGbaKB7M57dAlgizBFsF7NNal2lPFRQf0h87CYR9f1lITjF7hX2GkkH
 fDJw==
X-Gm-Message-State: AOAM531M4hY1HCRag1Npg6v88lw/xXZgMc2m7t0h7vF+p2JLY75tl2Ig
 /unY1h6/3d3HfVhpLCmq/l3lhw==
X-Google-Smtp-Source: ABdhPJxF4JwGl/3dWlZ49sFLkxDWP2tluvSCWg/3efw6j4Wj8ekwzpT2P4qYz8APyYH4UMbR56O9YQ==
X-Received: by 2002:a05:6808:9bc:: with SMTP id
 e28mr647059oig.71.1601573306020; 
 Thu, 01 Oct 2020 10:28:26 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id j24sm1344049otn.64.2020.10.01.10.28.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 10:28:25 -0700 (PDT)
Subject: Re: [PATCH 3/5] target/riscv: Add H extention state description
To: Yifei Jiang <jiangyifei@huawei.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20200929020337.1559-1-jiangyifei@huawei.com>
 <20200929020337.1559-4-jiangyifei@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2e725e26-3952-dbd2-c4aa-d9e933406220@linaro.org>
Date: Thu, 1 Oct 2020 12:28:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929020337.1559-4-jiangyifei@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.26,
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
Cc: zhang.zhanghailiang@huawei.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, victor.zhangxiaofeng@huawei.com,
 Alistair.Francis@wdc.com, yinyipeng1@huawei.com, palmer@dabbelt.com,
 wu.wubin@huawei.com, dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/28/20 9:03 PM, Yifei Jiang wrote:
> +        VMSTATE_UINTTL(env.vsstatus, RISCVCPU),
> +        VMSTATE_UINTTL(env.vstvec, RISCVCPU),
> +        VMSTATE_UINTTL(env.vsscratch, RISCVCPU),
> +        VMSTATE_UINTTL(env.vsepc, RISCVCPU),
> +        VMSTATE_UINTTL(env.vscause, RISCVCPU),
> +        VMSTATE_UINTTL(env.vstval, RISCVCPU),
> +        VMSTATE_UINTTL(env.vsatp, RISCVCPU),

So... if I understand things correctly, this is synthetic state, internal to
QEMU.  It is generally better to only serialize architectural state, so that if
qemu internals are rearranged, it is easy to decide on the correct sequence of
operations.

It seems like this should be re-generated with a post_load hook, calling some
of the code currently in riscv_cpu_swap_hypervisor_regs().  Note that some
minor rearrangement would be needed to call that code from this new context.


r~

