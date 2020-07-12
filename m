Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A95C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 22:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C0C020663
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 22:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ByplvrxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0C020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jukdO-0000k9-Bs
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 18:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jukcp-0000J3-SR
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 18:39:11 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:34158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jukco-0007NN-5w
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 18:39:11 -0400
Received: by mail-pl1-x632.google.com with SMTP id o1so4630903plk.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2020 15:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hADdDudifn0N1jq/qY8XOUGUrtdnjDfnBEI+OZArVvw=;
 b=ByplvrxULMNEjKA4h2OsrprxGJ56n08YeDzhIDrDiGge/kuiMX3qfa8YMuNyRH8SG5
 Na6Z3WOwM1RFWcxyOFAAh+ESacxVdt+lBO4bbMxw5NRlCiWwfsrUp/CHLq5mShHhJei1
 USDiB4KMnthwW+Xkvt5/8xy/iLyC0rlHuUkE8I1wn4RyuX8MhYRQaJy0bYH2R5JFKCpg
 Uj8RxLTKvegcyepewUyp+ssRjHffBKRfaA77WkxYiTlxrKCzYwVmvcyVaI1+ABq5vmSD
 JjsOGfGmUnjlJEpsW1UHOSVHb4YiLkXtYY7Lrz5OsCoKAxWz2Pc+KM1hwoxAzHAkNTb9
 1I7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hADdDudifn0N1jq/qY8XOUGUrtdnjDfnBEI+OZArVvw=;
 b=SOYaOVVf7DDNSN92S3V31GBhaJI+Qg1s40yQ11qcfvhd7UpOZi2cjcO+GDH3HhdPdi
 UBJnQj5/MWViAqfl9reDT8dSAOnZpI+K3MQPK/1T8zK7azxnZEbL6Dd7s4UmrSivMrHe
 w7YfTyfTvD8j9rmBYIA5Zs6IHNjFZAd36z36K6VO8JJ4d48ZBeMP4sn25RpevwtgnMYR
 AK6llVVhH6nX9QSX1uvg3mltCIkllrxbUlnSyis5NYyNptxkh3H/TlpFXHixAZEj+qKi
 mqP3EhWuSZmlYBDDdrPa0Qm4XvmJz9Jaxl7RdYm5VwVP41GxGHsb5RsrPApKBLsuueGo
 jzEg==
X-Gm-Message-State: AOAM532FJYvFuTRTAfk7S68y564HWyasgGvJuuk8H5EKbFTgjExWcHrK
 Pt4fxLgMrzCVQQo2ZysKAaB6wQ==
X-Google-Smtp-Source: ABdhPJxzdv1Ug0J3qUlpXLzVXJAGNVvvW6df2+rGw+r49MURaCAV/cvhdVkHaR11Sg8wqfrbl77OKA==
X-Received: by 2002:a17:90b:120a:: with SMTP id
 gl10mr16153435pjb.44.1594593547696; 
 Sun, 12 Jul 2020 15:39:07 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id k71sm12970887pje.33.2020.07.12.15.39.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jul 2020 15:39:06 -0700 (PDT)
Subject: Re: [PATCH for-5.1 0/3] Move and improve qdev API doc comments
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200711142425.16283-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d1a093eb-874b-c44e-0cb1-31e1b8838863@linaro.org>
Date: Sun, 12 Jul 2020 15:39:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200711142425.16283-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/11/20 7:24 AM, Peter Maydell wrote:
> Peter Maydell (3):
>   qdev: Move doc comments from qdev.c to qdev-core.h
>   qdev: Document qdev_unrealize()
>   qdev: Document GPIO related functions

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

