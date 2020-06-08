Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A03C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:39:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845D12053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ewp95Zpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845D12053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKo5-0003H6-Nk
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiKZX-0003eS-Mu
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:24:27 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiKZW-0003kx-8F
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:24:27 -0400
Received: by mail-pl1-x644.google.com with SMTP id bg4so6855965plb.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0Y4xc6MxXnp/UCqE/q/3jGHzpymQf0UxdyiAr5tbJaA=;
 b=Ewp95ZpdtMSe9pDrsaphR64wT8U01MhAeN/oW2zcbbi2G3GazFOWc/LJ8PhT45podS
 TcGwPayqFo9paPVvQr9AIyHRf4tRXToWcHhP4YA9q0MUfSqnpYViqN4GTFfaWCV75q0q
 VZp5oiGbHWQpyLOKQ8AE2e2zG2gZSSIDyRX+jzxTIlZPeKigxbs82eW06wtHK+QrsOcR
 FGN/jo4dcjabBlu/SaKrodkHGTJqVcAq9IjGzLiAaszmAxJhth08mxHsgxsUGCtKqpBD
 asGBRZa4lCqmkSYswdJpd9IaJepAUyb8D52TagPKsqEjbRJKgxo0CDlZpuwuakOMsk/3
 lxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0Y4xc6MxXnp/UCqE/q/3jGHzpymQf0UxdyiAr5tbJaA=;
 b=VqBS61ZLGt4R1y6WolRH0qXPi0NGp90m6mAPELM1pbSmOYVV+XTyw4VxW5MiTMFhAA
 YZHXj1P7cQaDvCRiMsGvC571w3quzfzubYefmnsSk0Mw1bac6qUIuRkezxaSEvMVin4O
 acid0g2PuvXYzFqFnCeryN4urt/7t07SaLg/xnUUnyKQC4ve4gKYhuEqrNZe12z708xv
 efDPGWO9YXLtFwZ4ZRivVqApBR88GZ95Jz6RDJpZSnZWidvepC0Y/V+hhKZTXv9683Pe
 x67zntA6ObVIrGb3FXpQE8WI8jJDiWZISz+4GAto8EglxsVLzd9VzjkGIFOkRN1E9XXx
 ve0g==
X-Gm-Message-State: AOAM533DBbBG0Vhg4JAx7XKTtFvqIV/AGp0lN7r3YzX959Cqs/ZGMR/Y
 UTZCNfiOXN5bnHh7eMrhdpU1ig==
X-Google-Smtp-Source: ABdhPJxzGmJZfW+lbewobue9y0vBeVjNRMguHbbGILdm/pMsmiwFoWt2zHt0OrfICGyj9iXiZyvYyw==
X-Received: by 2002:a17:902:aa88:: with SMTP id
 d8mr21429391plr.257.1591633464059; 
 Mon, 08 Jun 2020 09:24:24 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id a17sm7664085pfi.203.2020.06.08.09.24.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 09:24:23 -0700 (PDT)
Subject: Re: [PATCH] migration: fix xbzrle encoding rate calculation
To: Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org, dgilbert@redhat.com
References: <1591577607-13998-1-git-send-email-wei.w.wang@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c8f8a08a-7621-a170-d007-427ef7621dfb@linaro.org>
Date: Mon, 8 Jun 2020 09:24:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1591577607-13998-1-git-send-email-wei.w.wang@intel.com>
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
Cc: yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/7/20 5:53 PM, Wei Wang wrote:
> It's reported an error of implicit conversion from "unsigned long" to
> "double" when compiling with Clang 10. Simply make the encoding rate 0
> when the encoded_size is 0.
> 
> Fixes: e460a4b1a4
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  migration/ram.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

