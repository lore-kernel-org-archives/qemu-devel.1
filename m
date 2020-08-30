Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9208AC433E6
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 02:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 500AC20776
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 02:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="db1sQQhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500AC20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCCuW-0000QY-HR
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 22:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCCtz-0008Np-71
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 22:17:03 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:38473)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCCtw-00019b-Lm
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 22:17:02 -0400
Received: by mail-pf1-x430.google.com with SMTP id d22so2663053pfn.5
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 19:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RauguQR3pk3b6pQKo4JV/Q6ZSIAXKh1a0agR88oj0NU=;
 b=db1sQQhF0+AVYZ9GBPav24kKwX5hNe5BD0j1QKhswPmBME9bd/RS2sd+AM6tWtrAjc
 Zluh65YY4rBYR2vLy8e6RykzNoexE8SUF+V4nFwiZxnj1tpLI3xsE2RsZoBmDQ6oA5Iq
 zFshXzTLPs19ETXsWxXtjeRem5KSYW1k2oElJCpCmPV6ISSNthPISsdKnMgF9nyyCtWT
 Edoz+59bfbzll2gPw6K1QDljwXkjTdyGr66cU6LD1txOtM2QwdUaw7w08r1XDQs8xNXX
 pj2McM43qLGWb63BQgZt9hybWH/4eLbdfr4HNsUNldaoesUWsdqZ59ibF/5oH0QSVYi9
 1d2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RauguQR3pk3b6pQKo4JV/Q6ZSIAXKh1a0agR88oj0NU=;
 b=O1c8qk6miQ2M4go5hosdpkdIl2jRT3D9F4JwIG57aXzwOi4bCWCwIl/LsJke25o//V
 lTbX/Y4eMWSf+H4iqAIsyWyTJKPAoSe/zDvqMLV4qJfjNyDT0hvgTBNQnrTIk8iRkBqW
 u4nUuy9QoXtpjrA6KowjHGfNSWJ7epkoeFwDHEXKwSjq6vYWBrkKq3HdCtmZ7+fZ2dFn
 8fIlJzwCHSBhc/+4zeLeWoVjzcbkGlC5qihBqyoombO7VmBEgdqIvLjAMq/SLcja4bNY
 hErpag5skhYeZLu+od50/yEXc2DzmGlrAKKMV/0Ic838FpvilMSc/HQYWvoaWtQqgyby
 DKFg==
X-Gm-Message-State: AOAM531y9Gat9zO3bIt+hTbVZQxTDm1Uk5pDz2ZMcLKPF6UOSfe1WBiR
 VRQR7IXmHtIj9GLAsegJLzBORg==
X-Google-Smtp-Source: ABdhPJw8DgIUUnwqllXbeSiW3qPbK9BNwiKFdmW+VkZ+IObb+w1TTCAAtNK1rD1edc24AUTjtdxnJA==
X-Received: by 2002:a62:5a87:: with SMTP id o129mr4683942pfb.204.1598753818958; 
 Sat, 29 Aug 2020 19:16:58 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id i17sm3843308pfo.150.2020.08.29.19.16.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 19:16:58 -0700 (PDT)
Subject: Re: [RFC v4 68/70] target/riscv: gdb: modify gdb csr xml file to
 align with csr register map
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-69-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bb75a628-b94e-8c17-0bb0-55085bb96c04@linaro.org>
Date: Sat, 29 Aug 2020 19:16:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-69-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
> From: Hsiangkai Wang <kai.wang@sifive.com>
> 
> Signed-off-by: Hsiangkai Wang <kai.wang@sifive.com>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  gdb-xml/riscv-32bit-csr.xml | 11 ++++++-----
>  gdb-xml/riscv-64bit-csr.xml | 11 ++++++-----
>  target/riscv/gdbstub.c      |  4 ++--
>  3 files changed, 14 insertions(+), 12 deletions(-)

Looks ok, from a quick glance.

I do think that this could stand to be auto-generated as well, from an extended
csr_ops table.  Extended in that you'd want to include the name and the isa bit
to which the register applies.

I'll let Alistair weigh in on this.  But either way,
Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

