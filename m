Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AA7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9A121744
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hW11kHc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9A121744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Yst-0005MY-Qb
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 13:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1Yrr-0004j8-7l
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:30:51 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:45042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1Yro-0008Av-OK
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:30:50 -0400
Received: by mail-pg1-x531.google.com with SMTP id j19so16375513pgm.11
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WNZ0jVmsgiE0w8UeoHmpnAwLATROJgr1I69IRXhLDMM=;
 b=hW11kHc/rcOBR4aW0LrlQY9nKvO9ploB8n2V95PVOghD8cEGV9JvrA8vrXKOlBsRqJ
 Ml6za6Qk4YpWtsTG1uxcRH3anCrIapKz6+IbDefDoPNYVtksNGMiDbV15vrfqu3IC7dl
 ePRMTeWvZ8TPbLhhYkG+lnTTE9eTbIFBCDHozNhcv2Lp8YXeIqm0qjy6JflqEVAMdeme
 v04lyq2BBparMGY+UqKXs+kybTmsPzXgzmYWdOgaMTJySf8JlgvfjGLlA1qcADIpordl
 PqWeJDac9smM6xaBsQJhHgykr4VVhkUWrYrylPGzj+VpGg36wjx+h8tDHalPrMDLZ5at
 f5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WNZ0jVmsgiE0w8UeoHmpnAwLATROJgr1I69IRXhLDMM=;
 b=Gj3mJled0CSzUIoi+23DEUuubpZ9yyS8KCLHyfDu3Guqv1ufuC1AFlJVgdiwcplcmA
 Vzr5TC4b87Pchg7jHnc7n1sqVVaNRcmd8ec8ctxJ3g6pJLj3IiwRwKqltxHwOF/BVCca
 IP6Y4Ax0BMyLR3xbnapRTr3nEycmOLVh/Dfgmvg4pX6UHnSICfnriPszkuzzyGNntSuc
 sbeWG8vZhPmw1dwnjgjMmSyemQzpH/PHv6x6tD8sbgWkZyVMfTuLtc826+DLc94i/eSN
 te6t4PfrTeiCsmf8Lzt23T33hGmm/9hgX6fDMHTj9sAnJdWFAiqQongbhtcMeEdPxRfE
 RVeg==
X-Gm-Message-State: AOAM532s838Qb3+7HamhqzALdSswZpdE1OBntakEe1KwnmHciZcgoHNJ
 +zkTz29lZyvdVgJRBLpz7u7xdw==
X-Google-Smtp-Source: ABdhPJxcJNZPdh5W7MuE70WBa7wRoDFMALmRXCq3C6mmwx9lWVVBCZXJ7ue2FBPV4Id1qqqwzeJZ/w==
X-Received: by 2002:aa7:9404:: with SMTP id x4mr4651500pfo.46.1596216646863;
 Fri, 31 Jul 2020 10:30:46 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id z25sm11051807pfg.150.2020.07.31.10.30.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2020 10:30:46 -0700 (PDT)
Subject: Re: [RFC v2 43/76] target/riscv: rvv-0.9: integer extension
 instructions
To: Frank Chang <frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-44-frank.chang@sifive.com>
 <0b042afa-61e4-d6a4-7fbd-2c359026b8aa@linaro.org>
 <CAE_xrPhOJ3nUJJ_9o2m8EcJsBbpdEUz78qEt71mtFoF8gKgtiA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ea51f7de-24c4-7e9e-0649-b4e74810c887@linaro.org>
Date: Fri, 31 Jul 2020 10:30:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAE_xrPhOJ3nUJJ_9o2m8EcJsBbpdEUz78qEt71mtFoF8gKgtiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/20 3:17 AM, Frank Chang wrote:
> On Fri, Jul 31, 2020 at 4:35 AM Richard Henderson <richard.henderson@linaro.org
>     I don't understand why there aren't more functions in this table.  As far as I
>     can see, the only NULLs should be at [*][0].
> 
> 
> As source EEW has to be 1/2, 1/4, 1/8 of SEW and the source EEW must be
> a supported width (Section 12.3).

Oh, duh, of course.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

