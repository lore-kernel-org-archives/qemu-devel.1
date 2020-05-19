Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D60C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 03:40:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904C220674
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 03:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ErQ98ehY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904C220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jat75-0006A2-Ml
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 23:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jat6X-0005kx-Rv
 for qemu-devel@nongnu.org; Mon, 18 May 2020 23:39:45 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jat6W-0006Wf-SA
 for qemu-devel@nongnu.org; Mon, 18 May 2020 23:39:45 -0400
Received: by mail-pg1-x541.google.com with SMTP id f23so5777073pgj.4
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 20:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Q9wQN+n6nI42Ms+Oylu0REEMg41Z/3zN5OIZItTyQV4=;
 b=ErQ98ehYsdIjJ4ghEO4HjsEcDYYDnmHTwJYPygP7VhCxH36o6+v36OWqoWnHfg458c
 /n4HZ1lwTpHcfgXXpSvd/6KnAFg3ndmlrlxgwJiM3dIG7w+pZPmx6t4Q+rK7jacW3nn7
 41Ob4tPvizheqZEvFx9IXl4SMFrKn4wEdC9+KmJMDgeyrMUtm0JavemNV8H0cEuuKo7b
 kzoFvM0ELG6YX7tn31lHpIQxDWvxLjMlC/xHadguIZYq/9OWxw3M9BlHSZEFm2t24D3y
 gB0gugUujIplwm4+crlHbMUXeN3yhGBmdEB7X5QmRWRhilDxPLbkI8S9UlTFPpzWUBXX
 4wNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q9wQN+n6nI42Ms+Oylu0REEMg41Z/3zN5OIZItTyQV4=;
 b=Wtk3H8sJTU01ryAKJvxLGWU2cUm2NHdY7TKMngkxPbQzC1jYbmqdO6ISkJWS0CnB3K
 2ZS0IpkNfID4o4Al5DNk+GOQZz0Ku+5zTC6MowjwR5c/YDnBpgmXrkajIKuG2ajdI2zW
 9fRIXL9E+NkSbRc5V9biMgrO4Im7BUyu1RSOnHqFwxVomQ9K/8/B9hi8OpQ3OA+A8MTi
 O2nh/rRgGKylI+j5O+U4hKOCcfRDwWBJpLFWtyVc50tEq3uVa71NiJdgS6i8BbyUKBTr
 XbEQQDGPRZxboBSqpyK82uLvR1X2O5NIv9DSxZkOwgtZXwz6UoESx0J+Ae8jtgIuYM92
 Nxfg==
X-Gm-Message-State: AOAM531yb6iyCPNUoARBNvO7UGjLB15KqhPkTC4iOQgfRnrhurbWTZUH
 dAEKbBQWDhyXMtJrOTeZj+PT5A==
X-Google-Smtp-Source: ABdhPJwsr0D2j0dDQgmZZ465jsGnoix6vm40IDwhHXEaFl2eQvOvSL9Cr+MgyZ0M82jzaisk5H712Q==
X-Received: by 2002:a63:5c1d:: with SMTP id q29mr7053410pgb.105.1589859583049; 
 Mon, 18 May 2020 20:39:43 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gv4sm807411pjb.6.2020.05.18.20.39.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 20:39:42 -0700 (PDT)
Subject: Re: [PATCH] target/i386: Fix OUTL debug output
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200517110147.26026-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <234cbf5d-aed7-7b6c-e43d-ae47f8251916@linaro.org>
Date: Mon, 18 May 2020 20:39:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200517110147.26026-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Riku Voipio <riku.voipio@iki.fi>, Eduardo Habkost <ehabkost@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/20 4:01 AM, Philippe Mathieu-Daudé wrote:
> Fix OUTL instructions incorrectly displayed as OUTW.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  target/i386/misc_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

as far as it goes.  We should of course never be printing to stderr, but
logging or tracing.


r~

