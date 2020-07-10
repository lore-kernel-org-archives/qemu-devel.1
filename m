Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF45C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:31:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB46820657
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J/dZRZxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB46820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvvU-0000Pq-SO
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtvg4-0004h3-CV
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:15:08 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:46120)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtvfy-00056k-KP
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:15:06 -0400
Received: by mail-pl1-x629.google.com with SMTP id k5so2430243plk.13
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 09:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5dcMVQboCvcDWlgEiVC28+clgOKPcqp7v4lwPnU26yo=;
 b=J/dZRZxBQdzhi9S/mLnSQV52Uk9UEMedWLfQRhhlbNh/zgqdtdPHUpbYoSU7vTwLDV
 8lJEclAklgJwCjtw8VbRfExvUybseOLw1w08aHHd7s6JZD9SR7YLexogeGPfqnaUNyXl
 4/DUIlgrxaj+F2hpJLpYT7mAnK0tfiDr+89VJn1+ujkmRm1PqdmUVkFmDJu5ZNN0L3gg
 4069EIZDQdSTQ0PyvzicHGF0Y+E3DjnOwU7KyUB5/uAx6NYQf9OoU8eaq0kmhecysIb/
 gwKHRuDFrIDl37/8CLNw7XH8uhq9og79Er3l8Ze1mxVE5ojoODmnUuDirn7UH+CtKecq
 XfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5dcMVQboCvcDWlgEiVC28+clgOKPcqp7v4lwPnU26yo=;
 b=AglGSlxfzder13bobYe1v/ZjUKfhtnGTBkM3ixzvAMUBcdgpYuBK9h99v4ydYuIeY6
 8L8ZSomLuzU07j2FYo+0a8gdqSAxJUGYODYa/2DbxOSnI63XdBebuD2UlZouaSynqHTh
 0NQQxjAiGM8iiaFH+2xW4pDLvM1KLsPpqZwpTmNm36UIWFMxtLXaeHYyV9AVaLWYXSEi
 zB+KqW8ayp83pTHzKeSijGooAr9aDrIkipXcIsRmRvDTYUmIQEodstv8NAiHLCPhV2tY
 x4U9Bo8giFoBSU256Uj/eHulMEI/J5tv0ghVipDO6VnhAvlGbX8Mfs/2AKeCD49r0JQr
 ULuQ==
X-Gm-Message-State: AOAM530YgIHR03qfc+rfBHuK8ozuxDVdZqURuTO2j4GkC7fc8PAg3lzp
 KNGP9b9dO3TpXaDMzwxXwAm9EQ==
X-Google-Smtp-Source: ABdhPJxhkkP/me/4cgTGMWa99EPHIP5wjNYkRm/oqrnF0JmJiyov48gxmxzBbRhfuGfFyI7PwJ1Hnw==
X-Received: by 2002:a17:90b:33c5:: with SMTP id
 lk5mr6632330pjb.181.1594397699104; 
 Fri, 10 Jul 2020 09:14:59 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y80sm6185877pfb.165.2020.07.10.09.14.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 09:14:58 -0700 (PDT)
Subject: Re: [RFC 03/65] target/riscv: fix return value of do_opivx_widen()
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-4-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <07e07afb-bafa-4027-33fe-669e472de0ff@linaro.org>
Date: Fri, 10 Jul 2020 09:14:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200710104920.13550-4-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 7/10/20 3:48 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> do_opivx_widen() should return false if check function returns false.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/insn_trans/trans_rvv.inc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Alistair, this one should be queued for 5.1 as a bug fix.


r~


