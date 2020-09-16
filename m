Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B0FC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7E222274
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="et/4/Exo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7E222274
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIZQ0-0005nL-CZ
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 11:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIZO8-0004tL-RR
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 11:30:28 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIZO6-0007O6-Tb
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 11:30:28 -0400
Received: by mail-pg1-x544.google.com with SMTP id y1so4097494pgk.8
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 08:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rSWWkHT5REPj+U406wKkSIIkVRw68xksXwdGYcOT8mk=;
 b=et/4/ExoyYbazr9D3uzFBUX2MZvrivdI63k5wYo0kPoBufwdUG5iWOybCHA+Jr9em5
 SzyIXsDPiOYnCPqnGQVSw8GYsjxeAhqLv8UdbyOAFAxcgSjVlsn5Ee4oSu6FGLVkShuF
 NuXg7MEaYejGok4W5JHHi264MQ1+FxCXVoV2w3bOVGKGwDiHV1a94uwqMuLTeULcMkQl
 JoKkuKKwbMH+LY4SSK+PlX3OMdJ4BAftI2isbrOdy8+Za2g2EPJpUOFEnpX293Qe1twm
 7WfNq5tUI6df9LsejkhWoCJ0gYhDRWJz94fXymuIVqI1RXUjNdue1wa5Gvk6Ly83+9n4
 OvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rSWWkHT5REPj+U406wKkSIIkVRw68xksXwdGYcOT8mk=;
 b=ItJ3mWzNRrNrs4iHkE5DpT9jhjXJHS4oG6bLfkCcq0YQta0EpCXfDrr/6K5U44cuCH
 FVN5X38txDTsd6qMfQ6birb3ETv25e1BHtQrnk6NprmmYaM8uAOMhn9irZYxM2C3+iKr
 we5IBIqldWBSjvkQmz4eXWx9Y93fI1csS4Rf5KnIksm5P2rd3rNn+XL+lxkD61ArCB2l
 ZhPhh4NWp2IsKe376w4uNrFXDnGd9ZRnhgvKN2BbSjm9r8TRF2Mmul2ayZS/c0OP11Rz
 dqcnuWEwsUNXklppOYRKEx+PLwGl8VhTJl7LeIvYYs3kJ9RsQRykQMH4mm1s3JQ0NubD
 +Fsg==
X-Gm-Message-State: AOAM533k7cuZnvtlnXXIHjzw8/suy7ZHy5qWjlI3+z4CNscixV7G4era
 XLv1tJMmjD2yTt1MFmMgLvwr7+kRgazKAw==
X-Google-Smtp-Source: ABdhPJwNrgULf0JyvmDAe331s0g9VAFOvorK74alrB4hxkepsqb323s122/LNyR1fnyWKiqCDECSNg==
X-Received: by 2002:a63:342:: with SMTP id 63mr19603756pgd.134.1600270225441; 
 Wed, 16 Sep 2020 08:30:25 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id r123sm18010723pfc.187.2020.09.16.08.30.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 08:30:24 -0700 (PDT)
Subject: Re: [PATCH] configure: move cocoa option to Meson
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200916081131.21775-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4a101a38-cf97-f155-9b89-cfd70a35fe8b@linaro.org>
Date: Wed, 16 Sep 2020 08:30:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200916081131.21775-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.062,
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
Cc: Christophe de Dinechin <dinechin@redhat.com>, r.bolshakov@yadro.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 1:11 AM, Paolo Bonzini wrote:
>    --enable-cocoa)
> -      cocoa="yes" ;
> +      cocoa="enabled" ;

Lose the stray ; at the same time?

> @@ -101,7 +101,7 @@ if targetos == 'windows'
>  elif targetos == 'darwin'
>    coref = dependency('appleframeworks', modules: 'CoreFoundation')
>    iokit = dependency('appleframeworks', modules: 'IOKit')
> -  cocoa = dependency('appleframeworks', modules: 'Cocoa')
> +  cocoa = dependency('appleframeworks', modules: 'Cocoa', required: get_option('cocoa'))
>    hvf = dependency('appleframeworks', modules: 'Hypervisor')
>  elif targetos == 'sunos'
>    socket = [cc.find_library('socket'),
> @@ -112,6 +112,11 @@ elif targetos == 'haiku'
>              cc.find_library('network'),
>              cc.find_library('bsd')]
>  endif
> +
> +if not cocoa.found() and get_option('cocoa').enabled()
> +  error('Cocoa not available on this platform')
> +endif

Isn't the error redundant with the required above?


r~

