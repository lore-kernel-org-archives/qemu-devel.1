Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B2FC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA24205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rf5tESex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA24205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6d3A-0005jY-9W
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 12:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6d2Q-0004aN-TZ
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 12:58:42 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6d2N-0004gL-2e
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 12:58:42 -0400
Received: by mail-pl1-x641.google.com with SMTP id y10so2873341plr.11
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=I7csp+wRcOV9GeM/9pMtxs0mZ9h6QkOeuP5M3384jFk=;
 b=rf5tESexPryclzKwJSBFMkNpQdDYmMN54e/t1f23oq0fiSe4lTlGZPHs+xhrh7lNLn
 aStMMlrk96TyBgfrkb2irjvahAbELXZ489dsdFStE+4jlcS5ZGa0DyOnLz/BzO+IujR2
 1jfWdP4o62GMSlunn372PFR7VpV1PQOiV3OSXGS9CFfoH1ROTedBpxMt9GTA13xKApAs
 +92F98ZTeZpsVL56WZ0ike+/jQpfBYUEYCNXt5Plzgh3nKUwQpulBQZ8YScspjplP1qF
 mPBVESCl1Co0k87XF8xNFaZlmRS9C/s/kHw4mA8nxWUPKLlo9DZzFOXt6QEo41vXueEG
 Zc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I7csp+wRcOV9GeM/9pMtxs0mZ9h6QkOeuP5M3384jFk=;
 b=r1CMCKS+W5VEcwaQcEQmednRwe66RKPfnbKvmbCx3F+7C20PfYf+WGLCkURRQkHzbM
 spJ9p3izG+JTT/yzooepces/rqTT0oLHsWSX3Cf8OBjK52xuhVhiVwVIASj+1grJZO2f
 w7uJJLiXWPCIeWvm6XD20Wus8yOEhVp3M5w04zg+/1S1t5Xw82JArv/O/M5iu0601ubK
 qIycAo9ApU6ZrsSoCVbTuVjWEzb+dY5IMGEkY+ZkK4buionjOptZshukum5f3wh4UCUb
 Gn7pMwvLgKWU7NSJ5whmolkPtwvcQt30Oe7aOJxipPoAOJZWBpJuIU3ykrSjfFD/RZNT
 TVFg==
X-Gm-Message-State: AOAM531KqPGNtHt60wmuqUQyDXGcBw7ARCKH7LYlo5qcjHpFSTbsd9tv
 yC/ThHNIEmyH8QE68xnepn+7Uw==
X-Google-Smtp-Source: ABdhPJx/jX6GMbHBi9Jt4bcWQd3wf3BDwl2L2ufMzmTg0PCtSt1zNH0C6LYtP75MuXpplf4C3EHDoA==
X-Received: by 2002:a17:90a:f2d7:: with SMTP id
 gt23mr3104186pjb.0.1597424317670; 
 Fri, 14 Aug 2020 09:58:37 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x9sm9886898pff.145.2020.08.14.09.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 09:58:36 -0700 (PDT)
Subject: Re: [PATCH 2/7] hw/ide/core: Trivial typo fix
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200814082841.27000-1-f4bug@amsat.org>
 <20200814082841.27000-3-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6d95e086-4979-c585-cfc2-d3f162b576fc@linaro.org>
Date: Fri, 14 Aug 2020 09:58:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814082841.27000-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 1:28 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/ide/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


