Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFEFC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:55:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2E2206D4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZ5lD0jo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2E2206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPpJh-0003BB-UV
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 11:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kPpFU-0001Ec-4M
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 11:51:32 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:39836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kPpFS-0001CB-EN
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 11:51:31 -0400
Received: by mail-ot1-x334.google.com with SMTP id f10so4187629otb.6
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 08:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FJJg+RCysf8UzVov6YEuCsB/wvG6jpAoJaAMKGyXXpo=;
 b=eZ5lD0joDzyDmuNY+mlQ+6ZazHhewEsNy+0dNELSkb/O0S/C5ptfDrsWSxa5iwJ9jx
 dCWONZBQKTWIJ6aZZExSXdIorFPBFj0Jd0lzzp3mvyrwPQtX6WTZwTaayF4vPiP4/5D/
 aEAGKaICWh5l6FsZjadHsuu2Ne12+/W57FaJxNDICnapjjaKAlddxRa8/nQvWM9Ebs3D
 b9Vwd50nzqDclNYr2lnOktqoRT39ZzKrp6S5W7dc0vUivE29yB7izl1MewIQoY53O0ia
 ZkaYGCyLEsxwHawNqu+28uX8imnGGiOuYOb+5I6oP5ZoMEF5x81ORPy5w/1l+UxwpRJh
 RxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FJJg+RCysf8UzVov6YEuCsB/wvG6jpAoJaAMKGyXXpo=;
 b=YL66ReQpaFsJyu8f/mR1Ep2WwUyxUgmUrRSs2XoeHP5viS9C862kxiRnD3xC52Czem
 alPd84Aut1q8hnzTUrFBysExGVH3IUXYkYaB/CbmlHZJUQTtcNEShlWG7LCOltO/LV8X
 VZFpplAlJFte90OcGOyzhyT/V6pwzBTLRbXlwQw2PKPa/FIH82OSaCX8uW4ZeaC/7tPm
 KbQ5nfngffOIWSSZsvJm0Z6FSew7dLNHAAJ1RXBOk5W+q9FyUcmyGvxouUNCNVe4aNbW
 a7Qd8F6g9yId4Rm+u2FfDaTAB5zFAknhrl+KrO82gUmXrWa3UEOR+tUdNUKWEZ58q9pa
 7EjA==
X-Gm-Message-State: AOAM533KPtxAyYld69U1CMLQQ5hYiny+NrRB1RYoG4msgWOqxewqtlaj
 4IeI9eteLCgAAQLq9PpTDf/Z/Q==
X-Google-Smtp-Source: ABdhPJzQuVjGoDLGPIe0ifW5MV5I8/gUEk5hSBkNEVcDJArkcf/2+LqMOl3YfJDAyqZx7V1z7QwNTg==
X-Received: by 2002:a9d:1c90:: with SMTP id l16mr3454834ota.192.1601999488467; 
 Tue, 06 Oct 2020 08:51:28 -0700 (PDT)
Received: from [172.24.51.127] (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id t22sm1062282otk.24.2020.10.06.08.51.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 08:51:27 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] hw/nvram: Always register
 FW_CFG_DATA_GENERATOR_INTERFACE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201006153636.2383248-1-philmd@redhat.com>
 <20201006153636.2383248-2-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <134bbd15-c53c-7686-a36d-f02a81b56e0d@linaro.org>
Date: Tue, 6 Oct 2020 10:51:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201006153636.2383248-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/6/20 10:36 AM, Philippe Mathieu-Daudé wrote:
> +++ b/hw/nvram/fw_cfg-interface.c
> @@ -0,0 +1,15 @@
> +#include "qemu/osdep.h"
> +#include "hw/nvram/fw_cfg.h"

License boilerplate missing.

r~

