Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A76C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B5CA20786
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yytl8tZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5CA20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtCKj-0008L9-ST
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 11:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtCK2-0007ow-0o
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 11:49:22 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:37522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtCK0-0007jE-7o
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 11:49:21 -0400
Received: by mail-pj1-x1041.google.com with SMTP id o22so1367409pjw.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 08:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UWCYesOxDgIXzRIlU9/Q0MBOLlgHdcQa8hA19LKC/5A=;
 b=yytl8tZ6PUVRxgpUg628/0m722jxCJreNnu0kWiADsamGffx0/gi+WEKcCG7RE5czy
 vU2lbgGcBzglxwtFwUciN7lU7B5webdaMmv6+v7rwDArm1ep8yJPGzcpIq0VgbOJykyU
 YO6dUcIjmkycqGZD0Ofg+mC1RtwQMg0XUTo512Hqlj1MUMJO4l6LeyqtqhbFVO2bkmOq
 u2QZAQ0W9IijXz1Y82lIh+SJNgZr7M4SGbeHyTBvT10j1+krgQiOlT6j4xbOzKmFUB6P
 oswAnTTtUZt0dG1tE/L3CW14X2mut0DIAxY20eoGmvOW7lEJmwrHrr7pCnrcg05xJPSa
 fvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UWCYesOxDgIXzRIlU9/Q0MBOLlgHdcQa8hA19LKC/5A=;
 b=J3VYk7mofX/uKXNjZtUZOngXgXLfJTHhWSSljQY6P7O3CODZLgKXEoyBgOIDDgfPp9
 zziyIoUeUHIMCHUCPL8NUGl55ZVwWpGwg+hEUfKh5uU+Fc/ffUw677mAX0vCTVr/2w7F
 nxi4V+i3l1O7fF+kM89htvz5GdAHLNnwYDK9jO7xpDXU83cON3DLe2zTPSK+0B41QZlo
 9CNb1LWg9NDDyRe3wWMc4miZnMn6A2l7pvoZxm3Sk7EhTPIpjuiY1Srt95niG32j2T2z
 RIZVC/YbtJfQQX+F6CftZZAXxVjyZGi9tBbxuTw3Sk1ks2O4LQUDbG+CmQ9Fby23KuGN
 OxPw==
X-Gm-Message-State: AOAM5325fKOzY1WjZj5BVK/mdgPuH6BNuhK4oXz0AdcVF6v+/DumUraq
 Bt92GWtnWGw4+lwj5Y5xzwtOtw==
X-Google-Smtp-Source: ABdhPJz30OI6AM/QkFeYCuh9ZE/7yfYIJiLe94b5GP3EZmoOB2arF4Na3icpJEpFeChATSPjSA7nqw==
X-Received: by 2002:a17:90a:43c3:: with SMTP id
 r61mr10973307pjg.216.1594223358413; 
 Wed, 08 Jul 2020 08:49:18 -0700 (PDT)
Received: from [192.168.7.121] (24-113-145-216.wavecable.com. [24.113.145.216])
 by smtp.gmail.com with ESMTPSA id e128sm232065pfe.196.2020.07.08.08.49.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 08:49:17 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] linux-user: fix the errno value in
 print_syscall_err()
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200708152435.706070-1-laurent@vivier.eu>
 <20200708152435.706070-2-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9e272f2b-69f3-40c0-47d3-aaf32c749cc0@linaro.org>
Date: Wed, 8 Jul 2020 08:49:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708152435.706070-2-laurent@vivier.eu>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/20 8:24 AM, Laurent Vivier wrote:
> errno of the target is returned as a negative value by the syscall,
> not in the host errno variable.
> 
> The emulation of the target syscall can return an error while the
> host doesn't set an errno value. Target errnos and host errnos can
> also differ in some cases.
> 
> Fixes: c84be71f6854 ("linux-user: Extend strace support to enable argument printing after syscall execution")
> Cc: Filip.Bozuta@syrmia.com
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/strace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

