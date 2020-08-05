Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1326EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 16:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F6722CF7
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 16:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sv/nT8Ut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F6722CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Mcb-0008Ou-5D
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 12:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3Mb8-000739-Ri
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 12:49:02 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029]:40522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3Mb7-0004MQ-0t
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 12:49:02 -0400
Received: by mail-pj1-x1029.google.com with SMTP id d4so4589088pjx.5
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 09:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2jkOLs2Fczrz+WeSwz9LcNBM209XPoRACV7oi+7U/TU=;
 b=Sv/nT8UtC1YzA1aHmoS35NwUydAHOa9cqhv9e32WO1wH3BBk9/zuGKExOfcc0tPGyv
 GhoT6I/xyle1TM74gqr69wkVIDLVcWPXcGdo6uRkYnVYxto++8mRS2TUIpqrzYRwdPYa
 AkWtXoc+nVIqpSh2smcAYnK3KBu+Oxd/ZZDVrTlX6Vq8snJIo6viBvXGF0kn7pC2R4Yu
 /WC7VcCcAuzNkwBPp+bS4XAvcqdMW9A9GgrF4Z54YMLhZsht7bOUQfIJGJb+jhl/0Kvc
 htDnJ51gSnmXk5ri1qUd89Up1Gg/sifr4iQwugZJosxkkAQXUnpZVIvtpTAWPH+/ybCl
 rRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2jkOLs2Fczrz+WeSwz9LcNBM209XPoRACV7oi+7U/TU=;
 b=CfYaB5Cp6hswz/Gygd0yd2SmzJzBAi/BcbeictjClJSvuYlJnNjCVGaTnu0yZtnlws
 7vbtFhchUKimhKP/utI9btwMKd7R8+BBw1ULPWHE1x7EVKPQY9VGmXXnzz2mwoN3h/0W
 HpUAXLrb2nIHh19y8IpFJe9zJ5GRGzf2CZx5XrAmzdlvxYyiYeB5n7p8CKbikX1FgWbt
 vD3vsXOvIolLLmQ/HqhJmI2u3ZBC3vo3XEljF4MW8vwWxKnhR/uih9DK5Lwpc140qoKn
 u5zaC3ACJJ6p0RrBYLyN3rqqLD8QSAZRUbq7p4ncNP6QQoupIhqJasxYQJZRUPH7dJID
 jHqg==
X-Gm-Message-State: AOAM533xpwuNOEMn4UFbVQpdMWjhchINNhcpiL5t2LLE1O4l84e522PR
 Ko6kcpT7KgO0s02rfaursCEAPQ==
X-Google-Smtp-Source: ABdhPJwtnjFlbSNWyTmA2pscs9aUd5J286fWFCMlgTRyFurNZt6JibGWZXv5IyfyKfK1Vm6Wo65Xrw==
X-Received: by 2002:a17:90b:94c:: with SMTP id
 dw12mr4175111pjb.214.1596646139414; 
 Wed, 05 Aug 2020 09:48:59 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q73sm3845350pjc.11.2020.08.05.09.48.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 09:48:58 -0700 (PDT)
Subject: Re: [RFC v2 50/76] target/riscv: rvv-0.9: single-width saturating add
 and subtract instructions
To: Frank Chang <frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-51-frank.chang@sifive.com>
 <a9b14055-1e84-e8da-6901-4e3e863e121d@linaro.org>
 <CAE_xrPjg=AAeDVT5GbT0mQsxVQ-O6DaYnCzgaxxor6nMZWENEA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f89bc990-5458-05ec-b135-2cd0c6b1eb38@linaro.org>
Date: Wed, 5 Aug 2020 09:48:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAE_xrPjg=AAeDVT5GbT0mQsxVQ-O6DaYnCzgaxxor6nMZWENEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On 8/3/20 7:40 PM, Frank Chang wrote:
>     This isn't what spike does.
> 
>     The manual could really stand to be more specific here...
> 
> Isn't Spike's vsaddu.vi <http://vsaddu.vi> immediate value also signed-extended? 
> /riscv/insns/vsaddu_vi.h:/
> /vd = vs2 + (insn.v_simm5() & (UINT64_MAX >> (64 - P.VU.vsew))); /

Whoops, quite right.  Masking to SEW, not (u)imm5.


r~

