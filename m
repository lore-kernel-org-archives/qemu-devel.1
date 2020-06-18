Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD51C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 23:33:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 031792067D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 23:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YIMaEzUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031792067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm41q-00025j-AH
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 19:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jm411-000196-7P
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 19:32:15 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:40476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jm40z-0001GJ-Pu
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 19:32:14 -0400
Received: by mail-pl1-x62e.google.com with SMTP id x11so3147012plo.7
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 16:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=NBYqyKkpe19yasAYlCEWrjLJXUWJ/5RunM9EvD8j5Dc=;
 b=YIMaEzUm18FIv1NigKcWdXSSW1bo9oU5Hw7zLbn4Iq8nkIRqiH/M+Ey3QbN+ztVLEg
 d5mJlwyioq2R/lPMuszVbdaOsmQ2sN3mqilONmsg0jKnEC3kuJd1cv4wTqqgbFLO7e/B
 vilUdMbwPFFsMDNDKsMzK5VinbPcpayhj4iZ+Xu96L0isZjztjn6YiM8CMmrW2dLQJkb
 cysJjsGhmk2lASRnGM8+Qp37hBvu/b2VeK1EP19AMuGnlUcN+PIy/22d6uNzMqVckwP9
 kvEKxxAu+/4+dCOvCDEmnv1QoeXE2OX3ZFPOJnu8bKTJYhuyoJwfa2xESlApxtUwzGrQ
 W+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NBYqyKkpe19yasAYlCEWrjLJXUWJ/5RunM9EvD8j5Dc=;
 b=tQcL9GvOlABg5m4sYukK/3FF8ALkaTj5aGjmlZvZMqLCwS6oXI8gAn7kk8z1IqtfbD
 Z3KowXnuKEuKWr6OVmG2RDh3XFV4jYSZWlIww+pbvF8KaM23yhj2oq/vYRimbJZobFfi
 gPE0kdzPl8C9rTkJ3SwwM4KNPct3z31+VXJmfrkBct3wyyIaVa+NAOtWn2jCuX3dN9mF
 TzBSa9PaD06ibI42tq6fVWmUQ1lQ75RXPsz6bcoFUti9LcI6DBQdErwYSdsBlJAJwy8O
 IuOXByJ9A8Hin3wrpWy7hdRPbsDqop48Iy8eBxmgzFny4+QiV9ZZA86SYpGaV66cJ4nd
 hrfQ==
X-Gm-Message-State: AOAM530JEs2cb/2mei4HcsnSnODL/3jt91n4oO5ZLyg5boEN36IJ6xQZ
 qD8OrA4kLPuyHmsaxYFxumfNpm653qQ=
X-Google-Smtp-Source: ABdhPJyfGN4cJlFfY+WB173ewnGmrqbCAS+8sozKGA99I41Wyb33dWPQmfR8B74jm1PNiEhVdCx2xw==
X-Received: by 2002:a17:90a:336c:: with SMTP id
 m99mr710725pjb.168.1592523131884; 
 Thu, 18 Jun 2020 16:32:11 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id m9sm3903379pfo.200.2020.06.18.16.32.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 16:32:11 -0700 (PDT)
Subject: Re: [PATCH 4/6] target/ppc: add vmulh{su}d instructions
To: Lijun Pan <ljp@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20200613042029.22321-1-ljp@linux.ibm.com>
 <20200613042029.22321-5-ljp@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <04e49d12-6bdd-38d9-47e5-13c95284cd2e@linaro.org>
Date: Thu, 18 Jun 2020 16:32:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200613042029.22321-5-ljp@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 6/12/20 9:20 PM, Lijun Pan wrote:
> +void helper_vmulhsd(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
> +{
> +	int i;
> +	uint64_t h64 = 0;
> +	uint64_t l64 = 0;
> +
> +	for (i = 0; i < 2; i++) {
> +		muls64(&l64, &h64, a->s64[i], b->s64[i]);
> +		r->s64[i] = h64;
> +	}
> +}

Indentation is off.

This can just as easily be written as

    uint64_t discard;

    muls64(&discard, &r->u64[0], a->s64[0], b->s64[0]);
    muls64(&discard, &r->u64[1], a->s64[1], b->s64[1]);

and similarly for helper_vmulhud.


r~

