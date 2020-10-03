Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11A6C4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E2292067C
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K5Sjw0MT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2292067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOdva-00040l-AK
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 05:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOduH-0002gG-OL
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:32:45 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOduE-0000FZ-TG
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:32:45 -0400
Received: by mail-ot1-x342.google.com with SMTP id m12so3858595otr.0
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 02:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Lf+b6wz5aJcxLTuNyvH2xK88mrxNPbARWcfCoU54kpw=;
 b=K5Sjw0MTIeUlLlww3BOw6xcDB1/Qz4tk4Vph1UaEbLckM5ohrGn9M+oF6h1/5lnmhJ
 RPfzadY1+eClwFonL2SgiyOn9+397r7bktSIF55VTVf0uRA45T4G3HsKNuWKOZjw/AIO
 wc39cNiFzTALYhYhqD9bpIrC/UELcrLyhDY1oYoW7NDYStby0cK8sG2u0CXVIioF56Je
 AIRFbwa+KmMZRdQPFGPalKhoNU7sXWHuI8+3fXmMFt9rbAPbMG7Nv6eCPOOH3V59YEEz
 GXmk52dcQFBYuAKi8aDR52+f4N4sTyeh4QWohkU+Y1bSow2yZyYAsLJf8VYeojjS6sVW
 XmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Lf+b6wz5aJcxLTuNyvH2xK88mrxNPbARWcfCoU54kpw=;
 b=sFy6/wV0OsTG0RDw2Ri6oFxOsuT5m/8vQEIrHeH9JUYYCTa2ULD6tP4qlQghpSIs3/
 KPTDQoaQGLMioTpAO/7janM/VoLI/3rIrwnQ28VZZ+v3uF03RFOdxuBSniLAqtq/y2JE
 SmGJFBtB7n1PWxV0IJ4MWCuK1zuWsoL4dD6CBIiUBjjQezYZ6zJvwQ5OXFJRHB+zF5HY
 ruCpuuud2nUSx38T+GKgofTKDue/tN+R62N8Fx5GGr92vAtIRI4pFv9CiDf9xBzDr2aI
 uqegF/4+0raYV+1dtbOS8noUvzeGVnbs+TM95VeNWq5MnC/Ccg2eR97tjFuiYAKFiNEu
 sI3A==
X-Gm-Message-State: AOAM5315rmQ3sheY3S7qIipJTxNaPY5k/jiqyunfrYuns1HKPGR2zgyP
 WtQI6eX+QYNSTRU33Tf331eUaA==
X-Google-Smtp-Source: ABdhPJyYmIU4ZCcxWQ7wTs+cZZk1NiROSUjjIuOHFA8sUv7v1AcsT8YCeOpCVq5eAsoY07+30gxZGQ==
X-Received: by 2002:a9d:70d8:: with SMTP id w24mr4662130otj.275.1601717561171; 
 Sat, 03 Oct 2020 02:32:41 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id s13sm1085739otq.5.2020.10.03.02.32.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 02:32:40 -0700 (PDT)
Subject: Re: [PATCH v4 02/12] meson: Allow optional target/${ARCH}/Kconfig
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200929224355.1224017-1-philmd@redhat.com>
 <20200929224355.1224017-3-philmd@redhat.com>
 <31a173bf-6aa3-1ce8-7d14-5e8f11e2a279@linaro.org>
 <0303fe78-5ae1-2115-247c-71807ce74e12@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <af1779ad-bd09-d1dd-6790-e7004b59c0de@linaro.org>
Date: Sat, 3 Oct 2020 04:32:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0303fe78-5ae1-2115-247c-71807ce74e12@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.256,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/3/20 4:15 AM, Paolo Bonzini wrote:
> On 03/10/20 11:13, Richard Henderson wrote:
>>> +    target_kconfig = 'target' / config_target['TARGET_BASE_ARCH'] / 'Kconfig'
>>> +    minikconf_input = ['default-configs' / target + '.mak', 'Kconfig']
>>> +    if fs.is_file(target_kconfig)
>> Missing a meson.current_source_dir()?
>> Leastwise that was a comment that Paolo had for me.
> 
> Not sure, but it was the only way I thought the BSD build could fail;
> unless the capstone submodule really was not present in Peter's checkout
> and submodule update was disabled.

I don't think the build actually failed, I think it was just the cmake warning
from the missing method: to which Peter objected.

FWIW with and without source_dir work for me when testing, and I'm about to
include it in the v3 pull for an abundance of caution.


r~

