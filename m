Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868C8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 23:41:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41DD12242E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 23:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UnHzpdYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DD12242E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmQdx-0005lP-IE
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 19:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmQdG-0004oP-7S
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 19:41:14 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmQdD-0001tn-5C
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 19:41:13 -0400
Received: by mail-pg1-x544.google.com with SMTP id h10so5163323pgq.10
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 16:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=reABxjRR8Y81NuGMGmYFxj0MMegGnfcMQCByrhaY8Ts=;
 b=UnHzpdYaV6YRDgZJB1EltBVhVis9AZRHbTJvbIll4+rkm88ZuHqCR9TWl5CSOw1iwj
 L8+szEjc8dnkvQ7XFRXEDEJmHmsIN+NzNyl/h+IWsjzW/o6pj+nMt5WOYshfXbq48z4X
 1fDhgbhoodBBjPibleyBjqj0G4D2ZcJhsQzy/sMwv03++wkkM90KiQr2q+EHeGqhwsfU
 ShW2sqbBIxiHkN3VquTrtI/Lks/eookKRNZ/pQecwhCWqNXQtszhTV/KfhM1+2a/R7X9
 lvZFD4ano0hnIW+vBpyhVMaf+3JjfN8LiXvt+bpW+Waupdlre2OUqTUTOTXO9Wk4GGw6
 WHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=reABxjRR8Y81NuGMGmYFxj0MMegGnfcMQCByrhaY8Ts=;
 b=FJgHgjEDS1EpCI25+2g1XqDPmpsy9Kx3J3In+XyGFl8VsfO8m0jp/mEP0iWct1OTVj
 zcvUjQReFJS8Dqsa0iKklXbKNTAYR7v7oglwpey+M9usAsDnKIIytbVKSIhdZycCl1vu
 vgXc+0JcMInBrQ+r6hFTlIPz0nyz71TyoDPc1xj4y92NE5hFP0up+fDIrcKW0irwEWXc
 3HhZ3EphQ3NOnDwjxURKC5Boul0ujg9vhcBXbAG/yOn6zW0b9z2mji7PbJ2giH+NTmuY
 D7YzO3ofT4wcC4wbyQA/0BhFZ4qFMQ/J+8+bjLD/BxibUeqczWkUJLQaYGtHvTiuHzWV
 o19Q==
X-Gm-Message-State: AOAM530RHBerbKH+X2zXyR8lm8AvnjF3dmgg8lr6sb4luJVAPsp9wycX
 CvtIm8b8oVBUIcM8OuUmDodJaDCHG7o=
X-Google-Smtp-Source: ABdhPJxtTYLKtxa0aBQLU5vq/I48lq0Fcp//qpBsgkNWOsNlJaaGZQ+Kai50KMyFuGVoUZWe0Bc0yw==
X-Received: by 2002:a63:6643:: with SMTP id a64mr1881598pgc.246.1592610069616; 
 Fri, 19 Jun 2020 16:41:09 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id k7sm6771606pfp.84.2020.06.19.16.41.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 16:41:08 -0700 (PDT)
Subject: Re: [PATCH 13/21] target/arm: Convert remaining simple 2-reg-misc
 Neon ops
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200616170844.13318-1-peter.maydell@linaro.org>
 <20200616170844.13318-14-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3ea70fd8-2b15-8335-27ac-0b8948de43fd@linaro.org>
Date: Fri, 19 Jun 2020 16:41:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616170844.13318-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 6/16/20 10:08 AM, Peter Maydell wrote:
> Convert the remaining ops in the Neon 2-reg-misc group which
> can be implemented simply with our do_2misc() helper.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       | 10 +++++
>  target/arm/translate-neon.inc.c | 69 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 38 ++++--------------
>  3 files changed, 86 insertions(+), 31 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


