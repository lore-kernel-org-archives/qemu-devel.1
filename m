Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E56CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 23:14:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 582412076B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 23:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YrgtQpqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582412076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jftdJ-0001ZV-Ic
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 19:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jftcV-0000io-Gq
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 19:13:28 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45013)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jftcR-0006Af-On
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 19:13:25 -0400
Received: by mail-pl1-x642.google.com with SMTP id bh7so530789plb.11
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 16:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=1h5rSefFpVt4cVbiRRC970N1zUoUvg35pQmhzPoffj8=;
 b=YrgtQpqjWZe3qaH+ROM1esVcTcPCkw8zgui7wEBOEwlF6htqSosMP3OkzifWHi/T1m
 6iuaOEGIj0d8lZLIiHvD6v5wIb7+PjkPijE910thT2qqRk/Gch/Eeyf6QDFPEs/QrUgB
 xdfJjM8TV/2M0XEzafD+VuUWR2iAJS6v078my8xkIsqQe01QSXYgNL29gK8r1Mto2BFL
 VFbKX4kvW26UcesaPgIFVbLW4wUL3e4oqitYgy9/MJDKyx/RFua6t41JtRdEZhWYmgHT
 CBaK/TZAGw9vKMMvtAlAQ8AqgZnDB7gdNN2dVAqJ9t5u2gVovPwFWi+NKf+IGlaMQR88
 WMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1h5rSefFpVt4cVbiRRC970N1zUoUvg35pQmhzPoffj8=;
 b=o9LcfodBWcNOi9hnxGc6c1w6EzU3ZI5F/cbOwyL3tRmizO8s1pMd3y3BL6KzyE6ZSg
 xHIjqrIsap3xGuapxmw07bt1ZdRnnmwcp6VepFCl0nMOt4ZoJC3tIeKLo3oo4tHbpIrl
 qwKiX86R+7EzwH74dGsqcYx3sGukrB4R8/swdEfgPH4uunN18ebURTcvrUzDuGdcgjYe
 EQwLTxGQvv9IADAD4wQX3ApVnAIf8ajmUr6BdJAS1RUmjef1lWRJRZbEqWJ959roxHz4
 JKNCdhpHZAwiYsYA8/GKAgUrWpYDTTZagpyeH7mmIuMot1DJl9m7IIB3qQS82YYu85ux
 gZdQ==
X-Gm-Message-State: AOAM533vOynOVFQKiwJnAC6AS1UF33/DDJoG2awxD0hLn02p2BRa4Dp4
 /ynkOIWWzS4ce3ArspuZ/KqGN5g8Z10=
X-Google-Smtp-Source: ABdhPJxXw7mlAigueipAh7UgzVrp2eICWQDJTqBqMLhpt+gS7dsg6ZRjf1GtmvTWWpHpgVCrYEU2RQ==
X-Received: by 2002:a17:90a:2a8e:: with SMTP id
 j14mr1929789pjd.136.1591053202010; 
 Mon, 01 Jun 2020 16:13:22 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id v12sm453575pjt.32.2020.06.01.16.13.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 16:13:21 -0700 (PDT)
Subject: Re: [PATCH v2 5/9] target/arm: Convert Neon narrowing shifts with
 op==8 to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200522145520.6778-1-peter.maydell@linaro.org>
 <20200522145520.6778-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <05a6da74-6142-c730-df9d-1122db434e01@linaro.org>
Date: Mon, 1 Jun 2020 16:13:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200522145520.6778-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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

On 5/22/20 7:55 AM, Peter Maydell wrote:
> Convert the Neon narrowing shifts where op==8 to decodetree:
>  * VSHRN
>  * VRSHRN
>  * VQSHRUN
>  * VQRSHRUN
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       |  27 +++++
>  target/arm/translate-neon.inc.c | 168 ++++++++++++++++++++++++++++++++
>  target/arm/translate.c          |   1 +
>  3 files changed, 196 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


