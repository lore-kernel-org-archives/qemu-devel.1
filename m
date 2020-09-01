Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F44C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 21:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED5F2078B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 21:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P2HKW8PR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED5F2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDE13-0002B1-72
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 17:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDE05-0001k8-9R
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 17:39:33 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:43492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDE03-0004WE-RO
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 17:39:33 -0400
Received: by mail-io1-xd41.google.com with SMTP id z25so3440589iol.10
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 14:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=thchTl/dd/9GY5+hh4UQGpflHmmZzbqg0JnbKF+1rts=;
 b=P2HKW8PRHUJ6TyG3qlfv4WYoY7MCKxd+9u1rtHuV9f5nZXvvzPz1bgRWhjtFFLgmGW
 8ACm0Jn00uTKnN/1Lq22Ch6+EIXMzOLsE9B+pVBoDAYAsAeYkrE0hEIqpv6pF9oeNO37
 6IWvIMMHodRl88FesRWKSb5lSEmnhR2P+pAR3sm7IIkJ1djSBV4vNUFw+1ViAITWKAEp
 mM+RIhFoKNuEJb0Gn5S/9H8qAXAnH7Wj4qv8k6zTnKYyxrKsujx05s/KNjTeXPkMl2VN
 gp6RYIxubFZ9gUIPUGkmakgLhjHSyXRKIXznkva3O8rb2a9qH3K+bV9W67afNBrCKNRt
 4xRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=thchTl/dd/9GY5+hh4UQGpflHmmZzbqg0JnbKF+1rts=;
 b=QN6iUyji5dr2POb0JtQm2ik7bgmDw6Cyu9ABlwhhntOhNLak8sUkAVUNUNLUGtqATQ
 SEYx1eOTVoW/OGnpSHdIO7TkXMvy7HW+Ml6RrmMzJN2Zji4vXvS9xgbfvegzq9wqVSDE
 /dBXUk3/7IqCswM60Lzlj1aUaX3yOXeOrt6SMD10P5d6+o7l6Ipy4KwBxSqq3DVj7SCe
 KW6CfZjh+kVr08cw8aox9kKhbPL3aax2yPwpboGIDPWJaps7ALFA9L21NqJlZkt2b4HM
 dPKmmmyxwXY+m8Sn4n8KV9vCPxlA7rrpkFt/RawdDtjxylWBxcxktlVjVlnokgUAOoCo
 7qPA==
X-Gm-Message-State: AOAM5328MsznLEYa05jiGG4/KXmHa7A9EQJa0UlVeu6niQVQty8/sYo6
 FUZ5nKFG/g21z6qgsiHryOqYQA==
X-Google-Smtp-Source: ABdhPJxp9PbKudIjamnXL1oqIvlqWdohDhpKvJlT9bTBx+bFdl8mi2zfKvkOYTyBspF9SlVjBLfxhw==
X-Received: by 2002:a5e:9247:: with SMTP id z7mr902767iop.71.1598996370532;
 Tue, 01 Sep 2020 14:39:30 -0700 (PDT)
Received: from ?IPv6:2607:fb90:27d2:4b79:8545:2b44:3b48:7db9?
 ([2607:fb90:27d2:4b79:8545:2b44:3b48:7db9])
 by smtp.gmail.com with ESMTPSA id o8sm1248191ilb.64.2020.09.01.14.39.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 14:39:29 -0700 (PDT)
Subject: Re: [PATCH 4/7] hw/hppa: Inform SeaBIOS about fw_cfg port address
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20200901183452.24967-1-deller@gmx.de>
 <20200901183452.24967-5-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6385bd44-9cf8-95c3-1e59-0e1fb209863f@linaro.org>
Date: Tue, 1 Sep 2020 14:39:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901183452.24967-5-deller@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 11:34 AM, Helge Deller wrote:
> -/* QEMU fw_cfg interface port */
> -#define QEMU_FW_CFG_IO_BASE     (MEMORY_HPA + 0x80)
> +#define FW_CFG_IO_BASE  0xfffa0000

Why is this value changing?


r~

