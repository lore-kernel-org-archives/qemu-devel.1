Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDDDC2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 14:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C21D206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 14:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fjJu5zxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C21D206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMunI-0005Rl-JO
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 10:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jMume-0004q9-J5
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jMumd-00010w-Dm
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:37:28 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40532)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jMumd-00010S-0P
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:37:27 -0400
Received: by mail-pf1-x441.google.com with SMTP id x3so854847pfp.7
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 07:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=9K4/yvXzKDurZL6XM2O6YTDsHDLXIjiDByRaq/JHGww=;
 b=fjJu5zxW42VcMI4KTgto0e6qIAfag9SJQayhuPqDic2mjQIrDzStjXtyh/mi6PKR5e
 UIV7/MfZ1XrOaKk/2AjkxSRv+oINQ8lwiNMqmG1YUAd1EqE/9fHJmghOLhu1Hdw0YDtz
 9VZxgk18+6Szd2EdPJQcn0RsBVSDTJKp7kUlEE4uFWNBsWdr4q8+Ls6wMbeOI2GLkVdb
 KVbmIZo+2GuLQ9XxwIAKScOvBjy/NzOBG/3FxiTt8wzOfAFVZlt46LQu8Hn0OAVofElP
 RFTq0ivushdeT9HWipwowlVxwBdyoUER9xvMDk+7z3dHB27ajUODtJLwe+Jr0vV2SMMP
 aIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9K4/yvXzKDurZL6XM2O6YTDsHDLXIjiDByRaq/JHGww=;
 b=hk1jDCjf8IQeiDELqKEwI9PCVcze+D1igSjpxny9heUNPdkczX6tK9fJlDqJk3F4bM
 0RzEs3pFw5mbqgtp/mUH6z1thmfleNqSN35ilijV1vUy8102ZzgHOjLfXJwvDqyj7rUZ
 lt8GDsMq/tbotpVmjdNaudCUZ55L6u+vmCnRX1ov0z1oo5MVljhByk8S0KiOmoYN7d87
 qBanlqPz114eM3krLws7QaLsSEDeiOf7hQY0ikRqpkgF0qmoOqO+h4vTsk8JBRDZ0+uZ
 JpT8NrohyVDDYO442axYq5dlRrQ5X4xibf+mLR3n5zmfFGhvc0PWTpao66BpdxbaJlCC
 GoVQ==
X-Gm-Message-State: AGi0PuaJKrd/7YihuBH+95j6bipcqjccO4VHXajGHTlz5LIzWPa8ic6h
 TIMTMn/IwxpUjDwrbYAkICxMNcWuIbM=
X-Google-Smtp-Source: APiQypJWRRbiXSt6zDABmSmhGreak82iWhNeWYlkfAAHozJi044Sa/rFQDlvb3XqDHujSqy/1bbomQ==
X-Received: by 2002:a62:3808:: with SMTP id f8mr5237374pfa.38.1586529445169;
 Fri, 10 Apr 2020 07:37:25 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id t15sm1754386pgv.61.2020.04.10.07.37.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2020 07:37:24 -0700 (PDT)
Subject: Re: [PATCH v1 06/11] configure: redirect sphinx-build check to
 config.log
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200409211529.5269-1-alex.bennee@linaro.org>
 <20200409211529.5269-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4a33f512-188f-6766-626f-ec75ab171d30@linaro.org>
Date: Fri, 10 Apr 2020 07:37:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200409211529.5269-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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

On 4/9/20 2:15 PM, Alex Bennée wrote:
> Otherwise it's hard to debug whats going on.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

