Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7425C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8392D2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rNPZ2Bj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8392D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGWm-0000gV-Rl
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhGW6-0000Bt-9K
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:52:30 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37939)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhGW5-00071n-GO
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:52:30 -0400
Received: by mail-pg1-x541.google.com with SMTP id u5so5546174pgn.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4ZYegxnaM6zf0JrZfZnu4oUrk0aeAu78v2XzWIvM+rc=;
 b=rNPZ2Bj06JJMsVcCGwF7AhduzdzgElGLfqg9ChnAOR/QaPcq5Oj1JICtx5RK2Ljybb
 Ejjk0xakWM0FxfDAHnKIFhbK5kuixMcwby+teKjcWMGHsykSv6VFD7uF1ny4I2BZE3Jz
 8THk5keqG2o/ouF9FnOYr7e9w4r68O8wpLX5elBzPCp4YiMWvU+IXCFGeOhAcTKXo9mQ
 uQd7iSkoKL7Jo/SOFmD5mMRoyLgbsWyc8Qv+gMUW70WMV5B2hXPFIauFsPrIYIHFgK0w
 j5xwkUW1LH6WxPqAllxth47mDmpQweSwvcH33yzCQtlvO+mz710Z4Kc63mK8KiEtZ91T
 V0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4ZYegxnaM6zf0JrZfZnu4oUrk0aeAu78v2XzWIvM+rc=;
 b=Cs6QIfBxABL5fCW6KumD21dN5j6GcWlGc+z42twKcwVXXu7tlDtW124Gky/++WKpy0
 DbLpg060/T2ZN7E9ogcOfPfsK3iVYW+8fqfkiPAd3Bb6m5mnuDLtJxPGvwiQwWsw4jAb
 Lw9xRc1mGpyrvmYLU68e9izv8DucXW+PURiicDYd+hPr7CTgfLrxUZPlZXHfFXqPS8vZ
 Mfa3kxIuj0pcD7InyeEwOPe7TQ0t/m4Ku7gvulnvGMS0adLyVzXPHSgtgS83GWPWURX/
 g9IoDLBhrhMRG3gL4UW/Vi64FNuxKA2l7GSkTWyWbGiv+JRI8DhjysajSL4ElmIYaKE0
 337A==
X-Gm-Message-State: AOAM5316cOIdjfMLPXmOsfrHszSIP8kjmyR1UvDp7nJYJhijePqYKZHq
 x5XmAjfnXFN5Tg9sXULQcd/U0w==
X-Google-Smtp-Source: ABdhPJzQpr36b/eTpC+nkwZzNWBBYj9JOG9IF6OuqK4sZjS+mbnY0Ht8QNcExSbfifl6Y/D4dYPNRQ==
X-Received: by 2002:a65:4107:: with SMTP id w7mr10411397pgp.226.1591379548136; 
 Fri, 05 Jun 2020 10:52:28 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id u61sm9335307pjb.7.2020.06.05.10.52.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 10:52:27 -0700 (PDT)
Subject: Re: [PATCH v2 03/17] target/riscv: Move the hfence instructions to
 the rvh decode
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1591319882.git.alistair@alistair23.me>
 <6f88ddc816f7828e4b58acc82e3e4b61bd86e158.1591319882.git.alistair@alistair23.me>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <55e23f0e-cc7e-deb7-bc64-e8b31eeb1467@linaro.org>
Date: Fri, 5 Jun 2020 10:52:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <6f88ddc816f7828e4b58acc82e3e4b61bd86e158.1591319882.git.alistair@alistair23.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: palmer@dabbelt.com, anup.pate@wdc.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 6:20 PM, Alistair Francis wrote:
> Also correct the name of the VVMA instruction.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/insn32.decode                    |  8 ++-
>  .../riscv/insn_trans/trans_privileged.inc.c   | 38 -------------
>  target/riscv/insn_trans/trans_rvh.inc.c       | 57 +++++++++++++++++++
>  target/riscv/translate.c                      |  1 +
>  4 files changed, 63 insertions(+), 41 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_rvh.inc.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


