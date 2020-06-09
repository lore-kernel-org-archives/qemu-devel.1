Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7D1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 18:57:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37931206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 18:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hndLuWVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37931206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jijRG-0004nB-EJ
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 14:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jijQa-0004Ec-Ff
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 14:56:52 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43858)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jijQZ-0005L6-An
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 14:56:52 -0400
Received: by mail-pl1-x644.google.com with SMTP id g12so8390200pll.10
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 11:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=096eqWxL0XJqSGPkLl0rEVGBekBw/41/MfNnc40nJzQ=;
 b=hndLuWVZFsfYdn5ISengfI3Lea2VdRByxvQQMxvVD9+GuacOVdYTjfV64k8RuiVj71
 Gf32mYFunKfD2QbvBoirIm6+zbsbVyf4Tb0FU8TKs8hx2NmPgf+9fq6QjwtoKVLcOITU
 i4bfCGwQJRlD491PDIlk0QmIdUd56ud9PJOOwc7BkQylYjr6N4DT22y+fah+sHnh4nj8
 RmTrMhud/nPCEjqg3rD6dvV6EC8v5cWRUDxW+Fn0lDICX5LN8Lns/kVAnhHzyK5CDrpG
 RYvMgR3Na3mNW7qDnqeP6zygJb9XN5j0jp09uVZZ9kDUjjYC0kyMDUjsik/2T/USrUJQ
 Ufgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=096eqWxL0XJqSGPkLl0rEVGBekBw/41/MfNnc40nJzQ=;
 b=YdQ5r9Y/b6W2a6RpIe+503OjLOKLWpqdGalMr9LWuTcx5bQX8j0wn+kyE2aWw/R43I
 LE1qTgFM5d81cRgHtSV4CZpEl8nse081XICL93T3mrf3IOLb5wNGi36A1uKfatYYP4An
 7/0mES73gXZcKD122Oszu+BOoLKbaimI7WXtPmfyrZH/qyeNMqtB2Bf3QnWHqFDSQOIE
 uqZMEj5Unlr+43aoFvep7MGEiX2gAZbF3+uLGliWOeM8+Q+SdEoIeoeLumGEMWPZE9Mx
 o4mdJKKwUI5AHIVY9F3rffDBlorNnyzdBtHqabvYbDaEKjapHBQHObivon/TZDkdwF3w
 nzmg==
X-Gm-Message-State: AOAM532PaIOaUN4hK4FtlKpsmw8qiSYxVYpvkUvunDPRdgpruh8rJGtU
 gbbuz3XC0EI5JXAKHhWPnH65MARx3LY=
X-Google-Smtp-Source: ABdhPJzqUWxVLyBmjunE9sFPOIFlCdFTC7YatU5FQAvl67IrFYZULPrv//MkX+aCdwrH0KVtevh8CQ==
X-Received: by 2002:a17:902:c214:: with SMTP id
 20mr4589314pll.193.1591729009580; 
 Tue, 09 Jun 2020 11:56:49 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x11sm10502171pfm.196.2020.06.09.11.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 11:56:48 -0700 (PDT)
Subject: Re: [PATCH 7/7] target/arm: Convert Neon 3-reg-diff polynomial VMULL
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200609160209.29960-1-peter.maydell@linaro.org>
 <20200609160209.29960-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5682bf68-d7a4-0cfc-3017-2736c0a88f8e@linaro.org>
Date: Tue, 9 Jun 2020 11:56:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609160209.29960-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 6/9/20 9:02 AM, Peter Maydell wrote:
> Convert the Neon 3-reg-diff insn polynomial VMULL. This is the last
> insn in this group to be converted.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       |  2 ++
>  target/arm/translate-neon.inc.c | 43 +++++++++++++++++++++++
>  target/arm/translate.c          | 60 ++-------------------------------
>  3 files changed, 48 insertions(+), 57 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

