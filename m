Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A120CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA782083B
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uFPz6Pqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA782083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1YRJ-0006tt-O4
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 13:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1YQN-0006QX-HX
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:02:27 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:44596)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1YQI-0004VI-Vz
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:02:27 -0400
Received: by mail-pf1-x434.google.com with SMTP id r11so6873491pfl.11
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 10:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JlFAGtqbK3x9r76yBteOvIjBOWzwUcJOpWdwUyCk0ak=;
 b=uFPz6PqqaecCU64+tbJvUXeuBwoY0WVyjeFffhhyB+HRhVyTZVawAcl1XNzno2ttfi
 5DrdbGrk4Ng+d2NzeR5tlYRj0UOKksgWjk/rX1La65Mn6MCyO1rpasazJUB26hmXqWJJ
 0RtPfeor6fr44h90zdwn2SLvyHF8AvUmtu70YUXRoG0M589N0nD0yAGJCVwrXUT9WULE
 K5sIMATAMwX2CAMeBZA+D9pKpKSxODDsOkimqx33r/4TkJUFqvS/clUI2c8n7QELosF7
 x2cdW3Gg/ljSV76xDzncrXFYAmlvsT5XRWOTX6ZbrXbd5kyHnSiqoloWqbH4m8sIRQME
 IDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JlFAGtqbK3x9r76yBteOvIjBOWzwUcJOpWdwUyCk0ak=;
 b=R0vnetFCvNB9MQ5bNZB6KpLUbXTqGA9QYOp7KKx2xufUGGlD09JHxKy8eg7sIZ4zGB
 MZDi6IgZ9m7X53vDtnIitYepLmC/+jU23KvvpakxudocWhfD1CAttc4CcsK96H6yXBDz
 Gme/hdrbux/5kHtQyc4Ezs6QhrpCxNT565UD/e4TGzAkZIJO5VoUkNhcY3nt+7/0QA1o
 6AfyG6WK6Cq70+2r9m1KTV9nLFyjMqqoHEzxa6EjMuMMEqzRpTwutw+4K+uH2Wviw2Fx
 44GEgII7HBDfAFf1n8zEMRfuTYqHuMgtRonW3Y6tQVhdJNEjTxciBUgSO3j/t3Ipd7gs
 LcpQ==
X-Gm-Message-State: AOAM5317nV2/akBDX4oqso4tu6krdJZbAHx4MICBN/UJvLx2EZB0O32E
 EVV0a3y5DF7IBjpK5fvFiNdvTg==
X-Google-Smtp-Source: ABdhPJyJ3lGksi96RHQjYfXRWLO52ErKkbRIRHuoL8XyIEJ+QvQoCsm+YJH23/AeamdgIjnUQJm+pw==
X-Received: by 2002:a63:a05f:: with SMTP id u31mr4544998pgn.4.1596214939051;
 Fri, 31 Jul 2020 10:02:19 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id lr1sm11045306pjb.27.2020.07.31.10.02.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2020 10:02:18 -0700 (PDT)
Subject: Re: [RFC v2 65/76] target/riscv: rvv-0.9: remove widening saturating
 scaled multiply-add
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-66-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <863e4297-648a-d40f-1270-9abf7580150f@linaro.org>
Date: Fri, 31 Jul 2020 10:02:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-66-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:16 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/helper.h                   |  22 ---
>  target/riscv/insn32.decode              |   7 -
>  target/riscv/insn_trans/trans_rvv.inc.c |   9 --
>  target/riscv/vector_helper.c            | 205 ------------------------
>  4 files changed, 243 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

