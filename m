Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE061C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:26:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98907215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WDPy5+Lc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98907215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWkHX-00055F-QG
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWkGR-0003f4-B9
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:24:51 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:38219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWkGQ-0005jG-8t
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:24:51 -0400
Received: by mail-pj1-x1041.google.com with SMTP id t40so2919695pjb.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 10:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZzHbusT2sjOak3rkNaiXNoxTATmLAwkalFQWfFIpi7k=;
 b=WDPy5+Lc3jJDRfLomlkNQgz0inxdPNUzJIBvi8G+inAcIXWKJ/G1HSiqgmcqS/iL2a
 prdbBKaUdeWeNAVHGyrvLqKi8Uo0SL25rhu/DP0kq5ZNYTUk49qqf+Vmocw1zlGcNpwL
 T/Cs/CP0JnboOKzvSrD4ZBmdU22URvWViPYnFE9zTpq/9mfKWSwOqPHtcgngr1dWwDRV
 2pxNo9AWUNdn+uLJotOki8F8c9EyvVIGh2JHeBlKURO1CRowSSEBFo1uzAgMTdldenfJ
 lzhzFkONItNvHuVw1/YQ01mmQiiJ09nM8RLeHRqmHbmsRV35bANHTFj6r+cq6LT4OUNr
 4Jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZzHbusT2sjOak3rkNaiXNoxTATmLAwkalFQWfFIpi7k=;
 b=sPzwXBKFDls6czzrMhLfPPIxwZOr4ieBjzfh4KG4ewoQFdtF3qj5+VYgIatKwFUae6
 3k7kknYSXOppxlEguRR3daV4B+rXFBmISKuYx2s+vMR+Q/yLsB2ZV/rB56uMrG2T0ukC
 B7BQXPyEmyyhhyUda3sdI3q8XemFSBDMZa73D2uA7dFiWSv/smTU9EGVp0ACPWAUtR2t
 EMgzI26KYEsguI3YZcqZgchuL/GqZClvbKadKM0Rm+KTl22Od0PB/f/wOaF0FBLFK27w
 BcDrinoJuz3I+s8Z2CgOyw9+NHzFo7gVVWIGD6LFXPZzq/SfgvN1bGWZpABjTxE3nR6w
 /YrQ==
X-Gm-Message-State: AGi0PubAU8pPYP9aftatrRwUONUP7KdP0x0vHAVidLm05m1Z+qaVwaNF
 YF9XBcwKyHUpKcbZXz3ckwnwtw==
X-Google-Smtp-Source: APiQypIbQ9tjasxQ3FAgHio/W/9KfaOxnC34/KKssnggJs0WMtJff+2vQex/6gBDzvJ8KbP2qPotsA==
X-Received: by 2002:a17:90a:22e9:: with SMTP id
 s96mr1249668pjc.46.1588872288977; 
 Thu, 07 May 2020 10:24:48 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id v127sm5352962pfv.77.2020.05.07.10.24.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2020 10:24:48 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] target/arm: Misc cleanups
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20200507172352.15418-1-richard.henderson@linaro.org>
Message-ID: <f068f4ac-dbdb-59e7-c126-8814ec706ac8@linaro.org>
Date: Thu, 7 May 2020 10:24:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507172352.15418-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 10:23 AM, Richard Henderson wrote:
> Version 2 adds a fix to a just merged patch.

Ho hum.  This is actually v4.  Sigh.


r~

