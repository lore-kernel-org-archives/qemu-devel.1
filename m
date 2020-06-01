Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C7CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 21:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CC9C206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 21:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NU2q29FG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC9C206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfrcl-0007V2-KM
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 17:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfrc3-0006yW-Im
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 17:04:51 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:50594)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfrc2-0004cf-8r
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 17:04:51 -0400
Received: by mail-pj1-x1043.google.com with SMTP id nu7so354004pjb.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 14:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=t6mrYGwsHL2BBX8cFNIqAyzOxSAUq//xzEh+lAhNBA4=;
 b=NU2q29FGFPx4UxiVQheC/ZjZ0IKQVFMObdwuwB2Qu1oKyg2GaMsr86IgEKK4O52Fey
 QHz2F+WzLFHng5/5TEh9jGIZN+Nbq3vx3bN6gOA7B1ebqT87vcB7SkBjbzGdim8CKFY1
 AuMKwJlJOkuRA2Mr1qi5wwIyelpoq+svkCymFgSA+ya3F99KnvCvPstD3QFzndxlhSrL
 GF+MTqw60eOo0VrqrJ138/b5y8OVK0ze3wNyVk20Knpe9DfDZ+qkDdlqrtV0C/TJp78v
 Bsow2z+AtpD4F4M6QLSjHG43LjR7XJ7i64qMRXwb+lJcM9tMNxTqTckhee0bM3A1pv/1
 8C7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t6mrYGwsHL2BBX8cFNIqAyzOxSAUq//xzEh+lAhNBA4=;
 b=Oj+giBfekcPC3otGoSs0YNDcp/k+s+UDRNXR/QWmiu3N/YLklBNtuTXKvYiGFq0MCO
 +lWD56mODjKS1apx2q7hCECQFQ5IJNF/l/RznQ8fiQvcz3vH3LjpQluBQjq/8/rju0LZ
 vPYfZg6fx/V2FKG9ZYeAcCfgzqtYlYv8NBFq+9huyu2BBxU8tkj/228zKL95I/uH50jq
 isXMmXjXv2FNCMduXItZW0Jlqp5sxEpeRj+v6DuMRJtVi2l1R6E8ZgoWBgUgWm+P0sXk
 1u+Wrwwj94Kp9a7wVYYPQdEEk1w1YTCSyzwmW7lhFEhhzOFKVRGoRDla8EAVfIbgapFb
 enWw==
X-Gm-Message-State: AOAM533mFbotO9TDfWlUWHSpxf60pIRLDwrqHGPXFFjU9j10SZUU/7yu
 8TGH3xN4EV/yEwD/rm5NKGNKXw5jaBg=
X-Google-Smtp-Source: ABdhPJzYeRJ+AlC8U3QmcRvvhe4wmJdBnKByx3feLCAuG8K9XB38WZuLNYqG/34lv4rAx+sPSCVXqQ==
X-Received: by 2002:a17:90a:4809:: with SMTP id
 a9mr1394760pjh.196.1591045487155; 
 Mon, 01 Jun 2020 14:04:47 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y187sm301701pfb.46.2020.06.01.14.04.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 14:04:46 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] target/tricore: Raise EXCP_DEBUG in gen_goto_tb()
 for singlestep
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20200529072148.284037-1-kbastian@mail.uni-paderborn.de>
 <20200529072148.284037-4-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3004a483-44d9-34d6-c12a-e1ade85e6ebb@linaro.org>
Date: Mon, 1 Jun 2020 14:04:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529072148.284037-4-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 12:21 AM, Bastian Koppelmann wrote:
>          if (ctx->base.singlestep_enabled) {
> -            /* raise exception debug */
> +            generate_qemu_excp(ctx, EXCP_DEBUG);
>          }
>          tcg_gen_exit_tb(NULL, 0);

For preference, put an else here:

  if (singlestep) {
    generate_qemu_excp();
  } else {
    tcg_gen_exit_tb();
  }

else you emit dead code after the exception.

r~

