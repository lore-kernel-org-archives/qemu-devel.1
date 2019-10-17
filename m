Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BC2ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:23:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9072620872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZ+ywjQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9072620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7cK-0003RF-4k
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iL6jo-0001Be-Ij
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iL6jm-0000k1-EV
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:26:47 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34446)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iL6jm-0000jI-6m
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:26:46 -0400
Received: by mail-pg1-x542.google.com with SMTP id k20so1476751pgi.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 07:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0JxDt+sne9dRK2zA48Vm/X13m/uQ5iE/uTgAh+B7Fuw=;
 b=LZ+ywjQVz45oobFxRapTJCi+Z48JiJt1X8+kehz26NlIS7C7BKocLxF2oXn7791Gpb
 Zodwu6DasPmrc11WJuCqjmcCV0Rtz+U2jxo8/2Bsqk6xTV+BOghtnEpzYC4pXzJGmZl5
 8VWQ0Vw/aCtyBV5WPhdAPpGJd9Eo2NTSMDHTnHwti1VRD7dfZ+sFsUZ4dQ03lkpRayZW
 gXhgmbYVODRgxn+X8UNhYxsCJ+KFBcFHPLZv2yjtuU5qgvM6EyBYzEqwieEvBWYGHXuX
 v9pdUwd7SWb+g9ePctXJZ7BXlvFtrn5gyEoEgo9bTj0hF05iUiiZnEMyRw+wtcVA9ht1
 /hCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0JxDt+sne9dRK2zA48Vm/X13m/uQ5iE/uTgAh+B7Fuw=;
 b=UnemuCdveHZNcBs/FeoMHW/q9TTda8BiESIuSheh70IwV25AJrwJKnVD8XO0sMmO83
 8/qbR8T379HVjQLJBozJ01nIijZgTMgw9h9mineAdfLclHygepjg7Z0S+1urxI6TwDiz
 xK9oa8l1eJk9kpfdDl6rxusI0PqyEwo65U3up1C1OlbguF1iYC0yvl1YzaifjK8CiP2i
 HjG6oLQ65ghVRebA6OaBqgPPvCGU1eZSD9wOPmYAqU5EUbjaUae6TBrjU0EEgtq77Jcd
 FWq21DqsVhYVYl0JZF5qZFm1M8x3dtvgTUyWs2LGOrbkRHmxibc6DbqColR6UVGsjDu2
 AtOw==
X-Gm-Message-State: APjAAAX6DDczlvORRsUqMwfXJ9bNqFGe6Pn0MBOibpoKVLK6Y9pzzQGx
 1JuH/fKb7m7Fy3HKJlNrEdhspQ==
X-Google-Smtp-Source: APXvYqyUa84jn6J4b4iBUceDSWZt+vwe8/mz0UnZ+euJWPAhiTJxySbG6/w3YGb3Oa/P3xbMDk/ebA==
X-Received: by 2002:a62:1bd3:: with SMTP id b202mr458464pfb.50.1571322404639; 
 Thu, 17 Oct 2019 07:26:44 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s10sm5732803pgn.9.2019.10.17.07.26.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Oct 2019 07:26:43 -0700 (PDT)
Subject: Re: [PATCH 1/8] hw/timer/puv3_ost.c: Switch to transaction-based
 ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191017132905.5604-1-peter.maydell@linaro.org>
 <20191017132905.5604-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9a1b185f-c7a4-3eb0-cb66-8b352e74ff0e@linaro.org>
Date: Thu, 17 Oct 2019 07:26:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017132905.5604-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Walle <michael@walle.cc>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Magnus Damm <magnus.damm@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 6:28 AM, Peter Maydell wrote:
> Switch the puv3_ost code away from bottom-half based ptimers to the
> new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/puv3_ost.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

