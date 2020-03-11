Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AE8C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:33:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91317208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHslxzBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91317208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBuvM-0000Du-Md
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBusO-00057i-Pe
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:29:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBusN-0002jS-NY
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:29:56 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:50874)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBusN-0002hH-G6
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:29:55 -0400
Received: by mail-pj1-x1043.google.com with SMTP id u10so465096pjy.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MlYwl/F03NLK+epooCtA6fGFdPPFDk8TjxphUcUmRCI=;
 b=MHslxzBdHACIGZ2Zweb/+k/MeRsgh6xgIxaQjB865i53WQNSnKP5v1Gl/5w6l8Y4HQ
 7jDdSLEtXFRrHNSGj8+PDSYwOe7O23x3doddFck/+uQ2e/BoY56T2wuZ3hb3it6gSxgi
 n2EjiIk1mdVqOpitkZTlbRp1BWHZroMY7ew8XEQKKmdmFVbNeQPoi0CX3QJAZrvbgtI5
 x3oWa4NkKUFp6hw0EaY0sR7AM9PAd/R6EmSjO8KcKnFiXSDWWUIk0sxPsoln3a7lfrte
 I56mCwLMxglDFKshSgSetVikfMjV/sE6JQoMhjxSeya4hqRglfBkoUuQ8EA1SOomRK1S
 Xieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MlYwl/F03NLK+epooCtA6fGFdPPFDk8TjxphUcUmRCI=;
 b=HIsaK6RvJqWDO91GykfnwJzxEnm+dT41E81HcQAYohnyUI1CK+wVoXCUAK5eo6MDLM
 Ad8YeNn7B/PhnSwdP8oORjTDGEuFPLymyZk0YCZvl8dP3i7hVzWYGyczJQVCyk5CcRzL
 iOy7uSZjtJwkn4bYLnFlzugt01gx43N7pbo5YJAIhXUY9kaAIWqJgCFze+8WWFALQt+M
 eQ2iBYDXUcjLgvb6027jkj9FTj1qQY3ff36ZzDVwskZ0tpV4qBiOidpnZUYcjLdyYo14
 V5gn142H8emTB+er69fjF+CL1id1ZFKvleD6msZgiVywSlUb7B6fsz4OTXJsXI+7rTj7
 oAbw==
X-Gm-Message-State: ANhLgQ0lkn74Dsflez9mxDfxD9ofYBo0svbIhxuH5TnapYkHjKLs0Iwb
 gNPPH/PHNRtOch87NNvRiD04sQ==
X-Google-Smtp-Source: ADFU+vvATAFT0CHRC3c1gxeTiP9G1FP+2M0WI02ZHj7pHni1ujYwmTEc6QaHRKq4JldxnR7Od6lbYA==
X-Received: by 2002:a17:90a:d585:: with SMTP id v5mr1851751pju.4.1583908194501; 
 Tue, 10 Mar 2020 23:29:54 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 5sm5535197pfw.98.2020.03.10.23.29.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 23:29:53 -0700 (PDT)
Subject: Re: [PATCH v4 15/18] scripts/texi2pod: Delete unused script
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200309154405.13548-1-peter.maydell@linaro.org>
 <20200309154405.13548-16-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <63fe458f-40b5-bc9d-ab01-6ffaa7002e9b@linaro.org>
Date: Tue, 10 Mar 2020 23:29:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309154405.13548-16-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 8:44 AM, Peter Maydell wrote:
> We no longer need the texi2pod script, so we can delete it, and
> the special-casing it had in the checkpatch script.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  scripts/checkpatch.pl |   2 +-
>  scripts/texi2pod.pl   | 536 ------------------------------------------
>  2 files changed, 1 insertion(+), 537 deletions(-)
>  delete mode 100755 scripts/texi2pod.pl

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

