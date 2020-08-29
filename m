Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B1DC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 20:25:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05992076D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 20:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W2gYq2Bj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05992076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC7PN-0002bC-RH
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 16:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC7ON-0001GG-J0
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 16:24:03 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:43041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC7OL-00088I-2g
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 16:24:03 -0400
Received: by mail-pg1-x536.google.com with SMTP id d19so2132327pgl.10
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 13:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0B65qnkHdehDe3WaVfdLTw1Sw4msC7n+KjZA/enc+qw=;
 b=W2gYq2BjNJEAOaG0UZSUZnz+kRhGbWUhQDpRl4C5aiU/NmyhVjSIEHUNoNwYZ45Ojs
 7QTLjfJ2TDZrNO9i2LmtyTxSyBuFTbwfxZ5GX2e4iyuwHQST2CNYX2/zA4NHcm7FP8Rz
 tvc6SR9ZTZQZ4CSSepNuzQY40qsO7xWoeYroRW3quNnOthLYH60FAY9jzLmJyKR/SnJ8
 QlINj4A1RWk7urqrKyX8+V0sOH8w6OhdRUzXglX6PQwDLYbvco3DqCQOu80PwCRCADxV
 fdCGSRoIj3HUh2HUyOW86Jj/DYkAHqm3asIli3Ge00qQNUhHWIbDA9ZG5EgXE1YrK1il
 Enmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0B65qnkHdehDe3WaVfdLTw1Sw4msC7n+KjZA/enc+qw=;
 b=KxxMyEpoMibe6QmiBax5S/DoPA3Hd6Ex7C1Vl6nJWRB0sDCb73Rj/9csTRMmuKPYTC
 LW/cQj9fgHW1SZEyikanqeUndFoCSo/rWZgg3VVz+6sMB8lorT4HHMo1ZcE2aXYcx89e
 KVWvOlqtX24R1aLLjtIcPz3/8KG901IRfhZFMDeMe5kTT3obXL4SR82Ucqff49IJHSze
 EjrU6WVM3TyE8B0fVKQ2QqpF6tbPG279F1+WliPXFPMfYUvneqiqONgqRbvBl7vehthH
 ba4w5FIRuk13i1+LBwprULFqYv7oqQJ82d4QBiV+RS2xReQw9lagxTZn6OzdiZ9KcoTS
 cByg==
X-Gm-Message-State: AOAM531duk/wuciSU7DtgW/NccsbYgl0bOTLYjfJOK+PxhlIRZXEjYkk
 Ss77X87y/vNH7JMYcm/kTwuSBQ==
X-Google-Smtp-Source: ABdhPJylT7Vt2RX7PEqS0BydORQ2fiGtd4KhtdSvBMxnYrPVoXD3zuALTjd/5FOxhIu24Gi4w+6dYQ==
X-Received: by 2002:a62:31c7:: with SMTP id x190mr4082947pfx.100.1598732639582; 
 Sat, 29 Aug 2020 13:23:59 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v6sm3224589pgf.55.2020.08.29.13.23.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 13:23:58 -0700 (PDT)
Subject: Re: [RFC v4 48/70] target/riscv: rvv-1.0: integer comparison
 instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-49-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <09a3b3ee-2ec5-d61d-64ee-68e16a7f2499@linaro.org>
Date: Sat, 29 Aug 2020 13:23:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-49-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 1:49 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> * Sign-extend vmselu.vi and vmsgtu.vi immediate values.
> * Remove "set tail elements to zeros" as tail elements can be unchanged
>   for either VTA to have undisturbed or agnostic setting.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/insn_trans/trans_rvv.inc.c | 4 ++--
>  target/riscv/vector_helper.c            | 8 --------
>  2 files changed, 2 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

