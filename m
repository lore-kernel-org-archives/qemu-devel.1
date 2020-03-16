Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B5FC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:47:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C281220738
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mGKIQ3rE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C281220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvhe-00089g-Ue
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDvgp-0007Pm-Jz
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:46:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDvgo-00007a-Ai
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:46:19 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:36345)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDvgo-0008R5-2r
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:46:18 -0400
Received: by mail-pj1-x1044.google.com with SMTP id nu11so5994364pjb.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 12:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Fg2dIkWCB/O1LDCS9geq5EAQZZnI+9IQOwUr+ztmSSo=;
 b=mGKIQ3rE/W8YR3Tzqn81ilyK3CO1Ckuz06TR4oE12XPjyGjnVygcOSBCEyTP/ur6wK
 ZhZSaPC3s5+Ajp8rFzkY1Mcl68rlCzQf4AbCKoUhdl5++AWnjsrEXDI8shYLaXRJACCm
 ZMrewNmmoGQEYKPq044ZuJMeddaSyT+h/V0puTLnwSZ0RP99deWKvo8uuJ8dlvQdkZrk
 n6W2JHtyS+NLry3j+lRtQznf6WtI8/dgD3OoVRPRvu38VnItydo87odGkP22hDsIghqa
 772EEJQPrVqPlmr3rrabk/n15X6Kwod4NPjAJFArFpcZPoAic684k9ktoYHlQQq3NLIO
 F0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Fg2dIkWCB/O1LDCS9geq5EAQZZnI+9IQOwUr+ztmSSo=;
 b=AxugVFfsJlMHEyJiQDok7/SMo9UJeuheAa+zC5qUQWa/jaLROCrvHS1dRhO6s06Q6c
 SRbaPPADd9fQrxgP6YX9DH47VswG16uaQUEMbZG8OROtMbPaLi0Tn0znEij9CbF5t6Ib
 GNpMt1U92QduyL9SLjdVUz5hDtlwUra97wX/zWHcYpKCyGCWaYRzsDl2OngD9OrR+Zu7
 mb8hamxnEcMdosnynb9xBc+jUAHPV/nSeg77LE9BJkUQy9eIqW3HEA9Rc2lP67pBcLVG
 tWGLHUX34sid95ojdCAP+Mdd/K/jMy8DoHlVbxjDf13Sm7Rm0Xf+sViHsY009x87kuFU
 SWZw==
X-Gm-Message-State: ANhLgQ1Y1iylqaVrriOxfkG1l2HrqCT3GlefbL1F/VDJshP8rbKASFXp
 hIdEZD2mER3Nx6Dc6UdOcXboXA==
X-Google-Smtp-Source: ADFU+vuJRnVHlZ/NwMSs1hoyK2nwN/EKxc3cwui5H4fXByD28JtCPHowfGZeHQezFemq4Tc7M7mueg==
X-Received: by 2002:a17:90a:2489:: with SMTP id
 i9mr1069737pje.183.1584387976837; 
 Mon, 16 Mar 2020 12:46:16 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 u41sm335812pgn.8.2020.03.16.12.46.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 12:46:16 -0700 (PDT)
Subject: Re: [PATCH v3 08/19] target/arm: Add semihosting stub to allow
 building without TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-9-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a0aba55b-61d7-c0f4-9fc7-bf6b5675281f@linaro.org>
Date: Mon, 16 Mar 2020 12:46:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316160634.3386-9-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 9:06 AM, Philippe Mathieu-Daudé wrote:
> Semihosting requires TCG. When configured with --disable-tcg, the
> build fails because the 'do_arm_semihosting' is missing. Instead
> of adding more few more #ifdeffery to the helper code, add a stub.
...
>  ifeq ($(CONFIG_TCG),y)
>  
> -obj-y += arm-semi.o
> +obj-$(CONFIG_SEMIHOSTING) += arm-semi.o
> +obj-$(call lnot,$(CONFIG_SEMIHOSTING)) += arm-semi-stub.o
>  
>  endif # CONFIG_TCG

This code doesn't match the comment.

Why isn't this

obj-$(call land,$(CONFIG_TCG),$(CONFIG_SEMIHOSTING)) += arm-semi.o
obj-$(call lnot,$(call land ...)) += arm-semi-stub.o


r~


