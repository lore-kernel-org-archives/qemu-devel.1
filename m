Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EB0C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 21:01:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 380BC24797
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 21:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y3z9YAqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380BC24797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jn76E-00020O-E2
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 17:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jn74u-0001Rh-N5
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 17:00:37 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:54013)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jn74s-000586-Sw
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 17:00:36 -0400
Received: by mail-pj1-x1044.google.com with SMTP id i12so7068742pju.3
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 14:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3aYNK/Y55ZyftD/IVlFhDOk199toe1I7JokUnTmEw7M=;
 b=Y3z9YAqwNq74fKHe5zFD7+MbpqcY0sDzWer687Ta1lyh94KhInX6HLFmHf7UwqpGvO
 sa17Fjksxe6vpcQ+1LkLpuHDMFE7pQ728YCfP1PX1t7a4JPXziXwMVSp/JJYl213AlGm
 R43AYAnDhvPk3ERI27ou1r/2zGuq7KUcZH8WjdfbZwX1vWKTpU1l2/jvh/Cmno/057JF
 QFgWHQx0S5K6YvdaNmmNewfP9SsNSHxDw24bY/DuIoJDWD6Fyksuuz5B3vKvhZEPU03+
 lg4eLMhnK/cQa32bOqjfyXRvUrdqHV6XJcFZ5sdricJG0cCsktdQlQAJRR7qgWyiAs8s
 Id0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3aYNK/Y55ZyftD/IVlFhDOk199toe1I7JokUnTmEw7M=;
 b=OPxV7NLJSNIAEaGTSpW+Ak8SeCt32yuJ1liag5Sm6c/waEYCSFjpP1+kB6k/5o2L3f
 ByVtE3OzGh2htx65Mlglq6LHEuAH0l9KSFN18M3LKKvNKpZrcngzbyvzj/u5Dy6A1XAE
 IMsVZFg+PIexmWtj0JNuzg72lm8gzI6+sZCtYgc6ESFKquyCuaGlTgaQoQIaSkkbhdc0
 AlTrMn2dmaAdQn5pmpL7o0MWqH5ffyVpvgwawZLASFa16rYURMmZXIOHq/iARRdBLfmN
 jmrOjtM+zegga3UuJN9rbHUpN2F/cYPza/WP1OK6UOfbHXTyTtxLDEW3/mZWrWLHFkQt
 ynPA==
X-Gm-Message-State: AOAM53042flL0nBxG6yUw4gK+RVWoI4ev690JfQ0bc+QSpTSTxBDtwUs
 7Ryhh0l2NiMep5dJZCT6XbeGOw==
X-Google-Smtp-Source: ABdhPJxQ6x+GmpsmxY502qNnj3gJPihX4RKdWx+m5OwvKQLsVdrbsQXDz1bDG0Fw0U+dan32MLo+0A==
X-Received: by 2002:a17:902:7c16:: with SMTP id
 x22mr16763125pll.66.1592773233274; 
 Sun, 21 Jun 2020 14:00:33 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gm11sm11364698pjb.9.2020.06.21.14.00.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jun 2020 14:00:32 -0700 (PDT)
Subject: Re: [PATCH v3 5/7] hw/misc/mps2-fpgaio: Use the LED device
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200620230719.32139-1-f4bug@amsat.org>
 <20200620230719.32139-6-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <754c5ed3-9882-9261-80b4-f9e39ace170b@linaro.org>
Date: Sun, 21 Jun 2020 14:00:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200620230719.32139-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/20/20 4:07 PM, Philippe Mathieu-Daudé wrote:
> +    DeviceState *led[2];

Perhaps better as LEDState?  And perhaps return that from create_led.


r~

