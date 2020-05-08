Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093CDC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 20:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4251206D3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 20:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wvg8mDQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4251206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX9Qf-0002W3-PZ
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 16:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX9Pk-0001tA-2q
 for qemu-devel@nongnu.org; Fri, 08 May 2020 16:16:08 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38486)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX9Ph-0001mI-LM
 for qemu-devel@nongnu.org; Fri, 08 May 2020 16:16:07 -0400
Received: by mail-pf1-x442.google.com with SMTP id y25so1515687pfn.5
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 13:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bIGHQvRQq5Gcv5I5cSvS3nAGK5+TSbCAkAa1j8XYBxI=;
 b=wvg8mDQr5bzooh6M09TPXQrc93AXvGSxc9D9Nu0MD/jZYpFMrIqXisXDU5H3IGOqjc
 J7a1ZXUfMEHpuVZb49KHOiOAE6SZPn2w31KMk02CG2f17l6ty1mqQUYx0MwIEFNC4625
 SDbxp7U38dlLtjToKfqwBjVA2YLc/ytQgQpCCixZJr79wI8ipcjUUdk6cdTlAVgub+p3
 cPBFgLlvlqyzVC5xHIDIYEXD4C5fT3fyxNck/jqn+Rt1P7RQcoKSkoI/E63yzycOil8m
 i0Z9P8lJyU4t+uVZKZkdwv86hsf2wzbRaGKQn+6a+ZfLWIj1YybOnbFXpZfSaqM93+Uf
 z90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bIGHQvRQq5Gcv5I5cSvS3nAGK5+TSbCAkAa1j8XYBxI=;
 b=ZvBHY024FbX3p7tAM/ZVQOy0vCQQV7qLRuVtY0Ao2RDutZSMVXVvWZpfwpXdvWdQvU
 QIuPEfQ1N3kEwYboL8H+8VI5I7a41djolF+gZ7ZE9bjURwWd2FJir3BaHs9yKbCnT7nd
 Ew8si2AJToK1r9SlW2nKzsOvUNdQPG8xSGpCPeD86Rwxau99qmuqqVQQgd7JU5wfYUMS
 dTH7leLHhINfMVrJYxYlVvwrg+bbFdbTNnr1paGMiWLjf6YGYoEnBSSaWtyMLT1CxTbV
 EfpcCWrDANZQ0DO2uIDMob1QzKdY2mrqN3j02pagiBjhtYmm5fuULHLBp6gjIaxvXU9+
 smDQ==
X-Gm-Message-State: AGi0PubP2rumCe+dI7QgqjkXGHY9AY9LWFE/OT3SE+DUxgamIgjkhKFs
 nnIhe1yt77ykc4KaawUtkjCQ6A==
X-Google-Smtp-Source: APiQypIzQnLEmL1C4XM+91e5mZ9+aDpOxWzzn6bG46g6xeMsdGeh0gwzo5CFet0vz1ALXVJws0RJ4Q==
X-Received: by 2002:a62:3287:: with SMTP id y129mr4771046pfy.167.1588968963932; 
 Fri, 08 May 2020 13:16:03 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id a15sm3067236pju.3.2020.05.08.13.16.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2020 13:16:03 -0700 (PDT)
Subject: Re: [PATCH 1/4] memory: Rename memory_region_do_writeback ->
 memory_region_writeback
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200508062456.23344-1-philmd@redhat.com>
 <20200508062456.23344-2-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <df18d27a-7a87-32f7-fe62-115be72a08a5@linaro.org>
Date: Fri, 8 May 2020 13:16:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508062456.23344-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 11:24 PM, Philippe Mathieu-Daudé wrote:
> We usually use '_do_' for internal functions. Rename
> memory_region_do_writeback() as memory_region_writeback().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/exec/memory.h | 4 ++--
>  memory.c              | 2 +-
>  target/arm/helper.c   | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

