Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150BAC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 17:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5695206E7
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 17:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wJ7I1EUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5695206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLBO-0007vu-SR
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 13:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLAe-0006em-2e
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 13:43:12 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:43587)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLAc-00086B-BP
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 13:43:11 -0400
Received: by mail-pg1-x533.google.com with SMTP id t14so2866074pgl.10
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 10:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EJnK8m0ROXcp5RwFJMM1hO16MFAdhvGuXsqJ5FWXvI0=;
 b=wJ7I1EUidBwsD/n8d4Z8+cB/X5AIcA1fRWdn1R1VCeCYblxQQwffHelQV23yw2POiK
 qNZcVYefVJQ/g8qtQoEODXIoI8VXtXwd4BFT9OLJU+CX3NUMEtZjNtyrtp889Qf77/fo
 UA7BQD+NkdL/3wJ1Mk4WEhisZyzwrBKDPGzQABpgCnrDXb+iIcL4EiLaOE7rN0ZPnBti
 sffJTH4nq0tGGxDfE30sA01hgnqadb6U2bXAIEIR7iVjXnwy9nPps50GQiA3jlRHTKmL
 dc+xWiKZ+FpU6hNR3Cfbak4E9vpUsFatPGGyhmTmPw7/qAiW2lIXp8rGk6gEtjmbm00S
 m2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EJnK8m0ROXcp5RwFJMM1hO16MFAdhvGuXsqJ5FWXvI0=;
 b=iVoTnc7E5iiwMumLBdEqpfADWLCMp4xhJDgahzT9ZMZjCDXO7GtxJVku2SpKM8v6Pz
 3ogL9GJ5fPCovUmQ4BMRgFy80hG7ik0El61Y3ijiQUGoLHN+WMDZZnBZ8FR3v+ng17cF
 CjRprdZDOx5wOBIwr+6/7YRzWjVirFnKRQluthN7bjcr1wGSOTCaDEglCQlG6p0hC7DM
 0aoVrTxktO/h3KynegtuRz3pZCJjqWPGBRbNWSKBBln37sTMxfuKwrwhyZZzMXiOAEvw
 TavY8xABd/xwRGN/+Tmn09ag7AR/rl7dxz8c8HSOzXkvRLs8i46My/I0h4+UHx8mwwqI
 4/8w==
X-Gm-Message-State: AOAM5314GaELHDslhSXcNcMgmOZwxCpQ3xE/d2NEmOSMc01dKEwQ3yj/
 YTlaKzBQm1tUa40PS6dGrQ2VCA==
X-Google-Smtp-Source: ABdhPJxw1I6DawfrYySFOposSfzkewUpW6Abdv897XGdLU78jeofneS+TJDc3Js+95O3o4TYwLtq6A==
X-Received: by 2002:a62:33c2:: with SMTP id
 z185mr21373138pfz.242.1599500588758; 
 Mon, 07 Sep 2020 10:43:08 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j10sm16176028pff.171.2020.09.07.10.43.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 10:43:08 -0700 (PDT)
Subject: Re: [PATCH v3 00/19] target/microblaze improvements
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
References: <20200904190842.2282109-1-richard.henderson@linaro.org>
 <20200907092043.GV14249@toto>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f8133c2e-e38e-22e6-9528-27f9a5a3d826@linaro.org>
Date: Mon, 7 Sep 2020 10:43:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200907092043.GV14249@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.825,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/7/20 2:20 AM, Edgar E. Iglesias wrote:
> Looks good, none of the test issues were relatd. Thanks Richard!
> 
> On all the patches I had not previously reviewed:
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Thanks,

> Can you take the pull-req via your trees?

Yes.


r~

