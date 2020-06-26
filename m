Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645E3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F07220706
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VHlFSAMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F07220706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqa8-0001cx-Fk
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joqQP-0001iZ-Dd
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:37:57 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:40721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joqQN-0007m9-KT
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:37:57 -0400
Received: by mail-pj1-x1044.google.com with SMTP id cm23so5099775pjb.5
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Eiz+0GIH3tsZSp0WdMCWIyldsATrwS/pF9mZlVSR5ok=;
 b=VHlFSAMwdTCzu9zIzmcXRfKrRfWh5lKpSI72VIfIaxOl5DrWo0nNAIBHDpPCqQp6IO
 VfW6tGdUk74Awh0xVXqjkqUR52zvIK3vb2mWDszcuwPPathl4g8oyiq24ruUZ2KC9h42
 rtLszQIdTLD6dx2FgLuclazXWKF6YUrv0ZsLJbsBLET+cArFLTns6OgzC1PkAj5OJNjL
 zbfGpUsdO71wFDNI/ov9SUHTJo1LxYFt9BXsk0HMXQHEVGl2sNex3swFyw7owlB6B6S5
 054SijRvYAKMOovdpsXh/PQuGDAPhWxsdK618ABPiqEGnIdFKY5ALBW6HWAyDKsuz4Jd
 humw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Eiz+0GIH3tsZSp0WdMCWIyldsATrwS/pF9mZlVSR5ok=;
 b=Es2wAJXjeKrnwaOmjy2XMZhwWdURkBK+giEl3+DFS44jg/OvwypNbuAs46XHkuVfGW
 GYExBf8QTkokH7GYM3eDYbbYoupO2+roX+bz9dtdtLM3UN3LGHzNbSkyNG20CZk2Eqi6
 +R0t/X/1vQWihJqSkOD5iGbiVS7/xsClp+Au3iDr/48HLGDlhVqXwph7y56ZejcY9t8v
 u0czZzsYTOCifn3mahNsuv67a9md036qNOn7ZchV7gLQkWGmhSnmn0KBxx+UOn+SfEaJ
 VzyZjHQprYKZqPUajfVmwO5RFYKjmVUnC0piE6SVHJLLo+we7KZVsoumQRYVE3dreplS
 oLjA==
X-Gm-Message-State: AOAM533hWeHw6vFK3dxCg7iBFdFmo03O43ivq4TIFK0LMMU5B7oMBd8H
 D4RUHEGVVw4WXNUn2SPHR8S8YQ==
X-Google-Smtp-Source: ABdhPJxl6rOu+gPTwnzGhvLUhqPjcElNMpVciBvOig896C26rh1U5UG/l+L6jcAp8E1IgTZqrETcCQ==
X-Received: by 2002:a17:902:ff18:: with SMTP id
 f24mr3067144plj.118.1593185873996; 
 Fri, 26 Jun 2020 08:37:53 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id m3sm18607983pfk.171.2020.06.26.08.37.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 08:37:53 -0700 (PDT)
Subject: Re: [PATCH v5] tcg: Sanitize shift constants on ppc64le so that shift
 operations with large constants don't generate invalid instructions.
To: agrecascino123@gmail.com, qemu-devel@nongnu.org
References: <20200607211100.22858-1-agrecascino123@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <45a69aac-c803-950a-ee5d-e087f791a41e@linaro.org>
Date: Fri, 26 Jun 2020 08:37:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200607211100.22858-1-agrecascino123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
Cc: "Catherine A. Frederick" <chocola@animebitch.es>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/7/20 2:10 PM, agrecascino123@gmail.com wrote:
> From: "Catherine A. Frederick" <chocola@animebitch.es>
> 
> Signed-off-by: Catherine A. Frederick <chocola@animebitch.es>
> ---
> Okay, I removed the bad "fix" on sar_i64, and the asserts in the various functions. 
> Crossing my fingers here.
> 
>  tcg/ppc/tcg-target.inc.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)

Sorry for losing track of this.  Now queued to tcg-next.


r~

