Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B1EC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387A320720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RzMVlg7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387A320720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvet-0001Yd-I8
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtvdx-0000du-VY
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:12:57 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:46035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtvdu-0004r9-W8
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:12:57 -0400
Received: by mail-pg1-x533.google.com with SMTP id l63so2713907pge.12
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 09:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qRqlCF7caLfmkcVuclm0vZ4IDFCmNbMkWR5ABSmYfSU=;
 b=RzMVlg7WxenqZDVIzUB4mdrZdoqCh+lFsk1XyqIL5YKPh4h9P6OXjNoFftj2yiUxeh
 CB91O1Ofse6b+fu0P+jkfUJjeb0nCmwZ1OVTNhSE+ukjkES/taEMWrblJHMf8WJvXrLj
 GFjpJhWHOkIOmmPP5vNLgH6fA1m8jhr31nx9lsKuWJgSXXARBECnj7I6Gcdp62Biv7/f
 zIDGaTD97Ts51BMOlW71YRepIrcvqbGpDwdhCMWrY5J+9QsPht2rlSRiWh1C1i2MVayi
 w1K7USzCWkpvHLPlLkoPy0KSXggKbPgpaWUbhpMN7DI5okMVLPNdnWRa+KHYEo/DwwD7
 G+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qRqlCF7caLfmkcVuclm0vZ4IDFCmNbMkWR5ABSmYfSU=;
 b=YlXHvzYmpqv6DlEKzhgKXHqJRp5H6MyOJ+t7ev2Vs7gskkmWH4fWeafHj+FGoHBizC
 ZI4z4JldxqtUsqBqR/Ipf/OgtTTkdX8VOGKydLs0mMLD4698izN6XebKjcTWp9RELbSP
 HZwk6wz+JMlDkkPyXn1JRX7a1YqB6XK4/2PkFQ5+dHBSm+MPbuC653odMLM2chb1TyNh
 K5YqJgjbcPEOorTUfObVc6zjZUQVPzpdbEwIivrZ3ovtFphM3rRdCQ1qQBqNEKdLd5QK
 YrXhrwm2slx2xUNijyffhL+uxvO0i45cB0+rZC9Uw5TVaZaxjrcbbgeKv4/kToxFLybP
 6A5w==
X-Gm-Message-State: AOAM531KlgTEWVpuDoGAcwpNxXCsChkp7w7uteK7i4SGMlqvkdq6D53Q
 UfI4aLG0YGn1mTEPb+1+Hn5wUQ==
X-Google-Smtp-Source: ABdhPJyo+L8ryJa/OoVwpBeTGr8LRJB7IbK0a+AchsI8D1MtGnuiMYFF+0HlVMU2yexWzA5S5JGSfQ==
X-Received: by 2002:a63:1007:: with SMTP id f7mr58180509pgl.147.1594397573352; 
 Fri, 10 Jul 2020 09:12:53 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s187sm7257085pfs.83.2020.07.10.09.12.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 09:12:52 -0700 (PDT)
Subject: Re: [RFC 01/65] target/riscv: fix rsub gvec tcg_assert_listed_vecop
 assertion
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-2-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9be2326f-96d8-7680-d068-6fac66ba0be8@linaro.org>
Date: Fri, 10 Jul 2020 09:12:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200710104920.13550-2-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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
> gvec should provide vecop_list to avoid:
> "tcg_tcg_assert_listed_vecop: code should not be reached bug" assertion.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/insn_trans/trans_rvv.inc.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Alistair, this one should be queued for 5.1 as a bug fix.


r~

