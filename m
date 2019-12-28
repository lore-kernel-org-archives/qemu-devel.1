Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F106C2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:58:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FCF82173E
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wvZ9Pxwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCF82173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilLyv-0005JM-Fc
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 18:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLyK-0004qV-PC
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:58:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLyJ-0004Fe-R6
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:58:16 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilLyJ-00049t-IZ
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:58:15 -0500
Received: by mail-pl1-x642.google.com with SMTP id p27so13226363pli.10
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 15:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EyyjhjYM0xas6hmBIUBFMM79FrC/aQiPj7kd4YaFv9M=;
 b=wvZ9PxwdFQ9b27NB0Flg0zlgragzFR4TfvBcf3/XIgQJ9vGHyKxS9LQaVZ7gH829CC
 qI/MazLo2AfQD/deuv1lZC8WnRasoJp4jVXYL7a2s638jQuGnMJsM05FKaJH5RjYGFu+
 GQztYpn/UZr5nQNxCxawq/Zx8VIMDyALkf47TNAa6iDeJ0SjkAa9cOZ/uYefabboM1jZ
 rZKUx+IPfaHt9ur/2dOxv4dBDMVHVTJoomxyMhvsqPh/u55IqVZyNZa7mXo591GB6Kmf
 g8GBnuY5dIgtUGws8WooPXDDdegGpJMFG3pp7K38L8LZqYawOzA+GoFghA8A0c+1a5Zy
 1eAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EyyjhjYM0xas6hmBIUBFMM79FrC/aQiPj7kd4YaFv9M=;
 b=Kys0acxupAdFbtfFIXGpaYMh1EdM5qVI8jd6XGofQ6uSNHQp/r8gjrTVNvLSW5O+rp
 1a/DqdGr2mSmdBO3pYounmBIIryU9CGdXC9fiPlGn2qySGD6jV+83lUCzflBIeKp/Pog
 qA7Xgfof/BTeXuESM7UtOYFgyD7ZUmkVAlaORDZ0nHMK2KeCik2F3Jz8b9IaLxM3iqwt
 1MLCd/aj2ulSBZIW1awIJvBVF2otqYSwSEMcx4DHJReOQXU86QAi9x8GPjUANG/otWGE
 QPVvv5ZwBcn8ndP/zPNzQaPZSR8q7AadufegePjdoqueazVYDHpBAzo7ScVsihtxtPTh
 VGEA==
X-Gm-Message-State: APjAAAXkXdiMSQTK2jIbxnhiQesLwSRHefyWP7ft5axY/liacuG9vBcc
 +HhKBsGpIrfz8rEWuqFDxBVeqQ==
X-Google-Smtp-Source: APXvYqxCM0Xjf1Nuhy5AuC4vMp9150EgBB5gIq+t15dJTqBaClgGd7v++Wxhw7/ChPVPeRfBLpFG5w==
X-Received: by 2002:a17:90a:7781:: with SMTP id
 v1mr36242251pjk.57.1577577494574; 
 Sat, 28 Dec 2019 15:58:14 -0800 (PST)
Received: from [192.168.1.118] (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id k3sm43298068pgc.3.2019.12.28.15.58.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Dec 2019 15:58:13 -0800 (PST)
Subject: Re: [PATCH v6 07/11] hw/core/qdev: update hotplug reset regarding
 resettable
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20191220115035.709876-1-damien.hedde@greensocs.com>
 <20191220115035.709876-8-damien.hedde@greensocs.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f70ba0cf-8bf6-d6dc-6a1e-b7dad7454a36@linaro.org>
Date: Sun, 29 Dec 2019 10:58:06 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220115035.709876-8-damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 cohuck@redhat.com, mark.burton@greensocs.com, edgari@xilinx.com,
 qemu-s390x@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/20/19 10:50 PM, Damien Hedde wrote:
> +void resettable_state_clear(ResettableState *state)
> +{
> +    memset(state, 0, sizeof(ResettableState));
> +}

Worth moving this into the header as inline?  Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

