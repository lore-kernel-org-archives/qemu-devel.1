Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E622CC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:52:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE90620679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AQjrgjZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE90620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvn2-0003Tn-Ku
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDvm5-0002Y1-Kd
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDvm4-00055u-Kd
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:51:45 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35542)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDvm4-00051k-D6
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:51:44 -0400
Received: by mail-pl1-x644.google.com with SMTP id g6so8491847plt.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 12:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dDpacGNq/K7yM6PKdJ9BQLRdTUbRwvHtCgHhyhlKoTg=;
 b=AQjrgjZKqVW/SyhQvefTLDqlDuksBjLCZbzgROzXz0n3JVr1JybTnPwHORasM0VeEe
 bq5kFWQxiy7uwsxIt9CDyb3Cq43Ew/R6BEHUV0xOQBY9NyeA/6TKyhKL3I1y7QL9NC/p
 +zamfgWV7c/8s1b/1OzmI0cF5UKQKr6YcirpPVQhPDhEeojdSOBgn3uW4ItALdn4s/E4
 ZXPaw1lxlqJzmAQEmMbkOXThEbnBjtDyx4ciihBUo5D5u9HB4IMzyJOrGm85up3rapRK
 Glg//oOapd89gfUzTPU/7lWeB/O0ZGRy9j+vPrgmOkmGVZ8GS3kzUg/Yq6N4pLhhS8G3
 BWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dDpacGNq/K7yM6PKdJ9BQLRdTUbRwvHtCgHhyhlKoTg=;
 b=gm95hcca6OmrKQq0QZ2hogbqwSSrzCi/YaQO+EwMRQ5TnTKCS/gN4dP9MgF6JmFa8V
 wFDtrj1y24y5R3/mR+lISu/OsQeW0yBAPwpPlqNnsGW1OLpdaOUk+3y+2cptpNuS+0cz
 fta7tHW6M44Qfh1Ldf7yq6bQK2LsvKukO9KDlRkZIoCyfhZDyfGvKYgsf/PhrH+fHcc4
 /OwF/inPs28gkJka0oMWImYgY/F8njBtM0tkAweK1pV1qcQuTYBin+SrlTleABeE8Gbf
 o2UYKIi2+/+D9eMOtq2u7aVDmUbESbMd2VJf4a95gPWhZ9YVvJ6jVrNR806ZJeZmNtIZ
 kHmw==
X-Gm-Message-State: ANhLgQ2aZodlFRnhUrkgRhnP2HKP/HQB5ddVko6CX6NeRx0c7bBvsTOy
 IS8Fq/yq9KlLPrqhVojEqjIsOg==
X-Google-Smtp-Source: ADFU+vvjl9rPaCPg+vR6UzDGMf3+UPc19rwSelQmwlrtWB0EVNu6h7E4JtH8civEN52sD0o5SxTzKA==
X-Received: by 2002:a17:902:a9c5:: with SMTP id
 b5mr789269plr.126.1584388303264; 
 Mon, 16 Mar 2020 12:51:43 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 j19sm671763pfe.102.2020.03.16.12.51.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 12:51:42 -0700 (PDT)
Subject: Re: [PATCH v3 10/19] target/arm: Restrict ARMv4 cpus to TCG accel
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-11-philmd@redhat.com>
 <b5c047f3-ab3e-825d-35c8-b24c8efc616e@linaro.org>
Message-ID: <bd65d0e1-c94a-6823-cd5b-41aeef8df260@linaro.org>
Date: Mon, 16 Mar 2020 12:51:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b5c047f3-ab3e-825d-35c8-b24c8efc616e@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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

On 3/16/20 12:50 PM, Richard Henderson wrote:
> I much prefer ARRAY_SIZE() to sentinels.
> I know the existing code make much use of them,
> but we don't need to replicate that here.

... but otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

